local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("ProgressPoints")

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local teleportsFolder = Workspace:WaitForChild("Teleports")
local lobbyFolder = teleportsFolder:WaitForChild("Lobby")
local checkpointsFolder = Workspace:WaitForChild("Checkpoints")

local debounce = {}

local function teleportPlayerToSavedCheckpoint(player)
	local character = player.Character
	if not character then return end

	local key = "Player_" .. player.UserId
	local success, savedSpawnName = pcall(function()
		return DataStore:GetAsync(key)
	end)

	local targetCheckpointName = "Red 0"

	if success and savedSpawnName then
		targetCheckpointName = savedSpawnName
	end

	local targetPart = checkpointsFolder:FindFirstChild(targetCheckpointName)

	if not targetPart then
		targetPart = checkpointsFolder:FindFirstChild("Red 0")
	end

	if targetPart then
		local targetCFrame = targetPart:IsA("Model") and targetPart:GetPivot() or targetPart.CFrame
		character:PivotTo(targetCFrame + Vector3.new(0, 3, 0))
		player:SetAttribute("LevelRed", true)
	else
		warn("Could not find checkpoint target part: " .. tostring(targetCheckpointName))
	end
end

local function setupTeleportPart(part)
	if part:IsA("BasePart") then
		part.Touched:Connect(function(otherPart)
			local character = otherPart:FindFirstAncestorOfClass("Model")
			if not character then return end

			local player = Players:GetPlayerFromCharacter(character)
			if player and not debounce[player] then
				debounce[player] = true

				teleportPlayerToSavedCheckpoint(player)

				task.wait(1)
				debounce[player] = nil
			end
		end)
	end
end

for _, part in ipairs(lobbyFolder:GetDescendants()) do
	setupTeleportPart(part)
end

lobbyFolder.DescendantAdded:Connect(setupTeleportPart)