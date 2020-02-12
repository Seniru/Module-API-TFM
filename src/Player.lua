local Config = require "extra.Config"
 --

--[==[
  @type class
  @name Player
]==]
local Player = {}
Player.__index = Player

function Player.new(name, config)
    config = setmetatable(config or {}, Config)
    local self = setmetatable({}, Player)

    self.playerName = name
    self.community = config.community or "en"
    self.gender = config.gender or 0
    self.hasCheese = not (not config.hasCheese)
    self.id = config.id or 0
    self.inHardMode = config.inHardMode or 0
    self.isDead = config.isDead or false
    self.isFacingRight = config.isFacingRight == nil and true or config.isFacingRight
    self.isInvoking = not (not config.isInvoking)
    self.isJumping = false
    self.isShaman = not (not config.isShaman)
    self.isVampire = false
    self.look = "NOT IMPLEMENTED"
    self.movingLeft = not (not config.movingLeft)
    self.movingRight = not (not config.movingRight)
    self.registrationData = config.registrationData or 0
    self.score = 0
    self.shamanMode = config.shamanMode or 0
    self.spouseId = config.spouseId or 1
    self.spouseName = config.spouseName
    self.title = config.title or "Little Mouse"
    self.tribeId = config.tribeId or 0
    self.tribeName = config.tribeName or ""
    self.vx = config.vx or 0
    self.vy = config.vy or 0
    self.x = config.x or 0
    self.y = config.y or 0

    --[[WARNING! These fields are not included in TFM APJ]] 
    self.size = 1
    self.canMeep = false
    self.canTransform = false
    self.isFrozen = false
    self.nameColor = 0xffffff
    self.defaultShamanMode = self.shamanMode
    self.inventory = {}

    return self
end

return Player
