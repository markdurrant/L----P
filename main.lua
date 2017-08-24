local   log = require("modules/logTable")

local paper = require("modules/paper")
local   pen = require("modules/pen")
local  path = require("modules/path")
local point = require("modules/point")

local   new = require('modules/new')

paper = new:paper({ width = 297, height = 210 })

local bluePen = new:pen({ weight = 2, color = "#09f" })

local offset = 4

local myPath = new:path()

myPath:addPoint(
  new:point({ x = offset, y = offset }),
  new:point({ x = paper.width - offset, y = offset }),
  new:point({ x = paper.width - offset, y = paper.height - offset }),
  new:point({ x = offset, y = paper.height - offset })
)

bluePen:addPath(myPath)

paper:addPen(bluePen)

paper:log()

paper:saveTo('svg-output/testy.svg')