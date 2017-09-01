local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local black = Pen:new({ weight = 2, color = "#000" })
      paper:addPen(black)

p = Shape.RegPolygon(paper.center, 150, 4)
p:setPen(black)
p:log()

paper:saveTo('svg-output/testy.svg')