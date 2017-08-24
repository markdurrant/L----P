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
    "paper { width = %d, height = %d }",
    self.width, self.height
  )

  for i, pen in ipairs(self.pens) do
    paperLog = paperLog .. string.format(
      "\n  pen :%d { weight = %d, color = %s }",
      i, pen.weight, pen.color
    )

    for i, path in ipairs(pen.paths) do
      paperLog = paperLog .. string.format(
        "\n    path :%d { closed = %s }",
        i, path.closed
      )

      for i, point in ipairs(path.points) do
        paperLog = paperLog .. string.format(
          "\n      point :%s { x = %d, y = %d }",
          i, point.x, point.y
        )
      end
    end
  end

  print(paperLog)
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

  print('\n' .. '[ ' .. filename .. ' saved @ ' .. os.date() .. ' ]')
end

function paper:preview(filename)
  local html = [[<!doctype html><html><head><title>SVG preview</title>
<style type="text/css">
  html { height: 100%; }
  body { display: flex; justify-content: center; align-items: center;
         height: 100%; margin: 0; background: #ddd; }
  svg { background: white; transform: scale(2);
        box-shadow: 0 2px 12px 0 rgba(0, 0, 0, .15); border-radius: 1px; }
</style></head><body>\n]] .. self:render() .. "\n</body></html>"

  local output = assert(io.open(filename, 'w'))
        output:write(html)
        output:close()

  print('\n' .. '[ ' .. filename .. ' saved @ ' .. os.date() .. ' ]')
end

return paper