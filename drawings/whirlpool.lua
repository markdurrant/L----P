
local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local cyan = Pen:new({ weight = 1, color = "#0ff" })
local pink = Pen:new({ weight = 1, color = "#f09" })

function ring(number, inner, outer)
  for i = 1, number do
    local l = Path:new(
      paper.center:clone():moveVector(360 / number * i + utl.random() + 4, inner),
      paper.center:clone():moveVector(360 / number * i + utl.random(), outer)
    )

    if utl.random() > 0.5 then
      l:setPen(pink)
    else
      l:setPen(cyan)
    end
  end
end

local step = utl.random(2, 6)
local inner = utl.random(20, 40)
local itterations = 40

for i = 1, itterations do
  ring(60 + i * i / 6, inner + step * i, inner + step + step * i)
end

paper:addPens(cyan, pink)
paper:saveTo('svg-output/testy' .. tostring(utl.random() * 1000) .. '.svg')