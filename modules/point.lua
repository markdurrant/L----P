-- Set up Point class
local pointTable = { label = 'Point' }

-- Return a new point with optional X & Y
-- ↓ Not yet imlipmented ↓
-- If X & Y values are not supplied the center of the paper will be used for X & Y values.
function Point(x, y)
  local point = {}
        point.x = x or 0
        point.y = y or x or 0

  setmetatable(point, { __index = pointTable })

  return point
end

-- Return a new point using a vector and an optional origin.
-- ↓ Not yet imlipmented ↓
-- If an origin is not supplied the center of the paper will be used as the origin
function PointFromVector(direction, length, origin)
  local x = origin.x
  local y = origin.y

  local point = Point(x, y):moveVector(direction, length)

  return point
end

-- Move the Point in X & Y
function pointTable:move(x, y)
  if not y then
    y = x
  end

  self.x = self.x + x
  self.y = self.y + y

  return self
end

-- Move the Point along a vector
function pointTable:moveVector(direction, length)
  angle = math.rad(direction - 90) -- rotate counter-clockwise to make 'north' = 0 degrees

  self.x = self.x + math.cos(angle) * length
  self.y = self.y + math.sin(angle) * length

  return self
end

-- Rotate the Point around an origin (point) in degrees
function pointTable:rotate(angle, point)
  local radians = math.rad(angle)

  local x1 = self.x - point.x
  local y1 = self.y - point.y

  local x2 = x1 * math.cos(radians) - y1 * math.sin(radians)
  local y2 = x1 * math.sin(radians) + y1 * math.cos(radians)

  self.x = x2 + point.x
  self.y = y2 + point.y

  return self
end

-- Return the distance between the Point and a second point.
function pointTable:distanceTo(point)
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

  return math.abs(distance)
end

-- Return the angle between the point and a second point.
function pointTable:angleTo(point)
  local a = self.x - point.x
  local b = self.y - point.y

  local angle = math.atan2(b, a) * 180 / math.pi

  if angle < 0 then 
    angle = angle + 360
  end

  angle = angle - 90

  if angle < 0 then 
    angle = 360 + angle
  end

  return angle
end

-- Return an identical copy of a point.
-- ↓ Not yet imlipmented ↓
function pointTable:clone()
  print("not yet implimented")
end

-- Print the X & Y values for the point
function pointTable:log()
  print(string.format("Point { x = %s, y = %s }", self.x, self.y))
end

-- Return Point generator
return Point
