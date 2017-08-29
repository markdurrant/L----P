local utl = require("modules/utl")

local Point = { label = "point" }
      Point.metatable = { __index = Point }

function Point:new(t)
  if not t then t = {} end
  if not t.x then t.x = 0 end
  if not t.y then t.y = 0 end

  setmetatable(t, Point.metatable)

  return t
end

function Point:log()
  print(string.format("point { x = %s, y = %s }", self.x, self.y))
end

function Point:setPath(path)
  table.insert(path, self)
end

function Point:move(x, y)
  if not y then y = x end

  self.x = self.x + x
  self.y = self.y + y
end

function Point:rotate(angle, origin)
  local radians = math.rad(angle)

  local x1 = self.x - origin.x
  local y1 = self.y - origin.y

  local x2 = x1 * math.cos(radians) - y1 * math.sin(radians)
  local y2 = x1 * math.sin(radians) + y1 * math.cos(radians)

  self.x = x2 + origin.x
  self.y = y2 + origin.y
end

function Point:clone()
  return utl.clone(self)
end

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

function Point:getAngleTo(point)
  local a = self.x - point.x
  local b = self.y - point.y

  local angle = math.atan2(b, a) * 180 / math.pi

  if angle < 0 then angle = angle + 360 end

  angle = angle - 90

  if angle < 0 then angle = 360 + angle end

  return angle
end

return Point