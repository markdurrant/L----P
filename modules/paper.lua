local Point = require("modules/point")

local Paper = { label = 'paper' }
      Paper.metatable = { __index = Paper }

function Paper:new(t)
  if not t then t = {} end
  if not t.width then t.width = 0 end
  if not t.height then t.height = 0 end
  if not t.pens then t.pens = {} end

  setmetatable(t, Paper.metatable)

  self:setBBox(t.width, t.height)

  return t
end

function Paper:log()
  local paperLog = string.format(
    "paper { width = %s, height = %f }",
    self.width, self.height
  )

  for i, pen in ipairs(self.pens) do
    paperLog = paperLog .. string.format(
      "\n  pen :%d { weight = %s, color = %s }",
      i, pen.weight, pen.color
    )

    for i, path in ipairs(pen.paths) do
      paperLog = paperLog .. string.format(
        "\n    path :%d { closed = %s }",
        i, path.closed
      )

      for i, point in ipairs(path.points) do
        paperLog = paperLog .. string.format(
          "\n      point :%s { x = %s, y = %s }",
          i, point.x, point.y
        )
      end
    end
  end

  print(paperLog)
end

function Paper:setBBox(width, height)
       self.topLeft = Point:new({ x = 0, y = height })
     self.topCenter = Point:new({ x = width / 2, y = height })
      self.topRight = Point:new({ x = width, y = height })

    self.middleLeft = Point:new({ x = 0, y = height / 2 })
        self.center = Point:new({ x = width / 2, y = height / 2 })
   self.middleRight = Point:new({ x = width, y = height / 2 })

    self.bottomLeft = Point:new({ x = 0, y = 0 })
  self.bottomCenter = Point:new({ x = width / 2, y = 0 })
   self.bottomRight = Point:new({ x = width, y = 0 })
end

function Paper:addPen(...)
  for _, pen in ipairs( {...} ) do
    table.insert(self.pens, pen)
  end
end

function Paper:render()
  local paperTag = ""

  local svgHead = string.format(
    '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" ' ..
    'xmlns:xlink="http://www.w3.org/1999/xlink" ' ..
    'width="%f" height="%f" viewbox="0 0 %f %f">',
    self.width, self.height, self.width, self.height
  )

  for _, pen in ipairs(self.pens) do
    paperTag = paperTag .. pen:render()
  end

  paperTag = svgHead .. paperTag .. '</svg>'

  return paperTag
end

function Paper:saveTo(filename)
  local output = assert(io.open(filename, 'w'))
        output:write(self:render())
        output:close()

  print('\n' .. '[ ' .. filename .. ' saved @ ' .. os.date() .. ' ]')
end

function Paper:preview(filename)
  local html = [[<!doctype html><html><head><title>SVG preview</title>
<style type="text/css">
  html { height: 100%; }
  body { display: flex; justify-content: center; align-items: center;
         height: 100%; margin: 0; background: #ddd; }
  svg { background: white; transform: scale(2);
        box-shadow: 0 2px 12px 0 rgba(0, 0, 0, .15); border-radius: 1px; }
</style></head><body>]] .. '\n' .. self:render() .. "\n</body></html>"

  local output = assert(io.open(filename, 'w'))
        output:write(html)
        output:close()

  print('\n' .. '[ ' .. filename .. ' saved @ ' .. os.date() .. ' ]')
end

return Paper