local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("ProgressPoints")

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local checkpointsFolder = Workspace:WaitForChild("Checkpoints")
local lobbySpawn = Workspace:WaitForChild("Spawnpoints"):WaitForChild("LobbySpawn")

Players.PlayerAdded:Connect(function(player)
	player.RespawnLocation = lobbySpawn

	local stageValue = Instance.new("StringValue")
	stageValue.Name = "Stage"
	stageValue.Parent = player

	local key = "Player_" .. player.UserId
	local success, savedStageName = pcall(function()
		return DataStore:GetAsync(key)
	end)

	if success and savedStageName then
		stageValue.Value = savedStageName
	else
		stageValue.Value = "Red 0"
	end
end)

local function setupCheckpoint(spawnPoint)
	spawnPoint.Touched:Connect(function(otherPart)
		local character = otherPart:FindFirstAncestorOfClass("Model")
		if not character then return end

		local player = Players:GetPlayerFromCharacter(character)
		if not player then return end

		local stage = player:FindFirstChild("Stage")
		if stage and stage.Value ~= spawnPoint.Name then
			stage.Value = spawnPoint.Name

			local key = "Player_" .. player.UserId
			pcall(function()
				DataStore:SetAsync(key, spawnPoint.Name)
			end)
		end
	end)
end

for _, child in ipairs(checkpointsFolder:GetChildren()) do
	setupCheckpoint(child)
end

checkpointsFolder.ChildAdded:Connect(setupCheckpoint)