local    path = require 'modules/path'

-- draw a line
local line = function (from, to)
  local this = path()
        this:addPoints(from)
        this:addPoints(to)

  return this
end

return line