local path = { label = "path", points = {}, closed = false }
      path.metatable = { __index = path }

function path:new(t)
  setmetatable(t or {}, path.metatable)

  return t
end

function path:log()
  local pathLog = string.format("path { closed = %s }", self.closed)

  for i, point in ipairs(self.points) do
    pathLog = pathLog .. string.format(
      "\n  point :%s { x = %d, y = %d }",
      i, point.x, point.y
    )
  end

  print(pathLog)
end

function path:addPoint(...)
  for _, point in ipairs({ ... }) do
    table.insert(self.points, point)
  end
end

function path:setPen(pen)
  table.insert(pen.paths, self)
end

function path:render()
  local pathTag = ""

  for i, point in ipairs(self.points) do
    if i == 1 then
      pathTag = "M "
    else
      pathTag = pathTag .. " L"
    end

    pathTag = pathTag .. point.x .. " " .. point.y
  end

  if self.closed == true then pathTag = pathTag .. " Z" end

  pathTag = '<path d="' .. pathTag .. '"/>'

  return pathTag
end

return path