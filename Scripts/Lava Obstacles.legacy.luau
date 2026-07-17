local lavas = game.Workspace:WaitForChild('Lava'):GetChildren()

for _, lava in lavas do
	lava.Touched:Connect(function(object)
		local Obbyplayer = game.Players:GetPlayerFromCharacter(object.Parent)
		if Obbyplayer then
			object.Parent.Humanoid.Health = 0
		end
	end)
end
