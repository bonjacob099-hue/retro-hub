--[[
    ================================================================
    RETRO GUI HUB (Pro Categorized Edition + Jump Power & Custom Logo)
    ================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

----------------------------------------------------------------
-- FEATURE STATE SETTINGS
----------------------------------------------------------------
local Settings = {
    AimbotEnabled = false,
    WallCheck = true,
    FOVRadius = 120,
    ESPEnabled = false,
    TracersEnabled = false,
    CustomSpeed = 16,
    CustomJump = 50
}

----------------------------------------------------------------
-- UTILITY FUNCTIONS (Dragging & Mobile Support)
----------------------------------------------------------------
local function makeDraggable(guiObject)
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        guiObject.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    guiObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

local function isEnemy(player)
    if not player or player == LocalPlayer then return false end
    if LocalPlayer.Team and player.Team then
        return LocalPlayer.Team ~= player.Team
    end
    return true
end

----------------------------------------------------------------
-- PROFESSIONAL UI CREATION
----------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RETRO_Hub_Pro"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- MAIN HUB CONTAINER
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 480)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainUICorner = Instance.new("UICorner")
MainUICorner.CornerRadius = UDim.new(0, 14)
MainUICorner.Parent = MainFrame

local MainUIStroke = Instance.new("UIStroke")
MainUIStroke.Color = Color3.fromRGB(40, 40, 50)
MainUIStroke.Thickness = 1.8
MainUIStroke.Parent = MainFrame

makeDraggable(MainFrame)

-- TOP HEADER
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 46)
Header.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 10)
HeaderFix.Position = UDim2.new(0, 0, 1, -10)
HeaderFix.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "RETRO HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.Parent = Header

-- MINIMIZE (X) BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseButton"
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -40, 0, 7)
CloseBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 13
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- ================================================================
-- UPGRADED PROFESSIONAL FLOATING MINIMIZED LOGO (ORANGE 'R')
-- ================================================================
local MiniButton = Instance.new("TextButton")
MiniButton.Name = "MiniButton"
MiniButton.Size = UDim2.new(0, 54, 0, 54)
MiniButton.Position = UDim2.new(0.05, 0, 0.2, 0)
MiniButton.BackgroundColor3 = Color3.fromRGB(255, 110, 0)
MiniButton.Text = ""
MiniButton.Visible = false
MiniButton.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 14)
MiniCorner.Parent = MiniButton

-- Gradient Overlay for Professional Polish
local MiniGradient = Instance.new("UIGradient")
MiniGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 130, 10)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(230, 80, 0))
})
MiniGradient.Rotation = 45
MiniGradient.Parent = MiniButton

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = Color3.fromRGB(255, 200, 150)
MiniStroke.Thickness = 2
MiniStroke.Parent = MiniButton

local MiniText = Instance.new("TextLabel")
MiniText.Size = UDim2.new(1, 0, 1, 0)
MiniText.BackgroundTransparency = 1
MiniText.Text = "R"
MiniText.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniText.Font = Enum.Font.GothamBlack
MiniText.TextSize = 28
MiniText.Parent = MiniButton

makeDraggable(MiniButton)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniButton.Visible = true
end)

MiniButton.MouseButton1Click:Connect(function()
    MiniButton.Visible = false
    MainFrame.Visible = true
end)

-- SCROLLING CONTAINER FOR CATEGORIES
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -24, 1, -100)
Container.Position = UDim2.new(0, 12, 0, 52)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 3
Container.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 60)
Container.CanvasSize = UDim2.new(0, 0, 0, 480)
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 10)
UIList.Parent = Container

----------------------------------------------------------------
-- UI COMPONENT BUILDERS (Category Headers & Controls)
----------------------------------------------------------------
local function createCategoryHeader(titleText)
    local HeaderLabel = Instance.new("TextLabel")
    HeaderLabel.Size = UDim2.new(1, -4, 0, 26)
    HeaderLabel.BackgroundTransparency = 1
    HeaderLabel.Text = "  " .. string.upper(titleText)
    HeaderLabel.TextColor3 = Color3.fromRGB(255, 120, 0) -- Orange accent
    HeaderLabel.Font = Enum.Font.GothamBold
    HeaderLabel.TextSize = 12
    HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
    HeaderLabel.Parent = Container
end

local function createToggle(name, defaultState, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -4, 0, 42)
    Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    Frame.Parent = Container

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(32, 32, 40)
    Stroke.Thickness = 1
    Stroke.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 200, 1, 0)
    Label.Position = UDim2.new(0, 14, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(210, 210, 220)
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 42, 0, 22)
    Switch.Position = UDim2.new(1, -52, 0.5, -11)
    Switch.BackgroundColor3 = defaultState and Color3.fromRGB(230, 45, 45) or Color3.fromRGB(40, 40, 48)
    Switch.Text = ""
    Switch.Parent = Frame

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = Switch

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = defaultState and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = Switch

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    local state = defaultState
    Switch.MouseButton1Click:Connect(function()
        state = not state
        local targetBg = state and Color3.fromRGB(230, 45, 45) or Color3.fromRGB(40, 40, 48)
        local targetKnob = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)

        TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = targetBg}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {Position = targetKnob}):Play()

        callback(state)
    end)
end

local function createSlider(name, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -4, 0, 52)
    Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    Frame.Parent = Container

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(32, 32, 40)
    Stroke.Thickness = 1
    Stroke.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -24, 0, 20)
    Label.Position = UDim2.new(0, 14, 0, 6)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. tostring(default)
    Label.TextColor3 = Color3.fromRGB(210, 210, 220)
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local SliderBar = Instance.new("TextButton")
    SliderBar.Size = UDim2.new(1, -28, 0, 6)
    SliderBar.Position = UDim2.new(0, 14, 0, 34)
    SliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    SliderBar.Text = ""
    SliderBar.Parent = Frame

    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(1, 0)
    SliderCorner.Parent = SliderBar

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(230, 45, 45)
    Fill.Parent = SliderBar

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = Fill

    local dragging = false
    local function updateSlider(input)
        local posX = math.clamp(input.Position.X - SliderBar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
        local percentage = posX / SliderBar.AbsoluteSize.X
        local value = math.floor(min + (max - min) * percentage)
        
        Fill.Size = UDim2.new(percentage, 0, 1, 0)
        Label.Text = name .. ": " .. tostring(value)
        callback(value)
    end

    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
end

----------------------------------------------------------------
-- POPULATE CATEGORIES & CONTROLS
----------------------------------------------------------------

-- CATEGORY: AIMBOT
createCategoryHeader("Aimbot & Visuals")
createToggle("Enemy Aimbot", Settings.AimbotEnabled, function(val) Settings.AimbotEnabled = val end)
createToggle("Aimbot Wall Check", Settings.WallCheck, function(val) Settings.WallCheck = val end)
createSlider("FOV Radius", 30, 300, Settings.FOVRadius, function(val) Settings.FOVRadius = val end)
createToggle("Red Enemy ESP", Settings.ESPEnabled, function(val) Settings.ESPEnabled = val end)
createToggle("Red Enemy Tracers", Settings.TracersEnabled, function(val) Settings.TracersEnabled = val end)

-- CATEGORY: LOCAL PLAYER
createCategoryHeader("Local Player")
createSlider("Walk Speed", 16, 120, Settings.CustomSpeed, function(val) Settings.CustomSpeed = val end)
createSlider("Jump Power", 50, 200, Settings.CustomJump, function(val) Settings.CustomJump = val end)

----------------------------------------------------------------
-- RAINBOW FOOTER
----------------------------------------------------------------
local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, 0, 0, 38)
Footer.Position = UDim2.new(0, 0, 1, -38)
Footer.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
Footer.BorderSizePixel = 0
Footer.Parent = MainFrame

local FooterCorner = Instance.new("UICorner")
FooterCorner.CornerRadius = UDim.new(0, 14)
FooterCorner.Parent = Footer

local FooterFix = Instance.new("Frame")
FooterFix.Size = UDim2.new(1, 0, 0, 10)
FooterFix.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
FooterFix.BorderSizePixel = 0
FooterFix.Parent = Footer

local FooterText = Instance.new("TextLabel")
FooterText.Size = UDim2.new(1, 0, 1, 0)
FooterText.BackgroundTransparency = 1
FooterText.Text = "R E T R O"
FooterText.Font = Enum.Font.GothamBlack
FooterText.TextSize = 15
FooterText.Parent = Footer

RunService.RenderStepped:Connect(function()
    local hue = (tick() % 3) / 3
    FooterText.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
end)

----------------------------------------------------------------
-- DRAWING FOV CIRCLE
----------------------------------------------------------------
local FOVCircle
if Drawing then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = 1.5
    FOVCircle.Color = Color3.fromRGB(255, 255, 255)
    FOVCircle.Transparency = 0.6
    FOVCircle.Filled = false
    FOVCircle.Visible = false
end

----------------------------------------------------------------
-- ESP HIGHLIGHT MANAGEMENT
----------------------------------------------------------------
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "RETRO_ESP"
ESPFolder.Parent = Workspace

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if isEnemy(player) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local highlight = ESPFolder:FindFirstChild(player.Name)
            if Settings.ESPEnabled then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = player.Name
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(150, 0, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = ESPFolder
                end
                highlight.Adornee = player.Character
            else
                if highlight then highlight:Destroy() end
            end
        else
            local highlight = ESPFolder:FindFirstChild(player.Name)
            if highlight then highlight:Destroy() end
        end
    end
end

----------------------------------------------------------------
-- RAYCAST WALL CHECK LOGIC
----------------------------------------------------------------
local function hasLineOfSight(targetCharacter)
    if not targetCharacter or not targetCharacter:FindFirstChild("Head") then return false end
    
    local origin = Camera.CFrame.Position
    local targetPos = targetCharacter.Head.Position
    local direction = targetPos - origin

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    
    local ignoreList = {LocalPlayer.Character, targetCharacter, ESPFolder}
    raycastParams.FilterDescendantsInstances = ignoreList

    local result = Workspace:Raycast(origin, direction, raycastParams)
    return result == nil
end

----------------------------------------------------------------
-- MAIN RENDER STEP LOOP
----------------------------------------------------------------
local Lines = {}

local function getClosestEnemyInFOV()
    local closestPlayer = nil
    local shortestDistance = Settings.FOVRadius
    local centerScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if isEnemy(player) and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)

            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - centerScreen).Magnitude
                if dist < shortestDistance then
                    if not Settings.WallCheck or hasLineOfSight(player.Character) then
                        shortestDistance = dist
                        closestPlayer = player
                    end
                end
            end
        end
    end
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    -- Lock FOV Circle dead center
    if FOVCircle then
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        FOVCircle.Radius = Settings.FOVRadius
        FOVCircle.Visible = Settings.AimbotEnabled
    end

    -- Run Aimbot
    if Settings.AimbotEnabled then
        local target = getClosestEnemyInFOV()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
        end
    end

    -- Apply Speed & Jump Customizations Dynamically
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        humanoid.WalkSpeed = Settings.CustomSpeed
        
        -- Handle both JumpPower and JumpHeight property styles across roblox games
        pcall(function()
            humanoid.UseJumpPower = true
            humanoid.JumpPower = Settings.CustomJump
        end)
    end

    -- Run ESP Updates
    updateESP()

    -- Run Tracers Logic
    if Drawing then
        if Settings.TracersEnabled then
            local index = 1
            local screenBottom = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)

            for _, player in ipairs(Players:GetPlayers()
