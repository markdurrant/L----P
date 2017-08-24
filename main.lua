local paper = require("modules/paper")
local   pen = require("modules/pen")
local  path = require("modules/path")
local point = require("modules/point")



local paper = paper:new({ width = 297, height = 210 })
local pen = pen:new({ weight = 1.5, color = "#000" })
      paper:addPen(pen)

local center = point:new({ x = paper.width / 2, y = paper.height / 2 })

local line = path:new({ points = {
    point:new({ x = center.x, y = center.y - 20 }),
    point:new({ x = center.x, y = center.y - 60 })
  }})
line:setPen(pen)

paper:saveTo('svg-output/testy.svg')
paper:preview('html-preview/preview.html')