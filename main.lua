require('../L-P/L-P')

math.randomseed(os.time())

local black = Pen({ weight = 0.5, color = '#000' })
local cyan = Pen({ weight = 0.375, color = '#0ff' })
local magenta = Pen({ weight = 0.375, color = '#f0f' })
local yellow = Pen({ weight = 0.375, color = '#ff0' })

local paper = Paper({ width = 100, height = 100 })
      paper:add_pens({black, magenta, cyan, yellow})


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

local function hex_wiggle(point, hex_size, num_lines, rotation)
  hex_size = hex_size / 2

  local line_A = Path({
    point:clone():move_vector(360 / 6 * 0, hex_size),
    point:clone():move_vector(360 / 6 * 1, hex_size),
    point:clone():move_vector(360 / 6 * 2, hex_size),
    point:clone():move_vector(360 / 6 * 3, hex_size)
  })
  
  local line_B = Path({
    point:clone():move_vector(360 / 6 * 0, hex_size),
    point:clone():move_vector(360 / 6 * 5, hex_size),
    point:clone():move_vector(360 / 6 * 4, hex_size),
    point:clone():move_vector(360 / 6 * 3, hex_size)
  })

  local hex_wiggle = wiggle_between(line_A, line_B, num_lines)

  return hex_wiggle:rotate(rotation)
end

local function get_random_point(x_min, x_max, y_min, y_max)
  return Point(
    math.random() * (x_max - x_min) + x_min,
    math.random() * (y_max - y_min) + y_min
  )
end

local function find_closest(point_list, point)
  local distance = point_list[1]:distance_to(point)
  local closest = point_list[1]
  
  for _, p in pairs(point_list) do
    if p:distance_to(point) < distance then
      distance = p:distance_to(point)
      closest = p
    end
  end 

  return closest
end

local function sample(point_list, num_candidates)
  local best_candidate
  local best_distance = 0

  for c = 1, num_candidates do
    local candidate = get_random_point(x_min, x_max, y_min, y_max)
    local distance = find_closest(point_list, candidate):distance_to(candidate)

    if distance > best_distance then
      best_distance = distance
      best_candidate = candidate
    end
  end

  return best_candidate
end

x_min, x_max, y_min, y_max = 20, 80, 20, 80

local point_list = {get_random_point(x_min, x_max, y_min, y_max)}

for i = 1, 100 do
  table.insert(point_list, sample(point_list, 10))
end

for _, p in pairs(point_list) do
  hex_wiggle(p, 5.1, 11, 0):set_pen(cyan)
  hex_wiggle(p, 5.1, 11, 120):set_pen(magenta)
  hex_wiggle(p, 5.1, 11, 240):set_pen(yellow)
end 

paper:save_svg('main.svg')