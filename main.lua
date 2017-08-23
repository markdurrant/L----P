local   log = require("modules/logTable")

local paper = require("modules/paper")
local   pen = require("modules/pen")
local  path = require("modules/path")
local point = require("modules/point")

local   new = require('modules/new')

paper = new:paper(297, 210)

local bluePen = new:pen(1, "#09f")

local offset = 4

for i = 1, 10 do
  local rect = new:path()
  local offset = offset * i

  rect:addPoint(
    new:point(offset, offset),
    new:point(paper.width - offset, offset),
    new:point(paper.width - offset, paper.height - offset),
    new:point(offset, paper.height - offset)
  )

  rect.closed = true

  bluePen:addPath(rect)
end



paper:addPen(bluePen)

paper:saveTo('svg-output/testy.svg')