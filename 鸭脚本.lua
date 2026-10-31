loadstring(game:HttpGet("https://raw.githubusercontent.com/SaturnGroup02/Sakura-Hub-main/refs/heads/main/Sakura%20main"))()
task.wait(3)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SelectAmericaPrompt"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Name = "PromptFrame"
frame.Size = UDim2.fromOffset(400, 120)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local label = Instance.new("TextLabel")
label.Name = "PromptText"
label.Size = UDim2.fromScale(1, 1)
label.BackgroundTransparency = 1
label.Text = "请选择美国，版本最新"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Parent = frame

task.delay(5, function()
    if not screenGui.Parent then
        return
    end

    local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    local frameTween = TweenService:Create(frame, tweenInfo, {
        BackgroundTransparency = 1
    })
    local labelTween = TweenService:Create(label, tweenInfo, {
        TextTransparency = 1
    })

    frameTween:Play()
    labelTween:Play()

    frameTween.Completed:Once(function()
        screenGui:Destroy()
    end)
end)
task.wait(10)
local Translations = {
    ["Me(=^・^=)"] = "个人设置",
    ["GUI"] = "界面设置",
    ["Anti"] = "防御",
    ["Attack"] = "攻击",
    ["Server Manager"] = "滚木",
    ["Hijack Train"] = "火车",
    ["Sheet Music"] = "自动弹琴",
    ["SRBM"] = "玩具",
    ["CN_BX"] = "BX汉化",
    ["Info & Support"] = "信息与支持",
    ["Interface Hidden"] = "界面已隐藏",
    ["Tap K to reopen the interface"] = "按 K 键重新打开界面",

    ["Movement Features"] = "移动功能",
    ["Infinite Jump"] = "无限跳跃",
    ["Noclip"] = "穿墙",
    ["TPWalk"] = "行走",
    ["TPWalk Speed"] = "行走速度",
    ["Visual Features"] = "视觉功能",
    ["ESP"] = "透视",
    ["Third Person View"] = "第三人称视角",
    ["FOV"] = "视野范围",
    ["Reset FOV"] = "重置视野",
    ["Control"] = "控制",
    ["Stop All Features"] = "停止所有功能",
    
    ["Refresh Player List"] = "刷新玩家列表",
    ["Drift Kick V2"] = "漂移踢 V2（翻译就这样）",
    ["Send Flying"] = "甩飞",
    ["Select Player"] = "选择玩家",
    ["Send Flying!"] = "执行甩飞9191",
    ["Send Flying Additional Features"] = "击飞附加功能",
    ["Kick All"] = "踢出所有人",
    ["Exclude Friends"] = "排除好友",
    ["Status"] = "状态",
    ["Current state information"] = "当前状态信息",
    ["Current Target V1: None"] = "当前目标 V1: 无",
    ["Status V1: Stopped"] = "状态 V1: 已停止",
    ["Sphere Orbit Kick V1"] = "球形环绕踢 V1",
    ["Target Player"] = "目标玩家",
    ["Execute (Sphere Orbit Kick)"] = "执行 (球形环绕踢)",
    ["Stop"] = "停止",
    ["Orbit Radius"] = "环绕半径",
    ["Orbit Speed"] = "环绕速度",
    ["Float Height"] = "漂浮高度",
    ["Sphere Tilt"] = "球体倾斜",
    ["Orbit Complexity"] = "环绕复杂度",
    ["Show Effects"] = "显示特效",
    ["Description"] = "描述",
    ["Rapidly rotates in a 3D spherical orbit around the target, delivering a powerful drift kick. Rotates 360 degrees in all X, Y, Z directions."] = "围绕目标进行 3D 球形快速旋转，并造成强力的漂移踢。在 X、Y、Z 轴上 360 度旋转。",
    ["Warning!"] = "警告！",
    ["Do NOT abuse!"] = "请勿滥用！",
    ["Kick V1 (Blob Grab)"] = "踢人 V1 (史莱姆抓取)",
    ["Loop Kick V1 (Grab + Blob)"] = "循环踢人 V1 (抓取 + 史莱姆)",
    ["Kick V2 (Orbit & Grab)"] = "踢人 V2 (环绕 & 抓取)",
    ["Select Target"] = "选择目标",

    ["⚠ Do not abuse"] = "⚠ 请勿滥用（我是给）",
    ["Test feature for server owners."] = "供服务器所有者测试的功能。",
    ["Do not run on other people's servers."] = "请勿在他人的服务器上运行。",
    ["Test Execution"] = "测试执行",
    ["Server Crash Test (standalone, 35 consecutive runs)"] = "服务器崩溃测试 (单次，连续35次)",
    ["Auto Crash Mode (infinite loop)"] = "自动崩溃模式 (无限循环)",
    ["Information"] = "信息",
    ["Usage"] = "用法",
    ["URLs Used"] = "使用的网址",
    ["Notes"] = "注意事项",

    ["Seat Operations"] = "座位操作",
    ["Sit on Random Empty Seat"] = "随机坐在空座位上",
    ["Automation Settings"] = "自动化设置",
    ["Enable Automation"] = "启用自动化",
    ["Automation Behavior"] = "自动化行为",
    ["On board/alight: Spawn -> Hold -> Use -> Discard"] = "上车/下车: 生成 -> 持有 -> 使用 -> 丢弃",
    ["PC Useful Features"] = "PC 实用功能",
    ["Launch vFly GUI"] = "启动 vFly 界面",
    ["vFly GUI"] = "vFly 界面",
    ["WASD+QE flight, includes Noclip feature."] = "WASD+QE 飞行，包含穿墙功能。",

    ["Piano Control"] = "钢琴控制",
    ["Enable Piano Feature"] = "启用钢琴功能",
    ["Follow Player"] = "跟随玩家",
    ["Default Songs"] = "默认歌曲",
    ["Select a song to play"] = "选择要弹奏的歌曲",
    ["Play Girl A (少女A)"] = "播放少女A",
    ["Play 공격이다 (It's an Attack)"] = "播放 공격이다 (It's an Attack)",
    ["Play MONTAGEM_HIKARI"] = "播放 MONTAGEM_HIKARI",
    ["Stop Playing"] = "停止播放",
    ["Play Song (Text Input)"] = "播放歌曲 (文本输入)",
    ["Enter JSON Data"] = "输入 JSON 数据",
    ["Input"] = "输入",
    ["Play Entered Song"] = "播放输入的歌曲",
    ["MIDI -> JSON Converter"] = "MIDI -> JSON 转换器",
    ["Open Converter (Browser)"] = "打开转换器 (浏览器)",
    ["Copy URL"] = "复制链接",
    ["How to Use"] = "如何使用",
    ["Supported range: C4 to C6 (2 octaves)"] = "支持范围: C4 到 C6 (2个八度)",
    ["1. Open the MIDI -> JSON conversion page with 'Open Converter'"] = "1. 点击 '打开转换器' 打开网页",
    ["2. Upload a MIDI file and convert"] = "2. 上传 MIDI 文件并转换",
    ["3. Copy the generated JSON"] = "3. 复制生成的 JSON 代码",
    ["4. Paste into 'Enter JSON Data' above and play"] = "4. 粘贴到上方的 '输入 JSON 数据' 中并播放",

    ["Note"] = "注意",
    ["SRBM features can only obtain your own objects!"] = "SRBM 功能只能获取你自己的物品！",
    ["HUD Display"] = "HUD 显示",
    ["HUD Display (Image + Coords)"] = "HUD 显示 (图片 + 坐标)",
    ["Toggle Visibility with P Key (Info)"] = "按 P 键切换可见性 (信息)",
    ["ICBM"] = "洲际导弹",
    ["Third Person"] = "第三人称",
    ["Helicopter Control"] = "直升机控制",
    ["Toy Mode"] = "玩具模式",
    ["Load Resource Pack"] = "加载资源包",
    ["Resource Pack V1"] = "资源包 V1",
    ["Replaces the appearance of TractorGreen with another model."] = "将绿色拖拉机的外观替换为其他模型。",
    ["Script Hub"] = "脚本中心",
    ["⚠ Note"] = "⚠ 注意",
    ["Some external scripts are developed outside Sakura Hub. No guarantee."] = "部分外部脚本在樱花Hub之外开发，不保证安全性。",
    ["Load External Scripts"] = "加载外部脚本",
    ["Shader"] = "光影着色器",
    ["Shader 2"] = "光影着色器 2",
    ["Sky Change"] = "改变天空",
    ["Tetris"] = "俄罗斯方块",
    ["Kurosuke's V-Style Flight"] = "黑助的 V型飞行",
    ["HokutoHUB"] = "北斗脚本库",
    ["Backrooms"] = "后室",
    ["Translate UI to Japanese"] = "将界面翻译为日语",
    ["FTAP TP"] = "点击传送",
    ["All Object IDs (28 types):"] = "所有物品 ID (28种):",
    ["Supported objects: 28 types"] = "支持的物品: 28种",
    ["Barrier Break"] = "破坏屏障",
    ["Barrier Break Feature"] = "屏障破坏功能",
    ["Barrier Break (BETA)"] = "破坏屏障 (测试版)",

    ["Activate Feather"] = "激活羽毛翅膀",
    ["Max Object Count"] = "最大物品数量",
    ["Object Spacing"] = "物品间距",
    ["Height Offset"] = "高度偏移",
    ["Back Offset"] = "后方偏移",
    ["Tilt Angle"] = "倾斜角度",
    ["Wave Speed"] = "波浪速度",
    ["Base Amplitude"] = "基础振幅",
    ["Activate Wing V2"] = "激活翅膀 V2",
    ["Wing Height Position"] = "翅膀高度位置",
    ["Wing Spread"] = "翅膀展开程度",
    ["Flap Shape"] = "扇动形状",
    ["Flap Speed"] = "扇动速度",
    ["Flap Range"] = "扇动范围",
    ["Objects per Wing"] = "每侧翅膀物品数",
    ["Chain Delay"] = "链接延迟",
    ["Saturn-Type Sparkler Controller"] = "土星型烟花控制器",
    ["Enable"] = "启用",
    ["Placement Mode"] = "放置模式",
    ["Base Height"] = "基础高度",
    ["Follow Speed"] = "跟随速度",
    ["Ring Settings"] = "圆环设置",
    ["Ring Radius"] = "圆环半径",
    ["Ring Speed"] = "圆环速度",
    ["Sphere Settings"] = "球体设置",
    ["Sphere Radius"] = "球体半径",
    ["Sphere Speed"] = "球体速度",
    ["Sphere Layer Count"] = "球体层数",
    ["Plot Settings"] = "绘图设置",
    ["Plot Spread Radius"] = "绘图扩散半径",
    ["Rescan"] = "重新扫描",
    ["Activate Magic Circle"] = "激活魔法阵",
    ["Symbol Type"] = "符号类型",
    ["Glow Effect"] = "发光特效",
    ["Height"] = "高度",
    ["Diameter"] = "直径",
    ["Object Count"] = "物品数量",
    ["Rotation Speed"] = "旋转速度",
    ["Basic Settings"] = "基础设置",
    ["Activate Tornado Toy MOD"] = "激活龙卷风玩具 MOD",
    ["Tornado Effect (Spiral)"] = "龙卷风特效 (螺旋)",
    ["Size Settings"] = "大小设置",
    ["Base Radius"] = "基础半径",
    ["Total Height"] = "总高度",
    ["Firework Count"] = "烟花数量",
    ["Motion Settings"] = "运动设置",
    ["Spiral Speed"] = "螺旋速度",
    ["Wave Amplitude"] = "波浪振幅",
    ["Redetect Fireworks"] = "重新检测烟花",
    ["Activate Ferris Wheel"] = "激活摩天轮",
    ["Vertical Circle"] = "垂直圆环",
    ["Use Fixed Direction"] = "使用固定方向",
    ["Fixed Yaw"] = "固定偏航角 (左右)",
    ["Fixed Pitch"] = "固定俯仰角 (上下)",
    ["Fixed Roll"] = "固定翻滚角 (侧翻)",
    ["Radius"] = "半径",
    ["Center Height"] = "中心高度",
    ["Activate Heart"] = "激活爱心",
    ["Heart Size"] = "爱心大小",
    ["Pulse Speed"] = "脉冲速度",
    ["Pulse Amplitude"] = "脉冲振幅",

    ["Defense Features"] = "防御功能",
    ["Escape When Grabbed (Simple)"] = "被抓时逃脱 (简单版)",
    ["Anti Grab V2 (Enhanced)"] = "防抓取 V2 (增强版)",
    ["Escape When Grabbed (Simple): Struggle spam + Anchor"] = "简单版：疯狂挣扎 + 锚定",
    ["Anti Grab V2 (Enhanced): Collision off + Ragdoll release + Physics lock"] = "增强版：关闭碰撞 + 解除布娃娃 + 物理锁定",
    ["Anti Gucci"] = "防Gucci控制",
    ["Anti Void"] = "防虚空",
    ["Anti Void prevents falling into the void"] = "防虚空可防止掉入虚空死亡",
    ["Fix GUI"] = "修复界面",
    ["TP GUI"] = "传送界面",
    ["TTP GUI"] = "点击传送界面",
    ["Keyboard GUI"] = "键盘界面",

    ["Official Links (Press button to copy URL)"] = "官方链接 (点击复制网址)",
    ["Developer [Saturn Group] Official Site"] = "开发者 [土星集团] 官方网站",
    ["Sakurahub Official Site"] = "樱花Hub官方网站",
    ["Sakurahub Related Repo 1 (Sakura-Hub-main)"] = "樱花Hub相关仓库 1 (Sakura-Hub-main)",
    ["Sakurahub Related Repo 2 (Sakurahub-ja-en-vn-123-)"] = "樱花Hub相关仓库 2 (Sakurahub-ja-en-vn-123-)",
    ["Sakurahub Related Repo 3 (Sakurahub-SabuHUB)"] = "樱花Hub相关仓库 3 (Sakurahub-SabuHUB)",
    ["Sakurahub Related Repo 4 (Sakurahub-beta)"] = "樱花Hub相关仓库 4 (Sakurahub-beta)",
    ["Support Server"] = "支持服务器",
    ["Join Support Server [Discord Global]"] = "加入支持服务器 [Discord 全球]",
    ["Join Support Server [LINE Open Chat Japan Only]"] = "加入支持服务器 [LINE 仅限日本]",
    ["URL Copied"] = "网址已复制",
    ["'s URL copied to clipboard"] = "的网址已复制到剪贴板",
    ["Details"] = "详细信息",
    ["Version: V0.7.2.140"] = "版本: V0.7.2.140",
    ["Development Group: 土星グループ"] = "开发团队: 土星集团",
    ["Developers List (Press button to copy URL)"] = "开发者列表 (点击复制网址)",

    ["N1: Chaos Circle"] = "N1: 混沌之环",
    ["Activate N1"] = "激活 N1",
    ["Pulse Amount"] = "脉冲量",
    ["Jitter Speed"] = "抖动速度",
    ["Jitter Amount"] = "抖动幅度",
    
    ["N2: Tornado Spiral"] = "N2: 龙卷风螺旋",
    ["Activate N2"] = "激活 N2",
    ["Max Height"] = "最大高度",
    ["Rise Speed"] = "上升速度",
    ["Chaos Factor"] = "混沌系数",

    ["N3: Hyper Explosion"] = "N3: 超级爆炸",
    ["Activate N3"] = "激活 N3",
    ["Explosion Radius"] = "爆炸半径",
    ["Cycle Speed"] = "循环速度",
    ["Randomness"] = "随机度",

    ["Sphere"] = "球体",
    ["Activate Sphere"] = "激活球体",
    ["Latitude Lines"] = "纬度线",
    ["Longitude Lines"] = "经度线",
    ["Horizontal Rotation Speed"] = "水平旋转速度",
    ["Vertical Rotation Speed"] = "垂直旋转速度",

    ["Star of David"] = "六芒星",
    ["Activate Star of David"] = "激活六芒星",
    ["Star Size"] = "星星大小",
    ["Triangle Height"] = "三角形高度",

    ["Star"] = "星星",
    ["Activate Star"] = "激活星星",
    ["Outer Radius"] = "外半径",
    ["Inner Radius"] = "内半径",
    ["Twinkle Speed"] = "闪烁速度",

    ["Star2"] = "星星2",
    ["Activate Star2"] = "激活星星2",
    ["Base Size"] = "基础大小",
    ["Ray Length"] = "射线长度",
    ["Ray Count"] = "射线数量",

    ["卍 (Manji)"] = "卍 (万字符)",
    ["卍 (Both directions)"] = "卍 (双向)",
    ["Manji Size"] = "卍大小",
    ["Drawing Speed"] = "绘制速度",
    ["Rescan Sparklers"] = "重新扫描烟花",
    ["1. Place at least 2 FireworkSparklers"] = "1. 至少放置2个烟花",
    ["2. Toggle ON to draw 卍"] = "2. 开启以绘制卍",
    ["3. Size and speed are adjustable"] = "3. 大小和速度可调",

    ["Vertical Big"] = "垂直大爱心",
    ["Activate Vertical Big"] = "激活垂直大爱心",
    ["Scale Factor"] = "缩放比例",
    ["Vertical Stretch"] = "垂直拉伸",
    ["Big"] = "大爱心",
    ["Activate Big Heart"] = "激活大爱心",
    ["Activate Vertical Heart"] = "激活垂直爱心"
}

local sortedKeys = {}
for k, _ in pairs(Translations) do
    table.insert(sortedKeys, k)
end
table.sort(sortedKeys, function(a, b) return #a > #b end)

local function translateString(text)
    if string.match(text, "[\228-\233]") then return text end
    local translated = text
    for _, english in ipairs(sortedKeys) do
        if string.find(translated, english, 1, true) then
            local chinese = Translations[english]
            local pattern = english:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
            translated = string.gsub(translated, pattern, chinese)
        end
    end
    return translated
end

local function processInstance(instance)
    if not (instance:IsA("TextLabel") or instance:IsA("TextButton") or instance:IsA("TextBox")) then return end
    
    local currentText = instance.Text
    if currentText == "" then return end
    
    local newText = translateString(currentText)
    if newText ~= currentText then
        if not instance:GetAttribute("IsTranslating") then
            instance:SetAttribute("IsTranslating", true)
            instance.Text = newText
            pcall(function()
                instance.TextWrapped = true
                if string.match(newText, "[\228-\233]") and instance.TextSize > 12 then
                    instance.TextSize = 12
                end
            end)
            task.delay(0.1, function()
                if instance then instance:SetAttribute("IsTranslating", false) end
            end)
        end
    end
end

local function hookInstance(instance)
    processInstance(instance)
    instance:GetPropertyChangedSignal("Text"):Connect(function()
        processInstance(instance)
    end)
end

local function traverse(parent)
    for _, child in pairs(parent:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            hookInstance(child)
        end
    end
end

local function init()
    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    traverse(playerGui)
    
    local success, coreGui = pcall(function() return game:GetService("CoreGui") end)
    if success then traverse(coreGui) end
    
    local function onDescendantAdded(desc)
        if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
            task.defer(hookInstance, desc)
        end
    end
    
    playerGui.DescendantAdded:Connect(onDescendantAdded)
    if success and coreGui then coreGui.DescendantAdded:Connect(onDescendantAdded) end
end

init()
