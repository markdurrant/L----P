-- get mpdules
local   page = require 'modules/page'
local    pen = require 'modules/pen'
local  point = require 'modules/point'
local   line = require 'modules/line'
local svgGen = require 'modules/svg-gen'

--  svg body
local svgBody = line(point(0, 0), point(page.x, page.y)) ..
                line(point(0, page.y), point(page.x, 0))

svgGen('svg-output/test.svg', page, pen, svgBody)