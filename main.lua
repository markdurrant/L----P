local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local pink = Pen:new({ weight = 1.4, color = "#f09" })
local blue = Pen:new({ weight = 1.4, color = "#09f" })
      paper:addPens(blue, pink)

local baseAngle = 210

local p1 = Point:new(220, 140)
local p2 = Point:new(420, 260)
local p3 = Point:new(300, 250)
local p4 = Point:new(120, 160)

for i = 1, 22 do
  local pa1 = p1:clone()
  local pa2 = p2:clone()
  local pa3 = p3:clone()
  local pa4 = p4:clone()

  local distance = i * 2.65

  pa1:moveVector(baseAngle - 5, distance)
  pa2:moveVector(baseAngle - 16, distance)
  pa3:moveVector(baseAngle, distance)
  pa4:moveVector(baseAngle, distance)

  local poly1 = Path:new(pa2, pa3, pa4)
        poly1:setPen(blue)
  
  local poly2 = Path:new(pa4, pa1, pa2)
        poly2:setPen(pink)
end

paper:saveTo('svg-output/testy.svg')