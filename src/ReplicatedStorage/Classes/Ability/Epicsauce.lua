local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local Hitbox = require(ReplicatedStorage.Classes.Hitbox)
local Projectile = require(ReplicatedStorage.Classes.Projectile)
local Sounds = require(ReplicatedStorage.Modules.Sounds)
local Ability = require(ReplicatedStorage.Classes.Ability)
local Effect = require(ReplicatedStorage.Classes.Effect)
local Types = require(ReplicatedStorage.Classes.Types)
local Utils = require(ReplicatedStorage.Modules.Utils)
local CommonUtils = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions)


local EpicsauceModule = {}

local function EpicsauceBehavior(self : Types.Ability)
    if RunService:IsServer() then
        CommonUtils.ApplyEffect({TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Speed", Level = 1, Duration = 10}})
    CommonUtils.ApplyEffect({TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Burning", Level = 1, Duration = 10}})
    end
end


function EpicsauceModule.New()
    local Final = Ability.New({
        Name = "Epicsauce",
        InputName = "SecondAbility",
        Cooldown = 25,
        Behaviour = EpicsauceBehavior,
    })

    return Final

end

return EpicsauceModule