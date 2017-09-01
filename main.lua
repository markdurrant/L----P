local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local p = Path:new(
  Point:new(10, 0),
  Point:new(20, 0),
  Point:new(30, 0)
)

p:addPoints(
  Point:new(40, 0),
  Point:new(50, 0),
  Point:new(60, 0)
)

p:removePoints(2, 3)

p:log()