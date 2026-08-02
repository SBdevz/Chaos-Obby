local folder = script.Parent

local function setupPlatform(platform)
	-- Make sure the item added is a physical part
	if not platform:IsA("BasePart") then return end

	platform.Anchored = true
	local isTouched = false

	local function fade(hit)
		local character = hit.Parent
		local humanoid = character:FindFirstChild("Humanoid")

		if humanoid and not isTouched then
			isTouched = true

			-- 1. Smoothly fade out the platform
			for count = 1, 10 do
				platform.Transparency = count / 10
				task.wait(0.05)
			end

			-- 2. Turn off collisions and make it invisible
			platform.CanCollide = false
			platform.Transparency = 1

			-- 3. Wait for 3 seconds while hidden
			task.wait(3)

			-- 4. Reset the platform
			platform.CanCollide = true
			platform.Transparency = 0

			isTouched = false
		end
	end

	platform.Touched:Connect(fade)
end

-- 1. Set up any parts already inside the folder when the game starts
for _, child in ipairs(folder:GetChildren()) do
	task.spawn(function()
		setupPlatform(child)
	end)
end

-- 2. Automatically set up any new parts you drag into the folder later
folder.ChildAdded:Connect(function(child)
	task.spawn(function()
		-- Tiny yield to make sure the part finishes loading into the workspace
		task.wait(0.1)
		setupPlatform(child)
	end)
end)