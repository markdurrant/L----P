local Path = require("modules/path")

local Shape = {}

function Shape.Line(point1, point2)
  local line = Path:new()
        line:addPoints(point1, point2)
  
  return line
end

function Shape.RegPolygon(center, radius, sides)
  local polygon = Path:new()
  
  for i = 1, sides do
    local point = center:clone()
          point:moveVector(360 / sides * i, radius)
    
    polygon:addPoints(point)
  end 

  polygon.closed = true

  return polygon
end

return Shape
