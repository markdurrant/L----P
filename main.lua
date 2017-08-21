local log = require("modules/logTable")

local paper = require("modules/paper")
local pen = require("modules/pen")
local path = require("modules/path")
local point = require("modules/point")

local a4 = paper:new(297, 210)
local bluePen = pen:new(5, "#09f")

print(a4.pens)