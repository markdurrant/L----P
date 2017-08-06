-- get mpdules
local   page = require 'modules/page'
local    pen = require 'modules/pen'
local render = require 'modules/render'

local  point = require 'modules/point'
local   path = require 'modules/path'
local   line = require 'modules/line'


function addToTable(table, ...)
  for k, v in pairs({...}) do
    table[k] = v
  end
end

local myPath = path()
      myPath.closed = true

local offset = 25

addToTable(
  myPath.points,
  point(offset * 3, offset * 3),
  point(page.x - offset, offset),
  point(page.x - offset * 3, page.y - offset * 3),
  point(offset, page.y - offset)
)

local myLine = line(point(10, 10), point(page.x - 10, page.y - 10))

--  svg body
local svgBody = myPath:draw() .. myLine:draw()

-- render everything
render('test', svgBody)