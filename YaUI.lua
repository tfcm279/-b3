local YAGUI = {}
YAGUI.Version = "1.0.0"

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local INFO_FAST = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local INFO_PANEL = TweenInfo.new(0.32, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local THEME_KEYS = {
    "Window", "Panel", "Element", "ElementHover", "Text", "SubText",
    "Outline", "Accent", "Risk",
}

YAGUI.Themes = {
    YAG = {
        Window       = Color3.fromRGB(10, 88, 55),
        Panel        = Color3.fromRGB(7, 68, 43),
        Element      = Color3.fromRGB(13, 104, 66),
        ElementHover = Color3.fromRGB(18, 130, 82),
        Text         = Color3.fromRGB(255, 255, 255),
        SubText      = Color3.fromRGB(169, 229, 195),
        Outline      = Color3.fromRGB(76, 255, 122),
        Accent       = Color3.fromRGB(76, 255, 122),
        Risk         = Color3.fromRGB(255, 107, 107),
    },
    Dark = {
        Window       = Color3.fromRGB(24, 24, 28),
        Panel        = Color3.fromRGB(18, 18, 22),
        Element      = Color3.fromRGB(39, 39, 46),
        ElementHover = Color3.fromRGB(58, 58, 68),
        Text         = Color3.fromRGB(255, 255, 255),
        SubText      = Color3.fromRGB(160, 160, 172),
        Outline      = Color3.fromRGB(90, 90, 104),
        Accent       = Color3.fromRGB(124, 92, 252),
        Risk         = Color3.fromRGB(244, 71, 50),
    },
    Light = {
        Window       = Color3.fromRGB(245, 246, 248),
        Panel        = Color3.fromRGB(236, 238, 242),
        Element      = Color3.fromRGB(255, 255, 255),
        ElementHover = Color3.fromRGB(232, 240, 236),
        Text         = Color3.fromRGB(28, 32, 30),
        SubText      = Color3.fromRGB(110, 120, 115),
        Outline      = Color3.fromRGB(200, 210, 205),
        Accent       = Color3.fromRGB(16, 150, 90),
        Risk         = Color3.fromRGB(220, 60, 60),
    },
    Ocean = {
        Window       = Color3.fromRGB(12, 32, 56),
        Panel        = Color3.fromRGB(9, 25, 45),
        Element      = Color3.fromRGB(18, 48, 80),
        ElementHover = Color3.fromRGB(26, 66, 108),
        Text         = Color3.fromRGB(240, 248, 255),
        SubText      = Color3.fromRGB(150, 190, 225),
        Outline      = Color3.fromRGB(64, 156, 255),
        Accent       = Color3.fromRGB(64, 200, 255),
        Risk         = Color3.fromRGB(255, 110, 110),
    },
}

YAGUI.CurrentTheme = "YAG"
YAGUI._windows = {}
YAGUI.CurrentWindow = nil

local function currentPalette()
    return YAGUI.Themes[YAGUI.CurrentTheme] or YAGUI.Themes.YAG
end

function YAGUI:AddTheme(name, palette)
    assert(type(name) == "string" and type(palette) == "table", "YAGUI:AddTheme(name, table)")
    local base = YAGUI.Themes.YAG
    local theme = {}
    for _, key in ipairs(THEME_KEYS) do
        theme[key] = palette[key] or base[key]
    end
    YAGUI.Themes[name] = theme
    return theme
end

function YAGUI:GetThemes()
    local names = {}
    for name in pairs(YAGUI.Themes) do
        table.insert(names, name)
    end
    table.sort(names)
    return names
end

function YAGUI:GetCurrentTheme()
    return YAGUI.CurrentTheme
end

function YAGUI:SetTheme(name)
    if not YAGUI.Themes[name] then
        warn("[YAGUI] 主题不存在: " .. tostring(name))
        return
    end
    YAGUI.CurrentTheme = name
    local palette = YAGUI.Themes[name]
    for _, window in ipairs(YAGUI._windows) do
        for _, b in ipairs(window._colorBinds) do
            if b.Object and b.Object.Parent ~= nil then
                local ok = pcall(function()
                    TweenService:Create(b.Object, INFO_FAST, { [b.Property] = palette[b.Role] }):Play()
                end)
                if not ok then
                    b.Object[b.Property] = palette[b.Role]
                end
            end
        end
        for _, refresh in ipairs(window._refreshers or {}) do
            pcall(refresh)
        end
        local selected = window._selectedTab
        if selected and selected._button and selected._button.Parent then
            selected._button.BackgroundColor3 = palette.ElementHover
            selected._button.TextColor3 = palette.Text
        end
    end
end

local function make(className, props, parent)
    local obj = Instance.new(className)
    for key, value in pairs(props or {}) do
        if key ~= "Parent" then
            obj[key] = value
        end
    end
    obj.Parent = parent or (props and props.Parent) or nil
    return obj
end

local function tween(obj, info, goal)
    local t = TweenService:Create(obj, info or INFO_FAST, goal)
    t:Play()
    return t
end

local function fire(fn, ...)
    if type(fn) ~= "function" then return end
    local args = { ... }
    task.spawn(function()
        local ok, err = pcall(fn, unpack(args))
        if not ok then
            warn("[YAGUI] 回调出错: " .. tostring(err))
        end
    end)
end

local function bind(window, object, property, role)
    object[property] = currentPalette()[role]
    table.insert(window._colorBinds, { Object = object, Property = property, Role = role })
end

local function cfgTitle(cfg)
    return cfg.Title or cfg.Name or ""
end

local function cfgDefault(cfg, fallback)
    if cfg.Default ~= nil then return cfg.Default end
    if cfg.Value ~= nil and type(cfg.Value) ~= "table" then return cfg.Value end
    return fallback
end

local function getGuiParent(cfg)
    if cfg.Parent then return cfg.Parent end
    if type(gethui) == "function" then
        local ok, res = pcall(gethui)
        if ok and res then return res end
    end
    if LocalPlayer then
        return LocalPlayer:WaitForChild("PlayerGui")
    end
    return game:GetService("CoreGui")
end

local function hasFileAPI()
    return type(writefile) == "function"
        and type(readfile) == "function"
        and type(isfile) == "function"
        and type(makefolder) == "function"
end

function YAGUI:CreateWindow(config)
    config = config or {}
    if config.Theme and YAGUI.Themes[config.Theme] then
        YAGUI.CurrentTheme = config.Theme
    end

    local Window = {}
    Window._connections = {}
    Window._colorBinds = {}
    Window._flags = {}
    Window._tabs = {}
    Window._notifications = {}
    Window._events = { Open = {}, Close = {}, Destroy = {} }
    Window._refreshers = {}
    Window._selectedTab = nil
    Window._folder = config.Folder or "YAGUI"
    Window._minSize = config.MinSize or Vector2.new(420, 280)
    Window._maxSize = config.MaxSize or Vector2.new(1100, 760)
    Window._activeSlider = nil
    Window._openDropdown = nil
    Window._destroyed = false
    Window.Flags = {}
    Window.ConfigManager = {}

    function Window:_track(conn)
        table.insert(self._connections, conn)
        return conn
    end

    function Window:_fireEvent(name, ...)
        for _, fn in ipairs(self._events[name] or {}) do
            fire(fn, ...)
        end
    end

    function Window:_registerFlag(flag, getter, setter)
        if not flag or flag == "" then return end
        self._flags[flag] = { Get = getter, Set = setter }
    end

    function Window:_registerRefresh(fn)
        table.insert(self._refreshers, fn)
    end

    local parent = getGuiParent(config)
    local gui = make("ScreenGui", {
        Name = "YAGUI_" .. tostring(config.Title or "Window"),
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = config.DisplayOrder or 999,
    }, parent)
    Window._gui = gui

    local size = config.Size or UDim2.fromOffset(620, 420)
    local w = math.clamp(size.X.Offset, Window._minSize.X, Window._maxSize.X)
    local h = math.clamp(size.Y.Offset, Window._minSize.Y, Window._maxSize.Y)
    size = UDim2.fromOffset(w, h)
    local startPos = config.Position or UDim2.new(0.5, -w / 2, 0.5, -h / 2)
    local font = config.Font or Enum.Font.GothamMedium
    local T = currentPalette()

    local main = make("CanvasGroup", {
        Name = "Main",
        Size = size,
        Position = startPos,
        BackgroundColor3 = T.Window,
        BorderSizePixel = 0,
        GroupTransparency = 1,
        ClipsDescendants = false,
    }, gui)
    Window._main = main
    make("UICorner", { CornerRadius = UDim.new(0, 14) }, main)
    local mainStroke = make("UIStroke", { Color = T.Outline, Thickness = 2 }, main)
    bind(Window, main, "BackgroundColor3", "Window")
    bind(Window, mainStroke, "Color", "Outline")

    local barH = config.TopBarHeight or 44
    local topbar = make("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, barH),
        BackgroundTransparency = 1,
    }, main)

    local titleLabel = make("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -150, 1, 0),
        Position = UDim2.fromOffset(16, 0),
        BackgroundTransparency = 1,
        Text = config.Title or "yag ui",
        Font = font,
        TextSize = 20,
        TextColor3 = T.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 2,
    }, topbar)
    bind(Window, titleLabel, "TextColor3", "Text")

    local function makeBarButton(symbol, xOffset)
        local btn = make("TextButton", {
            Name = "BarButton",
            Size = UDim2.fromOffset(32, 32),
            Position = UDim2.new(1, xOffset, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Text = symbol,
            Font = Enum.Font.GothamBold,
            TextSize = 22,
            TextColor3 = T.Text,
            AutoButtonColor = false,
            ZIndex = 4,
        }, topbar)
        bind(Window, btn, "TextColor3", "Text")
        btn.MouseEnter:Connect(function()
            tween(btn, INFO_FAST, { TextTransparency = 0.35 })
        end)
        btn.MouseLeave:Connect(function()
            tween(btn, INFO_FAST, { TextTransparency = 0 })
        end)
        return btn
    end

    local maxBtn = makeBarButton("□", -72)
    local closeBtn = makeBarButton("×", -32)

    local dragHandle = make("Frame", {
        Name = "DragHandle",
        Size = UDim2.new(1, -128, 1, 0),
        BackgroundTransparency = 1,
        Active = true,
        ZIndex = 3,
    }, topbar)

    local body = make("Frame", {
        Name = "Body",
        Size = UDim2.new(1, 0, 1, -barH),
        Position = UDim2.fromOffset(0, barH),
        BackgroundTransparency = 1,
    }, main)
    Window._body = body

    local sidebarW = config.SideBarWidth or 168
    local sidebar = make("ScrollingFrame", {
        Name = "Sidebar",
        Size = UDim2.new(0, sidebarW, 1, 0),
        Position = UDim2.fromOffset(0, 0),
        BackgroundColor3 = T.Panel,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
    }, body)
    bind(Window, sidebar, "BackgroundColor3", "Panel")
    local tabLayout = make("UIListLayout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, sidebar)
    make("UIPadding", {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
    }, sidebar)
    Window:_track(tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sidebar.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 20)
    end))
    bind(Window, sidebar, "ScrollBarImageColor3", "Outline")

    local content = make("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -sidebarW, 1, 0),
        Position = UDim2.fromOffset(sidebarW, 0),
        BackgroundTransparency = 1,
    }, body)
    Window._content = content

    local notifHolder = make("Frame", {
        Name = "Notifications",
        Size = UDim2.fromOffset(288, 0),
        Position = UDim2.new(1, -300, 0, 20),
        BackgroundTransparency = 1,
        ZIndex = 30,
    }, gui)
    make("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
    }, notifHolder)
    Window._notifHolder = notifHolder

    if config.Draggable ~= false then
        local dragging, dragInput, dragStart, startFramePos, startAbs = false, nil, nil, nil, nil

        Window:_track(dragHandle.InputBegan:Connect(function(input)
            if Window._destroyed then return end
            if input.UserInputType ~= Enum.UserInputType.MouseButton1
                and input.UserInputType ~= Enum.UserInputType.Touch then return end
            dragging = true
            dragInput = input
            dragStart = input.Position
            startFramePos = main.Position
            startAbs = main.AbsolutePosition
            local conn
            conn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    conn:Disconnect()
                end
            end)
            Window:_track(conn)
        end))

        Window:_track(UserInputService.InputChanged:Connect(function(input)
            if not dragging or Window._destroyed then return end
            if input ~= dragInput and input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
            if input.UserInputType ~= Enum.UserInputType.MouseMovement
                and input.UserInputType ~= Enum.UserInputType.Touch then return end

            local delta = input.Position - dragStart
            local vp = workspace.CurrentCamera.ViewportSize
            local sz = main.AbsoluteSize
            local minDX, maxDX = -startAbs.X, vp.X - sz.X - startAbs.X
            local minDY, maxDY = -startAbs.Y, vp.Y - sz.Y - startAbs.Y
            local dx = math.clamp(delta.X, minDX, math.max(minDX, maxDX))
            local dy = math.clamp(delta.Y, minDY, math.max(minDY, maxDY))
            main.Position = UDim2.new(
                startFramePos.X.Scale, startFramePos.X.Offset + dx,
                startFramePos.Y.Scale, startFramePos.Y.Offset + dy
            )
        end))

        Window:_track(UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end))
    end

    Window:_track(UserInputService.InputChanged:Connect(function(input)
        if Window._activeSlider and not Window._destroyed then
            if input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch then
                Window._activeSlider(input)
            end
        end
    end))

    Window:_track(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            Window._activeSlider = nil
        end
    end))

    Window._toggleKey = config.ToggleKey
    Window:_track(UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if Window._destroyed then return end
        if not gameProcessed and Window._toggleKey
            and input.UserInputType == Enum.UserInputType.Keyboard
            and input.KeyCode == Window._toggleKey then
            Window:Toggle()
        end
        if Window._openDropdown then
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                local d = Window._openDropdown
                local p = input.Position
                local function inside(obj)
                    local a, s = obj.AbsolutePosition, obj.AbsoluteSize
                    return p.X >= a.X and p.X <= a.X + s.X and p.Y >= a.Y and p.Y <= a.Y + s.Y
                end
                if not inside(d.List) and not inside(d.Row) then
                    Window:_closeDropdown()
                end
            end
        end
    end))

    function Window:_closeDropdown()
        if not self._openDropdown then return end
        local d = self._openDropdown
        self._openDropdown = nil
        if d.List and d.List.Parent then
            tween(d.List, INFO_FAST, { GroupTransparency = 1 })
            task.delay(0.2, function()
                if d.List and d.List.Parent then d.List:Destroy() end
            end)
        end
    end

    function Window:SetTitle(text)
        titleLabel.Text = tostring(text)
    end

    function Window:SetSize(newSize)
        local nw = math.clamp(newSize.X.Offset, self._minSize.X, self._maxSize.X)
        local nh = math.clamp(newSize.Y.Offset, self._minSize.Y, self._maxSize.Y)
        tween(main, INFO_PANEL, { Size = UDim2.fromOffset(nw, nh) })
    end

    function Window:SetToTheCenter()
        local vp = workspace.CurrentCamera.ViewportSize
        local sz = main.AbsoluteSize
        tween(main, INFO_PANEL, {
            Position = UDim2.fromOffset((vp.X - sz.X) / 2, (vp.Y - sz.Y) / 2),
        })
    end

    function Window:Show()
        if self._destroyed then return end
        self._hiding = false
        gui.Enabled = true
        tween(main, INFO_PANEL, { GroupTransparency = 0 })
        self:_fireEvent("Open")
    end

    function Window:Hide()
        if self._destroyed then return end
        self._hiding = true
        tween(main, INFO_FAST, { GroupTransparency = 1 })
        task.delay(0.2, function()
            if not self._destroyed and gui and self._hiding then gui.Enabled = false end
        end)
        self:_fireEvent("Close")
    end

    function Window:Toggle()
        if self._destroyed then return end
        if gui.Enabled then self:Hide() else self:Show() end
    end

    function Window:Minimize()
        if self._destroyed or self._minimized then
            if self._minimized then self:Restore() end
            return
        end
        self._minimized = true
        self._restoreMinSize = main.Size
        body.Visible = false
        tween(main, INFO_PANEL, { Size = UDim2.fromOffset(main.AbsoluteSize.X, barH) })
    end

    function Window:Restore()
        if not self._minimized then return end
        self._minimized = false
        body.Visible = true
        tween(main, INFO_PANEL, { Size = self._restoreMinSize or size })
    end

    function Window:Maximize()
        if self._destroyed then return end
        if self._maximized then
            self._maximized = false
            tween(main, INFO_PANEL, {
                Position = self._restoreMaxPos or startPos,
                Size = self._restoreMaxSize or size,
            })
        else
            self._maximized = true
            self._restoreMaxPos = main.Position
            if self._minimized then
                self._restoreMaxSize = self._restoreMinSize or size
                self:Restore()
            else
                self._restoreMaxSize = main.Size
            end
            local vp = workspace.CurrentCamera.ViewportSize
            tween(main, INFO_PANEL, {
                Position = UDim2.fromOffset(20, 20),
                Size = UDim2.fromOffset(vp.X - 40, vp.Y - 40),
            })
        end
    end

    function Window:SetToggleKey(keyCode)
        self._toggleKey = keyCode
    end

    function Window:OnOpen(fn) table.insert(self._events.Open, fn) end
    function Window:OnClose(fn) table.insert(self._events.Close, fn) end
    function Window:OnDestroy(fn) table.insert(self._events.Destroy, fn) end

    function Window:Close()
        self:Destroy()
    end

    function Window:Destroy()
        if self._destroyed then return end
        self._destroyed = true
        self:_closeDropdown()
        self:_fireEvent("Destroy")
        for _, conn in ipairs(self._connections) do
            pcall(function() conn:Disconnect() end)
        end
        for _, n in ipairs(self._notifications) do
            pcall(function() n:Destroy() end)
        end
        tween(main, INFO_FAST, { GroupTransparency = 1 })
        task.delay(0.2, function()
            if gui and gui.Parent then gui:Destroy() end
        end)
        for i, w in ipairs(YAGUI._windows) do
            if w == self then
                table.remove(YAGUI._windows, i)
                break
            end
        end
        if YAGUI.CurrentWindow == self then
            YAGUI.CurrentWindow = YAGUI._windows[#YAGUI._windows]
        end
    end

    minBtn.MouseButton1Click:Connect(function() Window:Minimize() end)
    maxBtn.MouseButton1Click:Connect(function() Window:Maximize() end)
    closeBtn.MouseButton1Click:Connect(function() Window:Destroy() end)

    function Window:Notify(cfg)
        if self._destroyed then return end
        cfg = cfg or {}
        local P = currentPalette()
        local card = make("CanvasGroup", {
            Size = UDim2.fromOffset(288, 78),
            BackgroundColor3 = P.Panel,
            BorderSizePixel = 0,
            GroupTransparency = 1,
            ZIndex = 31,
        }, notifHolder)
        make("UICorner", { CornerRadius = UDim.new(0, 10) }, card)
        local stroke = make("UIStroke", { Color = P.Outline, Thickness = 1.5 }, card)
        bind(self, card, "BackgroundColor3", "Panel")
        bind(self, stroke, "Color", "Outline")

        local title = make("TextLabel", {
            Size = UDim2.new(1, -46, 0, 22),
            Position = UDim2.fromOffset(12, 10),
            BackgroundTransparency = 1,
            Text = cfg.Title or "通知",
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            TextColor3 = P.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, card)
        bind(self, title, "TextColor3", "Text")

        local desc = make("TextLabel", {
            Size = UDim2.new(1, -24, 0, 30),
            Position = UDim2.fromOffset(12, 34),
            BackgroundTransparency = 1,
            Text = cfg.Content or cfg.Desc or "",
            Font = font,
            TextSize = 12,
            TextColor3 = P.SubText,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
        }, card)
        bind(self, desc, "TextColor3", "SubText")

        local close = make("TextButton", {
            Size = UDim2.fromOffset(24, 24),
            Position = UDim2.new(1, -30, 0, 8),
            BackgroundTransparency = 1,
            Text = "×",
            Font = Enum.Font.GothamBold,
            TextSize = 18,
            TextColor3 = P.SubText,
            AutoButtonColor = false,
        }, card)
        bind(self, close, "TextColor3", "SubText")

        local bar = make("Frame", {
            Size = UDim2.new(1, 0, 0, 3),
            Position = UDim2.new(0, 0, 1, -3),
            BackgroundColor3 = P.Accent,
            BorderSizePixel = 0,
        }, card)
        bind(self, bar, "BackgroundColor3", "Accent")

        table.insert(self._notifications, card)
        tween(card, INFO_FAST, { GroupTransparency = 0 })
        local duration = cfg.Duration or 4
        tween(bar, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 0, 0, 3),
        })

        local closed = false
        local function dismiss()
            if closed or self._destroyed then return end
            closed = true
            tween(card, INFO_FAST, { GroupTransparency = 1 })
            task.delay(0.2, function()
                if card and card.Parent then card:Destroy() end
            end)
        end
        close.MouseButton1Click:Connect(dismiss)
        task.delay(duration, dismiss)
        return { Dismiss = dismiss }
    end

    function Window:Toast(cfg)
        return self:Notify(cfg)
    end

    function Window:CreateTab(tabCfg)
        if self._destroyed then return end
        tabCfg = tabCfg or {}
        local P = currentPalette()
        local name = cfgTitle(tabCfg)
        local icon = tabCfg.Icon and (tostring(tabCfg.Icon) .. "  ") or ""

        local button = make("TextButton", {
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = P.Element,
            BorderSizePixel = 0,
            Text = icon .. name,
            Font = font,
            TextSize = 14,
            TextColor3 = P.SubText,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false,
            LayoutOrder = #self._tabs + 1,
        }, sidebar)
        make("UICorner", { CornerRadius = UDim.new(0, 8) }, button)
        make("UIPadding", { PaddingLeft = UDim.new(0, 12) }, button)
        bind(self, button, "BackgroundColor3", "Element")

        local page = make("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = config.ScrollBarThickness or 4,
            ScrollBarImageColor3 = P.Outline,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
        }, content)
        bind(self, page, "ScrollBarImageColor3", "Outline")
        local rowLayout = make("UIListLayout", {
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }, page)
        make("UIPadding", {
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
        }, page)
        self:_track(rowLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0, 0, 0, rowLayout.AbsoluteContentSize.Y + 24)
        end))

        local Tab = {}
        Tab._window = self
        Tab._page = page
        Tab._button = button
        Tab._locked = false
        Tab.Title = name

        function Tab:Select()
            if self._locked or self._window._destroyed then return end
            for _, t in ipairs(self._window._tabs) do
                t._page.Visible = false
                t._button.BackgroundColor3 = currentPalette().Element
                t._button.TextColor3 = currentPalette().SubText
            end
            self._window._selectedTab = self
            self._page.Visible = true
            self._button.BackgroundColor3 = currentPalette().ElementHover
            self._button.TextColor3 = currentPalette().Text
            self._page.CanvasPosition = Vector2.new(0, 0)
            fire(tabCfg.Callback)
        end

        function Tab:SetTitle(text)
            self.Title = tostring(text)
            self._button.Text = icon .. self.Title
        end

        function Tab:Lock()
            self._locked = true
            self._button.TextTransparency = 0.5
        end

        function Tab:Unlock()
            self._locked = false
            self._button.TextTransparency = 0
        end

        local function makeRow(height, titleText, descText)
            local P2 = currentPalette()
            local row = make("Frame", {
                Size = UDim2.new(1, -20, 0, height),
                BackgroundColor3 = P2.Element,
                BorderSizePixel = 0,
            }, page)
            make("UICorner", { CornerRadius = UDim.new(0, 9) }, row)
            local stroke = make("UIStroke", { Color = P2.Outline, Thickness = 1, Transparency = 0.75 }, row)
            bind(self, row, "BackgroundColor3", "Element")
            bind(self, stroke, "Color", "Outline")

            local label = make("TextLabel", {
                Size = UDim2.new(1, -24, 0, 20),
                Position = UDim2.fromOffset(12, descText and 6 or (height - 20) / 2),
                BackgroundTransparency = 1,
                Text = titleText or "",
                Font = font,
                TextSize = 14,
                TextColor3 = P2.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
            }, row)
            bind(self, label, "TextColor3", "Text")
            if descText then
                local sub = make("TextLabel", {
                    Size = UDim2.new(1, -24, 0, 18),
                    Position = UDim2.fromOffset(12, 26),
                    BackgroundTransparency = 1,
                    Text = descText,
                    Font = font,
                    TextSize = 11,
                    TextColor3 = P2.SubText,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                }, row)
                bind(self, sub, "TextColor3", "SubText")
            end
            return row, label
        end

        function Tab:AddSection(text)
            local c = type(text) == "table" and text or { Title = text }
            local P2 = currentPalette()
            local row = make("Frame", {
                Size = UDim2.new(1, -20, 0, 26),
                BackgroundTransparency = 1,
            }, page)
            local bar2 = make("Frame", {
                Size = UDim2.fromOffset(3, 16),
                Position = UDim2.fromOffset(2, 5),
                BackgroundColor3 = P2.Accent,
                BorderSizePixel = 0,
            }, row)
            make("UICorner", { CornerRadius = UDim.new(1, 0) }, bar2)
            bind(self._window, bar2, "BackgroundColor3", "Accent")
            local label = make("TextLabel", {
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.fromOffset(14, 0),
                BackgroundTransparency = 1,
                Text = cfgTitle(c),
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                TextColor3 = P2.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, row)
            bind(self._window, label, "TextColor3", "Text")
            return { Instance = row }
        end

        function Tab:AddLabel(text)
            local c = type(text) == "table" and text or { Text = text }
            local P2 = currentPalette()
            local label = make("TextLabel", {
                Size = UDim2.new(1, -20, 0, c.Height or 26),
                BackgroundTransparency = 1,
                Text = c.Text or c.Title or "",
                Font = font,
                TextSize = c.TextSize or 13,
                TextColor3 = c.Color or P2.SubText,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
            }, page)
            if not c.Color then bind(self._window, label, "TextColor3", "SubText") end
            local obj = {}
            function obj:SetText(t)
                label.Text = tostring(t)
            end
            return obj
        end

        function Tab:AddParagraph(c)
            c = c or {}
            local P2 = currentPalette()
            local height = c.Height or 66
            local row = make("Frame", {
                Size = UDim2.new(1, -20, 0, height),
                BackgroundTransparency = 1,
            }, page)
            local title = make("TextLabel", {
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Text = cfgTitle(c),
                Font = Enum.Font.GothamBold,
                TextSize = 15,
                TextColor3 = P2.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, row)
            bind(self._window, title, "TextColor3", "Text")
            local desc = make("TextLabel", {
                Size = UDim2.new(1, 0, 1, -24),
                Position = UDim2.fromOffset(0, 24),
                BackgroundTransparency = 1,
                Text = c.Desc or c.Content or "",
                Font = font,
                TextSize = 12,
                TextColor3 = P2.SubText,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
            }, row)
            bind(self._window, desc, "TextColor3", "SubText")
            return {
                SetTitle = function(_, t) title.Text = tostring(t) end,
                SetDesc = function(_, t) desc.Text = tostring(t) end,
            }
        end

        function Tab:AddDivider()
            local P2 = currentPalette()
            local line = make("Frame", {
                Size = UDim2.new(1, -20, 0, 1),
                BackgroundColor3 = P2.Outline,
                BackgroundTransparency = 0.7,
                BorderSizePixel = 0,
            }, page)
            bind(self._window, line, "BackgroundColor3", "Outline")
            return { Instance = line }
        end

        function Tab:AddSpace(pixels)
            local f = make("Frame", {
                Size = UDim2.new(1, -20, 0, pixels or 8),
                BackgroundTransparency = 1,
            }, page)
            return { Instance = f }
        end

        function Tab:AddButton(c)
            c = c or {}
            local P2 = currentPalette()
            local height = c.Desc and 50 or 40
            local row = make("TextButton", {
                Size = UDim2.new(1, -20, 0, height),
                BackgroundColor3 = c.Color or P2.Element,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
            }, page)
            make("UICorner", { CornerRadius = UDim.new(0, 9) }, row)
            local stroke = make("UIStroke", { Color = P2.Outline, Thickness = 1, Transparency = 0.75 }, row)
            bind(self._window, row, "BackgroundColor3", "Element")
            bind(self._window, stroke, "Color", "Outline")
            local label = make("TextLabel", {
                Size = UDim2.new(1, -24, 0, 20),
                Position = UDim2.fromOffset(12, c.Desc and 6 or (height - 20) / 2),
                BackgroundTransparency = 1,
                Text = cfgTitle(c),
                Font = font,
                TextSize = 14,
                TextColor3 = P2.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
            }, row)
            bind(self._window, label, "TextColor3", "Text")
            local sub = nil
            if c.Desc then
                sub = make("TextLabel", {
                    Size = UDim2.new(1, -24, 0, 18),
                    Position = UDim2.fromOffset(12, 26),
                    BackgroundTransparency = 1,
                    Text = c.Desc,
                    Font = font,
                    TextSize = 11,
                    TextColor3 = P2.SubText,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, row)
                bind(self._window, sub, "TextColor3", "SubText")
            end

            local locked = false
            row.MouseEnter:Connect(function()
                if not locked then tween(row, INFO_FAST, { BackgroundColor3 = currentPalette().ElementHover }) end
            end)
            row.MouseLeave:Connect(function()
                if not locked then tween(row, INFO_FAST, { BackgroundColor3 = currentPalette().Element }) end
            end)
            row.MouseButton1Click:Connect(function()
                if locked then return end
                fire(c.Callback)
            end)

            local obj = {}
            function obj:SetTitle(t) label.Text = tostring(t) end
            function obj:SetDesc(t) if sub then sub.Text = tostring(t) end end
            function obj:Lock() locked = true; row.TextTransparency = 0 end
            function obj:Unlock() locked = false end
            function obj:Destroy() row:Destroy() end
            return obj
        end

        function Tab:AddToggle(c)
            c = c or {}
            local P2 = currentPalette()
            local value = cfgDefault(c, false) == true
            local row, label = makeRow(44, cfgTitle(c), c.Desc)

            local pill = make("Frame", {
                Size = UDim2.fromOffset(44, 24),
                Position = UDim2.new(1, -56, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = P2.ElementHover,
                BorderSizePixel = 0,
            }, row)
            make("UICorner", { CornerRadius = UDim.new(1, 0) }, pill)
            local knob = make("Frame", {
                Size = UDim2.fromOffset(18, 18),
                Position = UDim2.fromOffset(3, 3),
                BackgroundColor3 = P2.Text,
                BorderSizePixel = 0,
            }, pill)
            make("UICorner", { CornerRadius = UDim.new(1, 0) }, knob)
            bind(self._window, knob, "BackgroundColor3", "Text")

            local hit = make("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 5,
                AutoButtonColor = false,
            }, row)

            local function display()
                local P3 = currentPalette()
                tween(pill, INFO_FAST, {
                    BackgroundColor3 = value and P3.Accent or P3.ElementHover,
                })
                tween(knob, INFO_FAST, {
                    Position = value and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3),
                })
            end
            display()
            self._window:_registerRefresh(display)

            local function set(newValue, silent)
                value = newValue == true
                display()
                if c.Flag then self._window.Flags[c.Flag] = value end
                if not silent then fire(c.Callback, value) end
            end

            hit.MouseButton1Click:Connect(function()
                set(not value, false)
            end)
            self._window:_registerFlag(c.Flag, function() return value end, function(v, s) set(v, s) end)
            if c.Flag then self._window.Flags[c.Flag] = value end

            local obj = {}
            obj.Value = value
            function obj:Set(v, silent) set(v, silent); self.Value = value end
            function obj:GetValue() return value end
            function obj:OnChanged(fn) c.Callback = fn; return self end
            function obj:SetTitle(t) label.Text = tostring(t) end
            return obj
        end

        function Tab:AddSlider(c)
            c = c or {}
            local P2 = currentPalette()
            local min = c.Min or 0
            local max = c.Max or 100
            local inc = c.Increment or 1
            if max <= min then max = min + 1 end
            local value = math.clamp(tonumber(cfgDefault(c, min)) or min, min, max)

            local row = makeRow(58, cfgTitle(c), c.Desc)
            local valueLabel = make("TextLabel", {
                Size = UDim2.fromOffset(80, 20),
                Position = UDim2.new(1, -92, 0, 6),
                BackgroundTransparency = 1,
                Text = tostring(value),
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                TextColor3 = P2.Accent,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, row)
            bind(self._window, valueLabel, "TextColor3", "Accent")

            local track = make("Frame", {
                Size = UDim2.new(1, -24, 0, 6),
                Position = UDim2.new(0, 12, 1, -14),
                BackgroundColor3 = P2.ElementHover,
                BorderSizePixel = 0,
            }, row)
            make("UICorner", { CornerRadius = UDim.new(1, 0) }, track)
            bind(self._window, track, "BackgroundColor3", "ElementHover")
            local fill = make("Frame", {
                Size = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = P2.Accent,
                BorderSizePixel = 0,
            }, track)
            make("UICorner", { CornerRadius = UDim.new(1, 0) }, fill)
            bind(self._window, fill, "BackgroundColor3", "Accent")
            local knob = make("Frame", {
                Size = UDim2.fromOffset(14, 14),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0, 0, 0.5, 0),
                BackgroundColor3 = P2.Text,
                BorderSizePixel = 0,
                ZIndex = 3,
            }, track)
            make("UICorner", { CornerRadius = UDim.new(1, 0) }, knob)
            bind(self._window, knob, "BackgroundColor3", "Text")

            local hit = make("TextButton", {
                Size = UDim2.new(1, 12, 0, 28),
                Position = UDim2.new(0, -6, 1, -25),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 4,
                AutoButtonColor = false,
            }, row)

            local function display()
                local ratio = (value - min) / (max - min)
                tween(fill, INFO_FAST, { Size = UDim2.new(ratio, 0, 1, 0) })
                tween(knob, INFO_FAST, { Position = UDim2.new(ratio, 0, 0.5, 0) })
                valueLabel.Text = tostring(math.floor(value * 100 + 0.5) / 100)
            end
            display()
            self._window:_registerRefresh(display)

            local function set(v, silent)
                v = tonumber(v) or min
                value = math.clamp(math.floor((v - min) / inc + 0.5) * inc + min, min, max)
                display()
                if c.Flag then self._window.Flags[c.Flag] = value end
                if not silent then fire(c.Callback, value) end
            end

            local function updateFromInput(input)
                local x = input.Position.X - track.AbsolutePosition.X
                local ratio = math.clamp(x / math.max(track.AbsoluteSize.X, 1), 0, 1)
                set(min + ratio * (max - min), false)
            end

            hit.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    self._window._activeSlider = updateFromInput
                    updateFromInput(input)
                end
            end)

            self._window:_registerFlag(c.Flag, function() return value end, function(v, s) set(v, s) end)
            if c.Flag then self._window.Flags[c.Flag] = value end

            local obj = {}
            function obj:Set(v, silent) set(v, silent) end
            function obj:GetValue() return value end
            function obj:OnChanged(fn) c.Callback = fn; return self end
            return obj
        end

        function Tab:AddDropdown(c)
            c = c or {}
            local P2 = currentPalette()
            local windowRef = self._window
            local options = c.Options or c.Values or {}
            local value = cfgDefault(c, options[1])
            local row = makeRow(44, cfgTitle(c), c.Desc)

            local button = make("TextButton", {
                Size = UDim2.fromOffset(130, 28),
                Position = UDim2.new(1, -142, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = P2.ElementHover,
                BorderSizePixel = 0,
                Text = tostring(value) .. "  ▾",
                Font = font,
                TextSize = 12,
                TextColor3 = P2.Text,
                AutoButtonColor = false,
                ZIndex = 3,
            }, row)
            make("UICorner", { CornerRadius = UDim.new(0, 6) }, button)
            bind(self._window, button, "BackgroundColor3", "ElementHover")
            bind(self._window, button, "TextColor3", "Text")

            local function set(v, silent)
                value = v
                button.Text = tostring(value) .. "  ▾"
                if c.Flag then self._window.Flags[c.Flag] = value end
                if not silent then fire(c.Callback, value) end
            end

            local function open()
                if self._window._openDropdown then self._window:_closeDropdown() end
                local P3 = currentPalette()
                local list = make("CanvasGroup", {
                    Size = UDim2.fromOffset(row.AbsoluteSize.X, math.min(#options * 30 + 8, 190)),
                    Position = UDim2.fromOffset(row.AbsolutePosition.X, row.AbsolutePosition.Y + row.AbsoluteSize.Y + 4),
                    BackgroundColor3 = P3.Panel,
                    BorderSizePixel = 0,
                    GroupTransparency = 0,
                    ZIndex = 40,
                }, self._window._gui)
                make("UICorner", { CornerRadius = UDim.new(0, 8) }, list)
                local stroke = make("UIStroke", { Color = P3.Outline, Thickness = 1 }, list)
                bind(self._window, list, "BackgroundColor3", "Panel")
                bind(self._window, stroke, "Color", "Outline")
                local scroll = make("ScrollingFrame", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    ScrollBarThickness = 3,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ZIndex = 41,
                }, list)
                local layout = make("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }, scroll)
                make("UIPadding", {
                    PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4),
                    PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4),
                }, scroll)
                self._window:_track(layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 8)
                end))

                for i, option in ipairs(options) do
                    local optBtn = make("TextButton", {
                        Size = UDim2.new(1, 0, 0, 28),
                        BackgroundColor3 = (option == value) and P3.ElementHover or P3.Panel,
                        BorderSizePixel = 0,
                        Text = "  " .. tostring(option),
                        Font = font,
                        TextSize = 12,
                        TextColor3 = P3.Text,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutoButtonColor = false,
                        LayoutOrder = i,
                        ZIndex = 42,
                    }, scroll)
                    make("UICorner", { CornerRadius = UDim.new(0, 5) }, optBtn)
                    optBtn.MouseButton1Click:Connect(function()
                        set(option, false)
                        self._window:_closeDropdown()
                    end)
                end
                self._window._openDropdown = { List = list, Row = row }
            end

            button.MouseButton1Click:Connect(function()
                if self._window._openDropdown and self._window._openDropdown.Row == row then
                    self._window:_closeDropdown()
                else
                    open()
                end
            end)

            self._window:_registerFlag(c.Flag, function() return value end, function(v, s) set(v, s) end)
            if c.Flag then self._window.Flags[c.Flag] = value end

            local obj = {}
            function obj:Set(v, silent) set(v, silent) end
            function obj:GetValue() return value end
            function obj:Refresh(list)
                options = list or {}
                windowRef:_closeDropdown()
            end
            function obj:OnChanged(fn) c.Callback = fn; return self end
            return obj
        end

        function Tab:AddInput(c)
            c = c or {}
            local P2 = currentPalette()
            local row = makeRow(58, cfgTitle(c), c.Desc)
            local box = make("TextBox", {
                Size = UDim2.new(1, -24, 0, 24),
                Position = UDim2.new(0, 12, 1, -30),
                BackgroundColor3 = P2.ElementHover,
                BorderSizePixel = 0,
                Text = tostring(cfgDefault(c, "")),
                PlaceholderText = c.Placeholder or "输入...",
                PlaceholderColor3 = P2.SubText,
                Font = font,
                TextSize = 13,
                TextColor3 = P2.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
            }, row)
            make("UICorner", { CornerRadius = UDim.new(0, 6) }, box)
            make("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, box)
            bind(self._window, box, "BackgroundColor3", "ElementHover")
            bind(self._window, box, "TextColor3", "Text")

            local value = box.Text
            if c.Numeric then
                box:GetPropertyChangedSignal("Text"):Connect(function()
                    local filtered = string.gsub(box.Text, "[^%d%.%-]", "")
                    if filtered ~= box.Text then box.Text = filtered end
                end)
            end
            box.FocusLost:Connect(function(enterPressed)
                value = box.Text
                if c.Flag then self._window.Flags[c.Flag] = value end
                if c.Finished and not enterPressed then return end
                fire(c.Callback, value, enterPressed)
            end)

            local function set(v, silent)
                value = tostring(v)
                box.Text = value
                if c.Flag then self._window.Flags[c.Flag] = value end
                if not silent then fire(c.Callback, value, false) end
            end
            self._window:_registerFlag(c.Flag, function() return value end, function(v, s) set(v, s) end)
            if c.Flag then self._window.Flags[c.Flag] = value end

            local obj = {}
            function obj:Set(v, silent) set(v, silent) end
            function obj:GetValue() return value end
            function obj:OnChanged(fn) c.Callback = fn; return self end
            return obj
        end

        function Tab:AddKeybind(c)
            c = c or {}
            local P2 = currentPalette()
            local key = cfgDefault(c, Enum.KeyCode.Unknown)
            if type(key) == "string" then
                key = Enum.KeyCode[key] or Enum.KeyCode.Unknown
            end
            local row = makeRow(44, cfgTitle(c), c.Desc)
            local button = make("TextButton", {
                Size = UDim2.fromOffset(110, 28),
                Position = UDim2.new(1, -122, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = P2.ElementHover,
                BorderSizePixel = 0,
                Text = key.Name or "无",
                Font = font,
                TextSize = 12,
                TextColor3 = P2.Text,
                AutoButtonColor = false,
                ZIndex = 3,
            }, row)
            make("UICorner", { CornerRadius = UDim.new(0, 6) }, button)
            bind(self._window, button, "BackgroundColor3", "ElementHover")
            bind(self._window, button, "TextColor3", "Text")

            local capturing = false
            local function set(k, silent)
                if type(k) == "string" then k = Enum.KeyCode[k] or Enum.KeyCode.Unknown end
                key = k or Enum.KeyCode.Unknown
                button.Text = key.Name
                if c.Flag then self._window.Flags[c.Flag] = key.Name end
                if not silent then fire(c.Callback, key) end
            end

            button.MouseButton1Click:Connect(function()
                if capturing then return end
                capturing = true
                button.Text = "按下按键..."
                local conn
                conn = UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
                    conn:Disconnect()
                    capturing = false
                    if input.KeyCode ~= Enum.KeyCode.Escape then
                        set(input.KeyCode, false)
                    else
                        button.Text = key.Name
                    end
                end)
                self._window:_track(conn)
            end)

            self._window:_registerFlag(c.Flag, function() return key.Name end, function(v, s) set(v, s) end)
            if c.Flag then self._window.Flags[c.Flag] = key.Name end

            local obj = {}
            function obj:Set(v, silent) set(v, silent) end
            function obj:GetValue() return key end
            function obj:OnChanged(fn) c.Callback = fn; return self end
            return obj
        end

        Tab.Section = Tab.AddSection
        Tab.Label = Tab.AddLabel
        Tab.Paragraph = Tab.AddParagraph
        Tab.Divider = Tab.AddDivider
        Tab.Space = Tab.AddSpace
        Tab.Button = Tab.AddButton
        Tab.Toggle = Tab.AddToggle
        Tab.Slider = Tab.AddSlider
        Tab.Dropdown = Tab.AddDropdown
        Tab.Input = Tab.AddInput
        Tab.Keybind = Tab.AddKeybind
        Tab.CreateButton = Tab.AddButton
        Tab.CreateToggle = Tab.AddToggle
        Tab.CreateSlider = Tab.AddSlider
        Tab.CreateDropdown = Tab.AddDropdown
        Tab.CreateInput = Tab.AddInput
        Tab.AddKeybind = Tab.AddKeybind

        table.insert(self._tabs, Tab)
        button.MouseButton1Click:Connect(function() Tab:Select() end)
        if #self._tabs == 1 then Tab:Select() end
        return Tab
    end

    Window.Tab = Window.CreateTab

    local memoryConfigs = {}
    local function configPath(name)
        return "YAGUI/" .. Window._folder .. "/configs/" .. name .. ".json"
    end

    local function ensureFolder()
        if not hasFileAPI() then return false end
        pcall(function()
            makefolder("YAGUI")
            makefolder("YAGUI/" .. Window._folder)
            makefolder("YAGUI/" .. Window._folder .. "/configs")
        end)
        return true
    end

    local function newConfig(name)
        name = tostring(name or "default")
        local cfg = {}
        function cfg:Save()
            local data = {}
            for flag, f in pairs(Window._flags) do
                local ok, v = pcall(f.Get)
                if ok then data[flag] = v end
            end
            local encoded = HttpService:JSONEncode(data)
            if ensureFolder() then
                local ok, err = pcall(function() writefile(configPath(name), encoded) end)
                if not ok then warn("[YAGUI] 保存失败: " .. tostring(err)) end
            else
                memoryConfigs[Window._folder .. "/" .. name] = data
            end
            return data
        end

        function cfg:Load()
            local data
            if hasFileAPI() and isfile(configPath(name)) then
                local ok, raw = pcall(function() return readfile(configPath(name)) end)
                if ok then
                    local ok2, decoded = pcall(function() return HttpService:JSONDecode(raw) end)
                    if ok2 then data = decoded end
                end
            else
                data = memoryConfigs[Window._folder .. "/" .. name]
            end
            if type(data) ~= "table" then return false end
            for flag, value in pairs(data) do
                local f = Window._flags[flag]
                if f then pcall(f.Set, value, false) end
            end
            return true
        end

        function cfg:Set(key, value)
            local f = Window._flags[key]
            if f then pcall(f.Set, value, false) end
        end

        function cfg:Get(key)
            return Window.Flags[key]
        end

        function cfg:Delete()
            memoryConfigs[Window._folder .. "/" .. name] = nil
            if hasFileAPI() and type(delfile) == "function" and isfile(configPath(name)) then
                pcall(function() delfile(configPath(name)) end)
            end
        end
        return cfg
    end

    function Window.ConfigManager:Config(name)
        return newConfig(name)
    end

    function Window.ConfigManager:AllConfigs()
        local names = {}
        if hasFileAPI() and type(listfiles) == "function" then
            local folder = "YAGUI/" .. Window._folder .. "/configs"
            local ok, files = pcall(function() return listfiles(folder) end)
            if ok and type(files) == "table" then
                for _, path in ipairs(files) do
                    local base = string.match(tostring(path), "([^/\\]+)%.json$")
                    if base then table.insert(names, base) end
                end
            end
        end
        for key in pairs(memoryConfigs) do
            if string.sub(key, 1, #Window._folder + 1) == Window._folder .. "/" then
                table.insert(names, string.sub(key, #Window._folder + 2))
            end
        end
        table.sort(names)
        return names
    end

    function Window:GetFlag(name) return self.Flags[name] end
    function Window:SetFlag(name, value, silent)
        local f = self._flags[name]
        if f then pcall(f.Set, value, silent) end
    end

    table.insert(YAGUI._windows, Window)
    YAGUI.CurrentWindow = Window
    if config.Theme and YAGUI.Themes[config.Theme] then
        YAGUI:SetTheme(config.Theme)
    end
    tween(main, INFO_PANEL, { GroupTransparency = 0 })

    return Window
end

function YAGUI:Notify(cfg)
    if YAGUI.CurrentWindow then
        return YAGUI.CurrentWindow:Notify(cfg)
    end
    warn("[YAGUI] 请先创建一个窗口再调用 Notify")
end

function YAGUI:SetDisplayOrder(order)
    for _, window in ipairs(YAGUI._windows) do
        if window._gui then window._gui.DisplayOrder = order end
    end
end

local Icons = {}
Icons.__index = Icons

local LucideAtlas = {
    AssetId = "rbxassetid://10734950040",
    Size = 256,
    Icons = {
        ["home"] = Vector2.new(0, 0),
        ["settings"] = Vector2.new(256, 0),
        ["user"] = Vector2.new(512, 0),
        ["search"] = Vector2.new(768, 0),
        ["trash"] = Vector2.new(0, 256),
        ["save"] = Vector2.new(256, 256),
        ["edit"] = Vector2.new(512, 256),
        ["close"] = Vector2.new(768, 256),
        ["minimize"] = Vector2.new(0, 512),
        ["maximize"] = Vector2.new(256, 512),
        ["chevron-right"] = Vector2.new(512, 512),
        ["check"] = Vector2.new(768, 512),
        ["x"] = Vector2.new(0, 768),
        ["minus"] = Vector2.new(256, 768),
        ["square"] = Vector2.new(512, 768),
    }
}

local CurrentType = "lucide"
local OnlineLoaded = false

function Icons:InitOnline()
    if OnlineLoaded then return end
    local success, res = pcall(function()
        return loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()
    end)
    if success and res then
        self.OnlineLib = res
        self.OnlineLib.SetIconsType("lucide")
        OnlineLoaded = true
        print("[YAGUI] WindUI Online Icons Loaded.")
    else
        warn("[YAGUI] Failed to load online icons, using offline Lucide atlas.")
    end
end

function Icons:SetType(typ)
    CurrentType = typ
    if self.OnlineLib then self.OnlineLib.SetIconsType(typ) end
end

function Icons:Get(name)
    if OnlineLoaded and self.OnlineLib then
        local img = self.OnlineLib.GetIcon(name)
        if img then return { Image = img, ImageRectSize = Vector2.new(256,256), ImageRectOffset = Vector2.new(0,0) } end
    end
    
    local key = name:gsub("lucide:", "")
    local offset = LucideAtlas.Icons[key]
    if offset then
        return {
            Image = LucideAtlas.AssetId,
            ImageRectSize = Vector2.new(LucideAtlas.Size, LucideAtlas.Size),
            ImageRectOffset = offset
        }
    end
    return nil
end

function Icons:Create(parent, name, size, color)
    local data = self:Get(name)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, size or 18, 0, size or 18)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local lbl = Instance.new("ImageLabel")
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.ImageColor3 = color or Color3.fromRGB(50, 255, 120)
    lbl.ScaleType = Enum.ScaleType.Fit
    if data then
        lbl.Image = data.Image
        lbl.ImageRectSize = data.ImageRectSize
        lbl.ImageRectOffset = data.ImageRectOffset
    else
        lbl.Image = ""
    end
    lbl.Parent = frame
    return frame
end


local ICON_URL = "https://raw.githubusercontent.com/tfcm279/-b3/main/%E7%BB%84%20(3).png"
local ICON_PATH = "YAGUI/assets/collapse_icon.png"
local ICON_ID = nil

local function loadIconAsset()
    if type(writefile) ~= "function" or type(getcustomasset) ~= "function" then
        warn("[YAGUI] 当前环境不支持 writefile/getcustomasset，无法加载 GitHub 图片")
        return nil
    end
    if isfile and isfile(ICON_PATH) then
        local ok, asset = pcall(getcustomasset, ICON_PATH)
        if ok and asset then return asset end
    end
    local okHttp, body = pcall(function()
        return game:HttpGet(ICON_URL, true)
    end)
    if not okHttp or type(body) ~= "string" or #body == 0 then
        warn("[YAGUI] 下载图标失败")
        return nil
    end
    local okWrite = pcall(function()
        if makefolder and not (isfolder and isfolder("YAGUI/assets")) then
            makefolder("YAGUI"); makefolder("YAGUI/assets")
        end
        writefile(ICON_PATH, body)
    end)
    if not okWrite then
        warn("[YAGUI] 写入图标失败")
        return nil
    end
    local okAsset, asset = pcall(getcustomasset, ICON_PATH)
    return okAsset and asset or nil
end

ICON_ID = loadIconAsset()

local floatBtn = make("TextButton", {
    Name = "CollapseFloat",
    Size = UDim2.fromOffset(40, 40),
    Position = UDim2.new(0, 12, 0.5, -20),
    BackgroundTransparency = 1,
    Text = "",
    AutoButtonColor = false,
    ZIndex = 50,
    Parent = gui,
})
local floatIcon = make("ImageLabel", {
    Name = "Icon",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Image = ICON_ID or "",
    ImageColor3 = currentPalette().Accent,
    ScaleType = Enum.ScaleType.Fit,
}, floatBtn)

bind(Window, floatIcon, "ImageColor3", "Accent")

Window:_track(RunService.RenderStepped:Connect(function()
    if Window._destroyed then return end
    floatBtn.Position = UDim2.new(
        0, main.AbsolutePosition.X - 52,
        0, main.AbsolutePosition.Y + main.AbsoluteSize.Y / 2 - 20
    )
end))

Window:_track(floatBtn.MouseButton1Click:Connect(function()
    if Window._destroyed then return end
    if Window._minimized then
        Window:Restore()
    else
        Window:Minimize()
    end
end))

return YAGUI
