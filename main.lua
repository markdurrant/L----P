require('../L-P/L-P')

local devRandom = assert(io.open('/dev/random', 'rb')):read()				
local devSeed = 0
local random = 0
        
local dr = 1
        		
while dr < #devRandom and dr < 5 do
  devSeed = devSeed .. devRandom:byte(dr)
  dr = dr + 1
end
    		
math.randomseed(tonumber(devSeed))

local black = Pen({ weight = 0.5, color = '#000' })
local cyan = Pen({ weight = 0.375, color = '#0ff' })
local magenta = Pen({ weight = 0.375, color = '#f0f' })
local yellow = Pen({ weight = 0.375, color = '#ff0' })

local paper = Paper({ width = 140, height = 100 })
      paper:add_pens({black, cyan, magenta, yellow})


local function wiggle_between(line_A, line_B, num_lines)
  local wiggle_points = {line_A.points[1]:clone()}
  
  for l = 1, num_lines do
    if l % 2 == 0 then
      table.insert(
        wiggle_points,
        line_A:point_at_distance(line_A:length() / num_lines * l)
      )
    else
      table.insert(
        wiggle_points,
        line_B:point_at_distance(line_B:length() / num_lines * l)
      )
    end    
  end 

  return Path(wiggle_points)
end

local function get_blob(num_points, size, variance)
  if num_points % 2 ~= 0 then num_points = num_points + 1 end

  local point_list = {}

  for i = 0, num_points - 1 do
    table.insert(
      point_list,
      paper.center:clone():move_vector(360 / num_points * i, size / 2 + math.random() * variance  - variance / 2)
    )
  end

  return Path(point_list):close()
end

local function get_blob_lines(blob)
  local line_A_points = {}
  local line_B_points = {}

  for a = 1, #blob.points / 2 do
    table.insert(line_A_points, blob.points[a])
    table.insert(line_B_points, blob.points[#blob.points - a + 1])
  end 

  return {Path(line_A_points), Path(line_B_points)}
end

local function get_blob_wiggle(num_points, size, variance, num_lines)
  local blob = get_blob(num_points, size, variance)
  local blob_lines = get_blob_lines(blob)
  local blob_line_A = blob_lines[1]
  local blob_line_B = blob_lines[2]
  local blob_wiggle = wiggle_between(blob_line_A, blob_line_B, num_lines)

  return blob_wiggle
end

local angle = math.random() * 360

local blob_wiggle_A = get_blob_wiggle(12, 75, 15, 70):set_pen(yellow)
local blob_wiggle_B = get_blob_wiggle(10, 50, 10, 50):set_pen(magenta)
      blob_wiggle_B:rotate(120):move_vector(angle, math.random() * 10 + 5)
local blob_wiggle_C = get_blob_wiggle(8, 25, 5, 25):set_pen(cyan)
      blob_wiggle_C:rotate(240):move_vector(angle, math.random() * 20 + 10)


cyan:save_gcode('cyan.nc')
magenta:save_gcode('magenta.nc')
yellow:save_gcode('yellow.nc')
paper:save_svg('main.svg')