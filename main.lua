require('../L-P/L-P')

math.randomseed(os.time())

local black = Pen({ weight = 1, color = '#000' })
local blue = Pen({ weight = 0.5, color = '#0ff' })
local red = Pen({ weight = 0.5, color = '#f0f' })
local paper = Paper({ width = 100, height = 140 })
      paper:add_pens({black, red, blue})



      
paper:save_svg('main.svg')