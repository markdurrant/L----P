local utl = {}

-- Create a copy of a supplied table.
function utl.clone(original)
  local metatable = getmetatable(original)
  local clone = {}
  
  if type(original) ~= "table" then return original end 

  for k, v in pairs(original) do
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
function utl.append_to_string(str, num, char)
  local n = num or 1
  local c = char or ' '
  local indent = c

  for _ = 1, n - 1 do
    indent = indent .. c
  end 

  return indent .. string.gsub(str, '\n', '\n' .. indent)
end

-- Indent each line of a string by 2 spaces.
function utl.indent(str)
  return utl.append_to_string(str, 2)
end

-- Save a file to supplied filename.
function utl.save_file(filename, content)
  local output = assert(io.open(filename, 'w'))
        output:write(content)
        output:close()

  print('[ ' .. filename .. ' saved @ ' .. os.date() .. ' ]')
end

return utl