local utl = {}

function utl.clone (t) -- deep-copy a table
  if type(t) ~= "table" then return t end
  local meta = getmetatable(t)
  local target = {}
  for k, v in pairs(t) do
    if type(v) == "table" then
      target[k] = utl.clone(v)
    else
      target[k] = v
    end
  end
  setmetatable(target, meta)
  return target
end

function utl.random(a, b)
  local devRandom = assert(io.open('/dev/random', 'rb')):read()
  local devSeed = 0
  local random = 0
  
  local i = 1

  while i < #devRandom and i < 5 do
    devSeed = devSeed .. devRandom:byte(i)
    i = i + 1
  end
  
  math.randomseed(tonumber(devSeed))

  if type(a) == 'number' and type(b) == 'number' then
    random = math.random() * (b - a) + a
  elseif type(a) == 'number' then
    random = math.random() * a
  else
    random = math.random() 
  end

  random = tonumber(string.format('%.3f', random))

  return random
end

return utl