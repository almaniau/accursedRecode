local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local AnimationManager = require(StarterPlayer.StarterCharacterScripts.AnimationManager)
local Hitbox = require(ReplicatedStorage.Classes.Hitbox)
local Projectile = require(ReplicatedStorage.Classes.Projectile)
local Sounds = require(ReplicatedStorage.Modules.Sounds)
local Ability = require(ReplicatedStorage.Classes.Ability)
local Types = require(ReplicatedStorage.Classes.Types)
local Utils = require(ReplicatedStorage.Modules.Utils)
local CommonUtils = RunService:IsServer() and require(ServerScriptService.System.CommonFunctions)

local SwingModule = {}

local function SwingBehavior(self : Types.Ability)
    if RunService:IsServer() then
       --idk twin
       
       print("swing thing")
    end
end

function SwingModule.New()
    local Final = Ability.New({
        Name = "Swing",
        InputName = "FirstAbility",
        Cooldown = 40,
        Behaviour = SwingBehavior,
    })

    return Final

end

return SwingModule