local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 400, height = 400 })

local   black = Pen:new({ weight = 2, color = "#000" })

local     red = Pen:new({ weight = 2, color = "#f00" })
local   green = Pen:new({ weight = 2, color = "#0f0" })
local    blue = Pen:new({ weight = 2, color = "#00f" })

local    cyan = Pen:new({ weight = 2, color = "#0ff" })
local fuchsia = Pen:new({ weight = 2, color = "#f0f" })
local  yellow = Pen:new({ weight = 2, color = "#ff0" })


local dot = function(point, pen)
  return Shape.RegPolygon(point, 3, 12):setPen(pen)
end

function Path:getLineFromSegment(distAlongPath, angle, distance)
  local startPoint
  local endPoint
  local distAlongPath2 = distAlongPath

  for i = 1, #self.points - 1 do
    local segmentLength = self.points[i]:getDistanceTo(self.points[i + 1])

    if distAlongPath2 > segmentLength then
      distAlongPath2 = distAlongPath2 - segmentLength
    elseif distAlongPath2 >= 0 then
      distAlongPath2 = distAlongPath2 - segmentLength

      startPoint = self.points[i]
      endPoint = self.points[i + 1]
    end
  end

  local initalPoint = self:getPointAtDistance(distAlongPath)

  local point = initalPoint:clone()
  
  point:moveVector(startPoint:getAngleTo(endPoint) - angle, distance)

  return initalPoint, point
end

local path1 = Path:new(
  Point:new( 50,  50),
  Point:new(200, 100),
  Point:new(320, 220),
  Point:new(350, 350)
)


for i = 0, path1:getLength() / 4 do
  local point1, point2 = path1:getLineFromSegment(i * 4, 270, 4)

  local path2 = Path:new(
    point1,
    point2
  ):setPen(fuchsia)

  local point1, point2 = path1:getLineFromSegment(i * 4, 90, 4)

  local path2 = Path:new(
    point1,
    point2
  ):setPen(fuchsia)
end 


paper:addPens(cyan, fuchsia, black)
paper:saveTo('svg-output/testy.svg')