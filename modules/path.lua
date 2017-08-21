local path = {}

function path:new()
  local this = {}
        this.type = "path"
        this.closed = false
        this.points = {}

  return this
end

return path