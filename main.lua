require('../L-P/L-P')

math.randomseed(os.time())

local black = Pen({ weight = 1, color = '#000' })
local blue = Pen({ weight = 0.5, color = '#0ff' })
local red = Pen({ weight = 0.5, color = '#f0f' })
local paper = Paper({ width = 100, height = 140 })
      paper:add_pens({black, red, blue})

function fat_line(point_A, point_B)
  local fatness = 4
  local num_lines = 100
  local direction = point_A:angle_to(point_B)
  local fat_line_points = {}

  local guide_A = Path({
    point_A:clone():move_vector(direction + 90, fatness),
    point_B:clone():move_vector(direction + 90, fatness)
  })

  local guide_B = Path({
    point_A:clone():move_vector(direction - 90, fatness),
    point_B:clone():move_vector(direction - 90, fatness)
  })

  for i = 0, num_lines do
    if i % 2 == 0 then
      table.insert(
        fat_line_points,
        guide_A:point_at_distance(guide_A:length() / num_lines * i)
      )
    else
      table.insert(
        fat_line_points,
        guide_B:point_at_distance(guide_B:length() / num_lines * i)
      )
    end
  end

  return Path(fat_line_points):set_pen(black)
end

local line_A = Path({
  paper.center:clone():move(-20, -40),
  paper.center:clone():move(20, 40)
}):set_pen(red)

fat_line(line_A.points[1], line_A.points[2])

paper:save_svg('main.svg')