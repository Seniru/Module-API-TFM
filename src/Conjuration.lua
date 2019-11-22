local Conjuration = {}
Conjuration.__index = Conjuration

function Conjuration.new(xPosition, yPosition, duration)
  
  assert(type(xPosition) == 'number', 'Expected type of number for xPosition, instead got ' .. type(xPosition))
  assert(type(yPosition) == 'number', 'Expected type of number for yPosition, instead got ' .. type(yPosition))
  assert(type(duration) == 'number' or duration == nil, 'Expected type of number or nil for duration, instead got ' .. type(duration))
  
  local self = setmetatable({}, Conjuration)
  self.xPosition = xPosition
  self.yPosition = yPosition
  self.duration = duration or 10000
  return self
  
end

return Conjuration
