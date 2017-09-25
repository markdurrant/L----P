local utl = {}

-- Create a copy of a supplied table.
function utl.clone(table)
  local metatable = getmetatable(table)
  local clone = {}
  
  if type(table) ~= "table" then
    return table
  end 

  for k, v in pairs(table) do
    if type(v) == "table" then
      clone[k] = utl.clone(v)
    else
      clone[k] = v
    end
  end

  setmetatable(clone, metatable)

  return clone
end

-- Append a number of characters to the start of each line of a string.
function utl.appendToString(str, num, char)
  local num = num or 1
  local char = char or " "
  local indent = char

  for _ = 1, num - 1 do
    indent = indent .. char
  end 

  local newStr = indent .. string.gsub(str, '\n', '\n' .. indent)

  return newStr
end

-- Indent each line of a string by 2 spaces.
function utl.indent(str)
  return utl.appendToString(str, 2)
end

-- Save a file to supplied filename.
function utl.saveFile(filename, content)
  local output = assert(io.open(filename, 'w'))
        output:write(content)
        output:close()

  print('\n' .. '[ ' .. filename .. ' saved @ ' .. os.date() .. ' ]')
end

return utl