local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local checkpointsFolder = Workspace:WaitForChild("Checkpoints")

Players.PlayerAdded:Connect(function(player)
	player.RespawnLocation = game.Workspace.Structures:WaitForChild("Red Spawn")
end)

local function setupCheckpoint(spawnPoint)
	if spawnPoint:IsA("SpawnLocation") then
		spawnPoint.Touched:Connect(function(otherPart)
			local character = otherPart:FindFirstAncestorOfClass("Model")

			if character then
				local player = Players:GetPlayerFromCharacter(character)

				if player then
					player.RespawnLocation = spawnPoint
				end
			end
		end)
	end
end

for _, child in ipairs(checkpointsFolder:GetChildren()) do
	setupCheckpoint(child)
end

checkpointsFolder.ChildAdded:Connect(setupCheckpoint)