_ENV = require('lunity')()
require 'extra.escapes'
require 'src.events'

local tfm = require 'src.tfm'
local Object = require 'src.Object'
local PhysicObject = require 'src.PhysicObject'
local Player = require 'src.Player'
local Conjuration = require 'src.Conjuration'
local Joint = require 'src.Joint'

function test:before()
    --insert players to the game
    for name, player in next, {
        souris0 = Player.new('souris0', {}),
       souris1 = Player.new('souris1', {}),
       souris2 = Player.new('souris2', {})
    } do
        tfm.get.room.playerList[name] = player
    end

    tfm.exec.addPhysicObject(100, 200, 400, {type=3, width=100, height=200})
    tfm.exec.addPhysicObject(200, 300, 500, {type=5, width=300, height=600, dynamic=true})

end

function test:escapes()
    -- Testing label highlights
    assertEqual(label('[LABEL]'), '\27[1m\27[93;40m[LABEL]\27[0m')
    -- Testing function highlights
    assertEqual(func('(FUNC)'), '\27[3m\27[2m(FUNC)\27[0m')
    -- Testing other types of colorized outputs
    assertEqual(col('COLORS', 100, 100, 100), '\27[38;2;100;100;100mCOLORS\27[0m') -- Should color forground correctly when fg is not specified (nil)
    assertEqual(col('COLORS', 100, 0, 0, true), '\27[38;2;100;0;0mCOLORS\27[0m') -- Should color forground correctly when fg is true
    assertEqual(col('COLORS', 100, 100, 10, false), '\27[48;2;100;100;10mCOLORS\27[0m') -- Should color background correctly when fg is false
    assertEqual(col(col('COLORS', 0, 0, 0), 255, 255, 255, false), '\27[48;2;255;255;255m\27[38;2;0;0;0mCOLORS\27[0m\27[0m') -- Should color both background and forground correctly when they are nested and specified true and false for fg
end

function test:Player()
    assertType(Player.new('King_seniru#5890', {}), 'table') -- Should be able to create an return a new Player table
    assertType(Player.new('King_seniru#5890'), 'table') --Should be able to create an return a new Player table without config
    -- Testing players without configurations
    local p = Player.new('souris')
    assertEqual(p.playerName, 'souris')
    assertEqual(p.community, 'en')
    assertEqual(p.gender, 0)
    assertEqual(p.hasCheese, false)
    assertEqual(p.id, 0)
    assertEqual(p.inHardMode, 0)
    assertEqual(p.isDead, false)
    assertEqual(p.isFacingRight, true)
    assertEqual(p.isInvoking, false)
    assertEqual(p.isJumping, false)
    assertEqual(p.isShaman, false)
    assertEqual(p.isVampire, false)
    assertEqual(p.look, 'NOT IMPLEMENTED')
    assertEqual(p.movingLeft, false)
    assertEqual(p.movingRight, false)
    assertEqual(p.registrationData, 0)
    assertEqual(p.score, 0)
    assertEqual(p.shamanMode, 0)
    assertEqual(p.spouseId, 1)
    assertEqual(p.spouseName, nil)
    assertEqual(p.title, 'Little Mouse')
    assertEqual(p.tribeId, 0)
    assertEqual(p.tribeName, '')
    assertEqual(p.vx, 0)
    assertEqual(p.vy, 0)
    assertEqual(p.x, 0)
    assertEqual(p.y, 0)
    --Testing players with configurations (configurations are only tested this time)
    local p2 = Player.new('souris10', {
        community='br',
        hasCheese=true,
        id=100,
        inHardMode=true,
        isDead=true,
        isFacingRight=true,
        isInvoking=false,
        isShaman=true,
        movingLeft=true,
        movingRight=false,
        registrationData=20191010,
        shamanMode='hard',
        spouseId=900,
        spouseName='tig',
        title='noob',
        tribeId=900,
        tribeName='We talk a lot',
        vx=100,
        vy=100,
        x=100,
        y=100}
    )
    assertEqual(p2.community, 'br')
    assertEqual(p2.hasCheese, true)
    assertEqual(p2.id, 100)
    assertEqual(p2.inHardMode, true)
    assertEqual(p2.isDead, true)
    assertEqual(p2.isFacingRight, true)
    assertEqual(p2.isInvoking, false)
    assertEqual(p2.isShaman, true)
    assertEqual(p2.movingLeft, true)
    assertEqual(p2.movingRight, false)
    assertEqual(p2.registrationData, 20191010)
    assertEqual(p2.shamanMode, 'hard')
    assertEqual(p2.spouseId, 900)
    assertEqual(p2.spouseName, 'tig')
    assertEqual(p2.title, 'noob')
    assertEqual(p2.tribeId, 900)
    assertEqual(p2.tribeName, 'We talk a lot')
    assertEqual(p2.vx, 100)
    assertEqual(p2.vy, 100)
    assertEqual(p2.x, 100)
    assertEqual(p2.y, 100)
end

function test:Object()
    assertType(Object(0, 0, 0, 0, 0, 0, false), 'table') -- testing objects created with configuration
    -- general testing
    local obj1 = Object(1, 20, 40, 45, 2, 4, true, {0xFF0000, 0X000000})
    local obj2 = Object(5, 30, 50, 90, 1, 2, false)
    
    assertEqual(obj1.angle, 45)
    assertEqual(obj1.baseType, 1)
    assertTableEquals(obj1.colors, {0xFF0000, 0x000000})
    assertTableEquals(obj2.colors, {})
    assertEqual(obj1.ghost, true)
    assertEqual(obj1.id, 2)
    assertEqual(obj2.id, 3)
    assertEqual(obj1.type, 1)
    assertEqual(obj1.vx, 2)
    assertEqual(obj1.vy, 4)
    assertEqual(obj1.x, 20)
    assertEqual(obj1.y, 40)
    
end

function test:PhysicObject()
    assertType(PhysicObject(1, 20, 20, {type=1}), 'table') -- Should create a PhysicObject successfully
    assertErrors(PhysicObject, 2, 20, 20, {}) -- Should throw an error when called without the type
    
    --general testing
    local obj1 = PhysicObject(3, 10, 20, {type=1, width=10, foreground=true, groundCollision=false})
    local obj2 = PhysicObject(4, 30, 40, {type=2, width=100, miceCollision=false, dynamic=true, fixedRotation=true, mass=5})
    assertEqual(obj1.id, 3)
    assertEqual(obj1.xPosition, 10)
    assertEqual(obj2.yPosition, 40)
    assertEqual(obj1.foreground, true)
    assertEqual(obj2.foreground, false)
    assertEqual(obj1.groundCollision, false)
    assertEqual(obj1.miceCollision, true)
    assertEqual(obj2.dynamic, true)

end

function test:Conjuration()
    
    local c1 = Conjuration(100, 200, 1000)
    local c2 = Conjuration(200, 300)
    
    assertType(c1, 'table') -- Should create a Conjuration table when called new method
    assertType(c2, 'table') -- Should create a Conjuration table with default duration when duration is nil
    -- Should return correct
    assertEqual(c1.xPosition, 100)
    assertEqual(c1.yPosition, 200)
    assertEqual(c2.xPosition, 200)
    assertEqual(c2.yPosition, 300)
    -- Should return the correct duration
    assertEqual(c1.duration, 1000)
    assertEqual(c2.duration, 10000)
end

function test:Joint()

    assertErrors(Joint) -- Should throw errors when called without args
    assertErrors(Joint, 1, 1, 1) -- Should throw errors when type is not provided

    local j1 = Joint(1, 100, 100, {type=0, point1="10,20", point2="30,40", point3="50,60", axis="90,90"})
    local j2 = Joint(2, 200, 200, {type=1, axis="100,200", line=3})

    assertType(j1, "table")

    assertEqual(j1.typeWord, "distance")
    assertEqual(j1.x1, 10)
    assertEqual(j1.y1, 20)
    assertEqual(j1.x2, 30)
    assertEqual(j1.y2, 40)
    assertEqual(j1.point3, nil)
    assertEqual(j1.axis, nil)
    assertEqual(j2.axisX, 100)
    assertEqual(j2.axisY, 200)
    assertEqual(j1.visible, false)
    assertEqual(j2.visible, true)

end

function test:tfm()
    
    -- addConjuration
    assertTableEquals(tfm.exec.addConjuration(200, 200, 100), Conjuration(200, 200, 100))
    assertTableEquals(tfm.exec.addConjuration(200, 200), Conjuration(200, 200))
    
    assertErrors(tfm.exec.addImage) --addImage
    
    -- addJoint
    local joint = Joint(1, 100, 100, {type=0, point1="10,20", point2="30,40", point3="50,60", axis="90,90"})
    local tfmjoint = tfm.exec.addJoint(1, 100, 100, {type=0, point1="10,20", point2="30,40", point3="50,60", axis="90,90"})
    local joint2 = tfm.exec.addJoint(2, 200, 200, {type=0})

    assertTableEquals(joint, tfm.get.data.joints[1])
    assertTableEquals(joint, tfmjoint)
    assertEqual(joint2.x1, 450)
    assertEqual(joint2.y1, 800)
    
    --addPhysicObject
    assertErrors(tfm.exec.addPhysicObject) -- Should throw an error when called without args
    --general testing
    tfm.exec.addPhysicObject(100, 200, 400, {type=3, width=100, height=200})
    tfm.exec.addPhysicObject(200, 300, 500, {type=5, width=300, height=600, dynamic=true})
    local obj1 = tfm.get.data.physicObjects[100]
    local obj2 = tfm.get.data.physicObjects[200]
    assertType(obj1, 'table')
    assertNotEqual(obj1.id, obj2.id)
    assertEqual(obj1.width, 100)
    assertEqual(obj2.height, 600)


    --addShamanObject
    assertErrors(tfm.exec.addShamanObject) -- Should throw an error when called without args
    
    local obj1 = tfm.exec.addShamanObject(1, 2, 4, 45, 50, 60, true)
    local obj2 = tfm.exec.addShamanObject(2, 4, 5, 100, 200, 90, true)
    
    assertType(obj1, 'number')
    assertNotEqual(obj1, obj2)
    assertType(tfm.get.room.objectList[obj1], 'table')
    
    local objP1 = tfm.get.room.objectList[obj1]
    local objP2 = tfm.get.room.objectList[obj2]
    
    assertEqual(objP1.angle, 45)
    assertEqual(objP2.baseType, 2)
    assertTableEquals(objP1.colors, {})
    assertEqual(objP2.ghost,  true)
    assertEqual(objP1.id, obj1)
    assertEqual(objP2.id, obj2)
    assertEqual(objP1.type, 1)
    assertEqual(objP2.vx, 200)
    assertEqual(objP1.vy, 60)
    --assertEqual(objP2.x, 2)
    assertEqual(objP1.y, 4)

    --changePlayerSize
    assertErrors(tfm.exec.changePlayerSize, 0, 0)
    assertErrors(tfm.exec.changePlayerSize, 'seniru', 'five')
    tfm.exec.changePlayerSize('souris0', 3) -- changing size to 3
    assertEqual(tfm.get.room.playerList['souris0'].size, 3)
    tfm.exec.changePlayerSize('souris0', 1) -- changing size to default (1)
    assertEqual(tfm.get.room.playerList['souris0'].size, 1)

    --chatMessage
    assertErrors(tfm.exec.chatMessage, 1, 'souris1') -- Sending malformed messages
    assertErrors(tfm.exec.chatMessage, 'Hello world', 3) -- Sending to bad recipients 
    tfm.exec.chatMessage('Testing', 'souris1') -- Sending message only to souris1
    assertTableEquals(tfm.get.data[#tfm.get.data], {'Testing', 'souris1'})
    tfm.exec.chatMessage('Testing ..') -- Sending message to everybody
    assertTableEquals(tfm.get.data[#tfm.get.data], {'Testing ..', 'All'})

    --disableAfkDeath
    tfm.exec.disableAfkDeath()
    assertEqual(tfm.get.room.enabledAfkDeath, false)
    tfm.exec.disableAfkDeath(false)
    assertEqual(tfm.get.room.enabledAfkDeath, true)
    tfm.exec.disableAfkDeath(true)
    assertEqual(tfm.get.room.enabledAfkDeath, false)
    
    --disableAllShamanSkills
    tfm.exec.disableAllShamanSkills()
    assertEqual(tfm.get.room.enabledAllShamanSkills, false)
    tfm.exec.disableAllShamanSkills(false)
    assertEqual(tfm.get.room.enabledAllShamanSkills, true)
    tfm.exec.disableAllShamanSkills(true)
    assertEqual(tfm.get.room.enabledAllShamanSkills, false)

    --disableAutoNewGame
    tfm.exec.disableAutoNewGame()
    assertEqual(tfm.get.room.enabledAutoNewGame, false)
    tfm.exec.disableAutoNewGame(false)
    assertEqual(tfm.get.room.enabledAutoNewGame, true)
    tfm.exec.disableAutoNewGame(true)
    assertEqual(tfm.get.room.enabledAutoNewGame, false)

    --disableAutoScore
    tfm.exec.disableAutoScore()
    assertEqual(tfm.get.room.enabledAutoScore, false)
    tfm.exec.disableAutoScore(false)
    assertEqual(tfm.get.room.enabledAutoScore, true)
    tfm.exec.disableAutoScore(true)
    assertEqual(tfm.get.room.enabledAutoScore, false)
    
    --disableAutoShaman
    tfm.exec.disableAutoShaman()
    assertEqual(tfm.get.room.enabledAutoShaman, false)
    tfm.exec.disableAutoShaman(false)
    assertEqual(tfm.get.room.enabledAutoShaman, true)
    tfm.exec.disableAutoShaman(true)
    assertEqual(tfm.get.room.enabledAutoShaman, false)

    assertErrors(tfm.exec.disableAutoTimeLeft)

    --disableDebugCommand
    tfm.exec.disableDebugCommand()
    assertEqual(tfm.get.room.enabledDebugCommand, false)
    tfm.exec.disableDebugCommand(false)
    assertEqual(tfm.get.room.enabledDebugCommand, true)
    tfm.exec.disableDebugCommand(true)
    assertEqual(tfm.get.room.enabledDebugCommand, false)

    --disableMinimalistMode
    tfm.exec.disableMinimalistMode()
    assertEqual(tfm.get.room.allowedMinimalistMode, false)
    tfm.exec.disableMinimalistMode(false)
    assertEqual(tfm.get.room.allowedMinimalistMode, true)
    tfm.exec.disableMinimalistMode(true)
    assertEqual(tfm.get.room.allowedMinimalistMode, false)

    --disableMortCommand
    tfm.exec.disableMortCommand()
    assertEqual(tfm.get.room.allowedMortCommand, false)
    tfm.exec.disableMortCommand(false)
    assertEqual(tfm.get.room.allowedMortCommand, true)
    tfm.exec.disableMortCommand(true)
    assertEqual(tfm.get.room.allowedMortCommand, false)

    --disablePhysicalConsumables
    tfm.exec.disablePhysicalConsumables()
    assertEqual(tfm.get.room.enabledPhysicalConsumables, false)
    tfm.exec.disablePhysicalConsumables(false)
    assertEqual(tfm.get.room.enabledPhysicalConsumables, true)
    tfm.exec.disablePhysicalConsumables(true)
    assertEqual(tfm.get.room.enabledPhysicalConsumables, false)

    --disablePrespawnPreview
    tfm.exec.disablePrespawnPreview()
    assertEqual(tfm.get.room.enabledPrespawnPreview, false)
    tfm.exec.disablePrespawnPreview(false)
    assertEqual(tfm.get.room.enabledPrespawnPreview, true)
    tfm.exec.disablePrespawnPreview(true)
    assertEqual(tfm.get.room.enabledPrespawnPreview, false)

    --disableWatchCommand
    tfm.exec.disableWatchCommand()
    assertEqual(tfm.get.room.allowedWatchCommand, false)
    tfm.exec.disableWatchCommand(false)
    assertEqual(tfm.get.room.allowedWatchCommand, true)
    tfm.exec.disableWatchCommand(true)
    assertEqual(tfm.get.room.allowedWatchCommand, false)

    assertErrors(tfm.exec.displayParticle)

    --explosion
    assertErrors(tfm.exec.explosion) -- Should throw errors when called without args
    local e1 = tfm.exec.explosion(10, 10, 30, 10)
    local e2 = tfm.exec.explosion(20, 20, 40, 20, false)
    local e3 = tfm.exec.explosion(30, 30, 30, 30, true)

    assertTableEquals(tfm.get.data.explosions[1], {10, 10, 30, 10, false})
    assertTableEquals(tfm.get.data.explosions[2], {20, 20, 40, 20, false})
    assertTableEquals(tfm.get.data.explosions[3], {30, 30, 30, 30, true})

    --giveCheese
    assertErrors(tfm.exec.giveCheese) -- Should throw errors when called without args
    tfm.get.room.playerList['souris1'].hasCheese = false
    tfm.exec.giveCheese('souris1')
    assertEqual(tfm.get.room.playerList['souris1'].hasCheese, true)

    assertErrors(tfm.exec.giveConsumables)
    
    --giveMeep
    assertErrors(tfm.exec.giveMeep, nil, true) -- Should throw errors for non-string playerNames
    assertErrors(tfm.exec.giveMeep, 'souris3', 'true') -- Should throw errors for non nil or boolean values
    tfm.exec.giveMeep('souris2', true)
    assertEqual(tfm.get.room.playerList['souris2'].canMeep, true)
    tfm.exec.giveMeep('souris0')
    assertEqual(tfm.get.room.playerList['souris0'].canMeep, true)
    tfm.exec.giveMeep('souris0', false)
    assertEqual(tfm.get.room.playerList['souris0'].canMeep, false)

    --giveTransformations
    assertErrors(tfm.exec.giveTransformations, nil, true) -- Should throw errors for non-string playerNames
    assertErrors(tfm.exec.giveTransformations, 'souris3', 'true') -- Should throw errors for non nil or boolean values
    tfm.exec.giveTransformations('souris2', true)
    assertEqual(tfm.get.room.playerList['souris2'].canTransform, true)
    tfm.exec.giveTransformations('souris0')
    assertEqual(tfm.get.room.playerList['souris0'].canTransform, true)
    tfm.exec.giveTransformations('souris0', false)
    assertEqual(tfm.get.room.playerList['souris0'].canTransform, false)

    --killPlayer
    assertErrors(tfm.exec.killPlayer) -- Should throw an error for non-string names
    tfm.exec.killPlayer('souris1') -- Should kill a player
    assertEqual(tfm.get.room.playerList['souris1'].isDead, true)
    assertDoesNotError(tfm.exec.killPlayer, 'tig') -- Shouldn't throw errors for non-existing players
    
    assertErrors(tfm.exec.linkMice)
    assertErrors(tfm.exec.lowerSyncDelay)
    assertErrors(tfm.exec.moveObject)
    assertErrors(tfm.exec.movePlayer)
    assertErrors(tfm.exec.newGame)
    assertErrors(tfm.exec.playEmote)

    --playerVictory
    assertErrors(tfm.exec.playerVictory, nil) -- Should throw errors for non-string names
    tfm.get.room.enabledAutoScore = true
    -- Should win if player has cheese
    tfm.get.room.playerList['souris1'].hasCheese = true
    tfm.exec.playerVictory('souris1')
    assertEqual(tfm.get.room.playerList['souris1'].hasCheese, false)
    assertEqual(tfm.get.room.playerList['souris1'].score, 10)
    -- Should not win if player doesn't has cheese
    tfm.get.room.playerList['souris1'].hasCheese = false
    tfm.exec.playerVictory('souris1')
    assertEqual(tfm.get.room.playerList['souris1'].hasCheese, false)
    assertEqual(tfm.get.room.playerList['souris1'].score, 10)
    -- Should not add marks if auto score is disabled
    tfm.get.room.enabledAutoScore = false
    tfm.get.room.playerList['souris0'].hasCheese = true
    tfm.exec.playerVictory('souris0')
    assertEqual(tfm.get.room.playerList['souris0'].score, 0)

    --removeCheese
    assertErrors(tfm.exec.removeCheese, nil) -- Should throw errors for non-string names
    tfm.get.room.playerList['souris2'].hasCheese = true
    tfm.exec.removeCheese('souris2')
    assertEqual(tfm.get.room.playerList['souris2'].hasCheese, false)

    assertErrors(tfm.exec.removeImage)
    assertErrors(tfm.exec.removeJoint)
    assertErrors(tfm.exec.removeObject)
    assertErrors(tfm.exec.removePhysicalObject)

    --respawnPlayer
    assertErrors(tfm.exec.respawnPlayer) -- Should throw errors for non-string names
    tfm.get.room.playerList['souris2'].isDead = true
    tfm.exec.respawnPlayer('souris2')
    assertEqual(tfm.get.room.playerList['souris2'].isDead, false)
    assertEqual(tfm.get.room.playerList['souris2'].x, 0)
    assertEqual(tfm.get.room.playerList['souris2'].y, 0)

    --setAutoMapFlipMode
    assertErrors(tfm.exec.setAutoMapFlipMode, 1) -- Should throw errors for non boolean and non-nil values
    for _, mode in next, {true, false, nil} do
        tfm.exec.setAutoMapFlipMode(mode)
        assertEqual(tfm.get.room.enabledMapFlipMode, mode)
    end

    assertErrors(tfm.exec.setGameTime)

    --setNameColor
    assertErrors(tfm.exec.setNameColor) -- Should throw an error when called without args
    tfm.exec.setNameColor('souris1', 0xff0000)
    assertEqual(tfm.get.room.playerList['souris1'].nameColor, 0xff0000)
    
    assertErrors(tfm.exec.setPlayerScore) -- Should throw an error when called without args
    tfm.exec.setPlayerScore('souris1', 100)
    assertEqual(tfm.get.room.playerList['souris1'].score, 100)
    tfm.exec.setPlayerScore('souris1', 200, false)
    assertEqual(tfm.get.room.playerList['souris1'].score, 200)
    tfm.exec.setPlayerScore('souris1', 50, true)
    assertEqual(tfm.get.room.playerList['souris1'].score, 250)

    --setRoomMaxPlayers
    assertErrors(tfm.exec.setRoomMaxPlayers, 'five') -- Should throw an error for non number values
    tfm.exec.setRoomMaxPlayers(5)
    assertEqual(tfm.get.room.maxPlayers, 5)

    --setRoomPassword
    tfm.exec.setRoomPassword('p455w0rd') -- Should set a password when a string is specified
    assertEqual(tfm.get.room.passwordProtected, true)
    tfm.exec.setRoomPassword('') -- Should unset the password, when password is blank
    assertEqual(tfm.get.room.passwordProtected, false)

    --setShaman
    assertErrors(tfm.exec.setShaman) -- Should throw errors when called with a non-string name
    --setting all players to non-shamans
    for name, _ in next, tfm.get.room.playerList do
        tfm.get.room.playerList[name].isShaman = false
    end

    tfm.exec.setShaman('souris0')
    tfm.exec.setShaman('souris1', true)
    tfm.exec.setShaman('souris2', false)

    assertEqual(tfm.get.room.playerList['souris0'].isShaman, true)
    assertEqual(tfm.get.room.playerList['souris1'].isShaman, true)
    assertEqual(tfm.get.room.playerList['souris2'].isShaman, false)

    --setShamanMode
    assertErrors(tfm.exec.setShamanMode, nil) -- Should throw error for non string names
    assertErrors(tfm.exec.setShamanMode, 'souris1', 'divine') -- Should throw error for non integer or non-nil values
    tfm.exec.setShamanMode('souris1', 2)
    assertEqual(tfm.get.room.playerList['souris1'].shamanMode, 2)
    tfm.exec.setShamanMode('souris1', -1)
    assertEqual(tfm.get.room.playerList['souris1'].shamanMode, 0) -- Should set to default
    tfm.exec.setShamanMode('souris0', 1)
    assertEqual(tfm.get.room.playerList['souris0'].shamanMode, 1)
    tfm.exec.setShamanMode('souris0')
    assertEqual(tfm.get.room.playerList['souris0'].shamanMode, 0) -- Should set to default
    
    --setVampirePlayer
    assertErrors(tfm.exec.setVampirePlayer, 100, true) -- Should throw error for non string characters for name
    assertErrors(tfm.exec.setVampirePlayer, 'souris0', 'make a vamp') -- Should throw error for non boolean values for makeAVamp
    tfm.exec.setVampirePlayer('souris1', true)
    assertEqual(tfm.get.room.playerList['souris1'].isVampire, true)
    tfm.exec.setVampirePlayer('souris1', false)
    assertEqual(tfm.get.room.playerList['souris1'].isVampire, false)
    tfm.exec.setVampirePlayer('souris1')
    assertEqual(tfm.get.room.playerList['souris1'].isVampire, true)

    --snow
    assertErrors(tfm.exec.snow, 'forever', 100) -- Should throw error for non nil or number values
    assertErrors(tfm.exec.snow, 2000, 'powerful') -- Should throw error for non nil or number values

    
end

function test:events()
    
end

test({
    quiet = true
})
