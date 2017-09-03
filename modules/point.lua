-- get utilities 
local utl = require("modules/utl")

-- set up Point table & label
local Point = { label = "Point" }
      Point.metatable = { __index = Point }

-- create a new Point with X & Y
function Point:new(x, y)
  local point = {}
        point.x = x or 0
        point.y = y or 0

  setmetatable(point, Point.metatable)

  return point
end

-- create a copy of the Point
function Point:clone()
  return utl.clone(self)
end

-- add the Point to a path
function Point:setPath(path)
  table.insert(path, self)
end

-- move the Point in X & Y
function Point:move(x, y)
  if not y then y = x end

  self.x = self.x + x
  self.y = self.y + y
end

-- move the Point in X
function Point:moveX(x)
  self.x = self.x + x
end

-- move the Point in Y
function Point:moveY(y)
  self.y = self.y + y
end

-- move the Point along a vector (angle & distance)
-- North = 0, East = 90, South = 180, West = 270
function Point:moveVector(angle, distance)
  angle = math.rad(angle - 90)

  self.x = self.x + math.cos(angle) * distance
  self.y = self.y + math.sin(angle) * distance
end

-- rotate the Point around an origin (point) in degrees
function Point:rotate(point, angle)
  local radians = math.rad(angle)

  local x1 = self.x - point.x
  local y1 = self.y - point.y

  local x2 = x1 * math.cos(radians) - y1 * math.sin(radians)
  local y2 = x1 * math.sin(radians) + y1 * math.cos(radians)

  self.x = x2 + point.x
  self.y = y2 + point.y
end

-- get the distance to a second point
function Point:getDistanceTo(point)
  local a = self.x - point.x
  local b = self.y - point.y

  local distance = 0

  if a == 0 then
    distance = b
  elseif b == 0 then
    distance = a
  else
    distance = math.sqrt(a * a + b * b)
  end

  if distance < 0 then distance = distance * -1 end

  return distance
end

-- get the angle to a second point in degrees
-- North = 0, East = 90, South = 180, West = 270
function Point:getAngleTo(point)
  local a = self.x - point.x
  local b = self.y - point.y

  local angle = math.atan2(b, a) * 180 / math.pi

  if angle < 0 then angle = angle + 360 end

  angle = angle - 90

  if angle < 0 then angle = 360 + angle end

  return angle
end

function Point.getIntersection(p1, p2, p3, p4)
  local intersect = utl.getIntersection(p1, p2, p3, p4) 

  if intersect then
    intersect = Point:new(intersect.x, intersect.y)
  else 
    intersect = nil
  end

  return intersect
end

-- print Point details
function Point:log()
  print(string.format("point { x = %s, y = %s }", self.x, self.y))
end

-- return the Point module 
return Point