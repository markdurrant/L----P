local    path = require 'modules/path'

-- draw a line
local line = function (from, to)
  local this = path()
        this.points[1] = from
        this.points[2] = to

  return this
end

return line