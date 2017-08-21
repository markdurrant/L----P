-- get utilities
local    utl = require 'modules/utilities'
local random = require 'modules/random'

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

local offset = 20

myPath:addPoints(
  point(offset * 4, offset * 4),
  point(page.x - offset, offset),
  point(page.x - offset * 4, page.y - offset * 4),
  point(offset, page.y - offset)
)

print(random.number(10, 20))

local myLine = line(point(10, 10), point(page.x - 10, page.y - 10))

-- render everything
render('test')