local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function normal(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 16
	end
	game:GetService("Lighting").FogStart = 100
	game:GetService("Lighting").FogEnd = 500
	game:GetService("Lighting").FogColor = Color3.fromRGB(200, 200, 200)  
	print("normal")
end

local function low_speed(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 8
		print("low_speed")
	end
end

local function high_speed(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = 64
		print("high_speed")
	end
end

local function darkness(character)
	game:GetService("Lighting").FogStart = 0
	game:GetService("Lighting").FogEnd = 20
	game:GetService("Lighting").FogColor = Color3.fromRGB(50, 50, 50)
	print("darkness")
end

local chaosNames = {
	[low_speed] = "Low Speed",
	[high_speed] = "High Speed",
	[darkness] = "Darkness"
}

local currentChaos = normal

local function applyChaos(player, character)
	if not character then return end
	if player:GetAttribute("LevelRed") == true then
		currentChaos(character)
	else
		normal(character)
	end
end

local function newPlayer(player)
	player.CharacterAdded:Connect(function(character)
		task.wait(0.1)
		applyChaos(player, character)
	end)

	player:GetAttributeChangedSignal("LevelRed"):Connect(function()
		if player.Character then
			applyChaos(player, player.Character)
		end
	end)

	if player.Character then
		applyChaos(player, player.Character)
	end
end

local function timer(seconds, status)
	ReplicatedStorage:SetAttribute("ChaosText", status)
	for i = seconds, 1, -1 do
		ReplicatedStorage:SetAttribute("TimeLeft", i)
		task.wait(1)
	end
end

game.Players.PlayerAdded:Connect(newPlayer)

for _, player in ipairs(game.Players:GetPlayers()) do
	newPlayer(player)
end

while true do
	local functionList = {low_speed, high_speed, darkness}
	local randomGenerator = Random.new()
	local ChaosFunction = functionList[randomGenerator:NextInteger(1, #functionList)]

	timer(240, "Next Chaos Event In:")

	currentChaos = ChaosFunction
	for _, player in ipairs(game.Players:GetPlayers()) do
		local character = player.Character
		if character then
			applyChaos(player, character)
		end
	end

	local eventName = chaosNames[ChaosFunction] or "Chaos Event"
	timer(60, eventName .. " Event Ends In:")

	currentChaos = normal
	for _, player in ipairs(game.Players:GetPlayers()) do
		local character = player.Character
		if character then
			applyChaos(player, character)
		end
	end
end



