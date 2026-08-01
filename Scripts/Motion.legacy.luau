local RunService = game:GetService("RunService")

local Rotations = game.Workspace:WaitForChild('Rotation')

local Right = Rotations:WaitForChild('Right')
local Left = Rotations:WaitForChild('Left')
local CylRight = Rotations:WaitForChild('CylRight')
local CylLeft = Rotations:WaitForChild('CylLeft')

local Right60 = Right:WaitForChild('Right60')
local Left60 = Left:WaitForChild('Left60')
local Right480 = Right:WaitForChild('Right480')
local Left480 = Left:WaitForChild('Left480')
local CylRight30 = CylRight:WaitForChild('CylRight30')
local CylLeft30 = CylLeft:WaitForChild('CylLeft30')

local RotationSpeed = math.rad(60)

RunService.Heartbeat:Connect(function(dt)
	local AngleChange = RotationSpeed * dt
	for _, part in Right60:GetChildren() do
		if part:IsA("BasePart") then
			part.AssemblyAngularVelocity = Vector3.new(0, RotationSpeed, 0)
			part.CFrame = part.CFrame * CFrame.Angles(0, AngleChange, 0)
		end
	end
	for _, part in Left60:GetChildren() do
		if part:IsA("BasePart") then
			part.AssemblyAngularVelocity = Vector3.new(0, -RotationSpeed, 0)
			part.CFrame = part.CFrame * CFrame.Angles(0, -AngleChange, 0)
		end
	end
	for _, part in Right480:GetChildren() do
		if part:IsA("BasePart") then
			part.AssemblyAngularVelocity = Vector3.new(0, RotationSpeed*8, 0)
			part.CFrame = part.CFrame * CFrame.Angles(0, AngleChange*8, 0)
		end
	end
	for _, part in Left480:GetChildren() do
		if part:IsA("BasePart") then
			part.AssemblyAngularVelocity = Vector3.new(0, -RotationSpeed*8, 0)
			part.CFrame = part.CFrame * CFrame.Angles(0, -AngleChange*8, 0)
		end
	end
	for _, part in CylRight30:GetChildren() do
		if part:IsA("BasePart") then
			part.AssemblyAngularVelocity = part.CFrame:VectorToWorldSpace(Vector3.new(RotationSpeed/2, 0, 0))
			part.CFrame = part.CFrame * CFrame.Angles(AngleChange/2, 0, 0)
		end
	end
	for _, part in CylLeft30:GetChildren() do
		if part:IsA("BasePart") then
		part.AssemblyAngularVelocity = part.CFrame:VectorToWorldSpace(Vector3.new(-RotationSpeed/2, 0, 0))
			part.CFrame = part.CFrame * CFrame.Angles(-AngleChange/2, 0, 0)
		end
	end
end)