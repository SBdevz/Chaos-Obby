local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("ProgressPoints")

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local checkpointsFolder = Workspace:WaitForChild("Checkpoints")
local lobbySpawn = Workspace:WaitForChild("Spawnpoints"):WaitForChild("LobbySpawn")

local function findSpawnLocation(checkpointObject)
	if checkpointObject:IsA("SpawnLocation") then
		return checkpointObject
	elseif checkpointObject:IsA("Model") then
		return checkpointObject:FindFirstChildOfClass("SpawnLocation", true)
	end
	return nil
end

Players.PlayerAdded:Connect(function(player)
	if lobbySpawn:IsA("SpawnLocation") then
		player.RespawnLocation = lobbySpawn
	end

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

local function setupCheckpointTouch(part, checkpointObject)
	if part:IsA("BasePart") then
		part.Touched:Connect(function(otherPart)
			local character = otherPart:FindFirstAncestorOfClass("Model")
			if not character then return end

			local player = Players:GetPlayerFromCharacter(character)
			if not player then return end

			local spawnLoc = findSpawnLocation(checkpointObject)
			if spawnLoc then
				player.RespawnLocation = spawnLoc
			end

			local stage = player:FindFirstChild("Stage")
			if stage and stage.Value ~= checkpointObject.Name then
				stage.Value = checkpointObject.Name

				local key = "Player_" .. player.UserId
				pcall(function()
					DataStore:SetAsync(key, checkpointObject.Name)
				end)
			end
		end)
	end
end

local function setupCheckpoint(checkpointObject)
	if checkpointObject:IsA("BasePart") then
		setupCheckpointTouch(checkpointObject, checkpointObject)
	elseif checkpointObject:IsA("Model") then
		for _, part in ipairs(checkpointObject:GetDescendants()) do
			setupCheckpointTouch(part, checkpointObject)
		end
	end
end

for _, child in ipairs(checkpointsFolder:GetChildren()) do
	setupCheckpoint(child)
end

checkpointsFolder.ChildAdded:Connect(setupCheckpoint)