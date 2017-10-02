require("../L-P/L-P")


local paper = Paper({ width = 210, height = 297 })
local black = Pen({ weight = 0.5, color = "#000" })
local fuscia = Pen({ weight = 0.75, color = "#f09" })
local cyan = Pen({ weight = 0.75, color = "#0ff" })

local function dot(point)
  local dot = Path():close()
  
  for i = 1, 5 do
    dot:addPoints({ PointFromVector(360 / 5 * i, 1, point) })
  end

  return dot
end

function weightedAverage(values, weights)
  local function sumTable(t)
    local sum = 0
    
    for _, x in ipairs(t) do
      sum = sum + x
    end

    return sum
  end

  local weightedValues = {}

  local weightsTotal = sumTable(weights)

  for i, w in ipairs(weights) do
    weights[i] = w / weightsTotal
  end

  for i, v in ipairs(values) do
    weightedValues[i] = v * weights[i]
  end

  local average = sumTable(values) / #values
  local weightedAverage = sumTable(weightedValues)

  return average - (weightedAverage - average) * 2
end

local attractors = {}

math.randomseed(os.clock())

for i = 1, 2 do
  table.insert(attractors, Point(math.random(20, 190), math.random(20, 190)))
end

local gridPoints = {}
local gridSize = 88
local cellSize = 2
local offset = 15

for r = 1, gridSize do
  for c = 1, gridSize do
    table.insert(gridPoints, Point(offset + c * cellSize, offset + r * cellSize))
  end
end

for _, p in ipairs(gridPoints) do
  local angles = {}
  local distances = {}

  for _, a in ipairs(attractors) do
    table.insert(angles, p:angleTo(a))
    table.insert(distances, p:distanceTo(a))
  end

  Path({
    PointFromVector(weightedAverage(angles, distances), 0.75, p),
    PointFromVector(weightedAverage(angles, distances), -0.75, p)
  }):setPen(black)
end

paper:addPens({ fuscia, cyan, black })
paper:saveSvg("main.svg")