local paper = { label = 'paper', width = 0, height = 0, pens = {} }
      paper.metatable = { __index = paper }

function paper:new(t)
  if not t then
    t = {}
  end

  setmetatable(t, paper.metatable)

  return t
end

function paper:log()
  local paperLog = string.format(
    "PAPER, width: %d height: %d",
    self.width, self.height
  )

  for i, pen in pairs(self.pens) do
    paperLog = paperLog .. string.format('\n%s ', i) .. pen:log()
  end

  return paperLog
end

function paper:print()
  print(self:log())
end

function paper:addPen(...)
  for _, pen in ipairs( {...} ) do
    table.insert(self.pens, pen)
  end
end

function paper:render()
  local paperTag = ""

  local svgHead = string.format(
    '<svg version="1.1" xmlns="http://www.w3.org/2000/svg"' ..
    'xmlns:xlink="http://www.w3.org/1999/xlink"' ..
    'width="%d" height="%d" viewbox="0 0 %d %d">',
    self.width, self.height, self.width, self.height
  )

  for _, pen in ipairs(self.pens) do
    paperTag = paperTag .. pen:render()
  end

  paperTag = svgHead .. paperTag .. '</svg>'

  return paperTag
end

function paper:saveTo(filename)
  local output = assert(io.open(filename, 'w'))
        output:write(self:render())
        output:close()

  print('\n' .. filename .. ' saved @ ' .. os.date())
end

return paper