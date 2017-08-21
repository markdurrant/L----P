local charset = {}

for i = 48, 57 do
  table.insert(charset, string.char(i))
end

for i = 65, 90 do
  table.insert(charset, string.char(i))
end

for i = 97, 122 do
  table.insert(charset, string.char(i))
end

local random = {}

random.string = function(length)
  math.randomseed(os.time())

  if length > 0 then
    return random.string(length - 1) .. charset[math.random(1, #charset)]
  else
    return ""
  end
end

random.number = function(a, b)
  math.randomseed(os.time())

  if a == nil then
    return math.random()
  elseif b == nil then
    return math.random(a)
  else
    return math.random(a, b)
  end
end

return random