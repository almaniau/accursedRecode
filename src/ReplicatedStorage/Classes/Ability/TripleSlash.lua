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


local TripleSlashModule = {}

local function ApplyVelocity(intialVelocity : number, character : Model)
    local velInstance = CommonUtils.ApplyVelocity(character, {InitialVelocity = intialVelocity, LerpDelta = 0.1})
    velInstance.Parent = character
    task.delay(0.3, function()
        velInstance:Destroy()
    end)
end

local function ThrowProjectile(thrower : Player)
    local character = thrower.Character
    Projectile.New({
        SourcePlayer = thrower,
        Model = ServerStorage.Assets.Projectiles:FindFirstChild("1x1x1x1Slash"),
        StartingCFrame = character:FindFirstChild("HumanoidRootPart").CFrame,
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
end

local function TripleSlashBehavior(self : Types.Ability)
    if RunService:IsServer() then
        ApplyVelocity(-80, self.OwnerProperties.Character)
        
        task.delay(2, function() --idk change this value later
            for _ = 1, 3 do
                ThrowProjectile(self.Owner)
                ApplyVelocity(40, self.OwnerProperties.Character)
                task.wait(0.5)
            end
        end)
    end
end

--1x stuff

function TripleSlashModule.New()
    local Final = Ability.New({
        Name = "TripleSlash",
        InputName = "FirstAbility",
        Cooldown = 15,
        Behaviour = TripleSlashBehavior,
    })

    return Final

end

return TripleSlashModule