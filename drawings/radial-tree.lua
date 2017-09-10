local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 500, height = 500 })
local black = Pen:new({ weight = 2, color = "#000" })


-- local function dot(p)
--   Shape.RegPolygon(p, 3, 6):setPen(pink)
-- end

-- local function findDistance(a, b)
--   local distance = 0

--   if a < b then
--     if b - a < 360 - b + a then
--       distance = b - a
--     else 
--       distance = 360 - b + a
--     end
--   else
--     if a - b < 360 - a + b then
--       distance = a - b
--     else
--       distance = 360 - a + b
--     end  
--   end

--   return distance
-- end

-- local function findClosest(list, candidate)
--   local bestDistance = findDistance(list[1], candidate)
--   local closest = list[1]

--   for _, a in ipairs(list) do
--     if findDistance(a, candidate) < bestDistance then
--       bestDistance = findDistance(a, candidate)
--       closest = a
--     end
--   end

--   return closest
-- end

-- local function sample(list)
--   local bestCandidate 
--   local bestDistance = 0

--   if #list == 0 then
--     table.insert(list, utl.random(360))
--   end

--   for i = 1, 10 do
--     local candidate = utl.random(360)
--     local distance = findDistance(findClosest(list, candidate), candidate)

--     if distance > bestDistance then
--       bestDistance = distance
--       bestCandidate = candidate
--     end
--   end

--   return bestCandidate
-- end

-- local angles = {}
-- local innerRadius = 40
-- local ringSize = 4

-- for i = 1, 20 do
--   table.insert(angles, sample(angles))
-- end

-- for _, a in ipairs(angles) do
--   Path:new(
--     paper.center:clone():moveVector(a, innerRadius),
--     paper.center:clone():moveVector(a, innerRadius + ringSize)
--   ):setPen(black)
-- end

-- for i = 1, 10 do

-- end

paper:addPens(black)
paper:saveTo('svg-output/testy.svg')