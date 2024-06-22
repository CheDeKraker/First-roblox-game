local PlayerData = {}
PlayerData.COIN_KEY_NAME = "Coins"
PlayerData.JUMP_KEY_NAME = "Jump Power"

local playerData = {}

local DEFAULT_PLAYER_DATA = {
  [PlayerData.COIN_KEY_NAME] = 0,
  [PlayerData.JUMP_KEY_NAME] = 0
}

local function getData(player)
  local data = playerData[tostring(player.UserId)] or DEFAULT_PLAYER_DATA
  playerData[tostring(player.UserId)] = data
  return data
end

function PlayerData.getValue(player, key)
  return getData(player)[key]
end

function PlayerData.updateValue(player, key, updateFunction)
  local data = getData(player)
  local oldValue = data[key]
  local newValue = updateFunction(oldValue)

  data[key] = newValue
  return newValue
end

return PlayerData