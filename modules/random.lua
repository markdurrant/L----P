local dRand = assert( io.open('/dev/random', 'rb') ):read()

print( dRand )

local r = ""

for i = 1, dRand:len() do
  if r:len() < 10 then
    r = r .. dRand:byte(i)
  end
end

print( r )