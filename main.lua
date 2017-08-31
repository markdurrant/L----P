local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

-- local paper = Paper:new({ width = 500, height = 500 })
-- local black = Pen:new({ weight = 2, color = '#000' })
--       paper:addPen(black)

local p1 = Path:new({ points = {
  Point:new(0, 0), 
  Point:new(40, 30),
  Point:new(80, 0)
}})

print(p1:getLength())

p1.closed = true

print(p1:getLength())

-- paper:saveTo('svg-output/testy.svg')
-- paper:preview('html-preview/preview.html')