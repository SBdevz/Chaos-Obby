local Rotations = game.Workspace:WaitForChild('Rotation')
local Right = game.Workspace.Rotation:WaitForChild('Right')
local Left = game.Workspace.Rotation:WaitForChild('Left')
local CylRight = game.Workspace.Rotation:WaitForChild('CylRight')
local CylLeft = game.Workspace.Rotation:WaitForChild('CylLeft')
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
	for _, part in Right:GetChildren() do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.AssemblyAngularVelocity = Vector3.new(0, 1, 0)
			part.CFrame = part.CFrame * CFrame.Angles(0, math.rad(1), 0)
		end
	end
	for _, part in Left:GetChildren() do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.AssemblyAngularVelocity = Vector3.new(0, -1, 0)
			part.CFrame = part.CFrame * CFrame.Angles(0, math.rad(-1), 0)
		end
	end
	for _, part in CylRight:GetChildren() do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.AssemblyAngularVelocity = Vector3.new(1, 0, 0)
			part.CFrame = part.CFrame * CFrame.Angles(1, math.rad(0), 0)
		end
	end
	for _, part in CylLeft:GetChildren() do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.AssemblyAngularVelocity = Vector3.new(-1, 0, 0)
			part.CFrame = part.CFrame * CFrame.Angles(-1, math.rad(0), 0)
		end
	end
end)