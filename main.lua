local log = require("modules/logTable")

local paper = require("modules/paper")
local pen = require("modules/pen")
local path = require("modules/path")
local point = require("modules/point")

paper = paper:new(297, 210)

local bluePen = pen:new(5, "#09f")
local greenPen = pen:new(2, "#0F9")

local myPath = path:new()
local myPath2 = path:new()

myPath:addPoint(
  point:new(10, 10),
  point:new(100, 10),
  point:new(100, 100),
  point:new(10, 100)
)

myPath2:addPoint(
  point:new(20, 20),
  point:new(80, 20),
  point:new(80, 80),
  point:new(20, 80)
)

myPath2.closed = true

paper:addPen(bluePen, greenPen)

bluePen:addPath(myPath, myPath2)
greenPen:addPath(myPath)

print(paper:saveTo('svg-output/testy.svg'))