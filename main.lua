require("modules/luaSVG")

local p1 = Point(10, 10)
local p2 = Point(20, 20)
local p3 = Point(30, 30)

local t = {p1, p2, p3}

local path1 = Path(p1)

      path1:addPoints(p2)

print(path1.points[2]:log())