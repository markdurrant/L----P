local   log = require("modules/logTable")

local paper = require("modules/paper")
local   pen = require("modules/pen")
local  path = require("modules/path")
local point = require("modules/point")

paper = paper:new(297, 210)

local bluePen = pen:new(1, "#09f")

local offset = 4

for i = 1, 10 do
  local rect = path:new()
  local offset = offset * i

  rect:addPoint(
    point:new(offset, offset),
    point:new(paper.width - offset, offset),
    point:new(paper.width - offset, paper.height - offset),
    point:new(offset, paper.height - offset)
  )

  rect.closed = true

  bluePen:addPath(rect)
end

paper:addPen(bluePen)

paper:saveTo('svg-output/testy.svg')