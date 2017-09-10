local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local black = Pen:new({ weight = 1.5, color = "#000" })
local pink = Pen:new({ weight = 1, color = "#f09" })
local blue = Pen:new({ weight = 1, color = "#09f" })


-- return a random point
local function randomPoint()
  return Point:newVector(paper.center, utl.random(0, 360), 100)
end

local function spacing(list, point)
  local spacings = {}

  for _, p in ipairs(list) do
    table.insert(spacings, p:getDistanceTo(point))
  end

  table.sort(spacings, function(a, b) return a < b end)

  return spacings[2] + spacings[3]
end

local ringPoints = {}

for i = 1, 60 do
  Point:bestCandidate(ringPoints, randomPoint, 10)
end

function drawRing()
  local removals = {}
  local additions = {}

  for i, p in ipairs(ringPoints) do
    if spacing(ringPoints, p) > 30 then
      local p2 = Point:newVector(paper.center, p:getAngleTo(paper.center) - 2.5, - p:getDistanceTo(paper.center) - 18)
      local p3 = Point:newVector(paper.center, p:getAngleTo(paper.center) + 2.5, - p:getDistanceTo(paper.center) - 18)

      Path:new(
        p2,
        p:clone(),
        p3
      ):setPen(black)

      table.insert(removals, i)
      table.insert(additions, p2)
      table.insert(additions, p3)
    else
      Path:new(
        p:clone(),
        p:clone():moveVector(p:getAngleTo(paper.center), - 18)
      ):setPen(black)

      p:moveVector(p:getAngleTo(paper.center), - 18)
    end
  end 

  for i, r in ipairs(removals) do
    -- print(r)
    -- ringPoints[r] = nil
    -- Shape.RegPolygon(ringPoints[r], 1, 6):setPen(blue)
    print(#ringPoints, r)
    table.remove(ringPoints, r - i + 1)
  end

  for _, a in ipairs(additions) do
    table.insert(ringPoints, a)
  end

  return ringPoints
end

for _, p in ipairs(ringPoints) do
  Shape.RegPolygon(p, 1, 6):setPen(pink)
end

drawRing()

for _, p in ipairs(ringPoints) do
  Shape.RegPolygon(p, 1, 6):setPen(pink)
end

drawRing()

paper:addPens(black, pink, blue)
paper:saveTo('svg-output/testy.svg')