local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local cyan = Pen:new({ weight = 2, color = "0ef" })
local pink = Pen:new({ weight = 2, color = "f09" })


local function dot(p)
  Shape.RegPolygon(p, 3, 6):setPen(pink)
end

local function findDistance(a, b)
  local distance = 0

  if a < b then
    if b - a < 360 - b + a then
      distance = b - a
    else 
      distance = 360 - b + a
    end
  else
    if a - b < 360 - a + b then
      distance = a - b
    else
      distance = 360 - a + b
    end  
  end

  return distance
end

local function findClosest(list, candidate)
  local bestDistance = findDistance(list[1], candidate)
  local closest = list[1]

  for _, a in ipairs(list) do
    if findDistance(a, candidate) < bestDistance then
      bestDistance = findDistance(a, candidate)
      closest = a
    end
  end

  return closest
end

local function sample(list)
  local bestCandidate 
  local bestDistance = 0

  if #list == 0 then
    table.insert(list, utl.random(360))
  end

  for i = 1, 10 do
    local candidate = utl.random(360)
    local distance = findDistance(findClosest(list, candidate), candidate)

    if distance > bestDistance then
      bestDistance = distance
      bestCandidate = candidate
    end
  end

  return bestCandidate
end

local angles = {}
local splits = {}

for i = 1, 40 do
  table.insert(angles, sample(angles))
end

for _, a in ipairs(angles) do
  Path:new(
    paper.center:clone():moveVector(a, 100),
    paper.center:clone():moveVector(a, 110)
  ):setPen(pink)
end

for i = 1, 20 do
  local a = math.floor(utl.random(#angles) + 1)

  Path:new(
    paper.center:clone():moveVector(angles[a] - 1.5, 114),
    paper.center:clone():moveVector(angles[a], 110),
    paper.center:clone():moveVector(angles[a] + 1.5, 114)
  ):setPen(pink)
end


paper:addPens(cyan, pink)
paper:saveTo('svg-output/testy.svg')