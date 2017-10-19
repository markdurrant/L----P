require("../L-P/L-P")


local paper = Paper({ width = 210, height = 297 })
local blue = Pen({ weight = 2, color = "#339" })


local path = Path({
  Point(10, 10),
  Point(20, 10),
  Point(20, 20),
  Point(10, 20)
}):close():setPen(blue)

local path2 = Path({
  Point(40, 40),
  Point(80, 40),
  Point(80, 80),
  Point(40, 80)
}):close():setPen(blue)

blue:saveGCode("main.nc")

paper:addPens({ blue })
paper:saveSvg("main.svg")