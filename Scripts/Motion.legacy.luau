local RunService = game:GetService("RunService")

local Rotations = game.Workspace:WaitForChild('Rotation')
local Right = game.Workspace.Rotation:WaitForChild('Right')
local Left = game.Workspace.Rotation:WaitForChild('Left')
local CylRight = game.Workspace.Rotation:WaitForChild('CylRight')
local CylLeft = game.Workspace.Rotation:WaitForChild('CylLeft')
local RotationSpeed = math.rad(60)

RunService.Heartbeat:Connect(function(dt)
	local AngleChange = RotationSpeed * dt
	for _, part in Right:GetChildren() do
		if part:IsA("BasePart") then
			part.AssemblyAngularVelocity = Vector3.new(0, RotationSpeed, 0)
			part.CFrame = part.CFrame * CFrame.Angles(0, AngleChange, 0)
		end
	end
	for _, part in Left:GetChildren() do
		if part:IsA("BasePart") then
			part.AssemblyAngularVelocity = Vector3.new(0, -RotationSpeed, 0)
			part.CFrame = part.CFrame * CFrame.Angles(0, -AngleChange, 0)
		end
	end
	for _, part in CylRight:GetChildren() do
		if part:IsA("BasePart") then
			part.AssemblyAngularVelocity = part.CFrame:VectorToWorldSpace(Vector3.new(RotationSpeed/2, 0, 0))
			part.CFrame = part.CFrame * CFrame.Angles(AngleChange, 0, 0)
		end
	end
	for _, part in CylLeft:GetChildren() do
		if part:IsA("BasePart") then
		part.AssemblyAngularVelocity = part.CFrame:VectorToWorldSpace(Vector3.new(-RotationSpeed/2, 0, 0))
			part.CFrame = part.CFrame * CFrame.Angles(-AngleChange, 0, 0)
		end
	end
end)