require("../L-P/L-P")


local paper = Paper({ width = 350, height = 350 })
local blue = Pen({ weight = 2, color = "#339" })


paper:addPens({ blue })
paper:saveSvg("main.svg")