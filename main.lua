require("../L-P/L-P")


local paper = Paper({ width = 210, height = 297 })
local black = Pen({ weight = 2, color = "#000" })


paper:addPens({ black })
paper:saveSvg("main.svg")