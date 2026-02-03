local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local Hitbox = require(ReplicatedStorage.Classes.Hitbox)
local Projectile = require(ReplicatedStorage.Classes.Projectile)
local Sounds = require(ReplicatedStorage.Modules.Sounds)
local Ability = require(ReplicatedStorage.Classes.Ability)
local Types = require(ReplicatedStorage.Classes.Types)
local Network = require(ReplicatedStorage.Modules.Network)
local Utils = require(ReplicatedStorage.Modules.Utils)
local CommonUtils = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions)
local Behaviors = RunService:IsServer() and require(ServerStorage.ServerCharacterBehaviors.Killers["1x1x1x1Behavior"])


local ShockwaveModule = {}

local function ShockwaveBehavior(self : Types.Ability)
    if RunService:IsServer() then
        Behaviors.Shockwave(self)
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