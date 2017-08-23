local paper = {}

function paper:new(width, height)
  local this = {}

  this.type = "paper"
  this.width = width
  this.height = height
  this.pens = {}

  function this:addPen(...)
    for i, pen in ipairs({...}) do
      table.insert(this.pens, pen)
    end
  end

  function this:render()
    local paperTag = ""
    local paperContent = ""

    local svgHead = string.format(
      '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="%d" height="%d" viewbox="0 0 %d %d">',
      this.width, this.height, this.width, this.height
    )


    for k, pen in pairs(this.pens) do
      paperContent = paperContent .. pen:render()
    end

    paperTag = svgHead .. paperContent .. '</svg>'

    return paperTag
  end

  function this:saveTo(filename)
    local output = assert(io.open(filename, 'w'))
          output:write(this:render())
          output:close()

    print(filename .. ' saved @ ' .. os.date())
  end

  return this
end

return paper