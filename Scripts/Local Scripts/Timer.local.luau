local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local textLabel = script.Parent

local function updateDisplay()
	local isLevelRed = player:GetAttribute("LevelRed") == true
	textLabel.Visible = isLevelRed

	if not isLevelRed then return end

	local chaosText = ReplicatedStorage:GetAttribute("ChaosText") or "Next Chaos In:"
	local timeLeft = ReplicatedStorage:GetAttribute("TimeLeft") or 0

	local minutes = math.floor(timeLeft / 60)
	local seconds = timeLeft % 60

	textLabel.Text = string.format("%s %02d:%02d", chaosText, minutes, seconds)
end

ReplicatedStorage:GetAttributeChangedSignal("TimeLeft"):Connect(updateDisplay)
ReplicatedStorage:GetAttributeChangedSignal("ChaosText"):Connect(updateDisplay)
player:GetAttributeChangedSignal("LevelRed"):Connect(updateDisplay)

updateDisplay()