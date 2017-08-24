local paper = require("modules/paper")
local   pen = require("modules/pen")
local  path = require("modules/path")
local point = require("modules/point")

paper = paper:new({ width = 297, height = 210 })

local bluePen = pen:new({ weight = 2, color = "#09f" })

local offset = 4

local myPath = path:new()

myPath:addPoint(
  point:new({ x = offset, y = offset }),
  point:new({ x = paper.width - offset, y = offset }),
  point:new({ x = paper.width - offset, y = paper.height - offset }),
  point:new({ x = offset, y = paper.height - offset })
)

myPath.closed = true
myPath:setPen(bluePen)

paper:addPen(bluePen)

print(paper:render())

paper:saveTo('svg-output/testy.svg')
paper:preview('html-preview/preview.html')