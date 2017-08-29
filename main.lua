local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local black = Pen:new({ weight = 2, color = '#000' })
      paper:addPen(black)

p1 = Point:new({ x = 100, y = 100 })
p2 = Point:new({ x = 200, y = 200 })

l1 = Shape.Line(p1, p2)
l1:setPen(black)

paper:log()

paper:saveTo('svg-output/testy.svg')