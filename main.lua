local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local cyan = Pen:new({ weight = 2, color = "0ef" })
      paper:addPens(cyan)

local size = 100

local square = Path:new(
  Point:new(paper.center.x - size / 2, paper.center.y + size / 2),
  Point:new(paper.center.x + size / 2, paper.center.y + size / 2),
  Point:new(paper.center.x + size / 2, paper.center.y - size / 2),
  Point:new(paper.center.x - size / 2, paper.center.y - size / 2)
):setPen(cyan):close()

square:addPoints(paper.center, 3):addPoints(paper.center, 1)

paper:saveTo('svg-output/testy.svg')