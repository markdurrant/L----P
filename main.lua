-- get mpdules
local  page = require 'modules/page'
local   pen = require 'modules/pen'
local point = require 'modules/point'

-- use page conifg to create svg header
local svgHead = '<?xml version="1.0" encoding="utf-8"?>\n' ..
                '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" ' ..
                'xmlns:xlink="http://www.w3.org/1999/xlink" ' ..
                'width="' .. page.x .. 'mm" height="' .. page.y .. 'mm" ' ..
                'viewbox="0 0 ' .. page.x .. ' ' .. page.y .. '">'

-- add style tag for all elements
local svgStyle = '<style>* {fill: none; stroke-linecap: round;' ..
                 'stroke-linejoin: round; stroke-width: ' .. pen.thickness ..
                 '; stroke: ' .. pen.color .. ';}</style>'

-- add svg closing tag
local svgClose = '</svg>'

-- draw a line
local line = function (from, to)
  return '<line x1="' .. from.x .. '" y1="' .. from.y .. '" ' ..
         'x2="' .. to.x .. '" y2="' .. to.y .. '"/>'
end

--  svg body
local svgBody = line(point(0, 0), point(page.x, page.y)) ..
                line(point(page.x, 0), point(0, page.y))

-- concat all svg content to write to file
local svgContent = svgHead  ..
                   svgStyle ..
                   svgBody  ..
                   svgClose

-- file config
local directory = './svg-output/'
local fileName = 'test.svg'

-- write svg content to file
local output = assert(io.open(directory .. fileName, 'w'))
      output:write(svgContent)
      output:close()

-- print when file ran to console
print(
  '\n' .. svgContent .. '\n\n' ..
  'Saved to ' .. directory .. fileName .. ' @ ' .. os.date()
)