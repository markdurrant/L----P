local paper = require("modules/paper")
local   pen = require("modules/pen")
local  path = require("modules/path")
local point = require("modules/point")

local new = {}

function new:paper(width, height)
  local this = paper:new(width, height)

  return this
end

function new:pen(weight, color)
  local this = pen:new(weight, color)

  return this
end

function new:path()
  local this = path:new()

  return this
end

function new:point(x, y)
  local this = point:new(x, y)

  return this
end

return new