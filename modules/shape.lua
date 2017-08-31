local Path = require("modules/path")

local Shape = {}

function Shape.Line(point1, point2)
  local line = Path:new()
        line:addPoint(point1, point2)
  
  return line
end

return Shape
