local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Hazard = Workspace.World.Hazards:GetChildren()

-- Function that happens when player touches hazard
local function onHazardTouched(otherPart)
    local character = otherPart.Parent
    local player = Players:GetPlayerFromCharacter(character)
    if player then
        -- kill the player
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
    end
end

-- Setting up event listeners
for _, hazard in pairs(Hazard) do
    hazard.Touched:Connect(onHazardTouched)
end