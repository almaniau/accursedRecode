local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local Sounds = require(ReplicatedStorage.Modules.Sounds)
local Ability = require(ReplicatedStorage.Classes.Ability)
local Effect = require(ReplicatedStorage.Classes.Effect)
local Types = require(ReplicatedStorage.Classes.Types)
local CommonUtils = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions)


local ChickenModule = {}

local function ChickenBehavior(self : Types.Ability)
    CommonUtils.ApplyEffect({TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Regeneration", Level = 3, Duration = 10}})
end


function ChickenModule.New()
    local Final = Ability.New({
        Name = "Chicken",
        InputName = "SecondAbility",
        Cooldown = 60,
        Behaviour = ChickenBehavior,
    })

    return Final

end

return ChickenModule