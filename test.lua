_ENV = require('Lunity.lunity')()
require 'src.escapes'
require 'src.events'

local tfm = require 'src.tfm'
local Object = require 'src.Object'
local Player = require 'src.Player'

function test:before()
    --insert players to the game
    local players = {
       souris0 = Player.new('souris0', {}),
       souris1 = Player.new('souris1', {}),
       souris2 = Player.new('souris2', {})
    }
    for name, player in next, players do
        tfm.get.room.playerList[name] = player
    end
end

function test:escapes()
    assertEqual(label('[LABEL]'), '\27[1m\27[93;40m[LABEL]\27[0m')
    assertEqual(func('(FUNC)'), '\27[3m\27[2m(FUNC)\27[0m')
end

function test:events()
    
end

function test:Player()

end

function test:Object()

end

function test:tfm()

end

test({
    quiet = true
})