-- get utilities 
local utl = require("modules/utl")

-- set up Path table and label
local Path = { label = "path" }
      Path.metatable = { __index = Path }

-- create new Path with points table
function Path:new(...)
  local path = {}
        path.points = {}
        path.closed = true

  if {...} then
    path.points = {...}
  end

  setmetatable(path, Path.metatable)

  return path
end

-- add points to the Path 
-- give an optional index to add points to the middle of a path
function Path:addPoints(...)
  local t = { ... }
  local index = 0

  if type(t[#t]) == "number" then
    index = t[#t]
    table.remove(t, #t)
  else 
    index = #t
  end

  for i, point in ipairs(t) do
    table.insert(self.points, index + i, point)
  end
end

-- remove points from the Path at a specified position
function Path:removePoints(index, number)
  if index then
    for i = 1, number do
      table.remove(self.points, index)
    end
  else
    for i = 1, number do
      table.remove(self.points)
    end
  end
end

-- set the pen for the Path
function Path:setPen(pen)
  table.insert(pen.paths, self)
end

-- rotate the path around an origin
function Path:rotate(angle, point)
  for _, point in ipairs(self.points) do
    point:rotate(angle, point)
  end
end

-- move the Path in X & Y
function Path:move(x, y)
  for _, point in ipairs(self.points) do
    point:move(x, y)
  end
end

-- move the Path in X
function Path:moveX(x)
  for _, point in ipairs(self.points) do
    point:moveX(x)
  end
end

-- move the Path in Y
function Path:moveY(y)
  for _, point in ipairs(self.points) do
    point:moveY(y)
  end
end

-- create a copy of the Path
function Path:clone()
  return utl.clone(self)
end

-- get the total length of the path
function Path:getLength()
  local length = 0

  for i, point in ipairs(self.points) do  
    if i ~= #self.points then
      length = length + self.points[i]:getDistanceTo(self.points[i + 1])
    end
  end

  if self.closed == true then
    length = length + self.points[#self.points]:getDistanceTo(self.points[1])
  end

  return length
end

-- render the Path
function Path:render()
  local pathTag = ""

  for i, point in ipairs(self.points) do
    if i == 1 then
      pathTag = "M "
    else
      pathTag = pathTag .. " L"
    end

    pathTag = pathTag .. point.x .. " " .. point.y
  end

  if self.closed == true then pathTag = pathTag .. " Z" end

  pathTag = '<path d="' .. pathTag .. '"/>'

  return pathTag
end

-- print Path details
function Path:log()
  local pathLog = string.format("path { closed = %s }", self.closed)

  for i, point in ipairs(self.points) do
    pathLog = pathLog .. string.format(
      "\n  point :%s { x = %s, y = %s }",
      i, point.x, point.y
    )
  end

  print(pathLog)
end

-- return the Path module
return Path