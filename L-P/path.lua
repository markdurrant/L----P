-- get Utilities & Point modules.
local utl = require('L-P/utilities')
require('L-P/point')

-- Set up Path class, and set closed to false.
local path = { label = 'Path', closed = false }

-- Return a new path with an optional table of points.
function Path(points)
  local new_path = {}
        new_path.points = {}

  setmetatable(new_path, { __index = path })

  if points then
    new_path.points = points
    new_path:set_bounds()
  end

  return new_path
end

-- Sets the bounding box for the path. Used internally.
function path:set_bounds()
  local top    = self.points[1].y
  local bottom = self.points[1].y
  local left   = self.points[1].x 
  local right  = self.points[1].x

  for i, point in ipairs(self.points) do
    if point.y > top then top = point.y end
    if point.y < bottom then bottom = point.y end
    if point.x > right then right = point.x end
    if point.x < left then left = point.x end
  end
  
  local h_center = left + (right - left) / 2
  local v_center = bottom + (top - bottom) / 2

  self.top           = top
  self.bottom        = bottom
  self.left          = left
  self.right         = right

  self.top_left      = Point(left, top)
  self.top_center    = Point(h_center, top)
  self.top_right     = Point(right, top)  
  self.middle_left   = Point(left, v_center)
  self.center        = Point(h_center, v_center)
  self.middle_right  = Point(right, v_center) 
  self.bottom_left   = Point(left, bottom)
  self.bottom_center = Point(h_center, bottom)
  self.bottom_right  = Point(right, bottom)
end

function path:get_segments()
  local segments = {}

  for i, p in ipairs(self.points) do
    if i < #self.points then
      table.insert(segments, {self.points[i], self.points[i + 1]})
    elseif i == #self.points and self.closed == true then
      table.insert(segments, {self.points[i], self.points[1]})
    end 
  end 

  return segments
end

-- close the path
function path:close()
  self.closed = true

  return self
end

-- open the path
function path:open()
  self.closed = false

  return self
end

-- add points to the Path 
-- give an optional index to add points to the middle of a path
function path:add_points(points, index)
  local i = #self.points + 1
  
  if index then i = index + 1 end

  for _, p in ipairs(points) do
    table.insert(self.points, i, p)
  end

  self:set_bounds()

  return self
end

-- Remove points from the path using an index and an optional number of points.
function path:remove_points(index, number) 
  local n = number or 1

  for i = 1, n do
    table.remove(self.points, index)
  end
  
  self:set_bounds()

  return self
end

-- Move the path along the X & Y axes.
function path:move(x, y)
  for _, p in ipairs(self.points) do
    p:move(x, y)
  end
  
  self:set_bounds()
  
  return self
end

-- Move the path along a vector.
function path:move_vector(direction, length)
  for _, p in ipairs(self.points) do
    p:move_vector(direction, length)
  end
  
  self:set_bounds()
  
  return self
end

-- Rotate the path clockwise around an optional origin point.
function path:rotate(angle, point)
  local origin = point or self.center
  
  for _, p in ipairs(self.points) do
    p:rotate(angle, origin)
  end

  self:set_bounds()
  
  return self
end

-- Scale the path by a factor.
function path:scale(factor)
  for _, p in ipairs(self.points) do
    local direction = self.center:angle_to(p)
    local length = self.center:distance_to(p)

    p:move_vector(direction, length * factor - length)
  end
  
  self:set_bounds()
  
  return self
end

-- Return the total length of the path.
function path:length()
  local length = 0
  
  for i = 1, #self.points - 1 do
    length = length + self.points[i]:distance_to(self.points[i + 1])
  end

  if self.closed == true then
    length = length + self.points[#self.points]:distance_to(self.points[1])
  end

  return length
end

-- Return the point at a specified distance along a path.
function path:point_at_distance(distance)
  local point 
  local i = 1

  if distance == 0 then
    return self.points[1]:clone()
  end

  while distance > self:length() do
    distance = distance - self:length()
  end 

  while distance > 0 do
    local segment_length, p2
    local p1 = self.points[i]

    if self.closed == true and i == #self.points then
      p2 = self.points[1]
    else
      p2 = self.points[i + 1]
    end 

    segment_length = p1:distance_to(p2)

    if distance > segment_length then
      distance = distance - segment_length
    elseif distance >= 0 then
      local angle = p1:angle_to(p2)
      
      point = p1:clone():move_vector(angle, distance)
      distance = distance - segment_length
    end

    i = i + 1
  end

  return point
end

-- detect if two line segments intersect and at what point
local function line_segment_intersection(line_A_point_A, line_A_point_B, line_B_point_A, line_B_point_B)
  local denominator = ((line_B_point_B.y - line_B_point_A.y) * (line_A_point_B.x - line_A_point_A.x)) -
                      ((line_B_point_B.x - line_B_point_A.x) * (line_A_point_B.y - line_A_point_A.y))
  
  local a = line_A_point_A.y - line_B_point_A.y
  local b = line_A_point_A.x - line_B_point_A.x
  
  local numerator_A = ((line_B_point_B.x - line_B_point_A.x) * a) - ((line_B_point_B.y - line_B_point_A.y) * b)
  local numerator_B = ((line_A_point_B.x - line_A_point_A.x) * a) - ((line_A_point_B.y - line_A_point_A.y) * b)

  a = numerator_A / denominator
  b = numerator_B / denominator

  if denominator == 0 then
    return false
  end

  local intersection_point = {
    x = line_A_point_A.x + (a * (line_A_point_B.x - line_A_point_A.x)),
    y = line_A_point_A.y + (a * (line_A_point_B.y - line_A_point_A.y))
  }

  if a > 0 and a < 1 and b > 0 and b < 1 then 
    return intersection_point
  else 
    return false
  end 
end

-- Return `true` if the path intersects itself. Return false if not.
function path:intersects_self()
  local intersects_self = false
  local segments = self:get_segments()

  for _, a in ipairs(segments) do
    for _, b in ipairs(segments) do
      if type(line_segment_intersection(a[1], a[2], b[1], b[2])) == 'table' then 
        intersects_self = true
      end
    end 
  end

  return intersects_self
end

-- Return a table of points containing the intersections with a specified path.
-- ↓ Not yet imlipmented ↓
function path:intersections(path)
  print('not yet implimented')
end

-- Return true if path is equal to a supplied path
function path:equal_to(path)
  local is_equal = true

  if #self.points == #path.points then
    for i, p in ipairs(self.points) do
      if not p:equal_to(path.points[i]) then is_equal = false end
    end
  end

  return is_equal
end

-- Return an identical copy of a path.
function path:clone()
  return utl.clone(self)
end

-- Set the pen to draw the path.
function path:set_pen(pen)
  table.insert(pen.paths, self)

  return self
end

-- Return a string of a SVG `<path>` element for the path.
function path:render()
  local path_tag = ""

  for i, p in ipairs(self.points) do
    if i == 1 then
      path_tag = 'M '
    else
      path_tag = path_tag .. ' L'
    end

    path_tag = path_tag .. p.x .. ' ' .. p.y
  end

  if self.closed == true then path_tag = path_tag .. ' Z' end

  return '<path d="' .. path_tag .. '"/>'
end

-- Return a G code string for the path
function path:render_gcode()
  local gcode = ""

  for i, p in ipairs(self.points) do
    gcode = gcode .. string.format('\nG1 X%f Y%f', p.x, p.y)

    if i == 1 then gcode = gcode .. '\nM03 S1000' end
  end

  if self.closed then
    gcode = gcode .. string.format(
      '\nG1 X%f Y%f',
      self.points[1].x,
      self.points[1].y
    )
  end

  return gcode .. '\nM05 S1000'
end

-- Return a string with path information including all child points information.
-- Used internally.
function path:get_log()
  local log = string.format('Path { closed  = %s }', self.closed)
  local point_log = ""

  for i, p in ipairs(self.points) do
    local pString = string.gsub(
      p:get_log(), 'Point', string.format('\nPoint: %d', i)
    )
    point_log = point_log .. pString
  end

  return log .. utl.indent(point_log)
end

-- print path information including all child points information.
function path:log()
  print(self:get_log())
end

-- Return Path generator
return Path