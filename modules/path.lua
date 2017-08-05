-- create a path
local path = {
  points = {},
  closed = false,
  draw = function (self)
    local pathElm = '<path d="'

    for k, v in pairs(self.points) do
      if k == 1 then
        pathElm = pathElm .. 'M'
      else
        pathElm = pathElm .. 'L'
      end

      pathElm = pathElm .. v.x .. ' ' .. v.y .. ' '
    end

    if self.closed == true then
      pathElm = pathElm .. 'Z'
    end

    pathElm = pathElm .. '"/>'

    return pathElm
  end
}

return path