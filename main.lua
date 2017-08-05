-- get mpdules
local   page = require 'modules/page'
local    pen = require 'modules/pen'
local render = require 'modules/render'

local  point = require 'modules/point'
local   path = require 'modules/path'


function addToTable(table, ...)
  for k, v in pairs({...}) do
    table[k] = v
  end
end

local myPath = path
      myPath.closed = true

local offset = 20

addToTable(
  myPath.points,
  point(offset * 3, offset * 3),
  point(page.x - offset, offset),
  point(page.x - offset, page.y - offset),
  point(offset, page.y - offset)
)

local draw = function (path)
  local pathElm = '<path d="'

  for k, v in pairs(path.points) do
    if k == 1 then
      pathElm = pathElm .. 'M'
    else
      pathElm = pathElm .. 'L'
    end

    pathElm = pathElm .. v.x .. ' ' .. v.y .. ' '
  end

  if path.closed == true then
    pathElm = pathElm .. 'Z'
  end

  pathElm = pathElm .. '"/>'

  return pathElm
end

--  svg body
local svgBody = draw(myPath)

-- render everything
render('test', svgBody)