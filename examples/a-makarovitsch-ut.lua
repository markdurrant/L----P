require("../L-P/L-P")


math.randomseed(os.clock() * 99999999)


local paper = Paper({ width = 350, height = 350 })
local blue = Pen({ weight = 2, color = "#339" })


local margin = 8
local shapeSize = 60
local shapeOffset = 6
local rows = 5
local cols = 5


local function drawShape(x, y, rotateX, rotateZ)
  for i = 1, 5 do
    x = x + shapeOffset
    y = y + shapeOffset

    local shape = Path():setPen(blue)

    if rotateX then 
      shape:addPoints({
        Point(x, y),
        Point(x, y + shapeSize),
        Point(x + shapeSize / 2, y + shapeSize),
        Point(x + shapeSize / 2, y),
        Point(x + shapeSize, y),
        Point(x + shapeSize, y + shapeSize)
      })
    else
      shape:addPoints({
        Point(x, y + shapeSize),
        Point(x, y),
        Point(x + shapeSize / 2, y),
        Point(x + shapeSize / 2, y + shapeSize),
        Point(x + shapeSize, y + shapeSize),
        Point(x + shapeSize, y)
      })
    end

    if rotateZ then
      shape:rotate(90) 
    end
  end
end


-- local function drawGrid()
  for r = 0, rows - 1 do
    for c = 0, cols - 1 do
      local rotateX = false
      local rotateZ = false

      if math.random() > 0.5 then
        rotateX = true
      end

      if math.random() > 0.5 then
        rotateZ = true
      end

      drawShape(margin + shapeSize * c, margin + shapeSize * r, rotateX, rotateZ)
    end
  end
-- end


paper:addPens({ blue })
paper:saveSvg("a-makarovitsch-ut.svg")