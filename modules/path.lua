-- get Point module
require("modules/point")

-- Set up Path class, and set closed to false
local pathTable = { label = 'Path', closed = false }

-- Return a new path with an optional table or list of points.
function Path(...)
  local path = {}
  local t = { ... }

  setmetatable(path, { __index = pathTable })

  if not t[1] then -- if the Path is created with no points
    path.points = {}
  elseif t[1].label == 'Point' then -- if a list of points is supplied
    path.points = t

    path:setBox()
  else -- if a table of points is supplied
    path.points = {}

    for _, p in ipairs(t[1]) do
      table.insert(path.points, p)
    end

    path:setBox()
  end

  return path
end

-- Sets the bounding box for the path. Used internally.
function pathTable:setBox()
  local top    = self.points[1].y
  local bottom = self.points[1].y
  local left   = self.points[1].x 
  local right  = self.points[1].x

  for i, point in ipairs(self.points) do
    if point.y > top then
      top = point.y 
    end
    if point.y < bottom then
      bottom = point.y
    end
    if point.x > right then
      right = point.x
    end
    if point.x < left then
      left = point.x
    end
  end
  
  local hCenter = left + (right - left) / 2
  local vCenter = bottom + (top - bottom) / 2

  self.top          = top
  self.bottom       = bottom
  self.left         = left
  self.right        = right

  self.topLeft      = Point(left, top)
  self.topCenter    = Point(hCenter, top)
  self.topRight     = Point(right, top)  
  self.middleLeft   = Point(left, vCenter)
  self.center       = Point(hCenter, vCenter)
  self.middleRight  = Point(right, vCenter) 
  self.bottomLeft   = Point(left, bottom)
  self.bottomCenter = Point(hCenter, bottom)
  self.bottomRight  = Point(right, bottom)
end

-- close the path
function pathTable:close()
  self.closed = true

  return self
end

-- open the path
function pathTable:open()
  self.closed = false

  return self
end

-- add points to the Path 
-- give an optional index to add points to the middle of a path
function pathTable:addPoints(...)
  local t = { ... }
  local index = 0

  if type(t[#t]) == "number" then -- if an index is supplied
    index = t[#t]
    table.remove(t, #t)
  elseif #t == 1 or #self.points == 0 then -- only one point is supplied
    index = 0
  else -- if a table of points is supplied
    index = #t
  end

  for i, point in ipairs(t) do
    table.insert(self.points, index + i, point)
  end

  self:setBox()

  return self
end

-- Return Path generator
return Path