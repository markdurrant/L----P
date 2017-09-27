require("L----P/L----P")

math.randomseed(os.clock())

local paper = Paper({ width = 210, height = 297 })

local black = Pen({ weight = 0.75, color = "#000" })
local cyan = Pen({ weight = 0.5, color = "#0ff" })

local topLeft = paper.topLeft:clone():move(30, 30)
local topRight = paper.topRight:clone():move(-30, 30)
local bottomLeft = paper.bottomRight:clone():move(-30, -60)
local bottomRight = paper.bottomLeft:clone():move(30, -60)


local border = Path({
  paper.topLeft,
  paper.topRight,
  paper.bottomRight,
  paper.bottomLeft
}):close():setPen(cyan)


local numLines = 58
local offset = (bottomLeft.y - topLeft.y) / numLines


for i = 0, numLines do
  Path({
    topLeft:clone():move(0, i * offset),
    topRight:clone():move(0, i * offset)
  }):setPen(black)
end

local function drawDips(lineNum)
  local dips = {}
  local line = black.paths[lineNum]

  local dipTest = 1

  function getDip()
    local dip = math.random(topLeft.x + 2, topRight.x - 2)

    for _, d in ipairs(dips) do
      if dipTest < 10 and d - dip < 4 and d - dip > -4 then
        dip = getDip()
        dipTest = dipTest + 1
        print(dipTest)
      end
    end

    return dip
  end

  for i = 1, math.random(0, 34 - lineNum / 2.25) do
    dipTest = 1
    table.insert(dips, getDip())
    table.sort(dips, function(a, b) return a > b end)
  end

  local y = line.top

  for _, d in ipairs(dips) do
    line:addPoints({
      Point(d + offset / 2, y),
      Point(d + offset / 4, y + offset / 1.5),
      Point(d, y + offset / 3),
      Point(d - offset / 4, y + offset / 1.5),
      Point(d - offset / 2, y)
    }, 1)
  end
end

for i = 1, #black.paths do
  drawDips(i)
end


paper:addPens({ black, cyan })

paper:saveSvg("test.svg")