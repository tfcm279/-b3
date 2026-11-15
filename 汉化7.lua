loadstring(game:HttpGet("https://raw.githubusercontent.com/celestialteam/youhateme/refs/heads/main/BloodyPremiumCrack.lua"))()

task.wait(1.5)

local Translations = {
    ["Toggle"] = "开关",
    ["Lock"] = "锁定",
    ["Bloody V2"] = "Bloody V2",
    ["Player"] = "玩家",
    ["Invincibility"] = "无敌/防身",
    ["Grab & Lines"] = "抓取与连线",
    ["Loop"] = "循环",
    ["Auras"] = "光环",
    ["Explosions"] = "爆炸",
    ["Server"] = "服务器",
    ["Misc"] = "杂项",
    ["Fun"] = "趣味",
    ["Body Form [BETA]"] = "身体变形 [测试版]",
    ["Keybind"] = "按键绑定",
    ["Visual"] = "视觉",
    ["Whitelist"] = "白名单",

    ["WalkSpeed"] = "行走速度",
    ["WalkSpeed Value"] = "行走速度值",
    ["JumpPower"] = "跳跃力",
    ["JumpPower Value"] = "跳跃力值",
    ["Infinite Jump"] = "无限跳跃",
    ["Miscellaneous"] = "其他",
    ["Infinite Zoom"] = "无限缩放",
    ["Walk on Water"] = "水上行走",
    ["Noclip"] = "穿墙",
    ["Camera"] = "视角",
    ["Custom FOV"] = "自定义视野",
    ["FOV Value"] = "视野值",
    ["Gravity"] = "重力",
    ["Custom Gravity"] = "自定义重力",
    ["Gravity Value"] = "重力值",

    ["Anti Grab"] = "防抓取",
    ["anti gucci"] = "防Gucci",
    ["Invisibility / train Gucci"] = "隐身/防火车Gucci",
    ["Auto Attack"] = "自动攻击",
    ["Mode"] = "模式",
    ["Death"] = "死亡",
    ["Sky"] = "天空",
    ["TpToSpawn"] = "传送至出生点",
    ["BigFling"] = "强力甩飞",
    ["Crazy"] = "疯狂",
    ["Anti Utility"] = "防身工具",
    ["Anti-Kick"] = "防踢",
    ["Anti Defense"] = "防御反制",
    ["Anti-Explosion"] = "防爆炸",
    ["Anti Poison"] = "防中毒",
    ["Anti Burn"] = "防燃烧",
    ["Anti Banana"] = "防香蕉",
    ["Anti Banana v2"] = "防香蕉 v2",
    ["Anti Paint"] = "防油漆",
    ["Stability"] = "稳定性",
    ["Anti Lag"] = "防卡顿",
    ["Anti Void"] = "防虚空",
    ["Anti Character"] = "防角色控制",
    ["Anti Sticky"] = "防粘性",
    ["Anti Blobman"] = "防雪人",
    ["Anti Loop"] = "防循环",
    ["Anti Loop Ownership"] = "防循环所有权",
    ["Anti Loop Ownership V2"] = "防循环所有权 V2",
    ["Anti Blobkill"] = "防雪人击杀",
    ["button"] = "按钮",

    ["Grab"] = "抓取",
    ["Kill Grab"] = "击杀抓取",
    ["Noclip Grab"] = "穿墙抓取",
    ["kick Grab"] = "踢出抓取",
    ["Credits"] = "鸣谢",
    ["Ragdoll Grab"] = "布娃娃抓取",
    ["Massless Grab"] = "无质量抓取",
    ["Massless Sense"] = "无质量感知",
    ["Crazy Grab"] = "疯狂抓取",
    ["Fling Air Grab"] = "空中甩飞抓取",
    ["Spin Grab"] = "旋转抓取",
    ["Spin Speed"] = "旋转速度",
    ["Strenght"] = "强度",
    ["Strength (PC)"] = "强度 (PC)",
    ["Strength (Mobile)"] = "强度 (移动端)",
    ["Strength Force"] = "强度力度",
    ["Anchor"] = "锚定",
    ["Anchor Grab"] = "锚定抓取",
    ["Unanchor Parts"] = "取消锚定部件",
    ["Groups"] = "分组",
    ["Compile Parts"] = "拼装部件",
    ["Select Group"] = "选择分组",
    ["Delete Selected Group"] = "删除选中分组",
    ["Delete All Group"] = "删除所有分组",
    ["Line"] = "连线",
    ["Extend Line (Mobile)"] = "延伸连线 (移动端)",
    ["Extend Line (PC)"] = "延伸连线 (PC)",
    ["Scroll Force"] = "滑动力度",
    ["Others Lines"] = "其他连线",
    ["Invisible Line"] = "隐形连线",
    ["Crazy Line"] = "疯狂连线",
    ["Spinning Rainbow Line"] = "旋转彩虹连线",
    ["Lag"] = "卡顿",
    ["Lag Intensity"] = "卡顿强度",

    ["TARGET"] = "目标",
    ["Select Player"] = "选择玩家",
    ["Harmless"] = "无害",
    ["Bring"] = "拉过来",
    ["Spectate"] = "观战",
    ["Loop Teleport"] = "循环传送",
    ["Kill"] = "击杀",
    ["Loop Blobkill"] = "循环雪人击杀",
    ["Loop Kill"] = "循环击杀",
    ["Kick"] = "踢出",
    ["Loop Kick"] = "循环踢出",
    ["Spam Kick Grab"] = "无限踢出抓取",
    ["Silent Kick"] = "静默踢出",
    ["Basic Lock"] = "基础锁定",
    ["Mid Lock"] = "中级锁定",
    ["Ultimate Lock"] = "终极锁定",
    ["Loop Fling"] = "循环甩飞",
    ["Utility"] = "实用工具",
    ["Auto Freeze Blobman"] = "自动冻结雪人",

    ["OP Auras"] = "强力光环",
    ["Void Aura"] = "虚空光环",
    ["Kick Aura"] = "踢出光环",
    ["Grab Aura"] = "抓取光环",
    ["Throw Aura"] = "投掷光环",
    ["ThrowSpeed"] = "投掷速度",
    ["Objects & Players Auras"] = "物体与玩家光环",
    ["Telekinesis Aura"] = "念力光环",
    ["Impact"] = "影响目标",
    ["Players"] = "玩家",
    ["Objects"] = "物体",
    ["Player & Object"] = "玩家与物体",
    ["Distance"] = "距离",
    ["Height"] = "高度",
    ["Rotation Speed"] = "旋转速度",
    ["Air Aura"] = "空中光环",
    ["Air Suspend Aura"] = "空中悬浮光环",
    ["Speed"] = "速度",
    ["Teleport"] = "传送",
    ["Teleport Aura"] = "传送光环",
    ["Teleport Location"] = "传送位置",
    ["Cursed Cloud"] = "诅咒之云",
    ["Spawn"] = "出生点",
    ["Void"] = "虚空",
    ["Cozy Place"] = "舒适之地",
    ["Big Cave"] = "大洞穴",
    ["Small Cave"] = "小洞穴",
    ["Small Cave 2"] = "小洞穴 2",
    ["Very Very Small Cave"] = "非常小的洞穴",
    ["Island Cave"] = "岛屿洞穴",
    ["Poison"] = "毒区",

    ["Missile"] = "导弹",
    ["Select Target"] = "选择目标",
    ["Settings"] = "设置",
    ["Missiles per Wave"] = "每波导弹数量",
    ["Explosion Mode"] = "爆炸模式",
    ["Delay (Sequential)"] = "延迟 (连续)",
    ["Auto Spam"] = "自动连发",
    ["Instant"] = "瞬间",
    ["Sequential"] = "连续",
    ["Missile Explosion"] = "导弹爆炸提示",

    ["Aggressive"] = "攻击性",
    ["Loopkill All"] = "循环击杀所有人",
    ["Loopkick All"] = "循环踢出所有人",
    ["Annoying"] = "烦人",
    ["LoopRagdoll All"] = "循环布娃娃所有人",
    ["LoopVomit All"] = "循环呕吐所有人",
    ["Fire All"] = "点燃所有人",
    ["Bring All"] = "拉过来所有人",

    ["Silent Aim"] = "静默自瞄",
    ["On which executor it work ?"] = "支持哪些执行器？",
    ["Silent Aim HOOK"] = "静默自瞄注入",
    ["Script"] = "脚本",
    ["Open Infinite Yield"] = "打开 Infinite Yield",
    ["Pleasant"] = "提示音",
    ["Boombox"] = "音响",
    ["Volume"] = "音量",
    ["Auto"] = "自动",
    ["Enable Auto-Spin"] = "启用自动旋转",
    ["Time Remaining:"] = "剩余时间:",

    ["Chat"] = "聊天",
    ["Enable Spam"] = "启用刷屏",
    ["Select Keyword"] = "选择关键词",
    ["Animation"] = "动画",
    ["Play Animation"] = "播放动画",
    ["Select Animation"] = "选择动画",
    ["Crouch"] = "蹲下",
    ["FireFlail"] = "火焰挥舞",
    ["Flail"] = "挥舞",
    ["Typing"] = "打字",
    ["Wings"] = "翅膀",
    ["Enable Wings"] = "启用翅膀",
    ["Pallet Amount"] = "托盘数量",
    ["Auto Regrab"] = "自动重新抓取",
    ["Wings Speed"] = "翅膀速度",
    ["Wings Angle"] = "翅膀角度",
    ["Control"] = "控制",
    ["Control X"] = "控制 X",
    ["CONTROL SYSTEM"] = "控制系统",
    ["Sparkles"] = "闪光",
    ["Target Player"] = "目标玩家",
    ["Enable Sparkle Shape"] = "启用闪光形状",
    ["Sparkler Amount"] = "闪光数量",
    ["Shape"] = "形状",
    ["Heart"] = "爱心",
    ["Size"] = "大小",

    ["Premium Info"] = "高级版信息",
    ["How to get premium ?"] = "如何获取高级版？",
    ["Copy Discord link"] = "复制 Discord 链接",
    ["Auto-Whitelist Friend"] = "自动白名单好友",
    ["Others Player"] = "其他玩家",
    ["Add to whitelist"] = "添加到白名单",
    ["Whitelisted Players"] = "白名单玩家",
    ["Remove selected"] = "移除选中",
    ["Enable Whitelist"] = "启用白名单",
    ["What does this whitelist affect ?"] = "这个白名单影响什么？",
    ["Player ESP"] = "玩家透视",
    ["Object ESP"] = "物体透视",
    ["Player Object ESP"] = "玩家物体透视",
    ["Player Highlight Color"] = "玩家高亮颜色",
    ["Object Highlight Color"] = "物体高亮颜色",
    ["Shaders"] = "光影",
    ["Beam Lights"] = "光束灯",
    ["Day/Night Mode"] = "白天/黑夜模式",
    ["Better Textures & Materials"] = "更好的纹理与材质",

    ["Keybinds"] = "按键绑定",
    ["MobileKeyboard"] = "手机键盘",
    ["Teleport to Mouse"] = "传送至鼠标",
    ["Spawn Pallet"] = "生成托盘",
    ["Limb OP"] = "肢体操作",
    ["Delete Limbs"] = "删除肢体",
    ["Aimbot player"] = "自瞄玩家",
    ["Lobotomy OP"] = "脑白质切除操作",
    ["Lobotomy"] = "脑白质切除",
    ["How to use it :"] = "如何使用：",
    ["How it work:"] = "工作原理：",

    ["Enable Form Grab"] = "启用变形抓取",
    ["Orientation"] = "方向",
    ["Form"] = "形态",
    ["Copy Movement"] = "复制移动",
    ["Drop Current Target"] = "掉落当前目标",
    ["Penis Head"] = "龟头",
    ["Height OFFSET"] = "高度偏移",
    ["Rotation TURN"] = "旋转角度",
    ["PlotBreaker"] = "破坏地盘",
    ["Auto BREAK PLOT"] = "自动破坏地盘",
    ["Desync TRACTOR"] = "不同步拖拉机",
    ["Hold"] = "持有",
    ["Eat All Food"] = "吃掉所有食物",
    ["Use all Instruments"] = "使用所有乐器",

    ["nazi cross"] = "纳粹十字",
    ["Square"] = "正方形",
    ["Triangle"] = "三角形",
    ["MiddleFinger"] = "竖中指",
    ["Dick"] = "丁丁",
    ["L"] = "L 形状",

    ["kick"] = "踢出",
    ["dead"] = "死",
    ["yo"] = "哟",
    ["ree"] = "尖叫",
    ["mad"] = "生气",
    ["uwu"] = "uwu",
    ["yav"] = "yav",
    ["yey"] = "耶",
    ["banana"] = "香蕉",
    ["spook"] = "幽灵",
    ["grr"] = "咆哮",
    ["ew"] = "恶心",
    ["lol"] = "哈哈",
    ["hehe"] = "嘿嘿",
    ["hmm"] = "嗯",
    ["dad"] = "爸爸",
    ["hold"] = "拿着",
    ["pew"] = "射击",
    ["drink"] = "喝",
    ["soda"] = "汽水",
    ["yeehaw"] = "耶哈",
    ["fly"] = "飞",
    ["ahem"] = "咳嗽",
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