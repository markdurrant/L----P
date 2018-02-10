require("../L-P/L-P")

math.randomseed(os.time())

local black = Pen({ weight = 1, color = "#000" })
local blue = Pen({ weight = 0.5, color = "#0ff" })
local red = Pen({ weight = 0.5, color = "#f0f" })
local paper = Paper({ width = 100, height = 140 })
      paper:addPens({black, red, blue})

local square_size = 49 + math.random() * 2
      square_size = square_size / 2

local square = Path({
  Point(paper.center.x + square_size, paper.center.y + square_size),
  Point(paper.center.x + square_size, paper.center.y - square_size),
  Point(paper.center.x - square_size, paper.center.y - square_size),
  Point(paper.center.x - square_size, paper.center.y + square_size)
}):close():setPen(blue)

local guide_A = Path({
  square.points[1]:clone():moveVector(math.random() * 360, math.random() * 4),
  square.points[2]:clone():moveVector(math.random() * 360, math.random() * 4)
}):close():setPen(red)

local guide_B = Path({
  square.points[4]:clone():moveVector(math.random() * 360, math.random() * 4),
  square.points[3]:clone():moveVector(math.random() * 360, math.random() * 4)
}):close():setPen(red)

local point_list = {}
local num_lines = 45
      num_lines = num_lines * 2

for l = 0, num_lines + 2 do
  if l % 2 == 0 then
    table.insert(
      point_list,
      guide_A:pointAtDistance((guide_A:length() / num_lines * l))
    )
    table.insert(
      point_list,
      guide_B:pointAtDistance((guide_B:length() / num_lines * l))
    )
  else 
    table.insert(
      point_list,
      guide_B:pointAtDistance((guide_B:length() / num_lines * l))
    )
    table.insert(
      point_list,
      guide_A:pointAtDistance((guide_B:length() / num_lines * l))
    )
  end
end

local snake = Path(point_list):setPen(black)
      snake:rotate(math.random(0, 1) * 90)

black:saveGCode("main.nc")
paper:saveSvg("main.svg")