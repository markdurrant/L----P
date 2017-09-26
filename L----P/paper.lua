-- get Utilities & Point modules.
local utl = require("L----P/utilities")
require("L----P/point")

-- Return a new paper with a specified table with width and heighsize.
function Paper(size)
  local paper = { width = size.width, height = size.height, pens = {} }

  paper.topLeft      = Point(0, 0)
  paper.topCenter    = Point(size.width / 2, 0)
  paper.topRight     = Point(size.width, 0)
  paper.middleLeft   = Point(0, size.height / 2)
  paper.center       = Point(size.width / 2, size.height / 2)
  paper.middleRight  = Point(size.width, size.height / 2)
  paper.bottomLeft   = Point(0, size.height)
  paper.bottomCenter = Point(size.width / 2, size.height)
  paper.bottomRight  = Point(size.width, size.height)

  -- Add of a table of pens to the paper with an optional index.
  function paper:addPens(pens, index)
    local i = index or #self.pens
          i = i + 1

    for _, p in ipairs(pens) do
      table.insert(self.pens, i, p)
    end
  end

  -- Remove pens from the paper using an index and an optional number of pens.
  function paper:removePens(index, number)
    local n = number or 1

    for i = 1, n do
      table.remove(self.pens, index)
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
  function paper:savePreview(filename)
    local html = '<!doctype html><html><head><title>SVG preview</title>' ..
                 '<style type="text/css"> html { height: 100%; }' ..
                 'body { display: flex; justify-content: center; align-items:' .. 'center; height: 100%; margin: 0; background: #ddd; }' ..
                 'svg { background: white;' ..
                 'box-shadow: 0 2px 12px 0 rgba(0, 0, 0, .15);' ..
                 'border-radius: 1px; } </style></head><body>' .. 
                 self:render() .. '</body></html>'

    utl.saveFile(filename, html)
  end
  
  -- Return a string with paper information including all child pens information. Used internally.
  function paper:getLog()
    local log = string.format("Paper { width = %d, height = %d }", self.width, self.height)
    local penLog = ""
    
    for i, p in ipairs(self.pens) do
      local pString = string.gsub(p:getLog(), "Pen", string.format("\nPen: %d", i))

      penLog = penLog .. pString
    end

    return log .. utl.indent(penLog)
  end

  -- Print paper information including all child pens information.
  function paper:log()
    print(self:getLog())
  end

  return paper
end

return Paper