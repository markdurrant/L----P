require("../L-P/L-P")

math.randomseed(os.clock())


local paper = Paper({ width = 160, height = 160 })
local black = Pen({ weight = 2, color = "rgba(0, 0, 0, 0.5)" })


local gridSize = 20
local density = 3
local padding = gridSize / density


local rows = 8
local cols = 8

local padCells = 1

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

    drawCell(x, y)
  end
end


-- for _, p in ipairs(black.paths) do
--   for _, p2 in ipairs(black.paths) do
--     if p:equalTo(p2) then
--       print("!")
--     end
--   end
-- end


local margin = Path({
  Point(gridSize * padCells, gridSize * padCells),
  Point(gridSize * (cols - padCells), gridSize * padCells),
  Point(gridSize * (cols - padCells), gridSize * (rows - padCells)),
  Point(gridSize * padCells, gridSize * (rows - padCells))
}):close():setPen(black)

black:saveGCode("r-schneeberger-ut-5.nc")

paper:addPens({ black })
paper:saveSvg("./examples/r-schneeberger-ut-5.svg")