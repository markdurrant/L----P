-- page config
local page = {}
      page.x = 297
      page.y = 210

-- page config
local pen = {}
      pen.thickness = 6
      pen.color = '#226'

-- use page conifg to create svg header
local svgHead = '<?xml version="1.0" encoding="utf-8"?>\n' ..
                '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" ' ..
                'xmlns:xlink="http://www.w3.org/1999/xlink" ' ..
                'width="' .. page.x .. 'mm" height="' .. page.y .. 'mm" ' ..
                'viewbox="0 0 ' .. page.x .. ' ' .. page.y .. '">\n'

-- add style tag for all elements
local svgStyle =
[[
  <style>
    * {
      fill: none;
      stroke-width: ]] .. pen.thickness .. [[;
      stroke: ]] .. pen.color .. [[;
    }
  </style>
]]

--  svg content
local svgBody = '\n  <rect x="10" y="10" width="100" height="100"/>'

-- add svg closing tag
local svgClose = '\n</svg>'

-- concat all svg content to write to file
local svgContent = svgHead .. svgStyle .. svgBody .. svgClose

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