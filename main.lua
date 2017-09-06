local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local cyan = Pen:new({ weight = 2, color = "0ef" })
      paper:addPens(cyan)


local dot = Shape.RegPolygon(paper.center, 3, 6)
            :setPen(cyan)
            :scale(10)
            :move(100, 100)
            :rotate(180, paper.center)
            :moveVector(135, 141.421356)
            :scale(4)

paper:saveTo('svg-output/testy.svg')