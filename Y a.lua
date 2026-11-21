local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Library = {}
Library.__index = Library

local TOGGLE_IMAGE = "https://raw.githubusercontent.com/tfcm279/-b3/main/%E7%BB%84%20(3).png"

local ICONS = {
    home = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/home.png",
    settings = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/settings.png",
    user = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/user.png",
    shield = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/shield.png",
    sword = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/sword.png",
    target = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/target.png",
    zap = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/zap.png",
    eye = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/eye.png",
    lock = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/lock.png",
    unlock = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/unlock.png",
    play = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/play.png",
    pause = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/pause.png",
    stop = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/square.png",
    refresh = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/refresh-cw.png",
    trash = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/trash-2.png",
    plus = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/plus.png",
    minus = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/minus.png",
    check = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/check.png",
    x = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/x.png",
    chevronDown = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/chevron-down.png",
    chevronRight = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/chevron-right.png",
    search = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/search.png",
    bell = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/bell.png",
    mail = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/mail.png",
    star = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/star.png",
    heart = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/heart.png",
    info = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/info.png",
    alert = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/alert-triangle.png",
    help = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/help-circle.png",
    folder = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/folder.png",
    file = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/file.png",
    link = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/link.png",
    wifi = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/wifi.png",
    battery = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/battery.png",
    sun = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/sun.png",
    moon = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/moon.png",
    cloud = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/cloud.png",
    code = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/code.png",
    terminal = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/terminal.png",
    database = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/database.png",
    server = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/server.png",
    globe = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/globe.png",
    map = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/map.png",
    compass = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/compass.png",
    key = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/key.png",
    cpu = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/cpu.png",
    monitor = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/monitor.png",
    smartphone = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/smartphone.png",
    camera = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/camera.png",
    music = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/music.png",
    video = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/video.png",
    image = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/image.png",
    download = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/download.png",
    upload = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/upload.png",
    copy = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/copy.png",
    edit = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/edit.png",
    save = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/save.png",
    filter = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/filter.png",
    sort = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/arrow-up-down.png",
    grid = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/grid.png",
    list = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/list.png",
    layers = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/layers.png",
    move = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/move.png",
    maximize = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/maximize.png",
    minimize = "https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/minimize.png",
}

local Theme = {
    Background = Color3.fromRGB(18, 18, 22),
    Surface = Color3.fromRGB(28, 28, 35),
    SurfaceLight = Color3.fromRGB(38, 38, 48),
    Primary = Color3.fromRGB(120, 160, 255),
    Secondary = Color3.fromRGB(180, 120, 255),
    Accent = Color3.fromRGB(80, 220, 200),
    Text = Color3.fromRGB(245, 245, 250),
    TextDim = Color3.fromRGB(160, 160, 175),
    Danger = Color3.fromRGB(255, 90, 90),
    Success = Color3.fromRGB(90, 220, 120),
    Warning = Color3.fromRGB(255, 190, 80),
    GlowColor = Color3.fromRGB(120, 160, 255),
    StrokeColor = Color3.fromRGB(255, 255, 255),
    StrokeTransparency = 0.75,
}

local function SafeParent()
    local ok, parent = pcall(function()
        return CoreGui
    end)
    if ok and parent then return parent end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local function Create(className, props)
    local inst = Instance.new(className)
    for key, value in pairs(props or {}) do
        inst[key] = value
    end
    return inst
end

local function AddCorner(parent, radius)
    local corner = Create("UICorner", { CornerRadius = UDim.new(0, radius or 8) })
    corner.Parent = parent
    return corner
end

local function AddPadding(parent, padding)
    local pad = Create("UIPadding", {
        PaddingTop = UDim.new(0, padding),
        PaddingBottom = UDim.new(0, padding),
        PaddingLeft = UDim.new(0, padding),
        PaddingRight = UDim.new(0, padding),
    })
    pad.Parent = parent
    return pad
end

local function CreateGradient(parent, color1, color2, rotation)
    local gradient = Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color1 or Theme.Primary),
            ColorSequenceKeypoint.new(1, color2 or Theme.Secondary),
        }),
        Rotation = rotation or 0,
    })
    gradient.Parent = parent
    return gradient
end

local function CreateGlowStroke(parent, color, thickness, transparency)
    local stroke = Create("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = color or Theme.GlowColor,
        Thickness = thickness or 2,
        Transparency = transparency or 0.6,
    })
    stroke.Parent = parent
    local gradient = Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.5, color or Theme.GlowColor),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
        }),
        Rotation = 45,
    })
    gradient.Parent = stroke
    return stroke, gradient
end

local function Tween(instance, time, goal, style, direction)
    local info = TweenInfo.new(
        time or 0.3,
        style or Enum.EasingStyle.Quint,
        direction or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(instance, info, goal)
    tween:Play()
    return tween
end

local function PulseGradient(gradient, speed)
    task.spawn(function()
        while gradient and gradient.Parent do
            gradient.Offset = Vector2.new(-1, 0)
            Tween(gradient, speed or 1.2, { Offset = Vector2.new(1, 0) }, Enum.EasingStyle.Linear)
            task.wait(speed or 1.2)
        end
    end)
end

local function PulseStroke(stroke, minT, maxT, speed)
    task.spawn(function()
        local dir = 1
        while stroke and stroke.Parent do
            local target = dir == 1 and maxT or minT
            Tween(stroke, speed or 0.8, { Transparency = target }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            dir = -dir
            task.wait(speed or 0.8)
        end
    end)
end

function Library.new(config)
    local self = setmetatable({}, Library)
    self.Config = config or {}
    self.Visible = false
    self.Tabs = {}
    self.CurrentTab = nil
    self.Connections = {}
    self.Gui = nil
    self.MainFrame = nil
    self.ToggleButton = nil
    self.IsDragging = false
    self.DragStart = nil
    self.StartPos = nil
    self:Build()
    return self
end

function Library:Build()
    local gui = Create("ScreenGui", {
        Name = "WindLikeUI_" .. tostring(math.random(1, 999999)),
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999,
    })
    gui.Parent = SafeParent()
    self.Gui = gui

    local toggleSize = 46
    local toggle = Create("ImageButton", {
        Name = "ToggleImage",
        Size = UDim2.fromOffset(toggleSize, toggleSize),
        Position = UDim2.new(0, 18, 0, 180),
        BackgroundTransparency = 1,
        Image = TOGGLE_IMAGE,
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        ImageTransparency = 0,
        AutoButtonColor = false,
        ZIndex = 50,
    })
    toggle.Parent = gui
    AddCorner(toggle, 10)
    self.ToggleButton = toggle

    local toggleGlow = CreateGlowStroke(toggle, Theme.GlowColor, 3, 0.7)
    PulseStroke(toggleGlow, 0.4, 0.8, 0.9)

    local main = Create("Frame", {
        Name = "MainFrame",
        Size = UDim2.fromOffset(360, 520),
        Position = UDim2.new(0, -400, 0.5, -260),
        BackgroundColor3 = Theme.Background,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 10,
        Visible = false,
    })
    main.Parent = gui
    AddCorner(main, 14)
    self.MainFrame = main

    local mainStroke, mainGrad = CreateGlowStroke(main, Theme.Primary, 3, 0.55)
    PulseGradient(mainGrad, 2.4)
    PulseStroke(mainStroke, 0.35, 0.75, 1.6)

    local mainGradient = CreateGradient(main, Theme.Background, Theme.Surface, 135)
    mainGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.02),
        NumberSequenceKeypoint.new(1, 0.18),
    })

    local header = Create("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 58),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        ZIndex = 11,
    })
    header.Parent = main
    AddCorner(header, 14)

    local headerGrad = CreateGradient(header, Theme.Surface, Theme.Background, 90)
    headerGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.05),
        NumberSequenceKeypoint.new(1, 0.35),
    })

    local title = Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -100, 1, 0),
        Position = UDim2.fromOffset(18, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = self.Config.Title or "WindUI",
        TextColor3 = Theme.Text,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 12,
    })
    title.Parent = header

    local closeBtn = Create("TextButton", {
        Name = "Close",
        Size = UDim2.fromOffset(34, 34),
        Position = UDim2.new(1, -44, 0, 12),
        BackgroundColor3 = Theme.SurfaceLight,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 12,
    })
    closeBtn.Parent = header
    AddCorner(closeBtn, 8)
    local closeStroke = CreateGlowStroke(closeBtn, Theme.Danger, 2, 0.7)
    PulseStroke(closeStroke, 0.5, 0.85, 1.1)

    local closeIcon = Create("ImageLabel", {
        Size = UDim2.fromOffset(18, 18),
        Position = UDim2.new(0.5, -9, 0.5, -9),
        BackgroundTransparency = 1,
        Image = ICONS.x,
        ImageColor3 = Theme.Danger,
        ZIndex = 13,
    })
    closeIcon.Parent = closeBtn

    local body = Create("Frame", {
        Name = "Body",
        Size = UDim2.new(1, -20, 1, -78),
        Position = UDim2.fromOffset(10, 68),
        BackgroundTransparency = 1,
        ZIndex = 11,
    })
    body.Parent = main
    self.Body = body

    local scroll = Create("ScrollingFrame", {
        Name = "Scroll",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Primary,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ZIndex = 12,
    })
    scroll.Parent = body
    self.Scroll = scroll

    local layout = Create("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    layout.Parent = scroll

    self:MakeDraggable(main, header)
    self:MakeToggle(toggle)
    self:MakeClose(closeBtn)
end

function Library:MakeDraggable(frame, handle)
    local dragging = false
    local dragInput, dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

function Library:MakeToggle(toggle)
    local clickable = false
    toggle.MouseEnter:Connect(function()
        Tween(toggle, 0.2, { Size = UDim2.fromOffset(50, 50) })
    end)
    toggle.MouseLeave:Connect(function()
        if not clickable then
            Tween(toggle, 0.2, { Size = UDim2.fromOffset(46, 46) })
        end
    end)
    toggle.MouseButton1Click:Connect(function()
        clickable = true
        self:Toggle()
        task.delay(0.25, function()
            clickable = false
            if not toggle:IsHovered() then
                Tween(toggle, 0.2, { Size = UDim2.fromOffset(46, 46) })
            end
        end)
    end)
    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            self:Toggle()
        end
    end)
end

function Library:MakeClose(btn)
    btn.MouseButton1Click:Connect(function()
        self:Hide()
    end)
end

function Library:Toggle()
    if self.Visible then
        self:Hide()
    else
        self:Show()
    end
end

function Library:Show()
    if self.Visible then return end
    self.Visible = true
    self.MainFrame.Visible = true
    self.MainFrame.Position = UDim2.new(0, -400, 0.5, -260)
    Tween(self.MainFrame, 0.45, { Position = UDim2.new(0, 18, 0.5, -260) }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    Tween(self.ToggleButton, 0.3, { ImageColor3 = Theme.Primary })
end

function Library:Hide()
    if not self.Visible then return end
    self.Visible = false
    local tween = Tween(self.MainFrame, 0.35, { Position = UDim2.new(0, -420, 0.5, -260) }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    tween.Completed:Connect(function()
        if not self.Visible then
            self.MainFrame.Visible = false
        end
    end)
    Tween(self.ToggleButton, 0.3, { ImageColor3 = Color3.fromRGB(255, 255, 255) })
end

function Library:AddTab(name, icon)
    local tab = { Name = name, Icon = icon, Buttons = {} }
    table.insert(self.Tabs, tab)
    if not self.CurrentTab then
        self.CurrentTab = tab
    end
    return tab
end

function Library:AddButton(tab, text, icon, callback)
    local btn = Create("TextButton", {
        Name = "Button_" .. tostring(#tab.Buttons + 1),
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 13,
    })
    btn.Parent = self.Scroll
    AddCorner(btn, 8)

    local stroke, grad = CreateGlowStroke(btn, Theme.Primary, 1.5, 0.8)
    PulseStroke(stroke, 0.6, 0.9, 1.4)

    local bgGrad = CreateGradient(btn, Theme.Surface, Theme.SurfaceLight, 0)
    bgGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(1, 0.35),
    })

    local iconImg = Create("ImageLabel", {
        Size = UDim2.fromOffset(20, 20),
        Position = UDim2.fromOffset(12, 10),
        BackgroundTransparency = 1,
        Image = ICONS[icon] or ICONS[icon:lower()] or ICONS.info,
        ImageColor3 = Theme.Primary,
        ZIndex = 14,
    })
    iconImg.Parent = btn

    local label = Create("TextLabel", {
        Size = UDim2.new(1, -46, 1, 0),
        Position = UDim2.fromOffset(42, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 14,
    })
    label.Parent = btn

    btn.MouseEnter:Connect(function()
        Tween(btn, 0.2, { BackgroundColor3 = Theme.SurfaceLight, BackgroundTransparency = 0.05 })
        Tween(iconImg, 0.2, { ImageColor3 = Theme.Accent })
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, 0.2, { BackgroundColor3 = Theme.Surface, BackgroundTransparency = 0.15 })
        Tween(iconImg, 0.2, { ImageColor3 = Theme.Primary })
    end)
    btn.MouseButton1Click:Connect(function()
        if callback then
            task.spawn(callback)
        end
    end)

    table.insert(tab.Buttons, btn)
    return btn
end

function Library:AddToggle(tab, text, default, callback)
    local state = default or false
    local container = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        ZIndex = 13,
    })
    container.Parent = self.Scroll
    AddCorner(container, 8)

    local label = Create("TextLabel", {
        Size = UDim2.new(1, -70, 1, 0),
        Position = UDim2.fromOffset(12, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 14,
    })
    label.Parent = container

    local switch = Create("Frame", {
        Size = UDim2.fromOffset(44, 24),
        Position = UDim2.new(1, -56, 0.5, -12),
        BackgroundColor3 = state and Theme.Success or Theme.SurfaceLight,
        BackgroundTransparency = state and 0 or 0.2,
        BorderSizePixel = 0,
        ZIndex = 14,
    })
    switch.Parent = container
    AddCorner(switch, 12)

    local knob = Create("Frame", {
        Size = UDim2.fromOffset(18, 18),
        Position = state and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3),
        BackgroundColor3 = Theme.Text,
        BorderSizePixel = 0,
        ZIndex = 15,
    })
    knob.Parent = switch
    AddCorner(knob, 9)

    local function setState(newState)
        state = newState
        Tween(switch, 0.2, {
            BackgroundColor3 = state and Theme.Success or Theme.SurfaceLight,
            BackgroundTransparency = state and 0 or 0.2,
        })
        Tween(knob, 0.2, { Position = state and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3) })
        if callback then task.spawn(callback, state) end
    end

    switch.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            setState(not state)
        end
    end)

    table.insert(tab.Buttons, container)
    return container
end

function Library:AddSlider(tab, text, min, max, default, callback)
    local value = default or min
    local container = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        ZIndex = 13,
    })
    container.Parent = self.Scroll
    AddCorner(container, 8)

    local label = Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 24),
        Position = UDim2.fromOffset(12, 4),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = text .. "  [" .. tostring(value) .. "]",
        TextColor3 = Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 14,
    })
    label.Parent = container

    local bar = Create("Frame", {
        Size = UDim2.new(1, -24, 0, 6),
        Position = UDim2.fromOffset(12, 34),
        BackgroundColor3 = Theme.SurfaceLight,
        BorderSizePixel = 0,
        ZIndex = 14,
    })
    bar.Parent = container
    AddCorner(bar, 3)

    local fill = Create("Frame", {
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = Theme.Primary,
        BorderSizePixel = 0,
        ZIndex = 15,
    })
    fill.Parent = bar
    AddCorner(fill, 3)

    local fillGrad = CreateGradient(fill, Theme.Primary, Theme.Secondary, 0)
    PulseGradient(fillGrad, 2.0)

    local dragging = false

    local function update(input)
        local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        value = math.floor(min + (max - min) * rel + 0.5)
        label.Text = text .. "  [" .. tostring(value) .. "]"
        Tween(fill, 0.1, { Size = UDim2.new(rel, 0, 1, 0) })
        if callback then task.spawn(callback, value) end
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    table.insert(tab.Buttons, container)
    return container
end

function Library:AddDropdown(tab, text, options, default, callback)
    local selected = default or options[1]
    local expanded = false
    local container = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 13,
    })
    container.Parent = self.Scroll
    AddCorner(container, 8)

    local header = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 14,
    })
    header.Parent = container

    local label = Create("TextLabel", {
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.fromOffset(12, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = text .. ": " .. tostring(selected),
        TextColor3 = Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 15,
    })
    label.Parent = header

    local arrow = Create("ImageLabel", {
        Size = UDim2.fromOffset(18, 18),
        Position = UDim2.new(1, -30, 0.5, -9),
        BackgroundTransparency = 1,
        Image = ICONS.chevronDown,
        ImageColor3 = Theme.TextDim,
        ZIndex = 15,
    })
    arrow.Parent = header

    local list = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.fromOffset(0, 42),
        BackgroundColor3 = Theme.Background,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 13,
    })
    list.Parent = container
    AddCorner(list, 8)

    local listLayout = Create("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    listLayout.Parent = list
    AddPadding(list, 6)

    for _, option in ipairs(options) do
        local optionBtn = Create("TextButton", {
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundColor3 = Theme.Surface,
            BackgroundTransparency = 0.2,
            BorderSizePixel = 0,
            Font = Enum.Font.Gotham,
            Text = tostring(option),
            TextColor3 = Theme.Text,
            TextSize = 13,
            AutoButtonColor = false,
            ZIndex = 14,
        })
        optionBtn.Parent = list
        AddCorner(optionBtn, 6)

        optionBtn.MouseEnter:Connect(function()
            Tween(optionBtn, 0.15, { BackgroundColor3 = Theme.SurfaceLight, BackgroundTransparency = 0 })
        end)
        optionBtn.MouseLeave:Connect(function()
            Tween(optionBtn, 0.15, { BackgroundColor3 = Theme.Surface, BackgroundTransparency = 0.2 })
        end)
        optionBtn.MouseButton1Click:Connect(function()
            selected = option
            label.Text = text .. ": " .. tostring(selected)
            expanded = false
            Tween(container, 0.25, { Size = UDim2.new(1, 0, 0, 40) })
            Tween(list, 0.25, { Size = UDim2.new(1, 0, 0, 0) })
            Tween(arrow, 0.2, { Rotation = 0 })
            if callback then task.spawn(callback, selected) end
        end)
    end

    header.MouseButton1Click:Connect(function()
        expanded = not expanded
        local targetH = expanded and (42 + #options * 34 + 12) or 40
        Tween(container, 0.25, { Size = UDim2.new(1, 0, 0, targetH) })
        Tween(list, 0.25, { Size = UDim2.new(1, 0, 0, expanded and (#options * 34 + 12) or 0) })
        Tween(arrow, 0.2, { Rotation = expanded and 180 or 0 })
    end)

    table.insert(tab.Buttons, container)
    return container
end

function Library:AddLabel(tab, text)
    local label = Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = Theme.TextDim,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 13,
    })
    label.Parent = self.Scroll
    AddPadding(label, 4)
    table.insert(tab.Buttons, label)
    return label
end

function Library:AddDivider(tab)
    local line = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Theme.SurfaceLight,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        ZIndex = 13,
    })
    line.Parent = self.Scroll
    table.insert(tab.Buttons, line)
    return line
end

function Library:Notify(title, text, duration)
    local notif = Create("Frame", {
        Size = UDim2.fromOffset(280, 70),
        Position = UDim2.new(0.5, -140, 1, 30),
        BackgroundColor3 = Theme.Surface,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        ZIndex = 100,
    })
    notif.Parent = self.Gui
    AddCorner(notif, 10)

    local stroke = CreateGlowStroke(notif, Theme.Primary, 2, 0.5)
    PulseStroke(stroke, 0.3, 0.7, 0.8)

    local nTitle = Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 24),
        Position = UDim2.fromOffset(10, 6),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 101,
    })
    nTitle.Parent = notif

    local nText = Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.fromOffset(10, 28),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = Theme.TextDim,
        TextSize = 13,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 101,
    })
    nText.Parent = notif

    Tween(notif, 0.4, { Position = UDim2.new(0.5, -140, 1, -90) }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    task.delay(duration or 3, function()
        if notif and notif.Parent then
            local out = Tween(notif, 0.3, { Position = UDim2.new(0.5, -140, 1, 30) }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            out.Completed:Connect(function()
                notif:Destroy()
            end)
        end
    end)
end

return Library
