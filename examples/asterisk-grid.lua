require("../L-P/L-P")

math.randomseed(os.clock() * 99999999)

local black = Pen({ weight = 0.5, color = '#000' })
local blue = Pen({ weight = 0.375, color = '#09f' })
local red = Pen({ weight = 0.375, color = '#f0f' })
local paper = Paper({ width = 210, height = 297 })
      paper:add_pens({black, blue, red})

local function draw_asterisk(point, pen)
  local asterisk_points = {}
  local asterisk_size = 0.75

  for i = 0, 4 do
    table.insert(asterisk_points, point:clone():move_vector(360 / 5 * i, asterisk_size))
  end

  return Path({
    point, asterisk_points[1],
    point, asterisk_points[2],
    point, asterisk_points[3],
    point, asterisk_points[4],
    point, asterisk_points[5]
  }):close():set_pen(pen)
end

local function draw_square(center, size)
  return Path({
    Point(center.x + size / 2, center.y + size / 2),
    Point(center.x + size / 2, center.y - size / 2),
    Point(center.x - size / 2, center.y - size / 2),
    Point(center.x - size / 2, center.y + size / 2)
  }):close()
end

function get_grid_points(square, cells)
  local grid_points = {}

  for r = 0, cells do
    for c = 0, cells do
      local size = square.right - square.left
      local x = square.left + c * size / cells 
      local y = square.bottom + r * size / cells

      table.insert(grid_points, Point(x, y))
    end
  end  

  return grid_points
end

function attract_grid_points(grid_points, attractor)
  for _, point in ipairs(grid_points) do
    local distance = point:distance_to(attractor)
    local angle = point:angle_to(attractor)

    local magnitude = (50 - distance) / 5

    if magnitude > distance then magnitude = distance end

    point:move_vector(angle, magnitude)
  end

  return grid_points
end

local function random_point(center, size)
  return center:clone():move(math.random() * size - size / 2, math.random() * size - size / 2)
end

local square_A = draw_square(paper.center, 80)
local grid_points = get_grid_points(square_A, 36)

local attractors = {}

for i = 1, math.random(2, 5) do
  table.insert(
    attractors,
    random_point(paper.center, 100)
  )
end

for _, attractor in ipairs(attractors) do
  attract_grid_points(grid_points, attractor)
end

local square_B = draw_square(paper.center, 100)

local color_point_A = square_B:point_at_distance(square_B:length() * math.random())
local color_point_B = square_B:point_at_distance(square_B:length() * math.random())

for _, point in ipairs(grid_points) do
  local random_tolerance = 0.8 
  local distance_A = point:distance_to(color_point_A) * (math.random() * random_tolerance + (1 - random_tolerance))
  local distance_B = point:distance_to(color_point_B) * (math.random() * random_tolerance + (1 - random_tolerance))

  if distance_A > distance_B then
    draw_asterisk(point, red)
  else 
    draw_asterisk(point, blue)
  end
end

paper:save_svg('asterisk-grid.svg')