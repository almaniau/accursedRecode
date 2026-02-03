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
local Behaviors = RunService:IsServer() and require(ServerStorage.ServerCharacterBehaviors.Killers["1x1x1x1Behavior"])


local UnstableEyeModule = {}

local function UnstableEyeModuleBehavior(self : Types.Ability)
    if RunService:IsServer() then
        Behaviors.UnstableEye(self)
    end
end

--fehauhfaeiu
function UnstableEyeModule.New()
    local Final = Ability.New({
        Name = "UnstableEye",
        InputName = "ThirdAbility",
        Cooldown = 25,
        Behaviour = UnstableEyeModuleBehavior,
    })

    return Final

end

return UnstableEyeModule