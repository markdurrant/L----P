local point = { label = "point", x = 0, y = 0 }
      point.metatable = { __index = point }

function point:new(t)
  if not t then
    t = {}
  end

  setmetatable(t, point.metatable)

  return t
end

function point:log()
  local pointLog = string.format("POINT, x: %d y: %d", self.x, self.y)

  return pointLog
end

function point:print()
  print(self:log())
end

function point:getDistance(point)
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

  if distance < 0 then
    distance = distance * -1
  end

  return distance
end

return point