local point = {}

function point:new(x, y)
  local this = {}

  this.type = "point"
  this.x = x
  this.y = y

  return this
end

return point