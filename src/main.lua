local Player = require 'Player'
local Object = require 'Object'
local events = require 'events'
local tfm = require 'tfm'

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

print('\n===Testing Enums===')

print(tfm.enum.emote.flag)
print(tfm.enum.ground.sand)
print(tfm.enum.particle.spirit)
print(tfm.enum.shamanObject.box)

print('\n===Testing tfm.exec methods==\n')

tfm.exec.snow()
tfm.exec.snow(10)
tfm.exec.setRoomPassword('pass')
print(tfm.get.room.passwordProtected)
