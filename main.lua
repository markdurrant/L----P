local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local cyan = Pen:new({ weight = 2, color = "0ef" })
local pink = Pen:new({ weight = 2, color = "f09" })


for i = 1, 10 do
  print(utl.random(10))
end


paper:addPens(cyan, pink)
paper:saveTo('svg-output/testy.svg')