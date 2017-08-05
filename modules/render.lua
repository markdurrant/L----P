-- load page & pen local
local   page = require 'modules/page'
local    pen = require 'modules/pen'

-- render svg & preview
local render = function(name, svgBody)

  -- html header
  local htmlHead = [[<!doctype html>
<html>
<head>
  <style>
    html,
    body {
      margin: 0;
      height: 100%;
    }

    body {
      display: flex;
      align-items: center;
      justify-content: center;
      background: #eee;
    }

    svg {
      background: white;
      box-shadow: 0 5px 20px #ccc;
      border-radius: 2px;
      transform: scale(2);
    }
  </style>
</head>
<body>

]]

  -- html closing tags
  local htmlClose = [[


</body>
</html>]]

  -- use page conifg to create svg header
  local svgHead = '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" ' ..
                  'xmlns:xlink="http://www.w3.org/1999/xlink" ' ..
                  'width="' .. page.x .. '" height="' .. page.y .. '" ' ..
                  'viewbox="0 0 ' .. page.x .. ' ' .. page.y .. '">\n'

  -- use pen config to create svg <style>
  local svgStyle = '  <style>* {fill: none; stroke-linecap: round;' ..
                   'stroke-linejoin: round; stroke-width: ' .. pen.thickness ..
                   '; stroke: ' .. pen.color .. ';}</style>\n  '

  -- add svg closing tag
  local svgClose = '\n</svg>'

  -- concat all svg content to write to file
  -- local svgContent = svgHead  ..
  --                    svgStyle ..
  --                    svgBody  ..
  --                    svgClose

  -- write to file
  function writeToFile (fileName, content)
    local output = assert(io.open(fileName, 'w'))
          output:write(content)
          output:close()
  end

  local svgContent = svgHead .. svgStyle .. svgBody .. svgClose

  -- save a svg
  writeToFile('svg-output/' .. name .. '.svg', svgContent )

  -- save preview html
  writeToFile('preview/index.html', htmlHead .. svgContent .. htmlClose)

  -- print when file ran to console
  print(
    svgHead .. svgStyle .. svgBody .. svgClose .. '\n\n' ..
    'Saved to ' .. 'svg-output/' .. name .. '.svg' .. ' @ ' .. os.date() .. '\n'
  )
end

return render