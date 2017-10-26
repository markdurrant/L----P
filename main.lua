require("../L-P/L-P")


local paper = Paper({ width = 210, height = 297 })
local blue = Pen({ weight = 2, color = "#339" })


local point1 = Point( 50,  50)
local point2 = Point(150, 150)
local point3 = Point( 50,  50)

print("point1 point2: " .. tostring(point1:equalTo(point2)))
print("point1 point3: " .. tostring(point1:equalTo(point3)))

local path1 = Path({
  Point( 50,  50),
  Point(150,  50),
  Point(150, 150),
  Point( 50, 150)
})

local path2 = Path({
  Point(150, 150),
  Point(250, 150),
  Point(250, 250)
})

local path3 = Path({
  Point( 50,  50),
  Point(150,  50),
  Point(150, 150),
  Point( 50, 150)
})

print("path1 path2: " .. tostring(path1:equalTo(path2)))
print("path1 path3: " .. tostring(path1:equalTo(path3)))


blue:saveGCode("main.nc")

paper:addPens({ blue })
paper:saveSvg("main.svg")