require("../L-P/L-P")


local paper = Paper({ width = 210, height = 297 })
local black = Pen({ weight = 0.5, color = "#000" })


paper:addPens({ fuscia, cyan, black })
paper:saveSvg("main.svg")