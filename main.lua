-- get mpdules
local   page = require 'modules/page'
local    pen = require 'modules/pen'
local  point = require 'modules/point'
local svgGen = require 'modules/svg-gen'

-- draw a line
local line = function (from, to)
  return '<line x1="' .. from.x .. '" y1="' .. from.y .. '" ' ..
         'x2="' .. to.x .. '" y2="' .. to.y .. '"/>'
end

--  svg body
local svgBody = line(point(0, 0), point(page.x, page.y)) ..
                line(point(page.x, 0), point(0, page.y))

svgGen('svg-output/test2.svg', page, pen, svgBody)