require("../L-P/L-P")

math.randomseed(os.clock() * 99999999)

local black = Pen({ weight = 0.5, color = '#000' })
local blue = Pen({ weight = 0.375, color = '#0ff' })
local red = Pen({ weight = 0.375, color = '#f0f' })
local paper = Paper({ width = 140, height = 100 })
      paper:add_pens({black, blue, red})

local function draw_asterisk(point, pen)
  local asterisk_points = {}
  local asterisk_size = 0.25

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

local square_A = draw_square(paper.center, 60)
local grid_points = get_grid_points(square_A, 36)

local attractors = {}

for i = 1, math.random(2, 5) do
  table.insert(
    attractors,
    paper.center:clone():move(math.random() * 80 - 40, math.random() * 80 - 40)
  )
end

for _, attractor in ipairs(attractors) do
  attract_grid_points(grid_points, attractor)
end

for _, point in ipairs(grid_points) do
  draw_asterisk(point, black)
end

paper:save_svg('asterisk-grid.svg')