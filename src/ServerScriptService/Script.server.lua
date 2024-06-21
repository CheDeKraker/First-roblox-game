--test!!

-- Initializing services and variables
local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- Getting all the coins in the world
local coins = Workspace.World.Coins:GetChildren()

--Require the modules
local Leaderboard = require(ServerStorage.Leaderboard)
local PlayerData = require(ServerStorage.PlayerData)

local COOLDOWN = 10



--Update the player's coin value
local function updateCoinValue(player, value)
	local x = PlayerData.updateValue(player, PlayerData.COIN_KEY_NAME, function(oldValue)
		return oldValue + value
	end)
	
	Leaderboard.setStat(player, PlayerData.COIN_KEY_NAME, x)
end

-- Defining the event handler
local function onCoinTouched(otherPart, coin)
	if coin:GetAttribute("Enabled") then
		local character = otherPart.Parent
		local player = Players:GetPlayerFromCharacter(character)
		if player then
			-- Player touched a coin
			coin.Transparency = 1
			coin:SetAttribute("Enabled", false)
			print("Player collected coin")
			updateCoinValue(player, 1)
			task.wait(COOLDOWN)
			coin.Transparency = 0
			coin:SetAttribute("Enabled", true)
		end
	end
end

-- Setting up event listeners
for _, coin in coins do
	coin:SetAttribute("Enabled", true)
	coin.Touched:Connect(function(otherPart)
		onCoinTouched(otherPart, coin)
	end)
end