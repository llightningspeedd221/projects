-- Variables
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
-- Get the UserInputService
local key = game:GetService("UserInputService")


-- Speed variable
local tweenSpeed = 150
local tp = true
-- Helper function to calculate time based on distance and speed
local function calculateTime(targetPosition)
    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        error("Player's character or HumanoidRootPart is missing")
    end

    local distance = (targetPosition - character.HumanoidRootPart.Position).Magnitude
    return distance / tweenSpeed
end

-- Function to tween to a target part
local function tweenToPart(targetPart, yOffset)
    local character = plr.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        error("Player's character or HumanoidRootPart is missing")
    end

    if not targetPart or not targetPart:IsA("BasePart") then
        error("Invalid target part")
    end

    -- Apply Y offset to the target position
    local targetPosition = targetPart.Position + Vector3.new(0, yOffset or 0, 0)

    -- Calculate tween time and create TweenInfo
    local tweenTime = calculateTime(targetPosition)
    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

    -- Create and play the tween
    local tween = TweenService:Create(
        character.HumanoidRootPart,
        tweenInfo,
        {CFrame = CFrame.new(targetPosition)}
    )

    tween:Play()

    -- Optionally handle completion
    tween.Completed:Connect(function()
        
    end)
end


-- Example usage
local targetPart = workspace:FindFirstChild("Location").Enemy_Location:FindFirstChild("MrBeast") -- Replace "TargetPart" with the name of your part
if targetPart then
    while tp do
        key.InputBegan:Connect(function(input) if input.KeyCode == Enum.KeyCode.J then tp = false end end)
        targetPart = workspace:FindFirstChild("Location").Enemy_Location:FindFirstChild("MrBeast")
        task.wait(0.1)
        tweenToPart(targetPart, 0) -- Adjust the second argument to change the Y offset
        
        
    end
else
    warn("Target part not found in workspace")
end
