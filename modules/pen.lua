local pen = { label = 'pen', paths = {}, weight = 2, color = '#000' }
      pen.metatable = { __index = pen }

function pen:new(t)
  if not t then
    t =  {}
  end

  setmetatable(t, pen.metatable)

  return t
end

function pen:log()
  local penLog = string.format(
    "PEN, weight: %d color: $s",
    self.weight, self.color
  )

  for i, path in ipairs(self.paths) do
    penLog = penLog .. string.format("\n%s ", i) .. path:log()
  end

  return penLog
end

function pen:print()
  print(self:log())
end

function pen:addPath(...)
  for _, path in ipairs({ ... }) do
    table.insert(self.paths, path)
  end
end

function pen:render()
  local penTag = ""

  local style = string.format(
    'style="stroke-width: %d; stroke: %s; stroke-linecap: round;' ..
    'stroke-linejoin: round; fill: none;"',
    self.weight, self.color
  )

  for i, path in ipairs(self.paths) do
    penTag = penTag .. path:render()
  end

  penTag = '<g ' .. style .. penTag .. '</g>'

  return penTag
end

return pen