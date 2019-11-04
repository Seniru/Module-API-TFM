local Player = require 'Player'
local Object = require 'Object'

sen = Player.new('seniru', {gender='male', tribe='We talk a lot'})
oj = Player.new('overjoy', {tribe='wtal'})

print('\n===Testing Players===')

print(sen.playerName)
print(oj.gender)

print('\n===Testing Objects===')

obj1 = Object.new(1, 12, {ghost=true, colors={0xff0000}})
obj2 = Object.new(2, 32, {baseType=3})

print(obj1.colors[1])
print(obj2.id)
