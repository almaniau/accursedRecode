local SentryModule = {}

function SentryModule.New(sentryFolder : Folder, owner : Player)
    local self = {}
    self.State = "Building"
    self.Level = 1
    self.Owner = owner
    self.Model = sentryFolder.LevelOne:Clone()
    self.Model.Parent = workspace
    self.Model:PivotTo(owner.Character.HumanoidRootPart.CFrame * CFrame.new(0, -1, -2))
    print(self.Owner, self.Model)
    return self
end

function SentryModule.Upgrade(self)

end

function SentryModule.Destroy(self)

end

return SentryModule