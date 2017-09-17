-- Set up Point class
local pointClass = { label = "Point" }

-- Return a new point with optional X & Y
function Point(x, y)
  local point = {}
        point.x = x or 0
        point.y = y or x or 0

  setmetatable(point, { __index = pointClass })

  return point
end

-- Return a new point using a vector and an optional origin.
function pointClass:fromVector(direction, length, origin)
  
end

-- Move the Point in X & Y
function pointClass:move(x, y)
  if not y then
    y = x
  end

  self.x = self.x + x
  self.y = self.y + y

  return self
end

-- Move the Point along a vector
function pointClass:moveVector(direction, length)
  angle = math.rad(direction - 90) -- rotate counter-clockwise to make 'north' = 0 degrees

  self.x = self.x + math.cos(angle) * length
  self.y = self.y + math.sin(angle) * length

  return self
end

-- Rotate the Point around an origin (point) in degrees
function pointClass:rotate(angle, point)
  local angle = math.rad(angle)

  local x1 = self.x - point.x
  local y1 = self.y - point.y

  local x2 = x1 + math.cos(angle) - y1 * math.sin(angle)
  local y2 = y1 + math.sin(angle) + y1 * math.cos(angle)

  self.x = x2 + point.x
  self.y = x2 + point.y
end

-- Return the distance between the Point and a second point.
function pointClass:distanceTo(point)
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
function pointClass:angleTo(point)
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
function pointClass:clone()
  print("not yet implimented")
end

-- Print the X & Y values for the point
function pointClass:log()
  print(string.format("Point { x = %s, y = %s }", self.x, self.y))
end

-- Return Point generator
return Point
