require("../L-P/L-P")

math.randomseed(os.clock())


local paper = Paper({ width = 297, height = 210 })
local black = Pen({ weight = 2, color = "#f33" })


local gridSize = 10.5
local density = 3
local padding = gridSize / density


local rows = 20
local cols = 25

local padCells = 4

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


for r = padCells, rows - padCells - 1 do
  for c = padCells, cols - padCells - 1 do
    local x = c * gridSize
    local y = r * gridSize

    -- drawCell(x, y)
  end
end


local margin = Path({
  Point(gridSize * padCells, gridSize * padCells),
  Point(gridSize * (cols - padCells), gridSize * padCells),
  Point(gridSize * (cols - padCells), gridSize * (rows - padCells)),
  Point(gridSize * padCells, gridSize * (rows - padCells))
}):close():setPen(black)

black:saveGCode("r-schneeberger-ut-5.nc")

paper:addPens({ black })
paper:saveSvg("./examples/r-schneeberger-ut-5.svg")