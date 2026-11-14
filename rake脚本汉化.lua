loadstring(game:HttpGet("https://pastebin.com/raw/nDpRrjrj"))()

local Translations = {
    ["Toggle"] = "开关",
    ["Lock"] = "锁定",
    ["Vyrnox Hub"] = "Vyrnox 中心",
    ["Search"] = "搜索",
    ["Main"] = "主页",
    ["Player"] = "玩家",
    ["Visuals"] = "视觉",
    ["Misc"] = "杂项",
    ["Cheats"] = "作弊",
    ["Controls"] = "控制",
    ["Mods"] = "模组",
    ["Locations"] = "地点",
    ["Settings"] = "设置",
    ["Keybinds"] = "按键绑定",
    ["Changelog"] = "更新日志",
    ["The Rake REMASTERED"] = "The Rake 重制版",

    ["Bring Scraps"] = "拉取废料",
    ["Sell Scraps"] = "出售废料",
    ["Get Radio"] = "获取收音机",
    ["Teleport To Last Died"] = "传送至最后死亡点",
    ["Open Trapdoor"] = "打开活板门",
    ["Knock Trapdoor"] = "敲击活板门",
    ["Switch Lights"] = "开关灯光",
    ["Switch Radar"] = "开关雷达",
    ["Switch Door"] = "开关门",
    ["Switch Light"] = "开关灯",
    ["Knock Door"] = "敲门",

    ["Feedback"] = "反馈",
    ["Send Feedback"] = "发送反馈",
    ["Configurations"] = "配置",
    ["Save Config"] = "保存配置",
    ["Load Config"] = "加载配置",
    ["Discord"] = "Discord",
    ["Copy Invite Link"] = "复制邀请链接",
    ["Server"] = "服务器",
    ["Server Hop"] = "服务器跳转",
    ["Rejoin"] = "重新加入",
    ["UI"] = "界面",
    ["DPI"] = "界面缩放 (DPI)",

    ["Teleports"] = "传送",
    ["Shop"] = "商店",
    ["Power Station"] = "发电站",
    ["Safe House"] = "安全屋",
    ["Base Camp"] = "大本营",
    ["Observation Tower"] = "瞭望塔",
    ["Jumpscare Scene"] = "跳脸杀场景",
    ["Flat Island"] = "平坦岛屿",
    ["Outside Map"] = "地图外",

    ["Weather"] = "天气",
    ["RakeWeather Mod"] = "Rake天气模组",
    ["Rain Sound Volume"] = "雨声音量",
    ["Hours"] = "时间",
    ["Vision Hour Mod"] = "视野时间模组",

    ["Close Trapdoor"] = "关闭活板门",
    ["Character"] = "角色",
    ["Get Flung"] = "被甩飞",
    ["Instantly Free From Trap"] = "瞬间脱离陷阱",
    ["Take Damage"] = "承受伤害",
    ["Take Full Damage"] = "承受满额伤害",
    ["Normal"] = "正常",
    ["Hurt"] = "受伤",
    ["Injured"] = "重伤",
    ["Crawl"] = "爬行",

    ["Hide Below Map"] = "隐藏在地图下方",
    ["Disable Conveyors"] = "禁用传送带",
    ["Automations"] = "自动化",
    ["Auto Collect Item"] = "自动收集物品",
    ["Select Item"] = "选择物品",
    ["Auto Supply Teleport"] = "自动传送至补给",
    ["Hp Requirement"] = "生命值要求",
    ["Auto Heal"] = "自动治疗",
    ["Auto Fix Power"] = "自动修复电力",
    ["Auto Get Flare Gun"] = "自动获取信号枪",
    ["Auto Get Scraps"] = "自动获取废料",
    ["Auto Escape Trap"] = "自动逃离陷阱",
    ["Auto Farm"] = "自动刷取",
    ["Auto Farm Mode"] = "自动刷取模式",
    ["Smart (Beta)"] = "智能 (测试版)",
    
    ["Items"] = "物品",
    ["Keep Item On Spawn"] = "重生时保留物品",
    ["Item To Keep"] = "要保留的物品",
    ["Stun Stick"] = "电击棍",
    ["UV Lamp"] = "紫外线灯",
    ["Flare Gun"] = "信号枪",
    ["Medkit"] = "医疗包",
    ["Radio"] = "收音机",
    
    ["Anti"] = "防身",
    ["Anti Shock"] = "防电击",
    ["Anti Traps"] = "防陷阱",
    ["Anti Void"] = "防虚空",
    
    ["Combat"] = "战斗",
    ["Shield Studs Range"] = "护盾范围",
    ["Rake Shield"] = "Rake 护盾",
    ["Instant Kill Rake"] = "秒杀 Rake",
    ["Fling Rake (Kills You)"] = "甩飞 Rake (会杀死你)",
    ["Fling Players"] = "甩飞玩家",
    
    ["Control"] = "控制",
    ["Control Modes"] = "控制模式",
    ["Default"] = "默认",
    ["Fixed"] = "固定",
    ["Speed Compensation"] = "速度补偿",
    ["Throw Power"] = "投掷力度",
    ["Control Objects"] = "控制物体",
    ["Control Context Button"] = "控制上下文按钮",

    ["Stun Modifiers"] = "电击修改",
    ["Range"] = "范围",
    ["Stun Stick Hit Range"] = "电击棍攻击范围",
    ["Hit Faster"] = "更快攻击",
    ["Auto Stun Stick"] = "自动使用电击棍",
    ["Others"] = "其他",
    ["Instantly Open Supply"] = "瞬间打开补给",
    ["Teleport Behind Rake"] = "传送至 Rake 背后",
    ["TP Context Button"] = "传送上下文按钮",
    ["Teleport Distance"] = "传送距离",

    ["Notifiers"] = "通知",
    ["Blood Hour Notifier"] = "血月时间通知",
    ["Flare Gun Notifier"] = "信号枪通知",
    ["Gamepasses"] = "游戏通行证",
    ["Upgraded Flashlight"] = "升级版手电筒",
    ["Night Vision Goggles"] = "夜视仪",
    ["Unlock Sixth Sense"] = "解锁第六感",
    
    ["Fps"] = "帧率 (FPS)",
    ["Show Fps"] = "显示帧率",
    ["Fps Mode"] = "帧率模式",
    ["Counter"] = "计数器",
    ["Graph"] = "图表",
    ["Environment"] = "环境",
    ["Play Cave Sounds"] = "播放洞穴音效",
    ["Disable Tree Crowns"] = "禁用树冠",
    ["Disable Materials"] = "禁用材质",

    ["ESPs"] = "透视 (ESP)",
    ["Settings"] = "设置",
    ["ESP Mode"] = "透视模式",
    ["Highlight"] = "高亮",
    ["BoxHandleAdornment"] = "方框 (BoxHandle)",
    ["Drawing API"] = "绘图 API",
    ["ESP Text Size"] = "透视文本大小",
    ["Colors"] = "颜色",
    ["Rainbow Colors"] = "彩虹颜色",
    ["Rainbow Speed"] = "彩虹速度",
    ["Rake Color"] = "Rake 颜色",
    ["Player Color"] = "玩家颜色",
    ["Scrap Color"] = "废料颜色",
    ["Rusty Trap Color"] = "生锈陷阱颜色",
    ["Rake Trap Color"] = "Rake 陷阱颜色",
    ["Flare Gun Color"] = "信号枪颜色",
    ["Supply Drop Color"] = "补给空投颜色",
    ["Places Color"] = "地点颜色",
    
    ["Effects"] = "特效",
    ["No Camera Shake"] = "无镜头晃动",
    ["No Jumpscare Snap"] = "无跳脸杀",
    ["No Heartbeat"] = "无心跳声",
    ["No Static"] = "无静电雪花屏",
    ["No Scare"] = "无惊吓",
    ["No Blur"] = "无模糊",
    ["No Downed Color"] = "无倒地屏幕颜色",
    
    ["Camera & Pathfind"] = "视角与寻路",
    ["Third Person"] = "第三人称",
    ["Enable Shiftlock"] = "启用锁定视角 (Shiftlock)",
    ["Crosshair"] = "准星",
    ["Field Of View Value"] = "视野值 (FOV)",
    ["Field Of View Modes"] = "视野模式",
    ["Field Of View"] = "视野大小",
    ["Free Camera"] = "自由视角",
    ["Spectate"] = "观战",
    ["Camera Sensitivity"] = "视角灵敏度",
    ["Camera Speed"] = "视角速度",
    ["Highlight Spots"] = "高亮地点",
    ["Rake Pathfind"] = "Rake 寻路",
    ["No Bobbing"] = "无视角摇晃",

    ["Rake ESP"] = "Rake 透视",
    ["Show Hp"] = "显示血量",
    ["Show Distance"] = "显示距离",
    ["Show Highlights"] = "显示高亮",
    ["Player ESP"] = "玩家透视",
    ["Show Travelled"] = "显示移动距离",
    ["Show Inventory"] = "显示背包",
    ["Places ESP"] = "地点透视",
    ["Show Pallet Hp"] = "显示托盘血量",
    ["Scrap ESP"] = "废料透视",
    ["Show Level"] = "显示等级",
    ["Show Points"] = "显示积分",
    ["Rusty Trap ESP"] = "生锈陷阱透视",
    ["Rake Trap ESP"] = "Rake 陷阱透视",
    ["Flare Gun ESP"] = "信号枪透视",
    ["Supply Drop ESP"] = "补给空投透视",
    ["Show Items"] = "显示物品",

    ["Character"] = "角色",
    ["Speed Value"] = "速度值",
    ["Speed"] = "速度",
    ["Speed Bypass"] = "速度绕过",
    ["Bypass Method"] = "绕过方法",
    ["Method 1"] = "方法 1",
    ["Jump Height Value"] = "跳跃高度值",
    ["Jump Height"] = "跳跃高度",
    ["Hip Height Value"] = "腰部高度值",
    ["Hip Height"] = "腰部高度",
    ["Fly Speed"] = "飞行速度",
    ["Fly"] = "飞行",
    ["Max Slope Angle"] = "最大斜坡角度",
    ["Slope Angle"] = "斜坡角度",
    ["Freeze"] = "冻结",
    ["Sit"] = "坐下",
    
    ["Infinite"] = "无限",
    ["Infinite Jump"] = "无限跳跃",
    ["Infinite Stamina"] = "无限体力",
    ["Infinite Night Vision"] = "无限夜视",
    
    ["Disablers"] = "禁用功能",
    ["No Fall Damage"] = "无摔落伤害",
    ["No Jump Cooldown"] = "无跳跃冷却",
    ["No Player Collisions"] = "无玩家碰撞",
    ["Noclip"] = "穿墙",
    
    ["Sprint"] = "冲刺",
    ["Sprint Always Enabled"] = "始终启用冲刺",
    ["Sprint Speed Value"] = "冲刺速度值",
    ["Sprint"] = "冲刺",
    
    ["Dash"] = "疾跑",
    ["Dash Speed"] = "疾跑速度",
    ["Dash"] = "疾跑",
    ["Dash Context Button"] = "疾跑上下文按钮",

    ["Lighting"] = "光照",
    ["Brightness"] = "亮度",
    ["Fullbright"] = "全亮",
    ["No Fog"] = "无雾",
    ["Clock Time Value"] = "时钟时间值",
    ["Clock Time"] = "时钟时间",
    ["Day Time"] = "白天时间",
    ["Interaction"] = "交互",
    ["Enable Chat"] = "启用聊天",
    ["Extended Prompts"] = "延长交互提示",
    ["No Line Of Sight"] = "无视线限制",
    ["Instant Prompts"] = "瞬间交互提示",
    
    ["Other"] = "其他",
    ["Keep Backpack Enabled"] = "保持背包启用",
    ["No Fall Animation"] = "无摔落动画",
    ["Displays"] = "显示",
    ["Settings"] = "设置",
    ["Timer"] = "计时器",
    ["Power"] = "电力",
    ["Rake Target"] = "Rake 目标",
    ["Rake Health"] = "Rake 血量",
    ["Distance Travelled"] = "移动距离",
    ["Time Color"] = "时间颜色",
    ["Power Color"] = "电量颜色",
    ["Rake Target Color"] = "Rake 目标颜色",
    ["Rake Health Color"] = "Rake 血量颜色",
    ["Distance Color"] = "距离颜色",
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
