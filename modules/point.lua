local point = {}

function point:new(x, y)
  local this = {}

  this.type = "point"
  this.x = x
  this.y = y

  function this:log()
    print("point x: %d y: %d", this.x, this.y)
  end

  function this:getDistance(point)
    local a = this.x - point.x
    local b = this.y - point.y

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

  return this
end

return point