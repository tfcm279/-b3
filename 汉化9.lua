loadstring(game:HttpGet("https://pastefy.app/LXAlE7iF/raw"))()
local Translations = {
    ["Toggle"] = "开关",
    ["Lock"] = "锁定",
    ["unknown hub"] = "未知中心",
    ["Search"] = "搜索",
    ["version 1.4 by funricss"] = "版本 1.4 作者 funricss",
    ["defense"] = "防御",
    ["target"] = "目标",
    ["grab"] = "抓取",
    ["player"] = "玩家",
    ["misc"] = "杂项",
    ["UI Settings"] = "界面设置",

    ["select player for kick"] = "选择要踢出的玩家",
    ["refresh player list"] = "刷新玩家列表",
    ["kick (spam grab)"] = "踢出 (无限刷抓)",
    ["loop kill (changestate)"] = "循环击杀 (改变状态)",
    ["loop kick (wusha method)"] = "循环踢出 (Wusha方式)",
    ["loop kick (INIT + PING)"] = "循环踢出 (INIT+延迟)",
    ["destroy target's gucci (sit)"] = "破坏目标Gucci (坐下)",
    ["anti antikick"] = "防防踢",
    ["anti input lag"] = "防输入延迟",
    ["kick notify"] = "踢出提示",
    ["bring"] = "拉过来",
    
    ["Ragdoll Addon"] = "布娃娃附加",
    ["add ragdoll to kick"] = "添加布娃娃至踢出",
    ["invisible pallet"] = "隐形托盘",
    
    ["No Blobman"] = "无雪人",
    ["Target"] = "目标",
    ["Refresh"] = "刷新",
    ["Method"] = "方法",
    ["Loop Grab(Kick)"] = "循环抓取(踢出)",
    ["Apply Method"] = "应用方法",
    ["Settings"] = "设置",
    ["Change Offset"] = "更改偏移",
    ["only for kick"] = "仅用于踢出",
    ["X"] = "X",

    ["Blobman Control"] = "雪人控制",
    ["spawn blobman and seat (Z)"] = "生成雪人并坐下 (Z)",
    ["whitelist"] = "白名单",
    ["whitelist people (track list)"] = "白名单玩家 (追踪列表)",
    ["refresh list"] = "刷新列表",
    ["target joined notify"] = "目标加入提示",
    ["lock - another method"] = "锁定 - 另一种方法",
    ["lock"] = "锁定",
    ["Grabs Speed"] = "抓取速度",
    ["Auto Sit"] = "自动坐下",
    ["Spectate"] = "观战",
    ["View Target"] = "查看目标",
    ["Blobman Actions"] = "雪人操作",
    ["lock input lag"] = "锁定输入延迟",
    ["kill"] = "击杀",
    ["снос гуччи инпут лагом"] = "用输入延迟破坏Gucci",
    ["Others Kick"] = "其他踢出",
    ["loop kick (input lag)"] = "循环踢出 (输入延迟)",
    ["Input Lag Bring"] = "输入延迟拉取",
    ["Bring Input Lag Blob"] = "拉取输入延迟雪人",

    ["Miscellaneous"] = "其他",
    ["tp tool (T)"] = "传送工具 (T)",
    ["water walk"] = "水上行走",
    ["packet lag"] = "数据包卡顿",
    ["toggle triggerbot"] = "开关扳机Bot",
    ["FOV"] = "视野范围",
    ["heart (grab sparkler)"] = "爱心 (抓取闪光)",
    ["Anchor Object Bind"] = "锚定物体绑定",
    ["Bring Train"] = "拉过来火车",
    ["Limb Destruction (Grabbed)"] = "肢体破坏 (被抓时)",
    ["Remove Left Leg"] = "移除左腿",
    ["Remove Right Leg"] = "移除右腿",
    ["Remove Left Arm"] = "移除左臂",
    ["Remove Right Arm"] = "移除右臂",

    ["View & Movement"] = "视角与移动",
    ["3rd person view"] = "第三人称视角",
    ["Spin Character"] = "旋转角色",
    ["Spin Speed"] = "旋转速度",
    ["Infinite Jump"] = "无限跳跃",
    ["Environment"] = "环境",
    ["vintage shaders"] = "复古光影",
    ["shaders"] = "光影",
    ["delete shaders"] = "删除光影",
    ["lite shaders"] = "轻量光影",
    ["ESP"] = "透视 (ESP)",
    ["pcld view"] = "PCLD 视角",
    ["nickname esp"] = "昵称透视",
    ["Performance"] = "性能",
    ["boost fps"] = "提升FPS",
    ["delete boost fps"] = "删除FPS提升",
    ["Movement & Bypass"] = "移动与绕过",
    ["Noclip"] = "穿墙",
    ["Bypass Speed Factor"] = "绕过速度系数",
    ["CFrame Speed (Bypass)"] = "CFrame 速度 (绕过)",

    ["Grab Customization"] = "抓取自定义",
    ["Power"] = "力量",
    ["Strength"] = "强度",
    ["Kill Grab"] = "击杀抓取",
    ["Ragdoll Grab"] = "布娃娃抓取",
    ["Nameless Grab"] = "无名抓取",
    ["Auras"] = "光环",
    ["Fling Strength"] = "甩飞强度",
    ["Fling Aura (3st Person)"] = "甩飞光环 (第三人称)",

    ["Defense Main"] = "主防御",
    ["Extra Defense"] = "额外防御",
    ["anti blobjman"] = "防雪人",
    ["anti blobman"] = "防雪人",
    ["anti explosion"] = "防爆炸",
    ["anti burn"] = "防燃烧",
    ["anti sticky"] = "防粘性",
    ["anti paint"] = "防油漆",
    ["antikick (tysm Tapalka)"] = "防踢 (感谢 Tapalka)",
    ["antiloop kill (random tp)"] = "防循环击杀 (随机传送)",
    ["anti barrier"] = "防屏障",
    ["anti afk"] = "防挂机",
    ["anti banana"] = "防香蕉",
    ["anti ragdoll"] = "防布娃娃",
    ["delete legs"] = "删除腿部",
    ["antikick (reset)"] = "防踢 (重置)",

    ["Anti-Grab System"] = "防抓系统",
    ["Select Method"] = "选择方法",
    ["Anchor"] = "锚定",
    ["Normal"] = "普通",
    ["Current: Anchor"] = "当前：锚定",
    ["Anti Grab"] = "防抓取",

    ["Anti Input Lag (Custom Item)"] = "防输入延迟 (自定义物品)",
    ["Select Juggle Item"] = "选择杂耍物品",
    ["Lag Method"] = "卡顿方法",
    ["FoodHamburger"] = "食物汉堡",
    ["InstrumentDrumBongos"] = "乐器邦戈鼓",
    ["InstrumentBrassTrumpet"] = "乐器小号",
    ["InstrumentBrassBugle"] = "乐器军号",
    ["InstrumentVoiceMicrophone"] = "乐器麦克风",
    ["InstrumentWoodwindOcarina"] = "乐器陶笛",
    ["InstrumentGuitarUkulele"] = "乐器尤克里里",
    ["InstrumentGuitarLyre"] = "乐器里拉琴",

    ["Gucci (Tractor)"] = "Gucci (拖拉机)",
    ["Anti Gucci (Tractor)"] = "防Gucci (拖拉机)",
    ["Gucci (Santa)"] = "Gucci (圣诞老人)",
    ["Anti Gucci (Santa)"] = "防Gucci (圣诞老人)",
    ["Anti Lag System"] = "防卡顿系统",
    ["Mode"] = "模式",
    ["Default"] = "默认",
    ["Automatic"] = "自动",
    ["Anti Lag"] = "防卡顿",
    ["Gucci"] = "Gucci",
    ["Anti Gucci (Train)"] = "防Gucci (火车)",
    ["Auto Gucci (blobman)"] = "自动Gucci (雪人)",
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