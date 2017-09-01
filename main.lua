local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local p1 = Path:new(
  Point:new(0, 0), 
  Point:new(40, 30),
  Point:new(80, 0)
)

p1:log()