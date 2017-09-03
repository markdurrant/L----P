local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local black = Pen:new({ weight = 2, color = "#000" })
      paper:addPen(black)

l1 = Shape.Line(
  Point:new(100, 100),
  Point:new(200, 200)
)

l2 = Shape.Line(
  Point:new(200, 100),
  Point:new(100, 200)
)

black:addPaths(l1, l2)

local dotPoint = Point.getIntersection(l1.points[1], l1.points[2], l2.points[1], l2.points[2])

local red = Pen:new({ weight = 2, color = "#f00" })
      paper:addPen(red)

local dot = Shape.RegPolygon(dotPoint, 10, 8)
      dot:setPen(red)

paper:saveTo('svg-output/testy.svg')