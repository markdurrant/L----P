local pen = {}

function pen:new(weight, color)
  local this = {}
        this.type = "pen"
        this.weight = weight or 2
        this.color = color or "#000"
        this.paths = {}

  return this
end

return pen