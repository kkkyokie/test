
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local dropGui = playerGui:WaitForChild("DropHeldEgg")

--// TARGET
local TARGET_CFRAME = CFrame.new(
    538.389709,
    70.5743103,
    -364.192749,
    -0.0340620577,
    8.68050787e-08,
    0.99941969,
    0,
    1,
    -8.68994423e-08,
    -0.99941969,
    -2.96088495e-09,
    -0.0340620577
)

local SPEED = 300
local HEIGHT_OFFSET = 28

local flying = false

--// GET ROOT
local function findHRP()
    local character = player.Character
    if not character then
        return nil
    end

    return character:FindFirstChild("HumanoidRootPart")
        or character.PrimaryPart
end

--// FLY TO POINT
local function FlyToPoint(target, speed)
    local hrp = findHRP()
    if not hrp then
        return false
    end

    local start = hrp.CFrame
    local distance = (start.Position - target.Position).Magnitude

    if distance < 0.05 then
        hrp.CFrame = target
        return true
    end

    local duration = distance / speed
    local elapsed = 0

    while elapsed < duration do
        hrp = findHRP()
        if not hrp then
            return false
        end

        elapsed += RunService.Heartbeat:Wait()

        local alpha = math.clamp(elapsed / duration, 0, 1)

        -- Smooth glide
        local current = start:Lerp(target, alpha)

        -- Face the direction of movement
        local direction = target.Position - current.Position

        if direction.Magnitude > 0.001 then
            current = CFrame.lookAt(
                current.Position,
                current.Position + direction.Unit
            )
        end

        hrp.CFrame = current

        -- Keep movement stable
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end

    hrp.CFrame = target
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero

    return true
end

--// FULL FLY GLIDE BEHAVIOR
local function TravelFlyDirect(targetCFrame)
    local hrp = findHRP()
    if not hrp then
        return false
    end

    local targetPosition = targetCFrame.Position
    local currentPosition = hrp.Position

    -- Raise above everything first
    local highestY = math.max(
        currentPosition.Y,
        targetPosition.Y
    )

    local flyHeight = highestY + HEIGHT_OFFSET

    -- 1. GO UP
    local upPosition = Vector3.new(
        currentPosition.X,
        flyHeight,
        currentPosition.Z
    )

    local upCFrame = CFrame.lookAt(
        upPosition,
        upPosition + (targetPosition - currentPosition).Unit
    )

    if not FlyToPoint(upCFrame, SPEED) then
        return false
    end

    -- 2. GLIDE HORIZONTALLY
    local horizontalPosition = Vector3.new(
        targetPosition.X,
        flyHeight,
        targetPosition.Z
    )

    local horizontalDirection =
        horizontalPosition - hrp.Position

    local horizontalCFrame = CFrame.lookAt(
        horizontalPosition,
        horizontalPosition + horizontalDirection.Unit
    )

    if not FlyToPoint(horizontalCFrame, SPEED) then
        return false
    end

    -- 3. DESCEND
    local approachPosition = Vector3.new(
        targetPosition.X,
        targetPosition.Y,
        targetPosition.Z
    )

    local approachDirection =
        approachPosition - hrp.Position

    local approachCFrame = CFrame.lookAt(
        approachPosition,
        approachPosition + approachDirection.Unit
    )

    if not FlyToPoint(approachCFrame, SPEED) then
        return false
    end

    -- 4. EXACT FINAL CFRAME
    hrp = findHRP()
    if hrp then
        hrp.CFrame = targetCFrame
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end

    return true
end

--// RUN
local function RunFly()
    if flying then
        return
    end

    flying = true

    TravelFlyDirect(TARGET_CFRAME)

    flying = false
end

--// WHEN DropHeldEgg ENABLED BECOMES TRUE
dropGui:GetPropertyChangedSignal("Enabled"):Connect(function()
    if dropGui.Enabled then
        task.spawn(RunFly)
    end
end)

--// ALSO RUN IF ALREADY ENABLED
if dropGui.Enabled then
    task.spawn(RunFly)
end
