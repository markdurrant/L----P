-- get Utilities & Path modules
local utl = require("L-P/utilities")
require("L-P/path")

-- Set up Pen class
local penTable = { label = 'Pen' }

-- Return a new pen.
-- Optionally supply a table containing paths, a pen weight (number), and a pen color (Hex triplet).
function Pen(table)
  local pen = {}

  setmetatable(pen, { __index = penTable })

  if table.paths then
    pen.paths = table.paths

    pen:setBox()
  else
    pen.paths = {}
  end

  if table.weight then
    pen.weight = table.weight
  end

  if table.color then
    pen.color = table.color
  end

  return pen
end

-- Set the pen weight.
function penTable:setWeight(weight)
  self.weight = weight

  return self
end

-- Set the pen color (Hex triplet).
function penTable:setColor(color)
  self.color = color
  
  return self
end

-- Set the bounding box for the pen. Used internally.
function penTable:setBox()
  local top = self.paths[1].top
  local bottom = self.paths[1].bottom
  local left = self.paths[1].left
  local right = self.paths[1].right

  for _, p in ipairs(self.paths) do
    if p.top > top then
      top = p.top
    end
    
    if p.bottom < bottom then
      top = p.bottom
    end
    
    if p.left < left then
      left = p.left
    end
    
    if p.right > right then
      right = p.right
    end 
  end

  local hCenter = left + (right - left) / 2
  local vCenter = bottom + (top - bottom) / 2

  self.top          = top
  self.bottom       = bottom
  self.left         = left
  self.right        = right

  self.topLeft      = Point(left, top)
  self.topCenter    = Point(hCenter, top)
  self.topRight     = Point(right, top)  
  self.middleLeft   = Point(left, vCenter)
  self.center       = Point(hCenter, vCenter)
  self.middleRight  = Point(right, vCenter) 
  self.bottomLeft   = Point(left, bottom)
  self.bottomCenter = Point(hCenter, bottom)
  self.bottomRight  = Point(right, bottom)
end

-- Add a table of paths to the end of the pen.
function penTable:addPaths(paths)
  for _, p in ipairs(paths) do
    table.insert(self.paths, p)
  end

  return self
end

-- Remove paths from the pen using an index and an optional number of paths.
function penTable:removePaths(index, number)
  local n = number or 1

  for i = 1, n do
    table.remove(self.paths, index)
  end
  
  self:setBox()

  return self
end

-- Move the pen along the X & Y axes.
function penTable:move(x, y)
  for _, p in ipairs(self.paths) do
    p:move(x, y)
  end

  return self
end

-- Move the pen along a vector. 
function penTable:moveVector(direction, length)
  for _, p in ipairs(self.paths) do
    p:moveVector(direction, length)
  end

  return self
end

-- Rotate the Pen clockwise around an optional origin point.
function penTable:rotate(angle, origin)
  for _, p in ipairs(self.paths) do
    p:rotate(angle, origin)
  end

  return self
end

-- Scale the Pen by a factor.
function penTable:scale(factor)
  for _, p in ipairs(self.paths) do
    p:scale(factor)
  end

  return self
end

-- Return an identical copy of a pen.
function penTable:clone()
  return utl.clone(self)
end

-- Set the paper that the pen will draw on.
function penTable:setPaper(paper)
  table.insert(paper.pens, self)

  return self
end

-- Return a string of a SVG `<g>` element for the pen containing all child paths.
function penTable:render()
  local penTag = ""
  local style = "stroke-linecap: round; stroke-linejoin: round; fill: none;"

  if self.color then
    style = string.format("stroke: %s ;", self.color) .. style
  end

  if self.weight then
    style = string.format("stroke-width: %f; ", self.weight) .. style
  end

  style = 'style="' .. style .. '"'

  for _, p in ipairs(self.paths) do
    penTag = penTag .. "\n" .. p:render()
  end

  penTag = "<g " .. style .. ">" .. utl.indent(penTag) .. "\n</g>"

  return penTag
end

-- Return a G code string for the pen
function penTable:renderGCode()
  local gCode = "F10000\nM05 S0\nG1 X0 Y0"

  for _, p in ipairs(self.paths) do
    gCode = gCode .. "\n" .. p:renderGCode()
  end

  gCode = gCode .. "\n\nM05 S0\nG1 X0 Y0"

  return gCode
end

-- Save a G code file for the pen
function penTable:saveGCode(filename)
  utl.saveFile(filename, self:renderGCode())
end

-- Return a string with pen information including all child path information
function penTable:getLog()
  local log = "Pen "
  local pathLog = ""

  if self.weight and self.color then
    log = log .. string.format("{ width = %f, color = %s }", self.weight, self.color)
  elseif self.weight then
    log = log .. string.format("{ width = %f }", self.weight)
  elseif self.color then
    log = log .. string.format("{ color = %s }", self.color)
  end

  for i, p in ipairs(self.paths) do
    local pString = string.gsub(p:getLog(), "Path", string.format("\nPath: %d", i))
    pathLog = pathLog .. pString
  end

  return log .. utl.indent(pathLog)
end

-- Print pen information including all child path information
function penTable:log()
  print(self:getLog())
end

return Pen