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

local square = Shape.Rectangle(paper.center, 200, 200)
      square:setPen(black)

local hexagon = Shape.RegPolygon(paper.center, 140, 6)
      hexagon:setPen(black)

local function dot(point)
  local dot = Shape.RegPolygon(point, 10, 12)
        dot:setPen(red)
end

-- dot(square.points[1])

intersects = square:getIntersections(hexagon)

print(#intersects)

for i, intersect in ipairs(intersects) do
  intersect:log()
  dot(intersect)
end

-- dot(square.points[1])
-- dot(square.points[2])
-- dot(hexagon.points[1])
-- dot(hexagon.points[2])

dot(Point.getIntersection(square.points[1], square.points[2], hexagon.points[1], hexagon.points[2]))

paper:saveTo('svg-output/testy.svg')