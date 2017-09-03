-- get utilities & Point
local utl = require("modules/utl")
local Point = require("modules/point")

-- set up Path table and label
local Path = { label = "path" }
      Path.metatable = { __index = Path }

-- create new Path with points table
function Path:new(...)
  local path = {}
        path.points = {}
        path.closed = false

  if {...} then
    path.points = {...}
  end

  setmetatable(path, Path.metatable)

  if path.points[1] then
    path:setBbox()
  end

  return path
end

-- set bounding box for Path
function Path:setBbox()
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

  self.top    = top
  self.bottom = bottom
  self.left   = left
  self.right  = right

  self.topLeft      = Point:new(left, top)
  self.topCenter    = Point:new(left + (right - left) / 2, top)
  self.topRight     = Point:new(right, top)  
  self.middleLeft   = Point:new(left, bottom + (top - bottom) / 2)
  self.center       = Point:new(left + (right - left) / 2, bottom + (top - bottom) / 2)
  self.middleRight  = Point:new(right, bottom + (top - bottom) / 2) 
  self.bottomLeft   = Point:new(left, bottom)
  self.bottomCenter = Point:new(left + (right - left) / 2, bottom)
  self.bottomRight  = Point:new(right, bottom)
end

-- add points to the Path 
-- give an optional index to add points to the middle of a path
function Path:addPoints(...)
  local t = { ... }
  local index = 0

  if type(t[#t]) == "number" then
    index = t[#t]
    table.remove(t, #t)
  elseif #t == 1 or #self.points == 0 then
    index = 0
  else
    index = #t
  end

  for i, point in ipairs(t) do
    table.insert(self.points, index + i, point)
  end

  self:setBbox()
end

-- remove points from the Path at a specified position
function Path:removePoints(index, number)
  if index then
    for i = 1, number do
      table.remove(self.points, index)
    end
  else
    for i = 1, number do
      table.remove(self.points)
    end
  end

  self:setBbox()
end

-- set the pen for the Path
function Path:setPen(pen)
  table.insert(pen.paths, self)
end

-- rotate the path around an origin
function Path:rotate(angle, point)
  for _, point in ipairs(self.points) do
    point:rotate(angle, point)
  end

  self:setBbox()
end

-- move the Path in X & Y
function Path:move(x, y)
  for _, point in ipairs(self.points) do
    point:move(x, y)
  end

  self:setBbox()
end

-- move the Path in X
function Path:moveX(x)
  for _, point in ipairs(self.points) do
    point:moveX(x)
  end

  self:setBbox()
end

-- move the Path in Y
function Path:moveY(y)
  for _, point in ipairs(self.points) do
    point:moveY(y)
  end

  self:setBbox()
end

-- create a copy of the Path
function Path:clone()
  return utl.clone(self)
end

-- get the total length of the path
function Path:getLength()
  local length = 0

  for i, point in ipairs(self.points) do  
    if i ~= #self.points then
      length = length + self.points[i]:getDistanceTo(self.points[i + 1])
    end
  end

  if self.closed == true then
    length = length + self.points[#self.points]:getDistanceTo(self.points[1])
  end

  return length
end

function Path:getPointAtDistance(distance)
end

-- get the intersections with a second path
function Path:getIntersections(path)
  local intersections = {}

  for p1 = 1, #self.points do
    if p1 < #self.points or self.closed == true then

      for p2 = 1, #path.points do
        if p2 < #path.points or path.closed == true then

          local pA = self.points[p1]
          local pB = self.points[p1 + 1] or self.points[1]

          local pC = path.points[p2]
          local pD = path.points[p2 + 1] or path.points[1]

          local intersect = Point.getIntersection(pA, pB, pC, pD)
          
          if intersect then
            table.insert(intersections, intersect)
          end
        end
      end
    end
  end

  return intersections
end

-- render the Path
function Path:render()
  local pathTag = ""

  for i, point in ipairs(self.points) do
    if i == 1 then
      pathTag = "M "
    else
      pathTag = pathTag .. " L"
    end

    pathTag = pathTag .. point.x .. " " .. point.y
  end

  if self.closed == true then pathTag = pathTag .. " Z" end

  pathTag = '<path d="' .. pathTag .. '"/>'

  return pathTag
end

-- print Path details
function Path:log()
  local pathLog = string.format("path { closed = %s }", self.closed)

  for i, point in ipairs(self.points) do
    pathLog = pathLog .. string.format(
      "\n  point :%s { x = %s, y = %s }",
      i, point.x, point.y
    )
  end

  print(pathLog)
end

-- return the Path module
return Path