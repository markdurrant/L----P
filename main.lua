require('../L-P/L-P')

math.randomseed(os.clock() * 1000000)


local black = Pen({ weight = 0.5, color = '#000' })
local cyan = Pen({ weight = 1, color = '#0ff' })
local magenta = Pen({ weight = 0.6, color = '#f0f' })
local yellow = Pen({ weight = 0.375, color = '#ff0' })

local paper = Paper({ width = 140, height = 100 })
      paper:add_pens({black, magenta, cyan, yellow})


local function wiggle_between(line_A, line_B, num_lines)
  local wiggle_points = {line_A.points[1]:clone()}
  
  for l = 1, num_lines do
    if l % 2 == 0 then
      table.insert(
        wiggle_points,
        line_B:point_at_distance(line_A:length() / num_lines * l)
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

local function run_between(line_A, line_B, num_lines)
  local run_points = {}

  for l = 0, num_lines - 1 do
    if l % 2 == 0 then
      table.insert(run_points, line_A:point_at_distance(line_A:length() / (num_lines - 1) * l))
      table.insert(run_points, line_B:point_at_distance(line_A:length() / (num_lines - 1) * l))
    else
      table.insert(run_points, line_B:point_at_distance(line_A:length() / (num_lines - 1) * l))
      table.insert(run_points, line_A:point_at_distance(line_B:length() / (num_lines - 1) * l))
    end
  end

  return Path(run_points)
end

local function get_filled_rectangle(center, width, height)
  width = width / 2
  height = height / 2

  local line_A = Path({
    center:clone():move(-width, height),
    center:clone():move(-width, -height)
  })

  local line_B = Path({
    center:clone():move(width, height),
    center:clone():move(width, -height)
  })

  return run_between(line_A, line_B, math.floor(line_A:length() * 0.8))
end

local function get_random_filed_rectangle()
  local rectangle = get_filled_rectangle(
    paper.center, math.random(10, 50), math.random(10, 50)
  ):set_pen(cyan)
  rectangle:move(math.random(-40, 40), math.random(-30, 30))
  rectangle:rotate(math.random(0, 360))

  return rectangle
end

local function is_in_bounds(path)
  local in_bounds = true

  for _, p in pairs(path.points) do
    if p.x < 0 or p.x > paper.width or p.y < 0 or p.y > paper.height then
      in_bounds = false
    end
  end 

  return in_bounds
end

local function get_grid_rectangle(point, columns, rows)
  local size = 4

  Path({
    point:clone():move(-columns * size / 2, rows * size / 2),
    point:clone():move(columns * size / 2, rows * size / 2),
    point:clone():move(columns * size / 2, -rows * size / 2),
    point:clone():move(-columns * size / 2, -rows * size / 2)
  }):close():set_pen(magenta)
  
  for c = 1, columns - 1 do
    Path({
      point:clone():move(c * size - columns * size / 2, rows * size / 2),
      point:clone():move(c * size - columns * size / 2, -rows * size / 2)
    }):set_pen(magenta)
  end
  
  for r = 1, rows - 1 do
    Path({
      point:clone():move(columns * size / 2, r * size - rows * size / 2),
      point:clone():move(-columns * size / 2, r * size - rows * size / 2)
    }):set_pen(magenta)
  end
end

for _ = 1, math.random(2, 4) do
  local rectangle = get_random_filed_rectangle()
  
  while not is_in_bounds(rectangle) do
    cyan.paths[#cyan.paths] = nil
    rectangle = get_random_filed_rectangle()
  end
end 

for _ = 1, math.random(1, 2) do
  get_grid_rectangle(
    paper.center:clone():move(math.random(-7, 7) * 4, math.random(-7, 7) * 4),
    math.random(2, 8),
    math.random(2, 8)
  )
end

-- local guide_square_size = 72
--       guide_square_size = guide_square_size / 2
-- local guide_square = Path({
--   Point(paper.center.x - guide_square_size, paper.center.y + guide_square_size),
--   Point(paper.center.x + guide_square_size, paper.center.y + guide_square_size),
--   Point(paper.center.x + guide_square_size, paper.center.y - guide_square_size),
--   Point(paper.center.x - guide_square_size, paper.center.y - guide_square_size)
-- }):close():set_pen(yellow)

paper:save_svg('main.svg')