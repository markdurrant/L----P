require("modules/luaSVG")

local p1 = Point(100, 100)
local p2 = PointFromVector(90, 100, p1)

p1:log()
p2:log()

print(p1:angleTo(p2))