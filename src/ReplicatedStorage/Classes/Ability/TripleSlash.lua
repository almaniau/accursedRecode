local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

local Hitbox = require(ReplicatedStorage.Classes.Hitbox)
local Projectile = require(ReplicatedStorage.Classes.Projectile)
local Sounds = require(ReplicatedStorage.Modules.Sounds)
local Ability = require(ReplicatedStorage.Classes.Ability)
local Types = require(ReplicatedStorage.Classes.Types)
local Utils = require(ReplicatedStorage.Modules.Utils)

local TripleSlashModule = {}

local function TripleSlashBehavior(self : Types.Ability)
    if RunService:IsServer() then
        task.delay(2, function() --idk change this value later
            Projectile.New({
                SourcePlayer = self.Owner,
                Model = ServerStorage.Assets.Projectiles:FindFirstChild("1x1x1x1Slash"),
                StartingCFrame = self.OwnerProperties.Character.HumanoidRootPart.CFrame,
                Speed = 30,
                Lifetime = 10,
                ThrowType = "Forward",
                HitboxSettings = {Size = Vector3.new(5, 5, 5),
                    Damage = 15,
                    IsProjectile = true,
                    HitMultiple = true,
                    ExecuteOnKill = false,
                    Shape = Enum.PartType.Block,
                    
                }  
            })
        end)
    end
end

--1x stuff

function TripleSlashModule.New()
    local Final = Ability.New({
        Name = "TripleSlash",
        InputName = "Q",
        Cooldown = 15,
        Behaviour = TripleSlashBehavior,
    })

    return Final

end

return TripleSlashModule