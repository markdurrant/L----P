require('../L-P/L-P')

math.randomseed(os.time())

local black = Pen({ weight = 0.5, color = '#000' })
local blue = Pen({ weight = 0.375, color = '#0ff' })
local red = Pen({ weight = 0.375, color = '#f0f' })
local paper = Paper({ width = 100, height = 100 })
      paper:add_pens({black, red, blue})


function draw_dot(point)
  local size = 0.75
  local dot = Path({
    point:clone():move_vector(0, size),
    point:clone():move_vector(90, size),
    point:clone():move_vector(180, size),
    point:clone():move_vector(270, size)
  }):close():set_pen(red)

  return dot
end


local path_A = Path({
  Point(30, 30),
  Point(70, 30),
  Point(70, 70),
  Point(30, 70)
}):close():set_pen(blue)


local point_A = path_A:point_at_distance(190)
draw_dot(point_A)

paper:save_svg('main.svg')