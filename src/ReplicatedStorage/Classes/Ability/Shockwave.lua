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


local ShockwaveModule = {}

local function ShockwaveBehavior(self : Types.Ability)
    local character = self.OwnerProperties.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local lastHitPos = rootPart.Position - Vector3.new(0, 8, 0) 

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {character}
    params.FilterType = Enum.RaycastFilterType.Exclude

    for _ = 1, 25 do
        local currentForward = rootPart.CFrame.LookVector
        local goalPos = lastHitPos + (currentForward * 8)

        local ray = workspace:Raycast(goalPos + Vector3.new(0, 10, 0), Vector3.new(0, -20, 0), params)

        if ray then
            local hitPos = ray.Position
            
            local diff = (hitPos - lastHitPos)
            local flatDirection = Vector3.new(diff.X, 0, diff.Z).Unit
            
            if flatDirection.Magnitude == 0 then
                flatDirection = Vector3.new(currentForward.X, 0, currentForward.Z).Unit
            end

            local hitboxCFrame = CFrame.lookAt(hitPos, hitPos + flatDirection) 
                                 * CFrame.Angles(0, 0, math.rad(90))

            Hitbox.New(self.Owner, {
                Size = Vector3.new(30, 10, 10),
                CFrame = hitboxCFrame,
                Shape = Enum.PartType.Cylinder,
            })
            lastHitPos = hitPos
        end

        task.wait(0.1)
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