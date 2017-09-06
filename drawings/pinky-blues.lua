local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local pink = Pen:new({ weight = 1.4, color = "#f09" })
local blue = Pen:new({ weight = 1.4, color = "#09f" })
      paper:addPens(pink, blue)

local baseAngle = 20

local p1 = Point:new(190, 210)
local p2 = Point:new(390, 330)
local p3 = Point:new(270, 320)
local p4 = Point:new(090, 230)

for i = 1, 22 do
  local pa1 = p1:clone()
  local pa2 = p2:clone()
  local pa3 = p3:clone()
  local pa4 = p4:clone()

  local distance = i * 3

  pa1:moveVector(baseAngle + 5, distance)
  pa2:moveVector(baseAngle + 16, distance)
  pa3:moveVector(baseAngle, distance)
  pa4:moveVector(baseAngle, distance)

  local poly2 = Path:new(pa4, pa1, pa2)
        poly2:setPen(blue)

  local poly1 = Path:new(pa2, pa3, pa4)
        poly1:setPen(pink)
end

paper:saveTo('svg-output/testy.svg')