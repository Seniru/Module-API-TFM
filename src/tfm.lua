local Object = require 'src.Object'
local escapes = require 'src.escapes'
local Conjuration = require 'src.Conjuration'

require 'src.events'

local tfm = {
  enum = {
    emote = {
      dance = 0,
      laugh = 1,
      cry = 2,
      kiss = 3,
      angry = 4,
      clap = 5,
      sleep = 6,
      facepaw = 7,
      sit = 8,
      confetti = 9,
      flag = 10,
      marshmallow = 11,
      selfie = 12,
      highfive = 13,
      highfive_1 = 14,
      highfive_2 = 15,
      partyhorn = 16,
      hug = 17,
      hug_1 = 18,
      hug_2 = 19,
      jigglypuff = 20,
      kissing = 21,
      kissing_1 = 22,
      kissing_2 = 23,
      carnaval = 24,
      rockpaperscissors = 25,
      rockpaperscissors_1 = 26,
      rockpaperscissors_2 = 27
    },
    ground = {
      wood = 0,
      ice = 1,
      trampoline = 2,
      lava = 3,
      chocolate = 4,
      earth = 5,
      grass = 6,
      sand = 7,
      cloud = 8,
      water = 9,
      stone = 10,
      snow = 11,
      rectangle = 12,
      circle = 13,
      invisible = 14,
      web = 15
    },
    particle = {
      whiteGlitter = 0,
      blueGlitter = 1,
      orangeGlitter = 2,
      cloud = 3,
      dullWhiteGlitter = 4,
      heart = 5,
      bubble = 6,
      tealGlitter = 9,
      spirit = 10,
      yellowGlitter = 11,
      ghostSpirit = 12,
      redGlitter = 13,
      waterBubble = 14,
      plus1 = 15,
      plus10 = 16,
      plus12 = 17,
      plus14 = 18,
      plus16 = 19,
      meep = 20,
      redConfetti = 21,
      greenConfetti = 22,
      blueConfetti = 23,
      yellowConfetti = 24,
      diagonalRain = 25,
      curlyWind = 26,
      wind = 27,
      rain = 28,
      star = 29,
      littleRedHeart = 30,
      littlePinkHeart = 31,
      daisy = 32,
      bell = 33,
      egg = 34,
      projection = 35,
      mouseTeleportation = 36,
      shamanTeleportation = 37,
      lollipopConfetti = 38,
      yellowCandyConfetti = 39,
      pinkCandyConfetti = 40,
    },
    shamanObject = {
      arrow = 0,
      littleBox = 1,
      box = 2,
      littleBoard = 3,
      board = 4,
      ball = 6,
      trampoline = 7,
      anvil = 10,
      cannon = 17,
      bomb = 23,
      orangePortal = 26,
      blueBalloon = 28,
      redBalloon = 29,
      greenBalloon = 30,
      yellowBalloon = 31,
      rune = 32,
      chicken = 33,
      snowBall = 34,
      cupidonArrow = 35,
      apple = 39,
      sheep = 40,
      littleBoardIce = 45,
      littleBoardChocolate = 46,
      iceCube = 54,
      cloud = 57,
      bubble = 59,
      tinyBoard = 60,
      companionCube = 61,
      stableRune = 62,
      balloonFish = 65,
      longBoard = 67,
      triangle = 68,
      sBoard = 69,
      paperPlane = 80,
      rock = 85,
      pumpkinBall = 89,
      tombstone = 90,
      paperBall = 95
    }
  },
  exec = {},
  get = {
    misc = {
      apiVersion = 0.28,
      transformiceVersion = 6.09,
      moduleApiVersion = '0.2-SNAPSHOT'
    },
    room = {
      community = '',
      currentMap = 0,
      maxPlayers = 0,
      mirroredMap = false,
      name = '',
      objectList = {},
      passwordProtected = false,
      playerList = {},
      
      --[[WARNING!!!: Fields below are not related with tfm's module API]]--
      enabledAfkDeath = true,
      enabledAllShamanSkills = true,
      enabledAutoNewGame = true,
      enabledAutoScore = true,
      enabledAutoShaman = true,
      enabledAutoTimeLeft = true,
      enabledDebugCommand = true,
      allowedMinimalistMode = true,
      allowedMortCommand = true,
      enabledPhysicalConsumables = true,
      enabledPrespawnPreview = true,
      allowedWatchCommand = true
      
    },
    --[[WARNING!!!: data field is not related with tfm's module API]]--
    data = {
      chatMessages = {}
    }
  }
}

function tfm.exec.addConjuration(xPosition, yPosition, duration)
  local conj = Conjuration.new(xPosition, yPosition, duration)
  print(label('[Map: Conjuration]') .. '\tX: ' .. conj.xPosition .. ' | Y: ' .. conj.yPosition .. ' | duration: ' .. conj.duration .. 's \t' .. func('(tfm.exec.addConjuration)'))
  return conj
end

function tfm.exec.addImage(imageId, target, xPosition, yPosition, targetPlayer)
  error('Not implemented')
end

function tfm.exec.addJoint(id, ground1, ground2, jointDef)
  error('Not implemented')
end

function tfm.exec.addPhysicObject(id, xPosition, yPosition, bodyDef)
  tfm.get.room.objectList[id] = Object.new(id, xPosition, yPosition, bodyDef)
  print(label('[Map: (+)Phy Obj]') .. '\tID: ' .. id .. ' | X: ' .. xPosition .. ' | Y: ' .. yPosition .. ' ...\t\t' .. func('(tfm.exec.addPhysicObject)'))
  return tfm.get.room.objectList[id]
end

function tfm.exec.addShamanObject(objectType, xPosition, yPosition, angle, xSpeed, ySpeed, ghost)
  error('Not implemented')
end

function tfm.exec.changePlayerSize(playerName, size)
    size = size or 1
    assert(type(playerName) == 'string', 'Expected type of string for playerName, instead got ' .. type(playerName))
    assert(type(size) == 'number', 'Expected type of nil or number for size, instead got ' .. type(size))
    assert(size >= 0.1 and size <= 5, 'Expected value between 0.1 to 5 for size, instead got ' .. size)
    print(label('[Player: Change size]') .. '\tplayer: ' .. playerName .. ' | size: ' .. (size or 1) .. '\t\t' .. func('(tfm.exec.changePlayerSize)'))
    tfm.get.room.playerList[playerName].size = size or 1
end

function tfm.exec.chatMessage(message, playerName)
  assert(type(message) == 'string', 'Expected type of string for message, instead got type of ' .. type(message))
  assert(playerName == nil or type(playerName) == 'string', 'Expected type of string or nil for playerName, instead got ' .. type(playerName))
  table.insert(tfm.get.data, {message, playerName or 'All'})
  print(label('[Room: Chat message]') .. '\ttarget: ' .. (playerName or 'All') .. '\t\t\t\t' .. func('(tfm.exec.chatMessage)'))
  print(message)
end

function tfm.exec.disableAfkDeath(activate)
  error('Not implemented')
end

function tfm.exec.disableAllShamanSkills(active)
  error('Not implemented')
end

function tfm.exec.disableAutoNewGame(activate)
  error('Not implemented')
end

function tfm.exec.disableAutoScore(activate)
  error('Not implemented')
end

function tfm.exec.disableAutoShaman(activate)
  error('Not implemented')
end

function tfm.exec.disableAutoTimeLeft(activate)
  error('Not implemented')
end

function tfm.exec.disableDebugCommand(activate)
  error('Not implemented')
end

function tfm.exec.disableMinimalistMode(activate)
  error('Not implemented')
end

function tfm.exec.disableMortCommand(active)
  error('Not implemented')
end

function tfm.exec.disablePhysicalConsumables(active)
  error('Not implemented')
end

function tfm.exec.disablePrespawnPreview(display)
  error('Not implemented')
end

function tfm.exec.disableWatchCommand(activate)
  error('Not implemented')
end

function tfm.exec.displayParticle(particleType, xPosition, yPosition, xSpeed, ySpeed, xAcceleration, yAcceleration, targetPlayer)
  error('Not implemented')
end

function tfm.exec.explosion(xPosition, yPosition, power, radius, miceOnly)
  error('Not implemented')
end

function tfm.exec.giveCheese(playerName)
  error('Not implemented')
end

function tfm.exec.giveConsumables(playerName, consumableId, amount)
  error('Not implemented')
end

function tfm.exec.giveMeep(playerName, canMeep)
    canMeep = canMeep == nil and true or canMeep
    assert(type(playerName) == 'string', 'Expected type of string for playerName, instead got ' .. type(playerName))
    assert(type(canMeep) == 'boolean', 'Expected type of boolean or nil for canMeep, instead got ' .. type(canMeep))
    print(label('[Player: ' .. (canMeep and '(+)' or '(-)') ..' Meep]') .. '\tplayer: ' .. playerName .. ' | canMeep: ' .. tostring(canMeep) .. '\t\t' .. func('(tfm.exec.giveMeep)'))
    tfm.get.room.playerList[playerName].canMeep = canMeep
end

function tfm.exec.giveTransformations(playerName, canTransform)
    canTransform = canTransform == nil and true or canTransform
    assert(type(playerName) == 'string', 'Expected type of string for playerName, instead got ' .. type(playerName))
    assert(type(canTransform) == 'boolean', 'Expected type of boolean or nil for canTransform, instead got ' .. type(canTransform))
    print(label('[Player: ' .. (canTransform and '(+)' or '(-)') ..' Transform]') .. '\tplayer: ' .. playerName .. ' | canTransform: ' .. tostring(canTransform) .. '\t' .. func('(tfm.exec.giveTransformations)'))
    tfm.get.room.playerList[playerName].canTransform = canTransform
end

function tfm.exec.killPlayer(playerName)
  assert(type(playerName) == 'string', 'Expected type of string for playerName, instead got ' .. type(playerName))
  if (tfm.get.room.playerList[playerName]) then
    tfm.get.room.playerList[playerName].isDead = true
  end
  print(label('[Player: Kill]') .. '\t\tplayer: ' .. playerName .. ' | success: ' .. tostring(not not tfm.get.room.playerList[playerName]) .. '\t\t' .. func('(tfm.exec.killPlayer)'))
  eventPlayerDied(playerName)
end

function tfm.exec.linkMice(playerName1, playerName2, linked)
  error('Not implemented')
end

function tfm.exec.lowerSyncDelay(playerName)
  error('Not implemented')
end

function tfm.exec.moveObject(objectId, xPosition, yPosition, positionOffset, xSpeed, ySpeed, speedOffset, angle, angleOffset)
  error('Not implemented')
end

function tfm.exec.movePlayer(playerName, xPosition, yPosition, positionOffset, xSpeed, ySpeed, speedOffset)
  error('Not implemented')
end

function tfm.exec.newGame(mapCode, flipped)
  error('Not implemented')
end

function tfm.exec.playEmote(playerName, emoteId, emoteArg)
  error('Not implemented')
end

function tfm.exec.playerVictory(playerName)
  local gave = false
  assert(type(playerName) == 'string', 'Expected type of string for playerName, instead got ' .. type(playerName))
  if tfm.get.room.playerList[playerName].hasCheese then
      tfm.get.room.playerList[playerName].hasCheese = false
      if tfm.get.room.enabledAutoScore then
          tfm.get.room.playerList[playerName].score = tfm.get.room.playerList[playerName].score + 10
      end
      gave = true
      --TODO: Implement timeLeft and other relevant fields for using the function
      eventPlayerWon(playerName)
  end
  print(label('[Player: Win]') .. '\t\tplayer: ' .. playerName .. ' | success: ' .. tostring(gave) .. '\t\t' .. func('(tfm.exec.playerVictory)'))
end

function tfm.exec.removeCheese(playerName)
  assert(type(playerName) == 'string', 'Expected type of string for playerName, instead got ' .. type(playerName))
  tfm.get.room.playerList[playerName].hasCheese = false
  print(label('[Player: (-) Cheese]') .. '\tplayer: ' .. playerName .. '\t\t\t\t' .. func('(tfm.exec.removeCheese)'))
end

function tfm.exec.removeImage(imageId)
  error('Not implemented')
end

function tfm.exec.removeJoint(id)
  error('Not implemented')
end

function tfm.exec.removeObject(objectId)
  error('Not implemented')
end

function tfm.exec.removePhysicalObject(id)
  error('Not implemented')
end

function tfm.exec.respawnPlayer(playerName)
  error('Not implemented')
end

function tfm.exec.setAutoMapFlipMode(flipped)
  error('Not implemented')
end

function tfm.exec.setGameTime(time, init)
  error('Not implemented')
end

function tfm.exec.setNameColor(playerName, color)
  error('Not implemented')
end

function tfm.exec.setPlayerScore(playerName, score, add)
  error('Not implemented')
end

function tfm.exec.setRoomMaxPlayers(maxPlayers)
  assert(type(maxPlayers) == 'number', 'Expected type of number for maxPlayers, instead got ' .. type(maxPlayers))
  tfm.get.room.maxPlayers = maxPlayers
  print(label('[Room: Max players]') .. '\tmaxPlayers: ' .. maxPlayers .. '\t\t\t\t' .. func('(tfm.exec.setRoomMaxPlayers)'))
end

function tfm.exec.setRoomPassword(password)
  print(label('[Room: ' .. (password == '' and 'Unset' or 'Set') .. ' password]') .. '\tpassword: ' .. password .. '\t\t\t\t' .. func('(tfm.exec.setRoomPassword)'))
  tfm.get.room.passwordProtected = password ~= ''
end

function tfm.exec.setShaman(playerName, makeAShaman)
  error('Not implemented')
end

function tfm.exec.setShamanMode(playerName, mode)
  error('Not implemented')
end

function tfm.exec.setVampirePlayer(playerName, makeAVampire)
    makeAVampire = makeAVampire == nil and true or makeAVampire
    assert(type(playerName) == 'string', 'Expected type of string for playerName, instead got ' .. type(playerName))
    assert(type(makeAVampire) == 'boolean', 'Expected type of boolean or nil for makeAVampire, instrad got ' .. type(makeAVampire))
    print(label('[Player: Vampire]') .. '\tplayer: ' .. playerName .. ' | status: ' .. tostring(makeAVampire) .. '\t\t' .. func('(tfm.exec.setVampirePlayer)'))    
    tfm.get.room.playerList[playerName].isVampire = makeAVampire
    eventPlayerVampire(playerName)
end

function tfm.exec.snow(duration, snowBallPower)
  assert(type(duration) == 'number' or duration == nil, "Expected type of number or nil for duration, instead got " .. type(duration))
  assert(type(snowBallPower) == 'number' or snowBallPower == nil, "Expected type of number or nil for snowBallPower, instead got " .. type(snowBallPower))
  print(label('[Room: Snowing]') .. '\t\tduration: ' .. (duration or 60) .. 's | Snow Power: ' .. (snowBallPower or 10) .. '\t\t' .. func('(tfm.exec.snow)'))
end

return tfm
