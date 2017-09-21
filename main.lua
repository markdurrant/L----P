require("modules/luaSVG")

local p1 = Point(10, 10)
local p2 = Point(20, 20)
local p3 = Point(30, 30)

local t = {p1, p2, p3}

local path1 = Path()

      path1:addPoints(t)
      path1:addPoints({p2}, 2)

print(#path1.points)

      path1:removePoints(1)

print(#path1.points)