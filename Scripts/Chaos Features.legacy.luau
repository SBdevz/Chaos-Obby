
--Make the settings normal
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
	
for _, player in ipairs(game.Players:GetPlayers()) do
	local character = player.Character
	if character then
		normal(character)
	end
end
	
----------------------------------------------------------------------------------------------
--Types of Chaos
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

------------------------------------------------------------------------------------------------
--Pick and exectute a random chaos to execute every minute

while true do
	local functionList = {low_speed, high_speed, darkness}
	local randomGenerator = Random.new()
	local ChaosFunction = functionList[randomGenerator:NextInteger(1, #functionList)]
	task.wait(60)
	for _, player in ipairs(game.Players:GetPlayers()) do
		local character = player.Character
		if character then
			ChaosFunction(character)
		end
	end
	task.wait(60)
	for _, player in ipairs(game.Players:GetPlayers()) do
		local character = player.Character
		if character then
			normal(character)
		end
	end
end

