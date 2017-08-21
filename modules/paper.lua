local paper = {}

function paper:new(width, height)
  local this = {}
        this.type = "paper"
        this.width = width
        this.height = height
        this.pens = {}

  return this
end

return paper