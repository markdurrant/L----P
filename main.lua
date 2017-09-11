local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local black = Pen:new({ weight = 1.5, color = "#000" })
local pink = Pen:new({ weight = 1, color = "#f09" })
local blue = Pen:new({ weight = 1, color = "#09f" })


paper:addPens(black, pink, blue)
paper:saveTo('svg-output/testy.svg')