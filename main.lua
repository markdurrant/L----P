require("modules/luaSVG")

local p1 = Point(10, 10)
local p2 = Point(10, 20)
local p3 = p1:clone():move(10, 10)

p1:log()
p3:log()

local path1 = Path({p1, p2, p3})
local path2 = path1:clone():move(10, 10)

path1:log()
path2:log()