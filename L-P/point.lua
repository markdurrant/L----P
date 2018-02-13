-- get Utilities module
local utl = require('L-P/utilities')

-- Set up Point class
local point = { label = 'Point' }

-- Return a new point with optional X & Y
-- ↓ Not yet imlipmented ↓
-- If X & Y values are not supplied the center of the paper will be used
-- for X & Y values.
function Point(x, y)
  local new_point = {}
        new_point.x = x or 0
        new_point.y = y or x or 0

  setmetatable(new_point, { __index = point })

  return new_point
end

-- Move the Point in X & Y
function point:move(x, y)
  if not y then y = x end

  self.x = self.x + x
  self.y = self.y + y

  return self
end

-- Move the Point along a vector
function point:move_vector(direction, length)
  -- rotate counter-clockwise to make 'north' = 0 degrees
  local angle = math.rad(direction - 90) 

  self.x = self.x + math.cos(angle) * length
  self.y = self.y + math.sin(angle) * length

  return self
end

-- Rotate the Point around an origin (point) in degrees
function point:rotate(angle, origin)
  local radians = math.rad(angle)

  local x1 = self.x - origin.x
  local y1 = self.y - origin.y

  local x2 = x1 * math.cos(radians) - y1 * math.sin(radians)
  local y2 = x1 * math.sin(radians) + y1 * math.cos(radians)

  self.x = x2 + origin.x
  self.y = y2 + origin.y

  return self
end

-- Return the distance between the Point and a second point.
function point:distance_to(point_2)
  local a = self.x - point_2.x
  local b = self.y - point_2.y

  local distance

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
function point:angle_to(point_2)
  local a = self.x - point_2.x
  local b = self.y - point_2.y

  local angle = math.atan2(b, a) * 180 / math.pi - 90

  if angle < 0 then angle = angle + 360 end

  return angle
end

-- Return true if point is equal to a supplied point
function point:equal_to(point_2)
  if self.x == point_2.x and self.y == point_2.y then
    return true
  else
    return false
  end
end

-- Return true is point is on line segment

-- Return an identical copy of a point.
function point:clone()
  return utl.clone(self)
end

-- Return a string with the X & Y values for the point. Used internally.
function point:get_log()
  return string.format('Point { x = %s, y = %s }', self.x, self.y)
end

-- Print the X & Y values for the point
function point:log()
  print(self:get_log())
end

-- Return Point generator
return Point