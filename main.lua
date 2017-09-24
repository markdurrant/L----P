require("modules/luaSVG")

local p1 = Point(10, 10)
local p2 = Point(10, 20)
local p3 = Point(10, 30)

local t = {p1, p2, p3}

local path1 = Path(t)

path1.points[1]:log()

path1:rotate(90)

path1.points[1]:log()

print(path1:render())

path1:close()

print(path1:render())