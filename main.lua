require("modules/luaSVG")

local p1 = Point(10, 10)
local p2 = Point(10, 20)
local p3 = p1:clone():move(10, 10)

local path1 = Path({p1, p2, p3})
local path2 = path1:clone():move(10, 10)

-- path1:log()
local t = { paths = { path1 } }

local pen1 = Pen(t)
      pen1:setWidth(2)
      pen1:setColor("#000") 
      pen1:addPaths({path2})
      pen1:moveVector(10, 10)
      pen1:scale(2)

print(pen1:render())