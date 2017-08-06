local    utl = require 'modules/utilities'
local  scene = require 'modules/scene'

-- create a path
local path = function ()
  local this = {}

  this.points = {}
  this.closed = false

  -- add a point
  this.addPoints = function(self, ...)
    local points = {...}

    for i = 1, utl.length(points) do
      table.insert(self.points, points[i])
    end
  end

  -- render the svg path element
  this.draw = function (self)
    local pathContent = ''

    for k, point in pairs(self.points) do
      if k == 1 then
        pathContent = pathContent .. 'M'
      else
        pathContent = pathContent .. 'L'
      end

      pathContent = pathContent .. point.x .. ' ' .. point.y .. ' '
    end

    if self.closed == true then
      pathContent = pathContent .. 'Z'
    end

    pathContent = '<path d="' .. pathContent .. '"/>"'

    table.insert(scene, pathContent)

    return pathContent
  end

  return this
end

return path