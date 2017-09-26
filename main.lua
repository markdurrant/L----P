require("L----P/L----P")

math.randomseed(os.clock())

local paper = Paper({ width = 210, height = 297 })

local black = Pen({ weight = 0.5, color = "#000" })


local topLeft = paper.topLeft:clone():move(30, 30)
local topRight = paper.topRight:clone():move(-30, 30)
local bottomLeft = paper.bottomRight:clone():move(-30, -60)
local bottomRight = paper.bottomLeft:clone():move(30, -60)


local numLines = 68
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

  function getDip()
    local dip = math.random(topLeft.x + 2, topRight.x - 2)

    for _, d in ipairs(dips) do
      if d - dip < 4 and d - dip > -4 then
        dip = getDip()
      end
    end

    return dip
  end

  for i = 1, math.random(0, 34 - lineNum / 2) do
    table.insert(dips, getDip())
    table.sort(dips, function(a, b) return a > b end)
  end

  local y = line.top

  for _, d in ipairs(dips) do
    line:addPoints({
      Point(d + 1.5, y),
      Point(d, y + 1.5),
      Point(d - 1.5, y)
    }, 1)
  end
end

for i = 1, #black.paths do
  drawDips(i)
end


paper:addPens({ black })

paper:saveSvg("test.svg")