
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local RunService = game:GetService("RunService")
local Players    = game:GetService("Players")

local COIN_URL  = "https://raw.githubusercontent.com/tfcm279/-b3/main/%E6%96%87%E5%AD%97%20(1).png"
local COIN_FILE = "duck_coin_text_v2.png"
local IMG_SCALE = 1
local DEBUG     = true

local gradientSequence = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(0, 0, 0))
})

local activeGradients = {}
local rotation        = 0
local coinConnection  = nil
local currentDisplay  = nil

local function log(...) if DEBUG then print("[Coin]", ...) end end
local function warnLog(...) warn("[Coin]", ...) end

local function getCoinAsset()
    local ok, res = pcall(function()
        return toAsset(COIN_URL, COIN_FILE)
    end)
    if not ok then warnLog("toAsset 报错:", res) return nil end
    if not res then warnLog("toAsset 返回 nil") return nil end
    log("coinAsset =", res)
    return res
end

local function applyGradient(obj)
    if not obj then return end
    local uiGradient = obj:FindFirstChildOfClass("UIGradient")
    if not uiGradient then
        uiGradient = Instance.new("UIGradient")
        uiGradient.Parent = obj
    end
    uiGradient.Color = gradientSequence
    if obj:IsA("TextLabel") then
        obj.TextColor3 = Color3.new(1, 1, 1)
    elseif obj:IsA("ImageLabel") then
        obj.ImageColor3 = Color3.new(1, 1, 1)
    elseif obj:IsA("UIStroke") then
        obj.Color = Color3.new(1, 1, 1)
    end
    table.insert(activeGradients, uiGradient)
end

local function unclipChain(obj)
    local p = obj
    while p and p ~= game do
        if p:IsA("GuiObject") then
            if p.ClipsDescendants then
                log("关闭裁剪:", p:GetFullName())
            end
            p.ClipsDescendants = false
        end
        p = p.Parent
    end
end

local function getCoinsDisplay()
    local player = Players.LocalPlayer
    if not player then return nil end
    local ok, result = pcall(function()
        local menu = player.PlayerGui:WaitForChild("MenuGui", 5)
        if not menu then return nil end
        local topRight = menu:WaitForChild("TopRight", 3)
        if not topRight then return nil end
        local coinsFrame = topRight:WaitForChild("CoinsFrame", 3)
        if not coinsFrame then return nil end
        return coinsFrame:WaitForChild("CoinsDisplay", 3)
    end)
    if ok and result then
        log("找到 CoinsDisplay:", result:GetFullName())
        return result
    end
    warnLog("标准路径没找到，深度搜索 PlayerGui...")
    for _, d in ipairs(player.PlayerGui:GetDescendants()) do
        if d:IsA("GuiObject") and d.Name == "CoinsDisplay" then
            log("兜底找到:", d:GetFullName())
            return d
        end
    end
    return nil
end

local function scaleUp(imgLabel)
    if not imgLabel or not imgLabel:IsA("ImageLabel") then return end
    local uiScale = imgLabel:FindFirstChildOfClass("UIScale")
    if not uiScale then
        uiScale = Instance.new("UIScale")
        uiScale.Parent = imgLabel
    end
    uiScale.Scale = IMG_SCALE
    imgLabel.ZIndex = math.max(imgLabel.ZIndex, 10)
end

local function applyCoinEffect()
    local ok, err = pcall(function()
        local CoinsDisplay = getCoinsDisplay()
        if not CoinsDisplay then
            warnLog("没找到 CoinsDisplay")
            return
        end
        currentDisplay = CoinsDisplay
        unclipChain(CoinsDisplay)
        CoinsDisplay.ClipsDescendants = false
        activeGradients = {}
        local coinAsset = getCoinAsset()
        local imgCount, txtCount = 0, 0
        for _, d in ipairs(CoinsDisplay:GetDescendants()) do
            if d:IsA("ImageLabel") then
                imgCount = imgCount + 1
                d.ClipsDescendants = false
                if coinAsset then
                    d.Image = coinAsset
                    d.ScaleType = Enum.ScaleType.Fit
                    log("替换图片:", d:GetFullName())
                else
                    warnLog("coinAsset 为 nil，保留原图:", d:GetFullName())
                end
                scaleUp(d)
                applyGradient(d)
            elseif d:IsA("TextLabel") then
                txtCount = txtCount + 1
                applyGradient(d)
            end
            local stroke = d:FindFirstChildOfClass("UIStroke")
            if stroke then
                stroke.LineJoinMode = Enum.LineJoinMode.Round
                applyGradient(stroke)
            end
        end
        log(("CoinsDisplay 内: ImageLabel=%d, TextLabel=%d"):format(imgCount, txtCount))
        if not CoinsDisplay:FindFirstChildOfClass("UICorner") then
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = CoinsDisplay
        end
        local frameStroke = CoinsDisplay:FindFirstChildOfClass("UIStroke")
        if not frameStroke then
            frameStroke = Instance.new("UIStroke")
            frameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            frameStroke.Thickness = 3
            frameStroke.Parent = CoinsDisplay
        end
        frameStroke.LineJoinMode = Enum.LineJoinMode.Round
        applyGradient(frameStroke)
    end)
    if not ok then
        warnLog("applyCoinEffect 报错:", err)
        return false
    end
    return currentDisplay ~= nil
end

local function startAnimation()
    if coinConnection then return end
    coinConnection = RunService.RenderStepped:Connect(function(dt)
        rotation = (rotation + dt * 100) % 360
        for i = #activeGradients, 1, -1 do
            local g = activeGradients[i]
            if g and g.Parent then
                g.Rotation = rotation
            else
                table.remove(activeGradients, i)
            end
        end
    end)
end

task.spawn(function()
    applyCoinEffect()
    startAnimation()
    local waited = 0
    while not currentDisplay and waited < 30 do
        task.wait(1)
        waited = waited + 1
        if applyCoinEffect() then startAnimation() end
    end
end)

Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    if applyCoinEffect() then startAnimation() end
end)
local DUCK_ICON
do
    local url = "https://cdn.jsdelivr.net/gh/tfcm279/-b3@e832fbe27145908f15ec63cff2932544254c077d/%E9%B8%AD.png"
    local ok, res = pcall(toAsset, url, "duck_icon.png")
    if not ok then
        ok, res = pcall(toAsset, url)
    end
    if ok and res then
        DUCK_ICON = res
    else
        warn("[Coin] DUCK_ICON toAsset 失败: " .. tostring(res))
    end
end
WindUI:SetFont("BuilderSans")
WindUI:AddTheme({
    Name = "鸭",
    Background = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#F5C518"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#8B6914"), Transparency = 0 },
    }, { Rotation = 0 }),
    WindowBackground = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#E0B020"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#6B4F10"), Transparency = 0 },
    }, { Rotation = 0 }),
    Text = Color3.fromHex("#000000"),
    Placeholder = Color3.fromHex("#333333"),
    Icon = Color3.fromHex("#000000"),
    Accent = Color3.fromHex("#EAB308"),
    BackgroundTransparency = 0,
    Outline = Color3.fromHex("#2A2A2E"),
    Hover = Color3.fromHex("#FACC15"),
    WindowShadow = Color3.fromHex("#000000"),
    DialogBackground = Color3.fromHex("#161618"),
    DialogBackgroundTransparency = 0,
    DialogTitle = Color3.fromHex("#000000"),
    DialogContent = Color3.fromHex("#000000"),
    DialogIcon = Color3.fromHex("#000000"),
    WindowTopbarButtonIcon = Color3.fromHex("#000000"),
    WindowTopbarTitle = Color3.fromHex("#000000"),
    WindowTopbarAuthor = Color3.fromHex("#333333"),
    WindowTopbarIcon = Color3.fromHex("#000000"),
    TabBackground = Color3.fromHex("#1F1F23"),
    TabTitle = Color3.fromHex("#000000"),
    TabIcon = Color3.fromHex("#000000"),
    ElementBackground = Color3.fromHex("#18181B"),
    ElementTitle = Color3.fromHex("#000000"),
    ElementDesc = Color3.fromHex("#333333"),
    ElementIcon = Color3.fromHex("#000000"),
    PopupBackground = Color3.fromHex("#161618"),
    PopupBackgroundTransparency = 0,
    PopupTitle = Color3.fromHex("#000000"),
    PopupContent = Color3.fromHex("#000000"),
    PopupIcon = Color3.fromHex("#000000"),
    Toggle = Color3.fromHex("#27272A"),
    ToggleBar = Color3.fromHex("#EAB308"),
    Checkbox = Color3.fromHex("#3F3F46"),
    CheckboxIcon = Color3.fromHex("#000000"),
    Slider = Color3.fromHex("#27272A"),
    SliderThumb = Color3.fromHex("#EAB308"),
})

local Window = WindUI:CreateWindow({
    Title = "鸭脚本",
    Icon = DUCK_ICON or "duck",
    Author = "我是给",
    Folder = "MySuperHub",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    ToggleKey = Enum.KeyCode.LeftShift,
    Theme = "鸭",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function() print("clicked") end,
    },
})
Window:SetIconSize(42)
Window:EditOpenButton({
    Title = "鸭脚本",
    Icon = DUCK_ICON or "duck",
    Size = UDim2.fromOffset(64, 64),
    CornerRadius = UDim.new(16, 0),
    StrokeThickness = 4,
    Color = ColorSequence.new(
        Color3.fromHex("F5C518"),
        Color3.fromHex("8B6914")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:Tag({
    Title = "一些是借助ai来完成的（我很懒）",
    Icon = "github",
    Color = Color3.fromHex("#000000"),
    TextColor = Color3.fromHex("#FFFFFF"),
    Radius = 100,
})

Window:Tag({
    Title = "BX制作",
    Icon = "github",
    Color = Color3.fromHex("#000000"),
    TextColor = Color3.fromHex("#FFFFFF"),
    Radius = 100,
})

local NB = Window:Tab({
    Title = "FTAP脚本汉化",
    Icon = "languages",
    Locked = false,
})

local SZ = Window:Tab({
    Title = "其他FTAP脚本",
    Icon = "server-plus",
    Locked = false,
})
NB:Button({
    Title = "汉化FTAP脚本",
    Icon = "languages",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/dbCdFNXh/raw"))()
    end,
})

NB:Button({
    Title = "汉化FTAP（2）脚本",
    Icon = "languages",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/pB2a09BD/raw"))()
    end,
})

NB:Button({
    Title = "汉化FTAP（3）脚本",
    Icon = "languages",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://github.com/tfcm279/-b3/blob/main/%E9%B8%AD%E8%84%9A%E6%9C%AC.lua"))()
    end,
})

NB:Button({
    Title = "汉化FTAP（4）脚本",
    Icon = "languages",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tfcm279/-b3/refs/heads/main/%E6%B1%89%E5%8C%965.lua"))()
    end,
})

NB:Button({
    Title = "汉化FTAP（5）脚本",
    Icon = "languages",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tfcm279/-b3/refs/heads/main/%E6%B1%89%E5%8C%966.lua"))()
    end,
})
NB:Button({
    Title = "汉化FTAP（6）脚本",
    Icon = "languages",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tfcm279/-b3/refs/heads/main/%E6%B1%89%E5%8C%967.lua"))()
    end,
})
NB:Button({
    Title = "汉化FTAP（7）脚本",
    Icon = "languages",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tfcm279/-b3/refs/heads/main/%E6%B1%89%E5%8C%969.lua"))()
    end,
})
SZ:Button({
    Title = "第二强的（要卡密）",
    Icon = "languages",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://vault.pandauth.com/vss/863b48637365303f"))()
    end,
})

SZ:Button({
    Title = "1. Vortex",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Fling-Things-and-People-FTAP-Vortex-Hub-228539"))()
    end,
})

SZ:Button({
    Title = "2. Apex V2",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://paste.c-net.org/HorridPrivate"))()
    end,
})

SZ:Button({
    Title = "3. NeverLose",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/ATPWcoEb/raw"))()
    end,
})

SZ:Button({
    Title = "4. Blitz",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/BHQ1xXjK/raw"))()
    end,
})

SZ:Button({
    Title = "5. XOCU 2",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dray29471-del/VIZERbest/refs/heads/main/VIZERbest.lua"))()
    end,
})

SZ:Button({
    Title = "6. Oblivion",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/safonovmaksima-commits/65ca3fad4743c91ebbf5fadf5bebe066/raw/ed95e5a9b06de9b134422c0531e3aa406cd9af7b/vhr222"))()
    end,
})

SZ:Button({
    Title = "7. Fake resonance",
    Desc = "视觉菜单（无实际功能）",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/FNbok8Ua/raw"))()
    end,
})

SZ:Button({
    Title = "8. Unstable",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://doitenroi.win/paste/rlKgQK/raw"))()
    end,
})

SZ:Button({
    Title = "9. Bloody v2",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/celestialteam/youhateme/refs/heads/main/BloodyPremiumCrack.lua"))()
    end,
})

SZ:Button({
    Title = "10. Pluton",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://doitenroi.win/paste/A1x9Ra/raw"))()
    end,
})

SZ:Button({
    Title = "11. Poop hub premium",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://paste.c-net.org/VacatePicking"))()
    end,
})

SZ:Button({
    Title = "12. Lunar",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/bscLo4n8/raw"))()
    end,
})

SZ:Button({
    Title = "13. Unknown hub",
    Desc = "kotakbas client",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/LXAlE7iF/raw"))()
    end,
})

SZ:Button({
    Title = "14. Ragalic",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/Chk68Dbv/raw"))()
    end,
})

SZ:Button({
    Title = "15. Rr9",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/aVIt6mOJ/raw"))()
    end,
})

SZ:Button({
    Title = "16. Allun",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/OrWdkmOz/raw"))()
    end,
})

SZ:Button({
    Title = "17. Mobile trigger bot",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/srfwxEOM/raw"))()
    end,
})

SZ:Button({
    Title = "18. Fanatic ftap",
    Desc = "需要密钥",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/oElOKErG/raw"))()
    end,
})

SZ:Button({
    Title = "19. Fatalytyz",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/q8DLElpm/raw"))()
    end,
})

SZ:Button({
    Title = "20. Fosfor visuals",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/lOP2dXal/raw"))()
    end,
})

SZ:Button({
    Title = "21. Tokra",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/ccBEGiz7/raw"))()
    end,
})

SZ:Button({
    Title = "22. екоnаns",
    Desc = "非常容易出 bug",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/FOnKbxWU/raw"))()
    end,
})

SZ:Button({
    Title = "23. theWorst free",
    Desc = "原始版本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/m1kp0/ftap/refs/heads/main/TheWorstFreeLoader.lua"))()
    end,
})

SZ:Button({
    Title = "24. NNhub",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/72XjOBdT/raw"))()
    end,
})

SZ:Button({
    Title = "25. Eris",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/PTcKa7zg/raw"))()
    end,
})

SZ:Button({
    Title = "26. Nile",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/w0TpJ7bn/raw"))()
    end,
})

SZ:Button({
    Title = "27. NeoLose",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/X3CmLQHP/raw"))()
    end,
})

SZ:Button({
    Title = "28. Silent target hub",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/v9CUbtQQ/raw"))()
    end,
})

SZ:Button({
    Title = "29. Savitar",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://paste.c-net.org/FleetDisgrace"))()
    end,
})

SZ:Button({
    Title = "30. Drun script",
    Desc = "提示一律回答 da",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://paste.c-net.org/BeggingShady"))()
    end,
})

SZ:Button({
    Title = "31. Mercury",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://paste.c-net.org/ResignDolly"))()
    end,
})

SZ:Button({
    Title = "32. The revenge",
    Desc = "FTAP 脚本",
    Icon = "code",
    IconAlign = "Left",
    Callback = function()
        loadstring(game:HttpGet("https://paste.c-net.org/CornerKeepers"))()
    end,
})