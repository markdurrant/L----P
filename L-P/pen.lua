-- get Utilities & Path modules
local utl = require('L-P/utilities')
require('L-P/path')

-- Set up Pen class
local pen = { label = 'Pen' }

-- Return a new pen.
-- Optionally supply a table containing paths, a pen weight (number), and a pen color (Hex triplet).
function Pen(table)
  local new_pen = {}
        new_pen.paths = {}

  setmetatable(new_pen, { __index = pen })

  if table.paths then
    new_pen.paths = table.paths

    new_pen:set_bounds()
  end

  if table.weight then new_pen.weight = table.weight end
  if table.color then new_pen.color = table.color end

  return new_pen
end

-- Set the pen weight.
function pen:set_weight(weight)
  self.weight = weight

  return self
end

-- Set the pen color (Hex triplet).
function pen:set_color(color)
  self.color = color
  
  return self
end

-- Set the bounding box for the pen. Used internally.
function pen:set_bounds()
  local top = self.paths[1].top
  local bottom = self.paths[1].bottom
  local left = self.paths[1].left
  local right = self.paths[1].right

  for _, p in ipairs(self.paths) do
    if p.top > top then top = p.top end
    if p.bottom < bottom then top = p.bottom end
    if p.left < left then left = p.left end
    if p.right > right then right = p.right end 
  end

  local h_center = left + (right - left) / 2
  local v_center = bottom + (top - bottom) / 2

  self.top           = top
  self.bottom        = bottom
  self.left          = left
  self.right         = right

  self.top_left      = Point(left, top)
  self.top_center    = Point(h_center, top)
  self.top_right     = Point(right, top)  
  self.middle_left   = Point(left, v_center)
  self.center        = Point(h_center, v_center)
  self.middle_right  = Point(right, v_center) 
  self.bottom_left   = Point(left, bottom)
  self.bottom_center = Point(h_center, bottom)
  self.bottom_right  = Point(right, bottom)
end

-- Add a table of paths to the end of the pen.
function pen:add_paths(paths)
  for _, p in ipairs(paths) do
    table.insert(self.paths, p)
  end

  return self
end

-- Remove paths from the pen using an index and an optional number of paths.
function pen:remove_paths(index, number)
  local n = number or 1

  for i = 1, n do
    table.remove(self.paths, index)
  end
  
  self:set_bounds()

  return self
end

-- Move the pen along the X & Y axes.
function pen:move(x, y)
  for _, p in ipairs(self.paths) do
    p:move(x, y)
  end

  return self
end

-- Move the pen along a vector. 
function pen:move_vector(direction, length)
  for _, p in ipairs(self.paths) do
    p:move_vector(direction, length)
  end

  return self
end

-- Rotate the Pen clockwise around an optional origin point.
function pen:rotate(angle, origin)
  for _, p in ipairs(self.paths) do
    p:rotate(angle, origin)
  end

  return self
end

-- Scale the Pen by a factor.
function pen:scale(factor)
  for _, p in ipairs(self.paths) do
    p:scale(factor)
  end

  return self
end

-- Return an identical copy of a pen.
function pen:clone()
  return utl.clone(self)
end

-- Set the paper that the pen will draw on.
function pen:set_paper(paper)
  table.insert(paper.pens, self)

  return self
end

-- Return a string of a SVG `<g>` element for the pen containing all child paths.
function pen:render()
  local pen_tag = ''
  local style = 'stroke-linecap: round; stroke-linejoin: round; fill: none;'

  if self.color then
    style = string.format('stroke: %s ;', self.color) .. style
  end

  if self.weight then
    style = string.format('stroke-width: %f; ', self.weight) .. style
  end

  style = 'style="' .. style .. '"'

  for _, p in ipairs(self.paths) do
    pen_tag = pen_tag .. "\n" .. p:render()
  end

  return '<g ' .. style .. '>' .. utl.indent(pen_tag) .. '\n</g>'
end

-- Return a G code string for the pen
function pen:render_gcode()
  local gCode = 'F10000\nM05 S0\nG1 X0 Y0'

  for _, p in ipairs(self.paths) do
    gCode = gCode .. '\n' .. p:render_gcode()
  end

  return gCode .. '\n\nM05 S0\nG1 X0 Y0'
end

-- Save a G code file for the pen
function pen:save_gcode(filename)
  utl.save_file(filename, self:render_gcode())
end

-- Return a string with pen information including all child path information
function pen:get_log()
  local log = 'Pen '
  local pathLog = ''

  if self.weight and self.color then
    log = log .. string.format('{ width = %f, color = %s }', self.weight, self.color)
  elseif self.weight then
    log = log .. string.format('{ width = %f }', self.weight)
  elseif self.color then
    log = log .. string.format('{ color = %s }', self.color)
  end

  for i, p in ipairs(self.paths) do
    local pString = string.gsub(p:get_log(), 'Path', string.format('\nPath: %d', i))
    pathLog = pathLog .. pString
  end

  return log .. utl.indent(pathLog)
end

-- Print pen information including all child path information
function pen:log()
  print(self:get_log())
end

return Pen