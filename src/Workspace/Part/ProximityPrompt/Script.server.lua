script.Parent.Triggered:Connect(function(plr)
	require(game:GetService("ServerScriptService").Managers.ServerCharacterManager).SetupCharacter(plr, "2011x", "Killer")
end)