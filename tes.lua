
local Fluent = loadstring(game:HttpGet("https://github.com/StyearX/Fluent-Modded/releases/download/1.6.0/main.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")

function Notify(Title, Content, Status, Icon, Duration)
    Fluent:Notify({
        Title = Title,
        Content = Content,
        SubContent = Status,
        Image = Icon,
        Duration = Duration or 3,
    })
end

Fluent.NotifyInsideWindow = true

Fluent:AddTheme({
    Name = "Purple",

    Accent = "#9b6cff",

    AcrylicMain = "#0f0b18",
    AcrylicBorder = "#2a1d3d",
    AcrylicGradient = ColorSequence.new(
        Color3.fromHex("#151022"),
        Color3.fromHex("#090711")
    ),
    AcrylicNoise = 0.9,

    TitleBarLine = "#8b5cf6",

    -- More visible tabs
    Tab = "#30204d",

    -- Main elements: lighter + more separated
    Element = "#2b2040",
    ElementBorder = "#554078",
    InElementBorder = "#60458a",
    ElementTransparency = 0.15,
    ElementBorderThickness = 1,

    ToggleSlider = "#8b5cf6",
    ToggleToggled = "#ffffff",

    SliderRail = "#4b3670",

    CheckboxUnchecked = "#493568",
    CheckboxChecked = "#9b6cff",
    CheckboxCheck = "#ffffff",

    ProgressBarRail = "#3b2a58",
    ProgressBarFill = "#9b6cff",

    -- Dropdown
    DropdownFrame = "#33234d",
    DropdownHolder = "#3e2b5d",
    DropdownBorder = "#66478f",
    DropdownOption = "#9b6cff",
    DropdownBorderThickness = 1,

    -- Keybind / inputs
    Keybind = "#493568",
    Input = "#35264d",
    InputFocused = "#4b3670",
    InputIndicator = "#b99aff",

    -- Dialog
    Dialog = "#302043",
    DialogHolder = "#402b5c",
    DialogHolderLine = "#76539f",
    DialogButton = "#9b6cff",
    DialogButtonBorder = "#5b3d82",
    DialogBorder = "#63458c",
    DialogInput = "#2b1e3e",
    DialogInputLine = "#9b6cff",

    Text = "#ffffff",
    SubText = "#d8d0e5",

    Hover = "#9b6cff",
    HoverChange = 0.35,

    Background = "rbxassetid://137998028819479",
    BackgroundTransparency = 0,

    ViewportBackground = Color3.fromHex("#0d0818"),
    ViewportBackgroundImages = false,

    DropdownOutsideWindowBackground = Color3.fromHex("#110b1d"),
    DropdownOutsideWindowBackgroundImages = false,

    ShineEnabled = true,

    Shine = {
        Speed = 2.5,
        RotationSpeed = 1.0,

        ColorSequence = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("#120c1d")),
            ColorSequenceKeypoint.new(0.5, Color3.fromHex("#8b5cf6")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("#120c1d")),
        }),
    },

    StrokeShine = true,
    StrokeDark = Color3.fromHex("#35244d"),

    ButtonGradient = {
        Background = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("#211632")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("#8b5cf6")),
        }),

        Stroke = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("#2a1d3d")),
            ColorSequenceKeypoint.new(0.5, Color3.fromHex("#594080")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("#2a1d3d")),
        }),
    },

    DiscordJoinButton = "#9b6cff",

    WarningNotifyColor = "#facc15",
    SuccessNotifyColor = "#4ade80",
    ErrorNotifyColor = "#f87171",
    InfoNotifyColor = "#b99aff",
})

-- ================================================================

local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled

local Minimizer = Fluent:CreateMinimizer({
    Icon = "rbxassetid://94432012097794",
    Size = UDim2.fromOffset(64, 64),
    Position = UDim2.new(0.1, 0, 0.1, 0),
    Corner = 12,    
    BackgroundTransparency = 1,
    IconCorner = 6,
    Transparency = 0,
    Lockable = false,
    LockHoldTime = 1.0,
    Draggable = true,
    OnClickSound = {
        "4526034708"
    },
})

Minimizer.Visible = true

local Window = Fluent:CreateWindow({
    Title = "Ambient Hub",
    SubTitle = "By Kyokie",
    TabWidth = isMobile and 130 or 150,
    Acrylic = true,
    Size = isMobile and UDim2.fromOffset(400, 300) or UDim2.fromOffset(680, 600),
    Theme = "Purple",
    Background = true,
    Font = "GothamSSm",
    TitleIcon = "rbxassetid://94432012097794",
    Search = {
        Search = true,
        Highlight = true,
        HighlightColor = Color3.fromRGB(139, 92, 246),  -- updated to purple
    },
    UserInfo = {
        UserInfo = true,
        UserInfoTitle = LocalPlayer.Name,
        UserInfoSubtitle = LocalPlayer.DisplayName,
        UserInfoColor = Color3.fromRGB(139, 92, 246),    -- updated to purple
    },
    Anonymous = {
        Default = false,
        ShowAno = true,
        AnoUserInfoTitle = "Character",
        AnoUserInfoSubTitle = "Hiding...",
        Icons = "rbxassetid://94432012097794",
    },
    FolderName = "Kyokie Scripts",
    ScreenGuiName = "Ambient",
})


local MainTab = Window:AddTab({ Title = "Environment", Icon = "circle-dot" })
local Section = MainTab:AddSection("Feature", "solar/widget-2-bold")


local bypassedCharacter = nil

local function bypass()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local character =
        player.Character
        or player.CharacterAdded:Wait()

    if not character then
        return
    end

    if bypassedCharacter == character then
        return
    end

    local oldHumanoid =
        character:FindFirstChildOfClass("Humanoid")

    if not oldHumanoid then
        return
    end

    local camera = workspace.CurrentCamera

    local cameraOffset =
        oldHumanoid.CameraOffset


    local newHumanoid =
        oldHumanoid:Clone()

    newHumanoid.Parent = character

    newHumanoid.CameraOffset =
        cameraOffset

    local indicator =
        Instance.new("Folder")

    indicator.Name = "indicator"
    indicator.Parent = newHumanoid

    oldHumanoid:Destroy()

    camera.CameraSubject = newHumanoid

    bypassedCharacter = character
end

local autoB = false

Section:AddToggle("MyOnlyToggle", {
    Title = "Auto Bypass",
    Description = "Auto Bypass When your character Respawned",
    Default = false,
    Callback = function(Value)
        autoB = Value
        if autoB then
            bypass()
        end
    end,
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

player.CharacterAdded:Connect(function(character)
    print("Character spawned:", character.Name)

    character:WaitForChild("Humanoid")
    character:WaitForChild("HumanoidRootPart")
    if autoB then
        bypass()
    end
end)

local walkdef = player.Character.Humanoid.WalkSpeed

local walkval = walkdef
local WalkT = false

Section:AddInput("MyInput", {
    Title = "WalkSpeed Value",
    Placeholder = "Type here...",
    Finished = true,
    Callback = function(Value)
        walkval = Value
        if WalkT then
            player.Character.Humanoid.WalkSpeed = walkval
        else
            Notify("Warning", "Please Enable the WalkSpeed Changer first", "Error", "solar/danger-bold", 5)
        end
    end
})

Section:AddToggle("T2", {
    Title = "Enable WalkSpeed Changer",
    Description = "Change WalkSpeed, Bypass Needed",
    Default = false,
    Callback = function(Value)
        WalkT = Value
        if WalkT then
            if not autoB then
                bypass()
            end
            Notify("Success", "WalkSpeed Changed To,", walkval , "solar/check-circle-bold", 2)
            player.Character.Humanoid.WalkSpeed = walkval
        end
    end,
})


local promptZeroEnabled = false
local promptConnection

local function promptZero(enabled)
    promptZeroEnabled = enabled

    if promptConnection then
        promptConnection:Disconnect()
        promptConnection = nil
    end

    if not enabled then
        return
    end

    local function checkPrompt(obj)
        if obj:IsA("ProximityPrompt")
            and obj.HoldDuration ~= 0 then

            obj.HoldDuration = 0
        end
    end

    for _, obj in ipairs(
        game:GetDescendants()
    ) do
        checkPrompt(obj)
    end

    promptConnection =
        game.DescendantAdded:Connect(
            checkPrompt
        )
end

Section:AddToggle("T3", {
    Title = "Instant Interact",
    Description = "No Delay Interaction",
    Default = false,
    Callback = function(Value)
        promptZero(Value)
        if promptZeroEnabled then
            Notify("Instant Interaction", "Enabled Successfully")
        end
    end,
})

Section:AddButton({
    Title = "Apply Shader",
    Description = "make lighting good shader",
    Icon = "solar/lock-bold",
    Callback = function()
        
    end
})

local eggTab = Window:AddTab({
    Title = "EGG",
    Icon = "egg"
})

local egg = eggTab:AddSection(
    "Auto",
    "solar/widget-2-bold"
)

--------------------------------------------------
-- SERVICES
--------------------------------------------------

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local Rlist = {}
local Alist = {}

local farmegg = false

local GoSpeed = 300
local ReturnSpeed = 300

local Priority = "Rarest"

--------------------------------------------------
-- STATE
--------------------------------------------------

local currentEggUid = nil
local returningEgg = false
local dropConnection = nil

--------------------------------------------------
-- PRIORITY
--------------------------------------------------

egg:AddDropdown("Priority Select", {
    Title = "Egg Priority",
    Description = "Choose which rarity to farm first",

    Values = {
        "Rarest",
        "Lowest"
    },

    Multi = false,
    Default = "Rarest",

    Callback = function(Value)
        Priority = Value
    end
})

--------------------------------------------------
-- RARITY SELECT
--------------------------------------------------

egg:AddDropdown("Rarity Select", {
    Title = "Select Rarity",

    Values = {
        "Divine",
        "Eternal",
        "Secret",
        "Cosmic",
        "Mythic",
        "Legendary",
        "Epic",
        "Rare"
    },

    Multi = true,
    Default = {},

    Callback = function(selected)

        table.clear(Rlist)

        for name, state in pairs(selected) do
            if state then
                table.insert(Rlist, name)
            end
        end

        Notify(
            "Rarity",
            "Selected: " .. table.concat(Rlist, ", "),
            "Info"
        )
    end
})

--------------------------------------------------
-- AREA SELECT
--------------------------------------------------

egg:AddDropdown("Area Select", {
    Title = "Select Area",

    Values = {
        "Titan Temple",
        "Cherry Blossom",
        "Cosmic",
        "Prehistoric",
        "Abyss Ocean",
        "Volcano",
        "Snow",
        "Jungle",
        "Desert",
        "Lake",
        "Forest"
    },

    Multi = true,
    Default = {},

    Callback = function(selected)

        table.clear(Alist)

        for name, state in pairs(selected) do
            if state then
                table.insert(Alist, name)
            end
        end

        Notify(
            "Area",
            "Selected: " .. table.concat(Alist, ", "),
            "Info"
        )
    end
})

--------------------------------------------------
-- AUTO FARM TOGGLE
--------------------------------------------------

egg:AddToggle("idk", {
    Title = "Auto Farm Selected",
    Description = "auto farm selected eggs",
    Default = false,

    Callback = function(Value)

        farmegg = Value

        if not Value then

            currentEggUid = nil
            returningEgg = false

            local character = player.Character

            if character then

                local root =
                    character:FindFirstChild(
                        "HumanoidRootPart"
                    )

                if root then

                    root.AssemblyLinearVelocity =
                        Vector3.zero

                    root.AssemblyAngularVelocity =
                        Vector3.zero
                end
            end
        end
    end
})

--------------------------------------------------
-- MODULES
--------------------------------------------------

local EggState = require(
    ReplicatedStorage.Client.EggState
)

local Assets = require(
    ReplicatedStorage.Data.Assets
)

--------------------------------------------------
-- POSITIONS
--------------------------------------------------

local ReturnPosition = Vector3.new(
    525.026978,
    70.5743103,
    -363.389465
)

local SecondPosition = Vector3.new(
    522.404846,
    70.5743103,
    -307.801178
)

--------------------------------------------------
-- EGG RECORD
--------------------------------------------------

local function getEggRecord(uid)

    local success, result =
        pcall(function()
            return EggState.ReadFieldEgg(uid)
        end)

    if success then
        return result
    end

    return nil
end

--------------------------------------------------
-- ALL EGG RECORDS
--------------------------------------------------

local function getEggRecords()

    local success, result =
        pcall(function()
            return EggState.ReadFieldEggs()
        end)

    if success
        and result
        and result.Records then

        return result.Records
    end

    return {}
end

--------------------------------------------------
-- DROP GUI
--------------------------------------------------

local function getDropHeldEgg()

    local playerGui =
        player:FindFirstChild("PlayerGui")

    if not playerGui then
        return nil
    end

    return playerGui:FindFirstChild(
        "DropHeldEgg"
    )
end

local function isHoldingEgg()

    local gui =
        getDropHeldEgg()

    return gui
        and gui.Enabled == true
end

--------------------------------------------------
-- FLY GLIDE
--------------------------------------------------

local function findHRP()

    local character = player.Character

    return character
        and (
            character:FindFirstChild(
                "HumanoidRootPart"
            )
            or character.PrimaryPart
        )
end

--------------------------------------------------
-- FLY TO POINT
--------------------------------------------------

local function FlyToPoint(
    target,
    speed,
    easeOut,
    watchUid
)

    local hrp = findHRP()

    if not hrp or not target then
        return "failed"
    end

    local start = hrp.Position

    local dist =
        (target - start).Magnitude

    if dist < 1 then

        hrp.CFrame = CFrame.new(
            target.X,
            math.max(target.Y, 70),
            target.Z
        )

        hrp.AssemblyLinearVelocity =
            Vector3.zero

        hrp.AssemblyAngularVelocity =
            Vector3.zero

        return "arrived"
    end

    speed = math.clamp(
        tonumber(speed) or 300,
        50,
        750
    )

    local moveTime =
        math.max(
            dist / speed,
            0.02
        )

    if easeOut then
        moveTime *= 1.25
    end

    local t0 = os.clock()

    local delta =
        target - start

    local dir =
        delta.Magnitude > 0.001
        and delta.Unit
        or Vector3.new(1, 0, 0)

    while os.clock() - t0 < moveTime do

        if not farmegg then

            hrp.AssemblyLinearVelocity =
                Vector3.zero

            hrp.AssemblyAngularVelocity =
                Vector3.zero

            return "stopped"
        end

        --------------------------------------------------
        -- WATCH CURRENT EGG
        --------------------------------------------------

        if watchUid then

            local currentEgg =
                getEggRecord(watchUid)

            if not currentEgg then

                hrp.AssemblyLinearVelocity =
                    Vector3.zero

                hrp.AssemblyAngularVelocity =
                    Vector3.zero

                return "lost"
            end

            if currentEgg.State == "Dropped" then

                hrp.AssemblyLinearVelocity =
                    Vector3.zero

                hrp.AssemblyAngularVelocity =
                    Vector3.zero

                return "dropped"
            end
        end

        --------------------------------------------------
        -- HEARTBEAT
        --------------------------------------------------

        RunService.Heartbeat:Wait()

        hrp = findHRP()

        if not hrp then
            return "failed"
        end

        --------------------------------------------------
        -- MOVEMENT PROGRESS
        --------------------------------------------------

        local linearAlpha =
            math.clamp(
                (os.clock() - t0) / moveTime,
                0,
                1
            )

        local a = linearAlpha

        if easeOut then

            a = math.sin(
                linearAlpha *
                (math.pi / 2)
            )
        end

        local cur =
            start:Lerp(
                target,
                a
            )

        --------------------------------------------------
        -- FACE MOVEMENT DIRECTION
        --------------------------------------------------

        hrp.CFrame =
            CFrame.lookAt(
                cur,
                cur + dir
            )

        --------------------------------------------------
        -- VELOCITY
        --------------------------------------------------

        local curSpeed = speed

        if easeOut then

            curSpeed =
                math.max(
                    speed *
                    (1 - linearAlpha * 0.8),
                    35
                )
        end

        hrp.AssemblyLinearVelocity =
            Vector3.new(
                dir.X * curSpeed,

                math.clamp(
                    dir.Y * curSpeed,
                    -15,
                    150
                ),

                dir.Z * curSpeed
            )

        hrp.AssemblyAngularVelocity =
            Vector3.zero
    end

    --------------------------------------------------
    -- FINAL POSITION
    --------------------------------------------------

    hrp = findHRP()

    if not hrp then
        return "failed"
    end

    hrp.CFrame =
        CFrame.new(
            target.X,
            math.max(target.Y, 70),
            target.Z
        )

    hrp.AssemblyLinearVelocity =
        Vector3.zero

    hrp.AssemblyAngularVelocity =
        Vector3.zero

    return "arrived"
end

--------------------------------------------------
-- DIRECT FLY
--------------------------------------------------

local function TravelFlyDirect(
    targetPos,
    speed,
    isApproach,
    watchUid
)

    local hrp = findHRP()

    if not hrp or not targetPos then
        return "failed"
    end

    local startPos =
        hrp.Position

    local flyAltitude =
        math.max(
            startPos.Y,
            targetPos.Y,
            70.4
        ) + 28

    local totalDist =
        (targetPos - startPos).Magnitude

    --------------------------------------------------
    -- SHORT DISTANCE
    --------------------------------------------------

    if totalDist < 25 then

        return FlyToPoint(
            Vector3.new(
                targetPos.X,
                math.max(
                    targetPos.Y,
                    70
                ) + 1.2,
                targetPos.Z
            ),
            speed,
            isApproach == true,
            watchUid
        )
    end

    --------------------------------------------------
    -- CLIMB
    --------------------------------------------------

    local result =
        FlyToPoint(
            Vector3.new(
                startPos.X,
                flyAltitude,
                startPos.Z
            ),
            speed,
            false,
            watchUid
        )

    if result ~= "arrived" then
        return result
    end

    --------------------------------------------------
    -- FLY ACROSS
    --------------------------------------------------

    result =
        FlyToPoint(
            Vector3.new(
                targetPos.X,
                flyAltitude,
                targetPos.Z
            ),
            speed,
            false,
            watchUid
        )

    if result ~= "arrived" then
        return result
    end

    --------------------------------------------------
    -- DESCEND
    --------------------------------------------------

    return FlyToPoint(
        Vector3.new(
            targetPos.X,
            math.max(
                targetPos.Y,
                70
            ) + 1.2,
            targetPos.Z
        ),
        speed,
        isApproach == true,
        watchUid
    )
end

--------------------------------------------------
-- MOVE REPLACEMENT
--------------------------------------------------

local function moveTo(
    position,
    speed,
    watchUid
)

    if not farmegg then
        return "stopped"
    end

    return TravelFlyDirect(
        position,
        speed,
        true,
        watchUid
    )
end

--------------------------------------------------
-- CACHE PROXIMITY PROMPTS
--------------------------------------------------

local ProximityPrompts = {}

local function addPrompt(obj)

    if obj:IsA("ProximityPrompt") then
        ProximityPrompts[obj] = true
    end
end

for _, obj in ipairs(
    workspace:GetDescendants()
) do

    addPrompt(obj)
end

workspace.DescendantAdded:Connect(
    addPrompt
)

--------------------------------------------------
-- TRIGGER NEAREST PROMPT
--------------------------------------------------

local function TriggerNearestPrompt(
    targetPosition
)

    local character =
        player.Character

    if not character then
        return false
    end

    local root =
        character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not root then
        return false
    end

    local nearestPrompt
    local nearestDistance =
        math.huge

    for prompt in pairs(
        ProximityPrompts
    ) do

        if prompt.Parent
            and prompt.Enabled then

            local parent =
                prompt.Parent

            if parent:IsA("BasePart") then

                local distance =
                    (
                        targetPosition
                        - parent.Position
                    ).Magnitude

                if distance <
                    nearestDistance then

                    nearestDistance =
                        distance

                    nearestPrompt =
                        prompt
                end
            end
        end
    end

    if nearestPrompt then

        fireproximityprompt(
            nearestPrompt
        )

        return true
    end

    return false
end

--------------------------------------------------
-- PICK UP DROPPED EGG
--------------------------------------------------

local function pickUpDroppedEgg(uid)

    while farmegg do

        local eggData =
            getEggRecord(uid)

        if not eggData then
            return false
        end

        if eggData.State ~= "Dropped" then
            return true
        end

        if not eggData.BottomCFrame then
            return false
        end

        local position =
            eggData.BottomCFrame.Position

        local result =
            moveTo(
                position,
                GoSpeed,
                uid
            )

        if result == "stopped"
            or result == "failed"
            or result == "lost" then

            return false
        end

        if result == "dropped" then
            continue
        end

        if result == "arrived" then

            for _ = 1, 15 do

                if not farmegg then
                    return false
                end

                local currentEgg =
                    getEggRecord(uid)

                if not currentEgg then
                    return false
                end

                if currentEgg.State ~= "Dropped" then
                    return true
                end

                TriggerNearestPrompt(
                    position
                )

                task.wait(0.3)
            end
        end

        task.wait(0.05)
    end

    return false
end

--------------------------------------------------
-- WAIT FOR DROP
--------------------------------------------------

local function waitForDrop(uid)

    while farmegg do

        local eggData =
            getEggRecord(uid)

        if not eggData then
            return "lost"
        end

        if eggData.State == "Dropped" then
            return "dropped"
        end

        if not isHoldingEgg() then

            task.wait(0.1)

            local check =
                getEggRecord(uid)

            if not check then
                return "lost"
            end

            if check.State == "Dropped" then
                return "dropped"
            end
        end

        task.wait(0.05)
    end

    return "stopped"
end

--------------------------------------------------
-- RETURN EGG
--------------------------------------------------

local function returnEgg(uid)

    if returningEgg then
        return false
    end

    returningEgg = true

    currentEggUid = uid

    while farmegg do

        local result =
            moveTo(
                ReturnPosition,
                ReturnSpeed,
                uid
            )

        if result == "stopped"
            or result == "failed" then

            returningEgg = false
            return false
        end

        if result == "dropped" then

            print(
                "Egg dropped while returning:",
                uid
            )

            if not pickUpDroppedEgg(uid) then

                returningEgg = false
                return false
            end

            continue
        end

        if result == "lost" then

            returningEgg = false
            return false
        end

        if result == "arrived" then
            break
        end
    end

    if not farmegg then

        returningEgg = false
        return false
    end

    local character =
        player.Character

    if not character then

        returningEgg = false
        return false
    end

    local root =
        character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not root then

        returningEgg = false
        return false
    end

    root.AssemblyLinearVelocity =
        Vector3.zero

    root.AssemblyAngularVelocity =
        Vector3.zero

    root.CFrame =
        CFrame.new(
            SecondPosition
        )

    task.wait(0.15)

    local dropResult =
        waitForDrop(uid)

    if dropResult == "dropped" then

        print(
            "Egg dropped at second position:",
            uid
        )

        if not pickUpDroppedEgg(uid) then

            returningEgg = false
            return false
        end

        while farmegg do

            local result =
                moveTo(
                    ReturnPosition,
                    ReturnSpeed,
                    uid
                )

            if result == "stopped"
                or result == "failed" then

                returningEgg = false
                return false
            end

            if result == "lost" then

                returningEgg = false
                return false
            end

            if result == "dropped" then

                print(
                    "Egg dropped again while recovering:",
                    uid
                )

                if not pickUpDroppedEgg(uid) then

                    returningEgg = false
                    return false
                end

                continue
            end

            if result == "arrived" then
                break
            end
        end

        returningEgg = false
        return farmegg
    end

    if dropResult == "stopped" then

        returningEgg = false
        return false
    end

    if dropResult == "lost" then

        returningEgg = false
        return false
    end

    task.wait(0.2)

    local finalEgg =
        getEggRecord(uid)

    if not finalEgg then

        returningEgg = false
        return true
    end

    if finalEgg.State == "Dropped" then

        if not pickUpDroppedEgg(uid) then

            returningEgg = false
            return false
        end

        while farmegg do

            local result =
                moveTo(
                    ReturnPosition,
                    ReturnSpeed,
                    uid
                )

            if result == "stopped"
                or result == "failed"
                or result == "lost" then

                returningEgg = false
                return false
            end

            if result == "dropped" then

                if not pickUpDroppedEgg(uid) then

                    returningEgg = false
                    return false
                end

                continue
            end

            if result == "arrived" then

                returningEgg = false
                return true
            end
        end
    end

    returningEgg = false
    return true
end

--------------------------------------------------
-- RARITY ORDER
--------------------------------------------------

local rarityOrder = {

    Divine = 1,
    Eternal = 2,
    Secret = 3,
    Cosmic = 4,
    Mythic = 5,
    Legendary = 6,
    Epic = 7,
    Rare = 8
}

--------------------------------------------------
-- FIND BEST EGG
--------------------------------------------------

local function findBestEgg()

    local fieldData =
        EggState.ReadFieldEggs()

    if not fieldData
        or not fieldData.Records then

        return nil
    end

    local matchingEggs = {}

    for _, eggData in ipairs(
        fieldData.Records
    ) do

        if eggData.State == "Slot" then

            local config =
                Assets.Directory[
                    eggData.AssetCategory
                ]

            if config
                and config.Rarity then

                local rarity =
                    config.Rarity._id

                local area =
                    eggData.AreaId

                local raritySelected =
                    table.find(
                        Rlist,
                        rarity
                    )

                local areaSelected =
                    table.find(
                        Alist,
                        area
                    )

                if raritySelected
                    and areaSelected then

                    table.insert(
                        matchingEggs,
                        {
                            Data = eggData,

                            Rarity = rarity,

                            Priority =
                                rarityOrder[
                                    rarity
                                ]
                                or math.huge
                        }
                    )
                end
            end
        end
    end

    if #matchingEggs == 0 then
        return nil
    end

    table.sort(
        matchingEggs,
        function(a, b)

            if Priority == "Rarest" then

                return
                    a.Priority
                    < b.Priority

            else

                return
                    a.Priority
                    > b.Priority
            end
        end
    )

    return matchingEggs[1].Data
end

--------------------------------------------------
-- DROP GUI INSTANT RETURN
--------------------------------------------------

local function connectDropGui()

    if dropConnection then
        dropConnection:Disconnect()
        dropConnection = nil
    end

    local gui =
        getDropHeldEgg()

    if not gui then
        return
    end

    dropConnection =
        gui:GetPropertyChangedSignal(
            "Enabled"
        ):Connect(function()

            if not farmegg then
                return
            end

            if not gui.Enabled then
                return
            end

            if not currentEggUid then
                return
            end

            if returningEgg then
                return
            end

            task.spawn(function()

                print(
                    "DropHeldEgg Enabled -> INSTANT FLY",
                    currentEggUid
                )

                returnEgg(
                    currentEggUid
                )
            end)
        end)
end

--------------------------------------------------
-- CONNECT DROP GUI
--------------------------------------------------

task.spawn(function()

    local playerGui =
        player:WaitForChild(
            "PlayerGui"
        )

    local gui =
        playerGui:FindFirstChild(
            "DropHeldEgg"
        )

    if gui then
        connectDropGui()
    else

        local connection

        connection =
            playerGui.ChildAdded:Connect(
                function(child)

                    if child.Name ==
                        "DropHeldEgg" then

                        connection:Disconnect()

                        task.wait()

                        connectDropGui()
                    end
                end
            )
    end
end)

--------------------------------------------------
-- FARM ONE EGG
--------------------------------------------------

local function farmOneEgg()

    if not farmegg then
        return "stopped"
    end

    local eggData =
        findBestEgg()

    if not eggData then
        return "none"
    end

    local uid =
        eggData.Uid

    currentEggUid = uid

    local eggPosition =
        eggData.BottomCFrame.Position

    print(
        "TARGET:",
        eggData.AssetCategory,

        "RARITY:",
        Assets.Directory[
            eggData.AssetCategory
        ].Rarity._id,

        "AREA:",
        eggData.AreaId,

        "UID:",
        uid
    )

    --------------------------------------------------
    -- FLY TO EGG
    --------------------------------------------------

    local moveResult =
        moveTo(
            eggPosition,
            GoSpeed,
            uid
        )

    if moveResult == "stopped"
        or moveResult == "failed" then

        currentEggUid = nil
        return "failed"
    end

    if moveResult == "lost" then

        currentEggUid = nil
        return "lost"
    end

    if moveResult == "dropped" then

        if not pickUpDroppedEgg(uid) then

            currentEggUid = nil
            return "lost"
        end
    end

    --------------------------------------------------
    -- WAIT UNTIL EGG CHANGES
    --------------------------------------------------

    while farmegg do

        local currentEgg =
            getEggRecord(uid)

        if not currentEgg then

            currentEggUid = nil
            return "lost"
        end

        if currentEgg.State ~= "Slot" then
            break
        end

        TriggerNearestPrompt(
            eggPosition
        )

        task.wait(0.3)
    end

    if not farmegg then

        currentEggUid = nil
        return "stopped"
    end

    --------------------------------------------------
    -- WAIT FOR DROP GUI
    --
    -- IMPORTANT:
    -- No 0.3 second polling here.
    -- The Enabled signal handles it instantly.
    --------------------------------------------------

    while farmegg do

        if isHoldingEgg() then
            break
        end

        local currentEgg =
            getEggRecord(uid)

        if not currentEgg then

            currentEggUid = nil
            return "lost"
        end

        if currentEgg.State == "Dropped" then

            if not pickUpDroppedEgg(uid) then

                currentEggUid = nil
                return "lost"
            end

            break
        end

        TriggerNearestPrompt(
            eggPosition
        )

        task.wait(0.05)
    end

    if not farmegg then

        currentEggUid = nil
        return "stopped"
    end

    --------------------------------------------------
    -- IF GUI IS ALREADY ENABLED
    --
    -- The property signal only fires on a change,
    -- so handle the already-enabled case too.
    --------------------------------------------------

    if isHoldingEgg()
        and not returningEgg then

        task.spawn(function()

            returnEgg(
                uid
            )
        end)

        return "done"
    end

    --------------------------------------------------
    -- WAIT UNTIL RETURN HANDLER FINISHES
    --------------------------------------------------

    while farmegg
        and returningEgg do

        task.wait()
    end

    if not farmegg then

        currentEggUid = nil
        return "stopped"
    end

    currentEggUid = nil

    return "done"
end

--------------------------------------------------
-- AUTO FARM LOOP
--------------------------------------------------

task.spawn(function()

    while true do

        if not farmegg then

            task.wait(0.1)
            continue
        end

        local result =
            farmOneEgg()

        if result == "done" then

            task.wait(0.05)

        elseif result == "none" then

            task.wait(0.15)

        elseif result == "lost" then

            task.wait(0.1)

        else

            task.wait(0.1)
        end
    end
end)
