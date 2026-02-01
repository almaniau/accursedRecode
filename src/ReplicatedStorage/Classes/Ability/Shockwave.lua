local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local Hitbox = require(ReplicatedStorage.Classes.Hitbox)
local Projectile = require(ReplicatedStorage.Classes.Projectile)
local Sounds = require(ReplicatedStorage.Modules.Sounds)
local Ability = require(ReplicatedStorage.Classes.Ability)
local Types = require(ReplicatedStorage.Classes.Types)
local Utils = require(ReplicatedStorage.Modules.Utils)
local CommonUtils = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions)


local ShockwaveModule = {}

local function ShockwaveBehavior(self : Types.Ability)
    -- effects should be handled by client i have no idea how to do the network shit
    for i = 1, 25 do
        local lastCFrame = self.OwnerProperties.Character:FindFirstChild("HumanoidRootPart").CFrame
        local targetPos = (self.OwnerProperties.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, i * -15)).Position
        local ray = workspace:Raycast(targetPos + Vector3.new(0, 25, 0), Vector3.new(0, -200, 0))
        if ray and ray.Position then
            local offset = targetPos - ray.Position
            if offset.Magnitude > 10 then
                offset = offset.Unit * 10
            end
            local newCFrame = (lastCFrame + offset) * lastCFrame.Rotation
            lastCFrame = newCFrame
            Hitbox.New(self.Owner, {
                Size = Vector3.new(10, 10, 10),
                CFrame = newCFrame,
                Shape = Enum.PartType.Cylinder,
            })
        end
        task.wait(0.4)
    end
end

function ShockwaveModule.New()
    local Final = Ability.New({
        Name = "Shockwave",
        InputName = "SecondAbility",
        Cooldown = 22,
        Behaviour = ShockwaveBehavior
    })

    return Final
end

return ShockwaveModule