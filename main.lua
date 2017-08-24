local paper = require("modules/paper")
local   pen = require("modules/pen")
local  path = require("modules/path")
local point = require("modules/point")



local paper = paper:new({ width = 297, height = 210 })
local pen = pen:new({ weight = 2, color = "#000" })
      paper:addPen(pen)



local p0 = point:new({ x = 100, y = 100 })

local  p1 = point:new({ x = 100, y = 80 })
local  p2 = point:new({ x = 110, y = 80 })
local  p3 = point:new({ x = 120, y = 80 })
local  p4 = point:new({ x = 120, y = 90 })
local  p5 = point:new({ x = 120, y = 100 })
local  p6 = point:new({ x = 120, y = 110 })
local  p7 = point:new({ x = 120, y = 120 })
local  p8 = point:new({ x = 110, y = 120 })
local  p9 = point:new({ x = 100, y = 120 })
local p10 = point:new({ x = 90, y = 120 })
local p11 = point:new({ x = 80, y = 120 })
local p12 = point:new({ x = 80, y = 110 })
local p13 = point:new({ x = 80, y = 100 })
local p14 = point:new({ x = 80, y = 90 })
local p15 = point:new({ x = 80, y = 80 })
local p16 = point:new({ x = 90, y = 80 })

print("p1 " .. p0:getAngleTo(p1))
print("p2 " .. p0:getAngleTo(p2))
print("p3 " .. p0:getAngleTo(p3))
print("p4 " .. p0:getAngleTo(p4))

print("p5 " .. p0:getAngleTo(p5))
print("p6 " .. p0:getAngleTo(p6))
print("p7 " .. p0:getAngleTo(p7))
print("p8 " .. p0:getAngleTo(p8))

print("p9 " .. p0:getAngleTo(p9))
print("p10 " .. p0:getAngleTo(p10))
print("p11 " .. p0:getAngleTo(p11))
print("p12 " .. p0:getAngleTo(p12))

print("p13 " .. p0:getAngleTo(p13))
print("p14 " .. p0:getAngleTo(p14))
print("p15 " .. p0:getAngleTo(p15))
print("p16 " .. p0:getAngleTo(p16))


myPoint = point:new()


paper:saveTo('svg-output/testy.svg')
paper:preview('html-preview/preview.html')