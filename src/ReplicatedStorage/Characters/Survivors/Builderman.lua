--uncle dane
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Character = require(ReplicatedStorage.Classes.Character)
local Types = require(ReplicatedStorage.Classes.Types)
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local Ability = require(ReplicatedStorage.Classes.Ability)

local BehaviorsModule = RunService:IsServer() and require(ServerStorage.ServerCharacterBehaviors.Survivors.BuildermanBehavior)

local function BuildBehavior(self)
    if RunService:IsServer() then
        BehaviorsModule.Build(self)
    end
end

local function BuildermanInit(char : Model)
    char:SetAttribute("SentryModel", game.ReplicatedStorage.Assets.BuildermanSentries.DefaultSentry)
end

--[[
Builderman sentries exact specs and nerd shit (please model it using these rules, it makes my life easier)
Part names do not have to be casesensitive but animations DO
Please anchor only the base of the sentry
Must have an AnimationController with an Animator inside
Please still follow normal naming conventions e.g, NO SPACES, PascalCase
Make sure for lvl3 sentries, the rocketshootanim only has keyframes from the rocketpart itself
When making skins for the sentries, keep the size reasonable imcomparison to the stock sentry

lvl 1 sentries expect a toppart and base with base being MOTOR6D to toppart,
 a folder that contains anims called Shoot (Action1 Animation Priority) and Idle (Idle Animation Priority)

lvl 2 sentries expects the toppart and base with base being MOTOR6D to toppart,
 a folder that contains anims called Shoot1 (Action1 Animation Priority), Shoot2 (Action1 Animation Priority), and Idle (Idle Animation Priority)

lvl 3 sentries expects the toppart and base with base being MOTOR6D to toppart as well as an additional rocketlauncher MOTOR6d to toppart,
a folder that contains anims called Shoot1 (Action1 Animation Priority), Shoot2 (Action1 Animation Priority), ShootRocket (Action1 Animation Priority) and Idle (Idle Animation Priority)
 ]]

local Builderman: Types.Survivor = Character.CreateSurvivor({
    Config = {
        Name = "Builderman",
        Quote = "*i eat burger*",
        Render = "rbxassetid://108440668883002",

        Origin = {
            TooltipText = "no im not original",
            Icon = "rbxasset://textures/ui/GuiImagePlaceholder.png",
		},
		
		AnimationIDs = {
			IdleAnimation = "rbxassetid://86473463016151",
			WalkAnimation = "rbxassetid://122437062315092",
			RunAnimation = "rbxassetid://73164883164058",
		},
    },


    FacialExpressions = {
        Default = "rbxassetid://00",
        Hurt = "rbxassetid://00",
        Limping = "rbxassetid://00",
        Dead = "rbxassetid://00"
    },

    GameplayConfig = {
        Abilities = {
            -- yes the exact stats are fucking hardcoded in, fight me later over it
            HealBurger = Ability.New({
                Name = "Build",
                InputName = "FirstAbility",
                Cooldown = 30,
                Behaviour = BuildBehavior
            }),
        }
    },

    OnInit = BuildermanInit
})

Builderman.Config.Description = {
    {
        Type = "Separator",
        Text = "GENERAL INFO",
    },
    {
        Type = "Header",
        Text = Builderman.Config.Name:upper(),
    },
    {
        Type = "Quote",
        Text = "\""..Builderman.Config.Quote.."\""
    },
    {
        Type = "Text",
        Text = "guy man. "
            .."starter character so is good. "
            .."197",
    },
    {
        Type = "Header",
        Text = "STATS",
    },
    --{
    --    Type = "Text",
    --    Text = {
    --        "Difficulty: ★★★☆☆",
    --        -- "Difficulty: 6 7",
    --        "Health: "..tostring(Builderman.GameplayConfig.Health),
    --        "Base Speed: "..tostring(Builderman.GameplayConfig.BaseSpeed),
    --        "Sprint Speed: "..tostring(math.round(Builderman.GameplayConfig.BaseSpeed * Builderman.GameplayConfig.SprintSpeedMultiplier * 10) / 10),
    --        "Max Stamina: "..tostring(Builderman.GameplayConfig.StaminaProperties.MaxStamina),
    --        "Stamina Loss per second: "..tostring(Builderman.GameplayConfig.StaminaProperties.StaminaDrain),
    --        "Stamina Gain per second: "..tostring(Builderman.GameplayConfig.StaminaProperties.StaminaGain),
    --    },
    --},
    --{
    --    Type = "Separator",
    --    Text = "PASSIVES",
    --},
    --{
    --    Type = "Header",
    --    Text = Builderman.GameplayConfig.Abilities.BodyArmor.Name:upper(),
    --},
    --{
    --    Type = "Quote",
    --    Text = "\"Diamond armor, full set!\" -Minecraft Steve",
    --},
    --{
    --    Type = "Text",
    --    Text = "Every time Builderman gets hit, he gets <b>Resistance V</b> for 1 second, acting as invincibility frames.",
    --    Image = "http://www.roblox.com/asset/?id=113412520",
    --},
    --{
    --    Type = "Separator",
    --    Text = "ABILITIES",
    --},
    --{
    --    Type = "Header",
    --    Text = Builderman.GameplayConfig.Abilities.Blindside.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = "Builderman picks up a flashbang grenade and throws it after "..tostring(Builderman.GameplayConfig.Abilities.Blindside.ThrowDelay)..
    --        " seconds, triggering it after "..tostring(Builderman.GameplayConfig.Abilities.Blindside.TriggerDelay)..
    --        " seconds and inflicting the killer <b>Blindness</b> for "..tostring(Builderman.GameplayConfig.Abilities.Blindside.FlashTime)..
    --        " seconds if they're in a "..tostring(Builderman.GameplayConfig.Abilities.Blindside.FlashRadius)..
    --        " stud radius.",
    --},
    --{
    --    Type = "Header",
    --    Text = Builderman.GameplayConfig.Abilities.Reload.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = "Builderman reloads his gun, getting <b>Slowness "..Utils.Math.IntToRoman(Builderman.GameplayConfig.Abilities.Reload.SlownessLevel)..
    --        "</b> for "..tostring(Builderman.GameplayConfig.Abilities.Reload.Duration).." seconds.",
    --},
    --{
    --    Type = "Header",
    --    Text = Builderman.GameplayConfig.Abilities.Justice.Name:upper(),
    --},
    --{
    --    Type = "Text",
    --    Text = {
    --        "Builderman shoots forward "
    --        ..tostring(Builderman.GameplayConfig.Abilities.Justice.HitboxLength).." studs. If it hits the killer, they get stunned for "
    --        ..tostring(Builderman.GameplayConfig.Abilities.Justice.StunTime).." seconds and receive "
    --        ..tostring(Builderman.GameplayConfig.Abilities.Justice.Damage).." damage.",
    --        "This ability's charge is obtained through <b>Reload</b>."
    --    },
    --},

    
}

return Builderman
