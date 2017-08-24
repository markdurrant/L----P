local path = { label = "path", points = {}, closed = false }
      path.metatable = { __index = path }

function path:new(t)
  if not t then
    t = {}
  end

  setmetatable(t, path.metatable)

  return t
end

function path:log()
  local pathLog = string.format("PATH, closed: %s", self.closed)

  for k, point in pairs(self.points) do
    pathLog = pathLog .. string.format("\n  %s ", k) .. point:log()
  end

  return pathLog
end

function path:print()
  print(self:log())
end

function path:addPoint(...)
  for _, point in ipairs({ ... }) do
    table.insert(self.points, point)
  end
end

function path:render()
  local pathTag = ""

  for i, point in ipairs(self.points) do
    if i == 1 then
      pathTag = "M"
    else
      pathTag = " L"
    end

    pathTag = pathTag .. point.x .. " " .. point.y
  end

  if self.closed == true then
    pathTag = pathTag .. " Z"
  end

  pathTag = '<path ="' .. pathTag .. '"/>'

  return pathTag
end

return path