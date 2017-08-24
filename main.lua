local paper = require("modules/paper")
local   pen = require("modules/pen")
local  path = require("modules/path")
local point = require("modules/point")



local paper = paper:new({ width = 297, height = 210 })
local pen = pen:new({ weight = 1.5, color = "#000" })
      paper:addPen(pen)



local function cross(p)
  local size = 2

  local l1 = path:new()
        l1:addPoint(
          point:new({ x = p.x - size, y = p.y - size  }),
          point:new({ x = p.x + size, y = p.y + size  })
        )

  local l2 = path:new()
        l2:addPoint(
          point:new({ x = p.x - size, y = p.y + size }),
          point:new({ x = p.x + size, y = p.y - size })
        )

  pen:addPath(l1, l2)
end

local p0 = point:new({ x = paper.width / 2, y = paper.height / 2 })
local p1 = point:new({ x = paper.width / 2, y = paper.height / 2 - 50 })


cross(p0)

p1:rotate(45, p0)

cross(p1)



paper:saveTo('svg-output/testy.svg')
paper:preview('html-preview/preview.html')