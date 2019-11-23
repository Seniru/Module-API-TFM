_ENV = require('lunity')()
require 'src.escapes'
require 'src.events'

local tfm = require 'src.tfm'
local Object = require 'src.Object'
local Player = require 'src.Player'
local Conjuration = require 'src.Conjuration'

function test:before()
    --insert players to the game
    for name, player in next, {
       souris0 = Player.new('souris0', {}),
       souris1 = Player.new('souris1', {}),
       souris2 = Player.new('souris2', {})
    } do
        tfm.get.room.playerList[name] = player
    end
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
    assertType(Object.new(0, 0, 0, {type=0}), 'table') -- testing objects created with configuration
    assertErrors(Object.new, 0, 0, 0) -- should raise an error when created objects without configurations
    assertErrors(Object.new, 0, nil, 0, {})
    assertErrors(Object.new, 0, 0, nil, {})
    --general testing
    local obj = Object.new(1, 100, 100, {
        type=0,
        angle=90,
        baseType=2,
        width=100,
        ghost=true,
        x=20,
        y=20
    })
    assertEqual(obj.id, 1)
    assertEqual(obj.type, 0)
    assertEqual(obj.angle, 90)
    assertEqual(obj.baseType, 2)
    assertTableEquals(obj.colors, {})
    assertEqual(obj.ghost, true)
    assertEqual(obj.vx, 0)
    assertEqual(obj.vy, 0)
    assertEqual(obj.x, 100)
    assertEqual(obj.y, 100)
    assertEqual(obj.width, 100)
    assertEqual(obj.height, 0)
    assertType(obj.bodyDef, 'table')
end

function test:Conjuration()

    local c1 = Conjuration.new(100, 200, 1000)
    local c2 = Conjuration.new(200, 300)

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

function test:tfm()

    -- addConjuration
    assertTableEquals(tfm.exec.addConjuration(200, 200, 100), Conjuration.new(200, 200, 100))
    assertTableEquals(tfm.exec.addConjuration(200, 200), Conjuration.new(200, 200))

    assertErrors(tfm.exec.addImage) --addImage
    assertErrors(tfm.exec.addJoint) --addJoint

    --addPhysicObject
    local obj = tfm.exec.addPhysicObject(0, 100, 100, {type=0, width=100, height=100})
    assertTableEquals(obj, Object.new(0, 100, 100, {type=0, width=100, height=100}))
    assertTableEquals(tfm.get.room.objectList[0], obj)

    assertErrors(tfm.exec.addShamanObject) --addShamanObject

    --changePlayerSize
    assertErrors(tfm.exec.changePlayerSize, 0, 0)
    assertErrors(tfm.exec.changePlayerSize, 'seniru', 2)
    assertErrors(tfm.exec.changePlayerSize, 'seniru', 0)
    assertErrors(tfm.exec.changePlayerSize, 'seniru', 6)
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

    assertErrors(tfm.exec.disableAfkDeath)
    assertErrors(tfm.exec.disableAllShamanSkills)
    assertErrors(tfm.exec.disableAutoNewGame)
    assertErrors(tfm.exec.disableAutoScore)
    assertErrors(tfm.exec.disableAutoShaman)
    assertErrors(tfm.exec.disableAutoTimeLeft)
    assertErrors(tfm.exec.disableDebugCommand)
    assertErrors(tfm.exec.disableMinimalistMode)
    assertErrors(tfm.exec.disableMortCommand)
    assertErrors(tfm.exec.disablePhysicalConsumables)
    assertErrors(tfm.exec.disablePrespawnPreview)
    assertErrors(tfm.exec.disableWatchCommand)
    assertErrors(tfm.exec.displayParticle)
    assertErrors(tfm.exec.explosion)
    assertErrors(tfm.exec.giveCheese)
    assertErrors(tfm.exec.giveConsumables)
    
    --giveMeep
    assertErrors(tfm.exec.giveMeep, nil, true) -- Should throw errors for non-string playerNames
    assertErrors(tfm.exec.giveMeep, 'true') -- Should throw errors for non nil or boolean values
    tfm.exec.giveMeep('souris2', true)
    assertEqual(tfm.get.room.playerList['souris2'].canMeep, true)
    tfm.exec.giveMeep('souris0')
    assertEqual(tfm.get.room.playerList['souris0'].canMeep, true)
    tfm.exec.giveMeep('souris0', false)
    assertEqual(tfm.get.room.playerList['souris0'].canMeep, false)

    --giveTransformations
    assertErrors(tfm.exec.giveTransformations, nil, true) -- Should throw errors for non-string playerNames
    assertErrors(tfm.exec.giveTransformations, 'true') -- Should throw errors for non nil or boolean values
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
    assertErrors(tfm.exec.respawnPlayer)
    assertErrors(tfm.exec.setAutoMapFlipMode)
    assertErrors(tfm.exec.setGameTime)
    assertErrors(tfm.exec.setNameColor)
    assertErrors(tfm.exec.setPlayerScore)

    --setRoomMaxPlayers
    assertErrors(tfm.exec.setRoomMaxPlayers, 'five') -- Should throw an error for non number values
    tfm.exec.setRoomMaxPlayers(5)
    assertEqual(tfm.get.room.maxPlayers, 5)

    --setRoomPassword
    tfm.exec.setRoomPassword('p455w0rd') -- Should set a password when a string is specified
    assertEqual(tfm.get.room.passwordProtected, true)
    tfm.exec.setRoomPassword('') -- Should unset the password, when password is blank
    assertEqual(tfm.get.room.passwordProtected, false)

    assertErrors(tfm.exec.setShaman)
    assertErrors(tfm.exec.setShamanMode)

    --setVampirePlayer
    assertErrors(tfm.exec.setVampirePlayer, 100, true) -- Should throw error for non string characters for name
    assertErrors(tfm.exec.setVampirePlayer, 'souris0', 'make a vamp') -- Should throw error for non boolean values for makeAVamp
    tfm.exec.setVampirePlayer('souris1', true)
    assertEqual(tfm.get.room.playerList['souris1'].isVampire, true)
    tfm.exec.setVampirePlayer('souris1', false)
    assertEqual(tfm.get.room.playerList['souris1'].isVampire, false)
    tfm.exec.setVampirePlayer('souris1')
    assertEqual(tfm.get.room.playerList['souris1'].isVampire, true)

    --setSnow
    assertErrors(tfm.exec.snow, 'forever', 100) -- Should throw error for non nil or number values
    assertErrors(tfm.exec.snow, 2000, 'powerful') -- Should throw error for non nil or number values


end

function test:events()
    
end

test({
    quiet = true
})