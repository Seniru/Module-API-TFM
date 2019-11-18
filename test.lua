_ENV = require('lunity')()
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
    
end

function test:Object()
    
end

function test:tfm()
    
end

function test:events()
    
end

test({
    quiet = true
})