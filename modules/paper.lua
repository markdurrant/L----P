-- get Utilities & Point modules.
local utl = require("modules/utilities")
require("modules/point")

-- Return a new paper with a specified width and height.
function Paper(width, height)
  local paper = { width = width, height = height, pens = {} }

  paper.topLeft      = Point(0, 0)
  paper.topCenter    = Point(width / 2, 0)
  paper.topRight     = Point(width, 0)
  paper.middleLeft   = Point(0, height / 2)
  paper.center       = Point(width / 2, height / 2)
  paper.middleRight  = Point(width, height / 2)
  paper.bottomLeft   = Point(0, height)
  paper.bottomCenter = Point(width / 2, height)
  paper.bottomRight  = Point(width, height)

  -- Add of a table of pens to the paper with an optional index.
  function paper:addPens(pens, index)
    local i = index or #self.pens
          i = i + 1

    for _, p in ipairs(points) do
      table.insert(self.points, i, p)
    end
  end

  -- Remove pens from the paper using an index and an optional number of pens.
  function paper:removePens(index, number)
    local n = number or 1

    for i = 1, n do
      table.remove(self.paths, index)
    end
  end

  -- Return a string of a `<svg>` element containing all child pens.
  function paper:render()
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

    return svgHead .. utl.indent(paperTag) .. "</svg>"
  end

  -- Save the rendered `<SVG>` element to a file.
  function paper:saveSvg(filename)
    utl.saveFile(filename, self:render())
  end

  -- Save the the rendered `<SVG>` element in a html document for easy previewing. 
  function paper:savePreview()
    
  end

  return paper
end

return Paper