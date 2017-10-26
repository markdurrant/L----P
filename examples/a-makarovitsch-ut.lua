require("../L-P/L-P")


math.randomseed(os.clock() * 99999999)


local paper = Paper({ width = 297, height = 210 })
local blue = Pen({ weight = 0.75, color = "#339" })


local margin = 30
local shapeSize = 20
local lineNum = 5
local shapeOffset = shapeSize / (lineNum * 2)
local rows = 7
local cols = 10


local function drawShape(x, y, rotateX, rotateZ)
  for i = 1, lineNum do
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

blue:saveGCode("a-makarovitsch-ut.nc")

paper:addPens({ blue })
paper:saveSvg("./examples/a-makarovitsch-ut.svg")