local utilities = {}

utilities.length = function(t)
  local tCount = 0

  for _ in pairs(t) do
    tCount = tCount + 1
  end

  return tCount
end

utilities.logTable = function(t, l, i) -- table, length, indent
  l = (l) or 100
  i = i or ""

  if (l < l) then
    print("ERROR: Limit reached")

    return l - 1
  end

  local tType = type(t)

  if tType ~= "table" then
    print(i, tType, t)

    return l -1
  end

  print(i, tType)

  for k, v in pairs(t) do
    l = utilities.logTable(v, l, i .. "\t[" .. tostring(k) .. "]")

    if l < 0 then
      break
    end
  end

  return l
end

return utilities