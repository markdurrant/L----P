require("../L-P/L-P")

math.randomseed(os.clock())


local paper = Paper({ width = 210, height = 297 })
local black = Pen({ weight = 2, color = "#f3b" })


local gridSize = 15
local density = 3
local padding = gridSize / density


local rows = 18
local cols = paper.width / gridSize


local function drawCell(x, y)
  local rand = math.random()

  for d = 1, density do
    local p = Path({
      Point(x + padding * d, y),
      Point(x + padding * d, y + gridSize)
    }):setPen(black)

    if rand > 0.5 then
      p:rotate(90, Point(x + gridSize / 2, y + gridSize / 2))
    end
  end
end


for r = 2, rows - 3 do
  for c = 2, cols - 3 do
    local x = c * gridSize
    local y = r * gridSize

    drawCell(x, y)
  end
end

local margin = Path({
  Point(gridSize * 2, gridSize * 2),
  Point(gridSize * (cols - 2), gridSize * 2),
  Point(gridSize * (cols - 2), gridSize * (rows - 2)),
  Point(gridSize * 2, gridSize * (rows - 2))
}):close():setPen(black)

paper:addPens({ black })
paper:saveSvg("r-schneeberger-ut-5.svg")