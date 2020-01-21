function eventChatCommand(playerName, command) end
function eventChatMessage(playerName, message) end
function eventEmotePlayed(playerName, emoteType, emoteParam) end
function eventFileLoaded(fileNumber, fileData) end
function eventFileSaved(fileNumber) end
function eventKeyBoard(playerName, keyCode, down, xPlayerPosition, yPlayerPosition) end
function eventMouse(playerName, xMousePosition, yMousePosition) end
function eventLoop(elapsedTime, remainingTime) end
function eventNewGame() end
function eventNewPlayer(playerName) end
function eventPlayerDataLoaded(playerName, playerData) end
function eventPlayerDied(playerName) end
function eventPlayerGetCheese(playerName) end
function eventPlayerLeft(playerName) end
function eventPlayerVampire(playerName) end
function eventPlayerWon(playerName, timeElapsed,  timeElapsedSinceRespawn) end
function eventPlayerRespawn(playerName) end
function eventPlayerMeep(playerName, xPosition, yPosition) end
function eventPopupAnswer(popupId, playerName, answer) end
function eventSummoningStart(playerName, objectType, xPosition, yPosition, angle) end
function eventSummoningCancel(playerName) end
function eventSummoningEnd(playerName, objectType, xPosition, yPosition, angle) end
function eventTextAreaCallback(textAreaId, playerName, eventName) end
function eventColorPicked(colorPickerId, playerName, color) end

return
    eventChatCommand,
    eventChatMessage,
    eventEmotePlayed,
    eventFileLoaded,
    eventFileSaved,
    eventKeyBoard,
    eventMouse,
    eventLoop,
    eventNewGame,
    eventNewPlayer,
    eventPlayerDataLoaded,
    eventPlayerDied,
    eventPlayerGetCheese,
    eventPlayerLeft,
    eventPlayerVampire,
    eventPlayerWon,
    eventPlayerRespawn,
    eventPlayerMeep,
    eventPopupAnswer,
    eventSummoningStart,
    eventSummoningCancel,
    eventSummoningEnd,
    eventTextAreaCallback,
    eventColorPicked
