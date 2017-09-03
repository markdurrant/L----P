local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local black = Pen:new({ weight = 2, color = "#000" })
local red = Pen:new({ weight = 2, color = "#f00" })
      paper:addPens(black, red)

local size = 280

local square = Path:new(
  Point:new(paper.center.x + size / 2, paper.center.y - size / 2),
  Point:new(paper.center.x + size / 2, paper.center.y + size / 2),
  Point:new(paper.center.x - size / 2, paper.center.y + size / 2),
  Point:new(paper.center.x - size / 2, paper.center.y - size / 2)
)
square:setPen(black)

local hexagon = Shape.RegPolygon(paper.center, 200, 6)
      hexagon:setPen(black)

square.closed = true

local intersects = square:getIntersections(hexagon)

local function dot(point)
  local dot = Shape.RegPolygon(point, 10, 12)

  dot:setPen(red)
end

for i, intersect in ipairs(intersects) do
  dot(intersect)
end

paper:saveTo('svg-output/testy.svg')