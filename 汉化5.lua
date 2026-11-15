loadstring(game:HttpGet("https://pastefy.app/bscLo4n8/raw"))()
local Translations = {
    ["Toggle"] = "开关",
    ["Lock"] = "锁定",
    ["Lunar Hub"] = "Lunar Hub",
    ["Auras"] = "光环",
    ["auras things"] = "光环功能",
    ["Anti Kick Aura Radius"] = "防踢光环半径",
    ["Use Whitelist (Friends)"] = "使用白名单 (好友)",
    ["Remove Anti Kick Aura"] = "移除防踢光环",
    ["Dual Kick Aura Radius"] = "双手踢出光环半径",
    ["Whitelist Friends"] = "白名单好友",
    ["Dual Hand Kick Aura"] = "双手踢出光环",
    ["Kick Aura 1 Hand Radius"] = "单手踢出光环半径",
    ["Kick Aura 1 Hand (grab + blob)"] = "单手踢出光环 (抓取+雪人)",
    ["Kick Aura 1 Hand"] = "单手踢出光环",
    ["Keybinds"] = "按键绑定",
    ["Configure keybinds"] = "配置按键绑定",
    ["Teleport Tool"] = "传送工具",
    ["Blobman"] = "雪人",
    ["Fun"] = "趣味",
    ["like Misc but with more things"] = "类似杂项但功能更多",
    ["Troll"] = "恶搞",
    ["Jerk Off"] = "打飞机 (恶搞动作)",
    ["Toggle Key"] = "开关按键",
    ["Animations"] = "动画",
    ["Play Animation"] = "播放动画",
    ["Animation"] = "动画选择",
    ["Crazy"] = "疯狂",
    ["Insane"] = "癫狂",
    ["Collapse"] = "倒下",
    ["Zombie"] = "僵尸",
    ["Fake Death"] = "假死",
    ["Fake Lag"] = "假延迟",
    ["Bang (Slow)"] = "慢速击打",
    ["Stick Shuriken to UFO"] = "将手里剑粘在UFO上",
    ["Follow & Stare"] = "跟随并凝视",
    ["Build"] = "建筑",
    ["Builds cool thing"] = "建造酷炫的东西",
    ["Heart"] = "爱心",
    ["Misc"] = "杂项",
    ["packet and trigger bot ect"] = "数据包和扳机bot等",
    ["Miscellaneous"] = "其他",
    ["Dreamy Night Shader"] = "梦幻夜晚光影",
    ["Packet Lag"] = "数据包卡顿 (延迟)",
    ["Ignore House Barriers"] = "无视房屋屏障",
    ["Auto Reset"] = "自动重置",
    ["Trigger Bot"] = "扳机Bot (自动攻击)",
    ["FOV"] = "视野范围",
    ["Player"] = "玩家",
    ["client things like PCLD esp"] = "客户端功能，如PCLD透视",
    ["View & Movement"] = "视角与移动",
    ["3rd Person View"] = "第三人称视角",
    ["Spin Character"] = "旋转角色",
    ["Spin Speed"] = "旋转速度",
    ["Infinite Jump"] = "无限跳跃",
    ["Environment"] = "环境",
    ["ESP"] = "透视 (ESP)",
    ["PCLD View"] = "PCLD 视角",
    ["Nickname Esp"] = "昵称透视",
    ["Performance"] = "性能",
    ["boost fps"] = "提升FPS",
    ["delete boost fps"] = "删除FPS提升",
    ["grab"] = "抓取",
    ["basic things"] = "基础功能",
    ["Grab Customization"] = "抓取自定义",
    ["Power"] = "力量/力度",
    ["Strength"] = "强度",
    ["Kill Grab"] = "击杀抓取",
    ["MassLess Grab"] = "无质量抓取",
    ["Loops"] = "循环",
    ["loops people with good loops"] = "循环整人功能",
    ["Target Interaction"] = "目标交互",
    ["select player for kick"] = "选择要踢出的玩家",
    ["refresh player list"] = "刷新玩家列表",
    ["Fling ( grab )"] = "甩飞 (抓取)",
    ["Ragdoll Snowball"] = "布娃娃雪球",
    ["Grab Troll (spam grab)"] = "抓取恶搞 (无限刷抓)",
    ["Loop Kick (grab + blob)"] = "循环踢出 (抓取+雪人)",
    ["Loop Kick"] = "循环踢出",
    ["kick fast (grab + blob, with height)"] = "快速踢出 (抓取+雪人, 带高度)",
    ["Fling"] = "甩飞",
    ["Remove Anti Kick"] = "移除防踢",
    ["kick grabs loop"] = "抓取踢出循环",
    ["Kick (spam grab)"] = "踢出 (无限刷抓)",
    ["Kick (spam grab V2)"] = "踢出 (无限刷抓 V2)",
    ["Blobman Settings"] = "雪人设置",
    ["Auto Sit Blobman"] = "自动骑乘雪人",
    ["Blob Speed"] = "雪人速度",
    ["Custom Kick Height, for kick fast"] = "自定义踢出高度 (用于快速踢出)",
    ["Destroy Gucci (sit)"] = "破坏Gucci (坐下)",
    ["bring"] = "拉过来",
    ["Remove Anti Input Lag"] = "移除防输入延迟",
    ["Target Joined Notify"] = "目标加入提示",
    ["whitelist"] = "白名单",
    ["whitelist people"] = "白名单玩家",
    ["refresh List"] = "刷新列表",
    ["Protections"] = "保护 / 防御",
    ["Protect you with cool antis"] = "用强大的防身功能保护你",
    ["Defense Main"] = "主防御",
    ["Anti Reset"] = "防重置",
    ["Anti Grab"] = "防抓取",
    ["Anti Blobman"] = "防雪人",
    ["Auto Anti Lag"] = "自动防卡顿",
    ["Anti Explosion"] = "防爆炸",
    ["Anti Burn"] = "防燃烧",
    ["Anti Void"] = "防虚空",
    ["Anti Sticky"] = "防粘性",
    ["Anti Lag"] = "防卡顿",
    ["Anti Kick"] = "防踢出",
    ["Extra Defense"] = "额外防御",
    ["Anti Paint"] = "防油漆",
    ["Anti Gucci (Blobman)"] = "防Gucci (雪人)",
    ["Anti Gucci (Train)"] = "防Gucci (火车)",
    ["Delete Legs"] = "删除腿部",
    ["Input Lag Item"] = "输入延迟物品",
    ["Anti Input Lag"] = "防输入延迟",
    ["Water walk"] = "水上行走",
    ["Loop TP"] = "循环传送",
    ["Banana"] = "香蕉",
    ["Sax"] = "萨克斯",
    ["Snare"] = "军鼓",
    ["SparklePoop"] = "闪光大便",
    ["Trumpet"] = "小号",
    ["Ukulele"] = "尤克里里",
    ["Violin"] = "小提琴",
    ["Vuvuzela"] = "呜呜祖拉",
    ["WhiteMug"] = "白色马克杯",
    ["Poop"] = "大便",
    ["MeatStick"] = "肉串",
    ["Mic"] = "麦克风",
    ["Mushroom"] = "蘑菇",
    ["Ocarina"] = "陶笛",
    ["Pepperoni"] = "意大利辣香肠",
    ["Piano"] = "钢琴",
    ["Pizza"] = "披萨",
    ["Coconut"] = "椰子",
    ["Donut"] = "甜甜圈",
    ["Egg"] = "鸡蛋",
    ["Fries"] = "薯条",
    ["Hotdog"] = "热狗",
    ["Lyre"] = "里拉琴",
    ["Mayo"] = "蛋黄酱",
    ["Banjo"] = "班卓琴",
    ["Bongos"] = "邦戈鼓",
    ["Bread"] = "面包",
    ["BrownMug"] = "棕色马克杯",
    ["Burger"] = "汉堡",
    ["Cake"] = "蛋糕",
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