-- draw a line
local line = function (from, to)
  return '<line x1="' .. from.x .. '" y1="' .. from.y .. '" ' ..
         'x2="' .. to.x .. '" y2="' .. to.y .. '"/>'
end

return line