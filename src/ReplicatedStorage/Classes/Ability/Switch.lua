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

local SwitchModule = {}

--switch shedletsky sword, this idea is stupid

local function SwitchBeahvior(self : Types.Ability)
    if RunService:IsServer() then
       self.OwnerProperties.Character:SetAttribute("CurrentSword", (self.OwnerProperties.Character:GetAttribute("CurrentSword") + 1) % 8)
       print(self.OwnerProperties.Character:GetAttribute("CurrentSword"))
    end
end

local function SwitchExtraInit(self: Types.Ability)
    self.OwnerProperties.Character:SetAttribute("CurrentSword", 1)
end

function SwitchModule.New()
    local Final = Ability.New({
        Name = "Switch",
        InputName = "ThirdAbility",
        Cooldown = 1,
        Behaviour = SwitchBeahvior,
        ExtraInit = SwitchExtraInit, -- sets the sword to 1, corresponds to linked
    })


    return Final

end

return SwitchModule