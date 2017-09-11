local start = os.clock()

local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })

local black = Pen:new({ weight = 2, color = "#000" })
local pink = Pen:new({ weight = 2, color = "#f09" })
local blue = Pen:new({ weight = 2, color = "#09f" })


local margin = 100

local function randomPoint()
  return Point:new(
    math.random(margin, paper.width - margin),
    math.random(margin, paper.height - margin)
  )
end

local points = {}

for i = 1, 5000 do
  Point:bestCandidate(points, randomPoint, 50)
end

for _, p in ipairs(points) do
  Shape.RegPolygon(p, 1, 6):setPen(pink)
end

print(#points)

paper:addPens(black, pink, blue)
paper:saveTo('svg-output/testy.svg')

print("completed in " .. start + os.clock() .. " seconds")