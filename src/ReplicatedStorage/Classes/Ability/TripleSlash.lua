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
local CommonUtils = require(ServerScriptService.System.CommonFunctions)

local TripleSlashModule = {}

local function ApplyVelocity(intialVelocity : number, character : Model)
    local velInstance = CommonUtils.ApplyVelocity(character, {InitialVelocity = intialVelocity})
    task.delay(2, function()
        velInstance:Destroy()
    end)
end

local function TripleSlashBehavior(self : Types.Ability)
    if RunService:IsServer() then
        ApplyVelocity(-20, self.OwnerProperties.Character)
        
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