local pen = {}

function pen:new(weight, color)
  local this = {}

  this.type = "pen"
  this.weight = weight or 2
  this.color = color or "#000"
  this.paths = {}

  function this:log()
    local penLog = string.format("PEN, weight: %d color: %s", this.weight, this.color)

    for k, path in pairs(this.paths) do
      penLog = penLog .. string.format("\n[%s] ", k) .. path:log()
    end

    return penLog
  end

  function this:print()
    print(this:log())
  end

  function this:addPath(...)
    for i, path in ipairs({...}) do
      table.insert(this.paths, path)
    end
  end

  function this:render()
    local penTag = ""
    local penContent = ""

    local style = string.format(
      'style="stroke-width: %d; stroke: %s; stroke-linecap: round; stroke-linejoin: round; fill: none;"',
      this.weight, this.color
    )

    for i, path in pairs(this.paths) do
      penContent = penContent .. path:render()
    end

    penTag = '<g ' .. style .. '>' .. penContent .. '</g>'

    return penTag
  end

  return this
end

return pen