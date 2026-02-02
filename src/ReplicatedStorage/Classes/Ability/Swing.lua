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

local SwordsList = {
    -- icedagger, darkheart literally only visual effect
    "LinkedSword",
    "Firebrand",
    "Venomshank",
    "Icedagger",
    "Windforce",
    "Illumina",
    "Darkheart",
    "Ghostwalker"
}

local function ToggleSwordVisibility(model : Model, visible : boolean)
    for _, children in pairs(model:GetChildren()) do
        if children:IsA("BasePart") then
            children.Transparency = visible and 0 or 1
        end
    end
end

local function SwingBehavior(self : Types.Ability)
    if RunService:IsServer() then
       --idk twin
       local currentSword = self.OwnerProperties.Character:GetAttribute("CurrentSword") -- thank you lua dynamic variables
       print(currentSword)
       currentSword = SwordsList[currentSword]
       print(currentSword)
       local swordModel : Model = self.OwnerProperties.Character:FindFirstChild(currentSword)
       if swordModel then
        ToggleSwordVisibility(swordModel, true)
       end

       print(currentSword) 
       task.delay(0.8, function()
        Hitbox.New(self.Owner, {
				CFrameOffset = CFrame.new(0, 0, -5),
				Size = Vector3.new(1, 9, 7), -- if you know you know
				Time = 1.2,
				Damage = 30,
				Reason = "Swing Attack",
                EffectsToApply = {{TargetHumanoid = self.OwnerProperties.Humanoid, EffectSettings = {Name = "Stunned", Level = 1, Duration = 3.5}}}
			})
       end)
       
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