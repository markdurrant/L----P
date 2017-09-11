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
local paths = {}

for i = 2, 100 do
  Point:bestCandidate(points, randomPoint, 100)
end

local function line(point)
  return Path:new(point, points[math.random(#points)])
end

for i, point in ipairs(points) do
  Shape.RegPolygon(point, 2, 6):setPen(blue)

  local line = line(point)

  if math.fmod(i, 3) == 0 then
    line:setPen(pink)
    table.insert(paths, line)
  end
end


paper:addPens(blue, pink, black)
paper:saveTo('svg-output/testy.svg')

print("completed in " .. start + os.clock() .. " seconds")