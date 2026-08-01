local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("ProgressPoints")
local CheckpointsFolder = game.Workspace:WaitForChild("Checkpoints")

game.Players.PlayerAdded:Connect(function(player)
	local StageValue = Instance.new("StringValue")
	StageValue.Name = "Stage"
	StageValue.Parent = player
	
	local key = "Player_" .. player.UserId
	local success, data = pcall(function()
		return DataStore:GetAsync(key)
	end)
	
	if success and data then
		StageValue.Value = data
	else
		StageValue.Value = "Red 0"
	end
end)

for _, checkpointPart in CheckpointsFolder:GetChildren() do
	checkpointPart.Touched:Connect(function(hit)
		local Obbyplayer = game.Players:GetPlayerFromCharacter(hit.Parent)

		if Obbyplayer then
			local stage = Obbyplayer:FindFirstChild("Stage")

			if stage and stage.Value ~= checkpointPart.Name then
				stage.Value = checkpointPart.Name
				print(Obbyplayer.Name .. " reached " .. checkpointPart.Name)
			end
		end
	end)
end

game.Players.PlayerRemoving:Connect(function(player)
	local stage = player:FindFirstChild("Stage")
	if stage then
		local key = "Player_" .. player.UserId
		pcall(function()
			DataStore:SetAsync(key, stage.Value)
		end)
	end
end)

