local Config = require 'src.Config'

local Object = {}
Object.__index = Object

function Object.new(id, x, y, config)
  assert(type(config), 'table', 'Expected a table for config, instead got ' .. type(config))
  config = setmetatable(config, Config)
  local self = setmetatable({}, Object)

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
