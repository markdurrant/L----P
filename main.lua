-- get utilities
local    utl = require 'modules/utilities'

-- config
local   page = require 'modules/page'
local    pen = require 'modules/pen'
local  scene = require 'modules/scene'

-- geometry
local  point = require 'modules/point'
local   path = require 'modules/path'
local   line = require 'modules/line'

-- rendering
local render = require 'modules/render'



local myPath = path()
      myPath.closed = true

local offset = 25

myPath:addPoints(
  point(offset * 3, offset * 3),
  point(page.x - offset, offset),
  point(page.x - offset * 3, page.y - offset * 3)
)

myPath:addPoints(point(offset, page.y - offset))

local myLine = line(point(10, 10), point(page.x - 10, page.y - 10))

--  svg body
local svgBody = myPath:draw() .. myLine:draw()

-- render everything
render('test')