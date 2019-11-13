local Player = require 'src.Player'
local Object = require 'src.Object'
local events = require 'src.events'
local tfm = require 'src.tfm'


print('\n===Testing tfm.exec methods==\n')

tfm.get.room.playerList['Seniru'] = Player.new('Seniru', {})

tfm.exec.snow()
tfm.exec.snow(10)
tfm.exec.setRoomPassword('pass')
tfm.exec.setRoomMaxPlayers(50)
tfm.exec.addConjuration(32,43)
tfm.exec.addPhysicObject(0, 50, 60, {type=3})
tfm.exec.chatMessage('Hello, this is my first time testing chat message')
tfm.exec.killPlayer('Seniru')