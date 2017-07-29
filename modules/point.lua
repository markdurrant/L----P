-- create a new point
local point = function (x, y)
  local point = {}
        point.x = x
        point.y = y
        point.log = function ()
          print("point: " .. point.x .. ", " .. point.y)
        end
  return point
end

return point