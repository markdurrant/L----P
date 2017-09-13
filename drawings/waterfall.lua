local utl = require("modules/utl")

local Paper = require("modules/paper")
local   Pen = require("modules/pen")
local  Path = require("modules/path")
local Point = require("modules/point")

local Shape = require("modules/shape")

local paper = Paper:new({ width = 210, height = 297 })

local black = Pen:new({ weight = 1, color = "#000" })
local cyan = Pen:new({ weight = 1, color = "#0ff" })

local marginSize = 20

local margin = Path:new(
  Point:new(marginSize, marginSize),
  Point:new(paper.width - marginSize, marginSize),
  Point:new(paper.width - marginSize, paper.height - marginSize * 2),
  Point:new(marginSize, paper.height - marginSize * 2)
):close():setPen(cyan)

function randDash(shift)
  local gaps = {}

  for i = 1, math.random(20, 100) do
    table.insert(
      gaps,
      -- math.random(margin.top, margin.bottom)
      math.floor(margin.top + (margin.bottom - margin.top) * math.random() ^ 3)
      )
  end

  for _, g in ipairs(gaps) do
    Path:new(
      Point:new(margin.left + shift, g - 1.5),
      Point:new(margin.left + shift, g + 1.5)
    ):setPen(black)
  end
end

local divisions = 60

for i = 0, divisions do
  local shift = i * (margin.right - margin.left) / divisions

  randDash(shift)
end

-- paper:addPens(cyan)
paper:addPens(black)
paper:saveTo('svg-output/testy.svg')