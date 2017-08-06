local utilities = {}

utilities.length = function(t)
  local tCount = 0

  for _ in pairs(t) do
    tCount = tCount + 1
  end

  return tCount
end

return utilities