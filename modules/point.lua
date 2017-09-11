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

-- create a new point from vector (origin, angle, distance)
-- North = 0, East = 90, South = 180, West = 270
function Point:newVector(origin, angle, distance)
  point = Point:new(origin.x, origin.y)
  point:moveVector(angle, distance)

  return point
end

-- create a copy of the Point
function Point:clone()
  return utl.clone(self)
end

-- add the Point to a path
function Point:setPath(path)
  table.insert(path, self)

  return self
end

-- move the Point in X & Y
function Point:move(x, y)
  if not y then y = x end

  self.x = self.x + x
  self.y = self.y + y

  return self
end

-- move the Point in X
function Point:moveX(x)
  self.x = self.x + x

  return self
end

-- move the Point in Y
function Point:moveY(y)
  self.y = self.y + y

  return self
end

-- move the Point along a vector (angle & distance)
-- North = 0, East = 90, South = 180, West = 270
function Point:moveVector(angle, distance)
  angle = math.rad(angle - 90)

  self.x = self.x + math.cos(angle) * distance
  self.y = self.y + math.sin(angle) * distance

  return self
end

-- rotate the Point around an origin (point) in degrees
function Point:rotate(angle, point)
  local radians = math.rad(angle)

  local x1 = self.x - point.x
  local y1 = self.y - point.y

  local x2 = x1 * math.cos(radians) - y1 * math.sin(radians)
  local y2 = x1 * math.sin(radians) + y1 * math.cos(radians)

  self.x = x2 + point.x
  self.y = y2 + point.y

  return self
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

-- get intersection of two lines
-- from https://codea.io/talk/discussion/5930/line-segment-intersection
function Point.getIntersection(path1PointA, path1PointB, path2PointA, path2PointB)
  local intersect = nil
  
  local x1 = path1PointA.x
  local y1 = path1PointA.y
  
  local x2 = path1PointB.x
  local y2 = path1PointB.y
  
  local x3 = path2PointA.x
  local y3 = path2PointA.y
  
  local x4 = path2PointB.x
  local y4 = path2PointB.y

  local d = (y4-y3) * (x2-x1) - (x4-x3) * (y2-y1)
  local Ua_n = ((x4-x3) * (y1-y3) - (y4-y3) * (x1-x3))
  local Ub_n = ((x2-x1) * (y1-y3) - (y2-y1) * (x1-x3))

  local Ua = Ua_n / d
  local Ub = Ub_n / d
  local px = x1 + Ua * (x2-x1)
  local py = y1 + Ua * (y2-y1) 

  if Ua > 0 and Ua < 1 and Ub > 0 and Ub < 1 then 
    intersect = Point:new(px, py)
  end

  return intersect
end

-- find a point that is furtherst away from all other points in the list,
-- and add it to the list
function Point:bestCandidate(list, pointGenerator, noCandidates)
  local bestCandidate
  local bestDistance = 0

  -- find the closest point in list of points
  local function closest(list, point)
    local closest = list[1]
    local bestDistance = closest:getDistanceTo(point)

    for _, p in ipairs(list) do
      local distance = p:getDistanceTo(point)

      if distance  < bestDistance then
        bestDistance = distance
        closest = p
      end
    end

    return closest
  end

  if #list == 0 then
    table.insert(list, pointGenerator())
  end

  for i = 1, noCandidates do
    local candidate = pointGenerator()
    local distance = closest(list, candidate):getDistanceTo(candidate)

    if distance > bestDistance then
      bestDistance = distance
      bestCandidate = candidate
    end
  end

  table.insert(list, bestCandidate)
end

-- print Point details
function Point:log()
  print(string.format("point { x = %s, y = %s }", self.x, self.y))
end

-- return the Point module 
return Point