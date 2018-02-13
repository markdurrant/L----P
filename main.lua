require('../L-P/L-P')

math.randomseed(os.time())

local black = Pen({ weight = 1, color = '#000' })
local blue = Pen({ weight = 0.5, color = '#0ff' })
local red = Pen({ weight = 0.5, color = '#f0f' })
local paper = Paper({ width = 100, height = 100 })
      paper:add_pens({black, red, blue})


function draw_dot(point)
  local size = 1
  local dot = Path({
    point:clone():move_vector(0, size),
    point:clone():move_vector(120, size),
    point:clone():move_vector(240, size)
  }):close():set_pen(red)

  return dot
end

local line_A = Path({
  Point(25, 25),  Point(75, 75)
}):set_pen(blue)
local point_A = Point(75.0000, 75.0000)

draw_dot(point_A)

print(point_A:is_on_line(line_A.points[1], line_A.points[2]))


paper:save_svg('main.svg')