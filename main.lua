local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local cyan = Pen:new({ weight = 2, color = "0ef" })
local pink = Pen:new({ weight = 2, color = "f09" })

local function cross(point)
  local inner = 3
  local outer = 6

  local tl = Path:new(
    Point:new(point.x - inner, point.y - inner),
    Point:new(point.x - outer, point.y - outer)
  ):setPen(pink)

  local tr = Path:new(
    Point:new(point.x + inner, point.y - inner),
    Point:new(point.x + outer, point.y - outer)
  ):setPen(pink)

  local br = Path:new(
    Point:new(point.x + inner, point.y + inner),
    Point:new(point.x + outer, point.y + outer)
  ):setPen(pink)

  local bl = Path:new(
    Point:new(point.x - inner, point.y + inner),
    Point:new(point.x - outer, point.y + outer)
  ):setPen(pink)
end

local size = 100

local square = Path:new(
  Point:new(paper.center.x - size / 2, paper.center.y - size / 2),
  Point:new(paper.center.x + size / 2, paper.center.y - size / 2),
  Point:new(paper.center.x + size / 2, paper.center.y + size / 2),
  Point:new(paper.center.x - size / 2, paper.center.y + size / 2)
):setPen(cyan)

local five = Shape.RegPolygon(paper.center, 150, 5):setPen(cyan)

local p1 = five:getPointAtDistance(25)
cross(p1)


paper:addPens(cyan, pink)
paper:saveTo('svg-output/testy.svg')