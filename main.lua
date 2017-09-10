local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local black = Pen:new({ weight = 2, color = "#000" })


-- return a random point
local function randomPoint()
  return Point:new(
    utl.random(40, paper.width - 40),
    utl.random(40, paper.height - 40)
  )
end

local points = {}

for i = 1, 100 do
  Point:bestCandidate(points, randomPoint, 10)
end

for _, p in ipairs(points) do
  Shape.RegPolygon(p, 2, 6):setPen(black)
end

paper:addPens(black)
paper:saveTo('svg-output/testy.svg')