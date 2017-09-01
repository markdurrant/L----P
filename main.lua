local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local p = Path:new(
  Point:new(100, 100),
  Point:new(200, 100),
  Point:new(200, 200),
  Point:new(100, 200)
)