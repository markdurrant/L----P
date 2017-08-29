local utl = require("modules/utl")

local Path = { label = "path" }
      Path.metatable = { __index = Path }

function Path:new(t)
  if not t then t = {} end
  if not t.points then t.points = {} end
  if not t.closed then t.closed = false end

  setmetatable(t, Path.metatable)

  return t
end

function Path:log()
  local pathLog = string.format("path { closed = %s }", self.closed)

  for i, point in ipairs(self.points) do
    pathLog = pathLog .. string.format(
      "\n  point :%s { x = %s, y = %s }",
      i, point.x, point.y
    )
  end

  print(pathLog)
end

function Path:addPoint(...)
  for _, point in ipairs({ ... }) do
    table.insert(self.points, point)
  end
end

function Path:setPen(pen)
  table.insert(pen.paths, self)
end

function Path:rotate(angle, origin)
  for _, point in ipairs(self.points) do
    point:rotate(angle, origin)
  end
end

function Path:move(x, y)
  for _, point in ipairs(self.points) do
    point:move(x, y)
  end
end

function Path:clone()
  return utl.clone(self)
end

function Path:render()
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

return Path