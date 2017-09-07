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
  local random = 0

  math.randomseed(os.clock() * 1000000000)

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

-- from https://codea.io/talk/discussion/5930/line-segment-intersection
function utl.getIntersection(p1, p2, p3, p4)
  local x1 = p1.x
  local y1 = p1.y
  local x2 = p2.x
  local y2 = p2.y

  local x3 = p3.x
  local y3 = p3.y
  local x4 = p4.x
  local y4 = p4.y

  local ua1 = (x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)
  local ub1 = (x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)
  local u2 = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1)
  
  local ua = ua1 / u2
  local ub = ub1 / u2    
  
  local x = x1 + ua * (x2 - x1)
  local y = y1 + ua * (y2 - y1)

  local function bboxCheck(x1, y1, x2, y2, x3, y3, x4, y4)
    local ax1, ay1, ax2, ay2
    local bx1, by1, bx2, by2

    if x1 < x2 then ax1 = x1; ax2 = x2 else ax1 = x2; ax2 = x1 end
    if y1 < y2 then ay1 = y1; ay2 = y2 else ay1 = y2; ay2 = y1 end
    if x3 < x4 then bx1 = x3; bx2 = x4 else bx1 = x4; bx2 = x3 end
    if y3 < y4 then by1 = y3; by2 = y4 else by1 = y4; by2 = y3 end 

    if bx2 < ax1 then return false end  -- was <=
    if bx1 > ax2 then return false end  -- was >= 
    if by2 < ay1 then return false end  -- was <= 
    if by1 > ay2 then return false end  -- was >=

    return true
  end

  local intersection = {}

  if x == x and bboxCheck(x1, y1, x2, y2, x3, y3, x4, y4) then
    intersection.x = x
    intersection.y = y

    return intersection
  else
    return nil
  end
end

return utl