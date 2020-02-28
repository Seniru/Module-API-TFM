local escapes = require 'extra.escapes'
local Object = require 'src.Object'
local PhysicObject = require 'src.PhysicObject'
local Conjuration = require 'src.Conjuration'
local Joint = require 'src.Joint'
local Particle = require 'src.Particle'
local typeAssert = require 'extra.TypeError'

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
            xmlMapInfo = {
                permCode = nil,
                mapCode = 630022,
                author = "Tigrounette#0001",
                xml = "<C><P /><Z><S /><D /><O /></Z></C>"
            },
      
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
            allowedWatchCommand = true,
            enabledMapFlipMode = nil,
            gameTime = 2 * 60 + 10  
        },
        --[[WARNING!!!: data field is not related with tfm's module API]]--
        data = {
            chatMessages = {},
            physicObjects = {},
            explosions = {},
            joints = {},
            particles = {
                all = {},
                head = nil
            }
        }
    }
}

local shamanModes = {
    [0] = 'normal',
    [1] = 'hard',
    [2] = 'divine'
}
local jointTypes = {'distance', 'prismatic', 'pulley', 'revolute'}

function tfm.exec.addConjuration(xPosition, yPosition, duration)
    local conj = Conjuration(xPosition, yPosition, duration)
    print(label('[Map: Conjuration]') .. '\tX: ' .. conj.xPosition .. ' | Y: ' .. conj.yPosition .. ' | duration: ' .. conj.duration .. 's \t' .. func('(tfm.exec.addConjuration)'))
    return conj
end

function tfm.exec.addImage(imageId, target, xPosition, yPosition, targetPlayer)
    error('Not implemented')
end

function tfm.exec.addJoint(id, ground1, ground2, jointDef)
    -- defaulting the points locations to corresponding ground's center
    local g1 = tfm.get.data.physicObjects[ground1]
    local g2 = tfm.get.data.physicObjects[ground2]
    jointDef.point1 = jointDef.point1 or (g1.xPosition + (g1.width / 2) .. "," .. (g1.yPosition + (g1.height / 2)))
    jointDef.point2 = jointDef.point2 or (g2.xPosition + (g2.width / 2) .. "," .. (g2.yPosition + (g2.height / 2)))
    local joint = Joint(id, ground1, ground2, jointDef)
    tfm.get.data.joints[id] = joint
    print(label('[Map: Joint]') .. '\t\tid: ' .. id .. ' | type: ' .. jointTypes[jointDef.type + 1] .. ' | visible: ' .. tostring(joint.visible) .. '\t' .. func('(tfm.exec.addJoint)'))
    return joint
end

function tfm.exec.addPhysicObject(id, xPosition, yPosition, bodyDef)
    tfm.get.data.physicObjects[id] = PhysicObject(id, xPosition, yPosition, bodyDef)
    print(label('[Map: (+)Phy Obj]') .. '\tID: ' .. id .. ' | X: ' .. xPosition .. ' | Y: ' .. yPosition .. ' ... \t\t' .. func('(tfm.exec.addPhysicObject)'))
end

function tfm.exec.addShamanObject(objectType, xPosition, yPosition, angle, xSpeed, ySpeed, ghost)
    local obj = Object(objectType, xPosition, yPosition, angle or 0, xSpeed or 0, ySpeed or 0, not not ghost)
    tfm.get.room.objectList[obj.id] = obj
    print(label('[Map: (+)Sham Obj]') .. '\tID: ' .. obj.id .. ' | Type: ' .. objectType .. ' | X: ' .. xPosition .. ' Y: ' .. yPosition .. ' ...\t\t' .. func('(tfm.exec.addShamanObject)'))
    return obj.id
end

function tfm.exec.changePlayerSize(playerName, size)
    size = size or 1
    typeAssert('changePlayerSize', 'string', 1, playerName)
    typeAssert('changePlayerSize', {'number', 'nil'}, 2, size)
    assert(size >= 0.1 and size <= 5, 'Expected value between 0.1 to 5 for size, instead got ' .. size)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].size = size or 1
        print(label('[Player: Change size]') .. '\tplayer: ' .. playerName .. ' | size: ' .. (size or 1) .. '\t\t' .. func('(tfm.exec.changePlayerSize)'))
    end
end

function tfm.exec.chatMessage(message, playerName)
    typeAssert('chatMessage', 'string', 1, message)
    typeAssert('chatMessage', {'string', 'nil'}, 2, playerName)
    table.insert(tfm.get.data, {message, playerName or 'All'})
    print(label('[Room: Chat message]') .. '\ttarget: ' .. (playerName or 'All') .. '\t\t\t\t' .. func('(tfm.exec.chatMessage)'))
    print(message)
end

function tfm.exec.disableAfkDeath(activate)
    activate = activate == nil and true or activate
    typeAssert('disableAfkDeath', {'boolean'}, 1, activate)
    tfm.get.room.enabledAfkDeath = not activate
    print(label('[Room: Afk Death]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disableAfkDeath)'))
end

function tfm.exec.disableAllShamanSkills(activate)
    activate = activate == nil and true or activate
    typeAssert('disableAllShamanSkills', 'boolean', 1, activate)
    tfm.get.room.enabledAllShamanSkills = not activate
    print(label('[Room: Shaman Skills]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disableAllShamanSkills)'))
end

function tfm.exec.disableAutoNewGame(activate)
    activate = activate == nil and true or activate
    typeAssert('disableAutoNewGame', 'boolean', 1, activate)
    tfm.get.room.enabledAutoNewGame = not activate
    print(label('[Room: Auto New Game]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disableAutoNewGame)'))
end

function tfm.exec.disableAutoScore(activate)
    activate = activate == nil and true or activate
    typeAssert('disableAutoScore', 'boolean', 1, activate)
    tfm.get.room.enabledAutoScore = not activate
    print(label('[Room: Afk Death]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disableAfkDeath)'))
end

function tfm.exec.disableAutoShaman(activate)
    activate = activate == nil and true or activate
    typeAssert('disableAutoShaman', 'boolean', 1, activate)
    tfm.get.room.enabledAutoShaman = not activate
    print(label('[Room: Auto Shaman]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disableAutoShaman)'))
end

function tfm.exec.disableAutoTimeLeft(activate)
    activate = activate == nil and true or activate
    typeAssert('disableAutoTimeLeft', 'boolean', 1, activate)
    tfm.get.room.enabledAutoTimeLeft = not activate
    print(label('[Room: Auto Timeleft]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disableAutoTimeLeft)'))
end

function tfm.exec.disableDebugCommand(activate)
    activate = activate == nil and true or activate
    typeAssert('disableDebugCommand', 'boolean', 1, activate)
    tfm.get.room.enabledDebugCommand = not activate
    print(label('[Room: Debug]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disableDebugCommand)'))
end

function tfm.exec.disableMinimalistMode(activate)
    activate = activate == nil and true or activate
    typeAssert('disableAfkDeath', 'boolean', 1, activate)
    tfm.get.room.allowedMinimalistMode = not activate
    print(label('[Room: Minimalist Mode]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disableMinimalistMode)'))
end

function tfm.exec.disableMortCommand(activate)
    activate = activate == nil and true or activate
    typeAssert('disableMortCommand', 'boolean', 1, activate)
    tfm.get.room.allowedMortCommand = not activate
    print(label('[Room: Mort]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disableMortCommand)'))
end

function tfm.exec.disablePhysicalConsumables(activate)
    activate = activate == nil and true or activate    
    typeAssert('disablePhysicalConsumables', 'boolean', 1, activate)
    tfm.get.room.enabledPhysicalConsumables = not activate
    print(label('[Room: Consumables]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disablePhysicalConsumables)'))
end

function tfm.exec.disablePrespawnPreview(display)
    display = display == nil and true or display
    typeAssert('disablePrespawnPreview', 'boolean', 1, display)
    tfm.get.room.enabledPrespawnPreview = not display
    print(label('[Room: Prespawn Preview]') .. '\tdisplay: ' .. tostring(display) .. '\t\t\t\t' .. func('(tfm.exec.disablePrespawnPreview)'))
end

function tfm.exec.disableWatchCommand(activate)
    activate = activate == nil and true or activate    
    typeAssert('disableWatchCommand', 'boolean', 1, activate)
    tfm.get.room.allowedWatchCommand = not activate
    print(label('[Room: Watch]') .. '\tdisabled: ' .. tostring(activate) .. '\t\t\t\t' .. func('(tfm.exec.disableWatchCommand)'))
end

function tfm.exec.displayParticle(particleType, xPosition, yPosition, xSpeed, ySpeed, xAcceleration, yAcceleration, targetPlayer)
    local particle = Particle(particleType, xPosition, yPosition, xSpeed, ySpeed, xAcceleration, yAcceleration)
    local type = nil

    for name, id in next, tfm.enum.particle do
        if id == particleType then
            type = name
        end
    end

    if not targetPlayer then
        tfm.get.data.particles.all[#tfm.get.data.particles.all + 1] = particle
        tfm.get.data.particles.head = particle
    else
        if not tfm.get.data.particles[targetPlayer] then
            tfm.get.data.particles[targetPlayer] = {
                all = {particle},
                head = particle
            }
        else
            tfm.get.data.particles[targetPlayer].all[#tfm.get.data.particles[targetPlayer].all + 1] = particle
            tfm.get.data.particles[targetPlayer].head = particle
        end
    end

    print(label('[Game: Particle]') .. '\ttarget: ' .. (targetPlayer or 'All') .. ' | particle: ' .. particleType .. (type and ' (' .. type .. ')' or '') .. ' ...\t' .. func('(tfm.exec.displayParticle)'))

    return particle
end

function tfm.exec.explosion(xPosition, yPosition, power, radius, miceOnly)
    miceOnly = not not miceOnly
    typeAssert('explosion', 'number', 1, xPosition)
    typeAssert('explosion', 'number', 2, yPosition)
    typeAssert('explosion', 'number', 3, power)
    typeAssert('explosion', 'number', 4, radius)
    typeAssert('explosion', 'boolean', 5, miceOnly)
    print(label('[Game: Explosion]') .. '\tX: ' .. xPosition .. ' | Y: ' .. yPosition .. ' | power: ' .. power .. ' ... \t\t' .. func('(tfm.exec.explosion)'))
    tfm.get.data.explosions[#tfm.get.data.explosions + 1] = {xPosition, yPosition, power, radius, miceOnly}
    return #tfm.get.data.explosions
end

function tfm.exec.freezePlayer(playerName, freeze)
    freeze = freeze == nil and true or freeze
    typeAssert('freezePlayer', 'string', 1, playerName)
    typeAssert('freezePlayer', 'boolean', 2, freeze)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].isFrozen = freeze
        print(label('[Player: Freeze]') .. '\tplayer: ' .. playerName .. ' | freeze: ' .. tostring(freeze) .. '\t\t' .. func('(tfm.exec.freezePlayer)'))
    end
end

function tfm.exec.giveCheese(playerName)
    typeAssert('giveCheese', 'string', 1, playerName)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].hasCheese = true
        print(label('[Player: (+) Cheese]') .. '\tplayer: ' .. playerName .. '\t\t\t\t' .. func('(tfm.exec.giveCheese)'))
        eventPlayerGetCheese(playerName)
    end
end

function tfm.exec.giveConsumables(playerName, consumableId, amount)
    amount = amount or 1
    typeAssert('giveConsumables', 'string', 1, playerName)
    typeAssert('giveConsumables', 'string', 2, consumableId)
    typeAssert('giveConsumables', 'number', 3, amount)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].inventory[consumableId] = (tfm.get.room.playerList[playerName].inventory[consumableId] or 0) + amount
        print(label('[Player: (+)Consumable]') .. '\tplayer: ' .. playerName .. ' | consumable: ' .. consumableId .. ' | amount: ' .. amount .. '\t' .. func('(tfm.exec.giveConsumables)'))
    end
end

function tfm.exec.giveMeep(playerName, canMeep)
    canMeep = canMeep == nil and true or canMeep
    typeAssert('giveMeep', 'string', 1, playerName)
    typeAssert('giveMeep', 'boolean', 2, canMeep)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].canMeep = canMeep
        print(label('[Player: ' .. (canMeep and '(+)' or '(-)') ..' Meep]') .. '\tplayer: ' .. playerName .. ' | canMeep: ' .. tostring(canMeep) .. '\t\t' .. func('(tfm.exec.giveMeep)'))
    end
end

function tfm.exec.giveTransformations(playerName, canTransform)
    canTransform = canTransform == nil and true or canTransform
    typeAssert('giveTransformations', 'string', 1, playerName)
    typeAssert('giveTransformations', 'boolean', 2, canTransform)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].canTransform = canTransform
        print(label('[Player: ' .. (canTransform and '(+)' or '(-)') ..' Transform]') .. '\tplayer: ' .. playerName .. ' | canTransform: ' .. tostring(canTransform) .. '\t' .. func('(tfm.exec.giveTransformations)'))
    end
end

function tfm.exec.killPlayer(playerName)
    typeAssert('killPlayer', 'string', 1, playerName)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].isDead = true
    end
    print(label('[Player: Kill]') .. '\t\tplayer: ' .. playerName .. ' | success: ' .. tostring(not not tfm.get.room.playerList[playerName]) .. '\t\t' .. func('(tfm.exec.killPlayer)'))
    eventPlayerDied(playerName)
end

function tfm.exec.linkMice(playerName1, playerName2, linked)
    linked = linked == nil and true or linked
    typeAssert('linkMice', 'string', 1, playerName1)
    typeAssert('linkMice', 'string', 2, playerName2)
    typeAssert('linkMice', 'boolean', 3, linked)
    if tfm.get.room.playerList[playerName1] and tfm.get.room.playerList[playerName2] and playerName1 ~= playerName2 then
        tfm.get.room.playerList[playerName1].linkedTo = linked and playerName2 or nil
        tfm.get.room.playerList[playerName2].linkedTo = linked and playerName1 or nil
        print(label('[Player: Link]') .. '\t\tp1: ' .. playerName1 .. ' | p2: ' .. playerName2 .. ' | linked: ' .. tostring(linked) .. func(' (tfm.exec.linkMice)'))
    end
end

function tfm.exec.lowerSyncDelay(playerName)
    typeAssert('lowerSyncDelay', 'string', 1, playerName)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].syncDelay = 400
        print(label('[Player: (-) Sync delay') .. '\t' .. 'player: ' .. playerName .. '\t\t\t\t' .. func('(tfm.exec.lowerSyncDelay)'))
    end
end

function tfm.exec.moveObject(objectId, xPosition, yPosition, positionOffset, xSpeed, ySpeed, speedOffset, angle, angleOffset)
    typeAssert('moveObject', 'number', 1, objectId)
    typeAssert('moveObject', 'number', 2, xPosition)
    typeAssert('moveObject', 'number', 3, yPosition)
    xSpeed = xSpeed or 0
    ySpeed = ySpeed or 0
    angle = angle or 0

    if tfm.get.room.objectList[objectId] then
        
        if not positionOffset then
            tfm.get.room.objectList[objectId].x = xPosition
            tfm.get.room.objectList[objectId].y = yPosition
        else
            tfm.get.room.objectList[objectId].x = tfm.get.room.objectList[objectId].x + xPosition + xSpeed
            tfm.get.room.objectList[objectId].y = tfm.get.room.objectList[objectId].y + yPosition + ySpeed
        end
        
        if not angleOffset then
            tfm.get.room.objectList[objectId].angle = angle
        else
            tfm.get.room.objectList[objectId].angle = tfm.get.room.objectList[objectId].angle + angle
        end
        --angle normalization
        local degrees = tfm.get.room.objectList[objectId].angle
        tfm.get.room.objectList[objectId].angle = (degrees % 360 + 360) % 360

        print(label('[Object: Move]') .. '\tid: ' .. objectId .. ' | x: ' .. xPosition .. ' | y: ' .. yPosition .. ' | positionOffset: ' .. (tostring(not not positionOffset)) .. '\n\t\t\t' ..
            'xSpeed: ' .. xSpeed .. ' | ySpeed: ' .. ySpeed  .. ' | speedOff: ' .. tostring(not not speedOffset) .. '\n\t\t\t' .. 
            'angle: ' .. angle .. ' | angleOffset: ' .. tostring(not not angleOffset) .. '\t\t' .. func('(tfm.exec.moveObject)')
        )

    end
end

function tfm.exec.movePlayer(playerName, xPosition, yPosition, positionOffset, xSpeed, ySpeed, speedOffset)
    typeAssert('movePlayer', 'string', 1, playerName)
    typeAssert('movePlayer', 'number', 2, xPosition)
    typeAssert('movePlayer', 'number', 3, yPosition)
    xSpeed = xSpeed or 0
    ySpeed = ySpeed or 0
    if tfm.get.room.playerList[playerName] then
        if not positionOffset then
            tfm.get.room.playerList[playerName].x = xPosition
            tfm.get.room.playerList[playerName].y = yPosition
        else
            --assuming no speed gain before
            tfm.get.room.playerList[playerName].x = tfm.get.room.playerList[playerName].x + xPosition + xSpeed -- assuming no friction
            tfm.get.room.playerList[playerName].y = tfm.get.room.playerList[playerName].y + yPosition + ySpeed -- assuming no gravity
        end
        print(label('[Player: Move]') .. '\t\t\tplayer: ' .. playerName .. ' | x: ' .. xPosition .. ' | y: ' .. yPosition .. ' | positionOffset: ' .. (tostring(not not positionOffset)) .. '\n\t\t\t' ..
            'xSpeed: ' .. xSpeed .. ' | ySpeed: ' .. ySpeed  .. ' | speedOff: ' .. tostring(not not speedOffset) .. '\t' .. func('(tfm.exec.movePlayer)')
        )
    end
end

function tfm.exec.newGame(mapCode, flipped)
    local success = false
    --checking the mapcode format
    if mapCode == nil then
        local randMap = math.random(1, 9999999)
        tfm.get.room.currentMap = "@" .. randMap
        tfm.get.room.xmlMapInfo.mapCode = randMap
        tfm.get.room.xmlMapInfo.permCode = nil
        tfm.get.room.xmlMapInfo.author = nil
        tfm.get.room.xmlMapInfo.xml = nil
        success = true
    elseif type(mapCode) == "number" then
        tfm.get.room.currentMap = "@" .. mapCode
        tfm.get.room.xmlMapInfo.mapCode = mapCode
        tfm.get.room.xmlMapInfo.permCode = nil
        tfm.get.room.xmlMapInfo.author = nil
        tfm.get.room.xmlMapInfo.xml = nil
        success = true
    elseif mapCode:find("^@?%d+$") then
        tfm.get.room.currentMap = mapCode
        tfm.get.room.xmlMapInfo.mapCode = tonumber(mapCode:match("@(%d+)"))
        tfm.get.room.xmlMapInfo.permCode = nil
        tfm.get.room.xmlMapInfo.author = nil
        tfm.get.room.xmlMapInfo.xml = nil
        success = true
    elseif mapCode:find("^#%d+$") then
        tfm.get.room.currentMap = nil
        tfm.get.room.xmlMapInfo.mapCode = nil
        tfm.get.room.xmlMapInfo.permCode = tonumber(mapCode:match("#(%d+)"))
        tfm.get.room.xmlMapInfo.author = nil
        tfm.get.room.xmlMapInfo.xml = nil
        success = true
    elseif mapCode:find("^<.+>$") then
        tfm.get.room.currentMap = mapCode
        tfm.get.room.xmlMapInfo.mapCode = nil
        tfm.get.room.xmlMapInfo.permCode = nil
        tfm.get.room.xmlMapInfo.author = nil
        tfm.get.room.xmlMapInfo.xml = mapCode
        success = true
    end
    
    if success then
        tfm.get.room.mirroredMap = flipped
        print(label('[Map: New]') .. '\t\tmapCode: ' .. (mapCode == nil and "random" or mapCode) .. " | flipped: " .. tostring(flipped) .. '\t\t' .. func('(tfm.exec.newGame)'))
    end

end

function tfm.exec.playEmote(playerName, emoteId, emoteArg)
    typeAssert('playEmote', 'string', 1, playerName)
    typeAssert('playEmote', 'number', 2, emoteId)
    typeAssert('playEmote', {'nil', 'string'}, 3, emoteArg)
    if tfm.get.room.playerList[playerName] then
        local emoteName = ''
        for name, id in next, tfm.enum.emote do
            if id == emoteId then
                emoteName = name
            end
        end
        print(label('[Player: Emote]') .. '\t\tplayer: ' .. playerName .. ' | emote: ' .. emoteId.. ' (' .. emoteName .. ')' .. (emoteArg and ' | args: ' .. emoteArg or '') .. '\t' .. func('(tfm.exec.playEmote)')) 
        eventEmotePlayed(playerName, emoteId, emoteArg)
    end
end

function tfm.exec.playerVictory(playerName)
    local gave = false
    typeAssert('playerVictory', 'string', 1, playerName)
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
    typeAssert('removeCheese', 'string', 1, playerName)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].hasCheese = false
        print(label('[Player: (-) Cheese]') .. '\tplayer: ' .. playerName .. '\t\t\t\t' .. func('(tfm.exec.removeCheese)'))
    end
end

function tfm.exec.removeImage(imageId)
    error('Not implemented')
end

function tfm.exec.removeJoint(id)
    typeAssert('removeJoint', 'number', 1, id)
    tfm.get.data.joints[id] = nil
    print(label('[Room: (-) Joint]') .. '\tid: ' .. id .. '\t\t\t\t\t' .. func('(tfm.exec.removeJoint)'))
end

function tfm.exec.removeObject(objectId)
    typeAssert('removeObject', 'number', 1, objectId)
    tfm.get.room.objectList[objectId] = nil
    print(label('[Map: (-) Sham Obj]') .. '\tID: ' .. objectId .. '\t\t\t\t\t' .. func('(tfm.exec.removeObject)'))
end

function tfm.exec.removePhysicObject(id)
    typeAssert('removePhysicObject', 'number', 1, id)
    tfm.get.data.physicObjects[id] = nil
    print(label('[Map: (-) Phy Obj]') .. '\tID: ' .. id .. '\t\t\t\t\t' .. func('(tfm.exec.removePhysicObject)'))
end

function tfm.exec.respawnPlayer(playerName)
    typeAssert('respawnPlayer', 'string', 1, playerName)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].isDead = false
        tfm.get.room.playerList[playerName].x = 0
        tfm.get.room.playerList[playerName].y = 0
        print(label('[Player: Respawn]') .. '\tplayer: ' .. playerName .. ' | success: ' .. tostring(not not tfm.get.room.playerList[playerName]) .. '\t\t' .. func('(tfm.exec.respawnPlayer)'))
        eventPlayerRespawn(playerName)
    end
end

function tfm.exec.setAutoMapFlipMode(flipped)
    typeAssert('setAutoMapFlipMode', {'boolean', 'nil'}, 1, flipped)
    tfm.get.room.enabledMapFlipMode = flipped
    print(label('[Map: Flipped]') .. '\t\tflipped: ' .. tostring(flipped == nil and 'default' or flipped) .. '\t\t\t\t' .. func('(tfm.exec.setAutoMapFlipMode)'))
end

function tfm.exec.setGameTime(time, init)
    typeAssert('setGameTime', 'number', 1, time)
    init = init == nil and true or init
    if init then
        tfm.get.room.gameTime = time
    else
        if time < tfm.get.room.gameTime then
            tfm.get.room.gameTime = time
        end
    end
    print(label('[Game: Time]') .. '\t\ttime: ' .. time .. ' | init: ' .. tostring(init) .. '\t\t\t' .. func('(tfm.exec.setGameTime)'))
end

function tfm.exec.setNameColor(playerName, color)
    typeAssert('setNameColor', 'string', 1, playerName)
    typeAssert('setNameColor', 'number', 2, color)
    local success = false
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].nameColor = color
        success = true
    end
    print(label('[Player: Name Color]') .. '\tplayer: ' .. playerName .. ' | color: ' .. tostring(success and color or false) .. " " .. func('(tfm.exec.setNameColor)'))
end

function tfm.exec.setPlayerScore(playerName, score, add)
    add = add or false
    typeAssert('setPlayerScore', 'string', 1, playerName)
    typeAssert('setPlayerScore', 'number', 2, score)
    typeAssert('setPlayerScore', 'boolean', 3, add)
    local success = false
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].score = add and (tfm.get.room.playerList[playerName].score + score) or score
    end
    print(label('[Player: Score]') .. '\t\tplayer: ' .. playerName .. ' | add: ' .. tostring(success and score or false) .. '\t' .. func('(tfm.exec.setPlayerScore)'))
end

function tfm.exec.setRoomMaxPlayers(maxPlayers)
    typeAssert('setRoomMaxPlayers', 'number', 1, maxPlayers)
    tfm.get.room.maxPlayers = maxPlayers
    print(label('[Room: Max players]') .. '\tmaxPlayers: ' .. maxPlayers .. '\t\t\t\t' .. func('(tfm.exec.setRoomMaxPlayers)'))
end

function tfm.exec.setRoomPassword(password)
    print(label('[Room: ' .. (password == '' and 'Unset' or 'Set') .. ' password]') .. '\tpassword: ' .. password .. '\t\t\t\t' .. func('(tfm.exec.setRoomPassword)'))
    tfm.get.room.passwordProtected = password ~= ''
end

function tfm.exec.setShaman(playerName, makeAShaman)
    makeAShaman = makeAShaman == nil and true or makeAShaman
    typeAssert('setShaman', 'string', 1, playerName)
    typeAssert('setShaman', 'boolean', 2, makeAShaman)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].isShaman = makeAShaman
        print(label('[Player: Shaman]') .. '\tplayer: ' .. playerName .. ' | status: ' .. tostring(makeAShaman) .. '\t\t' .. func('(tfm.exec.setShaman)'))
    end
end

function tfm.exec.setShamanMode(playerName, mode)
    typeAssert('setShamanMode', 'string', 1, playerName)
    typeAssert('setShamanMode', {'number', 'nil'}, 2, mode)
    if tfm.get.room.playerList[playerName] then
        if mode == nil or (mode >= 0 and mode < 3) then
            tfm.get.room.playerList[playerName].shamanMode = mode or tfm.get.room.playerList[playerName].defaultShamanMode
        else
            tfm.get.room.playerList[playerName].shamanMode = tfm.get.room.playerList[playerName].defaultShamanMode
        end
        print(label('[Player: Shaman Mode]') .. '\tplayer: ' .. playerName .. ' | mode: ' .. shamanModes[tfm.get.room.playerList[playerName].shamanMode] .. '\t\t' .. func('(tfm.exec.setShamanMode)'))
    end
end

function tfm.exec.setVampirePlayer(playerName, makeAVampire)
    makeAVampire = makeAVampire == nil and true or makeAVampire
    typeAssert('setVampirePlayer', 'string', 1, playerName)
    typeAssert('setVampirePlayer', 'boolean', 2, makeAVampire)
    if tfm.get.room.playerList[playerName] then
        tfm.get.room.playerList[playerName].isVampire = makeAVampire
        print(label('[Player: Vampire]') .. '\tplayer: ' .. playerName .. ' | status: ' .. tostring(makeAVampire) .. '\t\t' .. func('(tfm.exec.setVampirePlayer)'))    
        eventPlayerVampire(playerName)
    end
end

function tfm.exec.snow(duration, snowBallPower)
    typeAssert('snow', {'number', 'nil'}, 1, duration)
    typeAssert('snow', {'number', 'nil'}, 2, snowBallPower)
    print(label('[Room: Snowing]') .. '\t\tduration: ' .. (duration or 60) .. 's | Snow Power: ' .. (snowBallPower or 10) .. '\t\t' .. func('(tfm.exec.snow)'))
end

return tfm
