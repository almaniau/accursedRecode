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

local PizzaModule = {}

local function ToggleModelVisibility(model : Model, visible : boolean)
    for _, children in pairs(model:GetChildren()) do
        if children:IsA("BasePart") then
            children.Transparency = visible and 0 or 1
        end
    end
end

local function PizzaBehavior(self : Types.Ability)
    if RunService:IsServer() then
        local Pizza = self.OwnerProperties.Character:FindFirstChild("Pizza")
        if Pizza then
            ToggleModelVisibility(Pizza, true)
            task.delay(0.6, function()
                ToggleModelVisibility(Pizza, false)
                local FunctionalPizza = Pizza:Clone()
                local Joint = FunctionalPizza:FindFirstChildWhichIsA("JointInstance")
                if Joint then
                    Joint:Destroy()
                end
                FunctionalPizza.Name = "ActivePizza"
                FunctionalPizza.CanCollide = true
                FunctionalPizza.CollisionGroup = "Items"
                FunctionalPizza.AssemblyLinearVelocity = (self.OwnerProperties.Character.HumanoidRootPart.CFrame.LookVector + Vector3.new(0, 0.5, 0)) * self.ThrowForce
                FunctionalPizza.Parent = workspace:FindFirstChild("Map") and workspace.Map.InGame or workspace.TempObjectFolders
            end)
        else
            warn("this model has no pizza thus cannot throw a pizza")
        end
    end
end

function PizzaModule.New()
    local Final = Ability.New({
        Name = "Pizza",
        InputName = "FirstAbility",
        Cooldown = 40,
        Behaviour = PizzaBehavior,
    })

    return Final
end


return PizzaModule