local Path = require("modules/path")

local Shape = {}

Shape.Line = function(p1, p2)
  local line = Path:new()
        line:addPoint(p1, p2)
  
  return line
end

return Shape
