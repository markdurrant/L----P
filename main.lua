local utl = require("modules/utl")

local paper = require("modules/paper")
local   pen = require("modules/pen")
local  path = require("modules/path")
local point = require("modules/point")

local paper = paper:new({ width = 300, height = 300 })
local pen = pen:new({ weight = 2, color = "#000" })
      paper:addPen(pen)



function point:newOAD(origin, angle, distance)
  local t = point:new()
  local angle = math.rad(angle - 90)

  t.x = origin.x + math.cos(angle) * distance
  t.y = origin.y + math.sin(angle) * distance

  return t
end

function closest(angles, angle)
  local bestDist 
  local closest

  for i, a in ipairs(angles) do
    local d = a - angle

    if d < 0 then
      d = d * -1
    end

    if bestDist == nil or d < bestDist then
      bestDist = d
      closest = a
    end
  end

  return closest
end

function sample(angles)
  local bestCandidate
  local bestDistance = 0

  if angles[1] == nil then
    bestCandidate = utl.random(360)
  else 
    for i = 1, 4 do
      local c = utl.random(360)
      local d = closest(angles, c) - c

      if d < 0 then
        d = d * -1
      end

      if d > bestDistance then
        bestDistance = d
        bestCandidate = c
      end
    end
  end

  return bestCandidate
end

for r = 1, 12 do
  local angles = {}

  for i = 1, 10 + r * r * 4 do
    table.insert(angles, sample(angles))
  end

  for _, angle in ipairs(angles) do
    local p1 = point:newOAD(paper.center, angle, 10 + r * 8)
    local p2 = point:newOAD(paper.center, angle, 14 + r * 8)

    local l = path:new({ points = { p1, p2 }})
          l:setPen(pen)
  end
end


paper:saveTo('svg-output/testy.svg')
paper:preview('html-preview/preview.html')