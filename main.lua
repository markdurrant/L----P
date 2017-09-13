local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 210, height = 297 })
local black = Pen:new({ weight = 1, color = "#000" })


paper:addPens(black)
paper:saveTo('svg-output/testy.svg')