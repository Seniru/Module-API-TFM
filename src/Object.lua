local Config = require 'src.Config'

local Object = {}
Object.__index = Object

function Object.new(id, x, y, config)
    config = setmetatable(config, Config)
    local self = setmetatable({}, Object)
    
    assert(type(x) == 'number', 'Expected type of number for x, instead got ' .. type(xPosition))
    assert(type(y) == 'number', 'Expected type of number for y, instead got ' .. type(yPosition))
    assert(type(config), 'table', 'Expected a table for config, instead got ' .. type(config))
  

  self.id = id
  self.type = config.type
  self.angle = config.angle or 0
  self.baseType = config.baseType or 2
  self.colors = config.colors or {}
  self.ghost = not not config.ghost
  self.vx = config.vx or 0
  self.vy = config.vy or 0
  self.x = x or 0
  self.y = y or 0
  self.width = config.width or 0
  self.height = config.height or 0
  self.bodyDef = config

  return self
end

return Object
