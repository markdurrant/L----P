local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local cyan = Pen:new({ weight = 2, color = "0ef" })

local size = 100

local square = Path:new(
  Point:new(paper.center.x - size / 2, paper.center.y + size / 2),
  Point:new(paper.center.x + size / 2, paper.center.y + size / 2),
  Point:new(paper.center.x + size / 2, paper.center.y - size / 2),
  Point:new(paper.center.x - size / 2, paper.center.y - size / 2)
):close():setPen(cyan)

paper:addPens(cyan)
paper:saveTo('svg-output/testy.svg')