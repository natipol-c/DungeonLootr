--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Left
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Left
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("GuiService");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local Index = require(GameInfo:WaitForChild("ItemData")).Index;
require(ReplicatedStorage.SharedDictionaries.RarityColors);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Modules.SharedUtils);
local spr = require(script.Parent.Parent.ClientUtils.spr);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local LocalPlayer = game.Players.LocalPlayer;
local TweenInfo_new_ret = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local u1 = {
    Shop = "1",
    Inventory = "2",
    Quests = "3",
    Battlepass = "4",
    Setting = "5",
    Codes = "6",
    More = "3",
    LeaveDungeon = "2"
};
local u2 = {};
local u3 = {
    LeaveDungeon = true
};
local u4 = {
    Shop = "Shop",
    Inventory = "Inventory"
};
local v5 = {};
local u6 = {
    Shop = true,
    Inventory = true,
    Battlepass = true,
    Quests = true,
    Codes = true,
    More = true
};
local u7 = {
    Quests = true,
    Battlepass = true,
    Codes = true,
    Setting = true
};
local u8 = { "Shop", "Inventory", "More", "Quests", "Battlepass", "Setting", "Codes", "LeaveDungeon" };
local u9 = nil;

for i, v in u1 do
    local v10 = u2[v];

    if not v10 then
        v10 = {};
        u2[v] = v10;
    end;

    table.insert(v10, i);
end;

local function starDelayFor(p11: string, p12: boolean, p13: number) -- Line: 152
    local v14 = tonumber(p11);

    return not v14 and 0 or math.max(p12 and v14 - 1 or p13 - v14, 0) * 0.07;
end;

local function getButtonScale(p15: userdata) -- Line: 162
    local v16 = p15:FindFirstChildOfClass("UIScale");

    if not v16 then
        v16 = Instance.new("UIScale");
        v16.Parent = p15;
    end;

    return v16;
end;

local function tweenButtonScale(u17: userdata, u18: number, p19: number, u20: boolean?) -- Line: 176
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    local u21 = u17:FindFirstChildOfClass("UIScale");

    if not u21 then
        u21 = Instance.new("UIScale");
        u21.Parent = u17;
    end;

    task.delay(p19, function() -- Line: 178
        -- upvalues: u17 (copy), u18 (copy), u20 (copy), TweenService (ref), u21 (copy), TweenInfo_new_ret (ref)
        if not u17.Parent then
            return;
        end;

        if u18 > 0 and not u20 then
            u17.Visible = true;
        end;

        local v22 = TweenService:Create(u21, TweenInfo_new_ret, {
            Scale = u18
        });
        v22:Play();

        if u18 <= 0 and not u20 then
            v22.Completed:Once(function() -- Line: 186
                -- upvalues: u17 (ref)
                if u17.Parent then
                    u17.Visible = false;
                end;
            end);
        end;
    end);
end;

local TweenInfo_new_ret2 = TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local TweenInfo_new_ret3 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

local function wireButtonHoverReveal(p23: userdata) -- Line: 206
    -- upvalues: TweenService (copy), TweenInfo_new_ret2 (copy), TweenInfo_new_ret3 (copy)
    local Background = p23:FindFirstChild("Background");

    if Background then
        Background = Background:FindFirstChildOfClass("CanvasGroup");
    end;

    if not Background then
        return;
    end;

    local Size = Background.Size;
    local UDim2_new_ret = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset);
    Background.Size = UDim2_new_ret;
    Background.GroupTransparency = 1;
    local u24 = nil;
    local u25 = nil;

    local function playTo(p26: number, p27) -- Line: 220
        -- upvalues: u24 (ref), u25 (ref), TweenService (ref), Background (copy), TweenInfo_new_ret2 (ref), TweenInfo_new_ret3 (ref)
        if u24 then
            u24:Cancel();
        end;

        if u25 then
            u25:Cancel();
        end;

        u24 = TweenService:Create(Background, TweenInfo_new_ret2, {
            GroupTransparency = p26
        });
        u25 = TweenService:Create(Background, TweenInfo_new_ret3, {
            Size = p27
        });
        u24:Play();
        u25:Play();
    end;

    p23.MouseEnter:Connect(function() -- Line: 229
        -- upvalues: playTo (copy), Size (copy)
        playTo(0, Size);
    end);
    p23.MouseLeave:Connect(function() -- Line: 230
        -- upvalues: playTo (copy), UDim2_new_ret (copy)
        playTo(1, UDim2_new_ret);
    end);
end;

local function wireAutoOpen(p28: userdata, u29: function, u30: function) -- Line: 245
    local u31 = nil;
    p28.PromptShown:Connect(function() -- Line: 249
        -- upvalues: u31 (ref), u29 (copy)
        u31 = nil;
        u29();
    end);
    p28.PromptHidden:Connect(function() -- Line: 253
        -- upvalues: u31 (ref), u30 (copy)
        local u32 = {};
        u31 = u32;
        task.delay(0.35, function() -- Line: 256
            -- upvalues: u31 (ref), u32 (copy), u30 (ref)
            if u31 == u32 then
                u31 = nil;
                u30();
            end;
        end);
    end);
end;

function v5._Init(p33) -- Line: 265
    -- upvalues: u9 (ref), ReplicatedStorage (copy), wireButtonHoverReveal (copy), u4 (copy), UIController (copy), Knit (copy), LocalPlayer (copy), u6 (copy), u3 (copy), u7 (copy), u2 (copy), u8 (copy), TweenService (copy), TweenInfo_new_ret (copy), u1 (copy), wireAutoOpen (copy), spr (copy), Index (copy), Registry (copy)
    u9 = p33;
    local Left = u9.HUD.Actions.Left;
    local Buttons = Left.Buttons;
    local Stars = Left.Stars;
    local Left2 = u9.HUD:FindFirstChild("Left");
    local u34 = ReplicatedStorage:GetAttribute("IsDungeon") == true;

    for _, child in Buttons:GetChildren() do
        if child:IsA("GuiButton") then
            wireButtonHoverReveal(child);
        end;
    end;

    for i, v in u4 do
        local v35 = Buttons:FindFirstChild(i);

        if v35 then
            local v36 = u9.Frames:FindFirstChild(v);

            if v36 then
                local u37 = UIController._cached[v36] or UIController.new(v36);
                local v38 = v36:FindFirstChild("Exit", true) or v36:FindFirstChild("Close", true);

                if v38 and v38:IsA("GuiButton") then
                    v38.MouseButton1Click:Connect(function() -- Line: 310
                        -- upvalues: u37 (copy)
                        u37:close();
                    end);
                end;

                v35.Activated:Connect(function() -- Line: 314
                    -- upvalues: u37 (copy)
                    u37:toggle();
                end);
            else
                warn((`[Left] Buttons.{i}: no Frames.{v} — skipping`));
            end;
        end;
    end;

    local Setting = Buttons:FindFirstChild("Setting");

    if Setting then
        Setting.Activated:Connect(function() -- Line: 322
            -- upvalues: Knit (ref)
            local Controller = Knit.GetController("SettingsController");

            if Controller then
                Controller:ToggleSettings();
            end;
        end);
    end;

    local LeaveDungeon = Buttons:FindFirstChild("LeaveDungeon");

    if LeaveDungeon then
        local u39 = false;

        local function reArm() -- Line: 345
            -- upvalues: u39 (ref), LeaveDungeon (copy)
            u39 = false;
            LeaveDungeon.Active = true;
        end;

        local function dispatchLeave() -- Line: 352
            -- upvalues: LocalPlayer (ref), Knit (ref)
            return pcall(function() -- Line: 353
                -- upvalues: LocalPlayer (ref), Knit (ref)
                if LocalPlayer:GetAttribute("InBossRush") then
                    Knit.GetService("BossRushService"):RequestReturn();

                    return;
                end;

                if LocalPlayer:GetAttribute("InChallenge") then
                    Knit.GetService("ChallengeRunService"):RequestReturn();

                    return;
                end;

                if LocalPlayer:GetAttribute("InRaid") then
                    Knit.GetService("RaidRunService"):RequestReturn();

                    return;
                end;

                Knit.GetService("DungeonRunService"):RequestReturn();
            end);
        end;

        LeaveDungeon.Activated:Connect(function() -- Line: 366
            -- upvalues: u39 (ref), LeaveDungeon (copy), LocalPlayer (ref), Knit (ref)
            if u39 then
                return;
            end;

            u39 = true;
            LeaveDungeon.Active = false;
            local Attribute = LocalPlayer:GetAttribute("InBossRush");
            local Attribute2 = LocalPlayer:GetAttribute("InChallenge");
            local Attribute3 = LocalPlayer:GetAttribute("InRaid");
            local v40 = LocalPlayer:GetAttribute("CurrentDifficultyMode") == "Endless";
            local Controller = Knit.GetController("DungeonHUDController");
            local v41 = Controller and Controller.HasEarnedRewards and Controller:HasEarnedRewards();
            local v42 = not (Attribute or Attribute2) and (not Attribute3 and not v41);
            local Controller2 = Knit.GetController("DungeonLootController");
            local v43 = Controller2 and Controller2.GetPendingQuestItemNames and (Controller2:GetPendingQuestItemNames() or {}) or {};
            local v44 = #v43 <= 0 and "" or ("\n\nYou\'ll also lose your <b>%s</b> — Quest Items are only secured by <b>completing the dungeon</b>."):format(table.concat(v43, ", "));
            local v45 = Controller2 and (Controller2.GetPendingMaterialNames and Controller2:GetPendingMaterialNames()) or {};
            local v46 = #v45 <= 0 and "" or ("\n\nYou\'ll also lose your <b>%s</b> — these rare drops are only secured by <b>completing the dungeon</b>."):format(table.concat(v45, ", "));
            local u47;

            if v40 then
                u47 = "Leave now and you\'ll keep everything banked at your <b>last checkpoint</b> — but any loot gathered since it is <b>lost</b>.\n\nReturn to the lobby?" .. v44 .. v46;
            elseif v42 then
                u47 = "Leave now and you\'ll receive <b>NO rewards</b> — no coins, stars, or loot. Defeat the boss to secure them." .. v44 .. v46 .. "\n\nAbandon the dungeon anyway?";
            else
                u47 = Attribute2 and "Leave the Challenge now? Everything you\'ve earned this run is kept — you\'ll see your run summary before heading back to the lobby." or "Return to the lobby now? Anything you\'ve already earned this run is kept.";
            end;

            local Controller3 = Knit.GetController("WarningController");

            if Controller3 then
                local success, result = pcall(function() -- Line: 431
                    -- upvalues: Controller3 (copy), u47 (ref)
                    return Controller3:Prompt({
                        ConfirmText = "Leave",
                        DenyText = "Stay",
                        Message = u47
                    });
                end);

                if success and not result then
                    u39 = false;
                    LeaveDungeon.Active = true;

                    return;
                end;
            end;

            if not pcall(function() -- Line: 353
                -- upvalues: LocalPlayer (ref), Knit (ref)
                if LocalPlayer:GetAttribute("InBossRush") then
                    Knit.GetService("BossRushService"):RequestReturn();

                    return;
                end;

                if LocalPlayer:GetAttribute("InChallenge") then
                    Knit.GetService("ChallengeRunService"):RequestReturn();

                    return;
                end;

                if LocalPlayer:GetAttribute("InRaid") then
                    Knit.GetService("RaidRunService"):RequestReturn();

                    return;
                end;

                Knit.GetService("DungeonRunService"):RequestReturn();
            end) then
                u39 = false;
                LeaveDungeon.Active = true;
            end;
        end);
    end;

    local u48 = true;

    local function targetFor(p49: string, p50: boolean) -- Line: 461
        -- upvalues: u34 (copy), u6 (ref), u3 (ref), u7 (ref)
        if u34 then
            if u6[p49] then
                return 0;
            end;
        elseif u3[p49] or u7[p49] then
            return 0;
        end;

        return p50 and 1 or 0;
    end;

    local function starTargetFor(p51: string, p52: boolean) -- Line: 481
        -- upvalues: u2 (ref), u34 (copy), u6 (ref), u3 (ref), u7 (ref)
        local v53 = u2[p51];

        if not v53 then
            return p52 and 1 or 0;
        end;

        local v54 = 0;

        for _, v in v53 do
            local v55;

            if u34 then
                if u6[v] then
                    v55 = 0;
                else
                    v55 = p52 and 1 or 0;
                end;
            elseif u3[v] or u7[v] then
                v55 = 0;
            else
                v55 = p52 and 1 or 0;
            end;

            v54 = math.max(v54, v55);
        end;

        return v54;
    end;

    local function setMenuState(p56: boolean, p57: boolean) -- Line: 496
        -- upvalues: u48 (ref), Stars (copy), u8 (ref), u34 (copy), u6 (ref), u3 (ref), u7 (ref), Buttons (copy), TweenService (ref), TweenInfo_new_ret (ref), u1 (ref), starTargetFor (copy)
        u48 = p56;
        local v58 = {};
        local v59 = {};
        local v60 = 0;

        if Stars then
            for _, child in Stars:GetChildren() do
                if child:IsA("GuiObject") and tonumber(child.Name) then
                    v60 = v60 + 1;
                end;
            end;
        end;

        for i, v in ipairs(u8) do
            local v61 = (i - 1) * 0.07;
            local u62;

            if u34 then
                if u6[v] then
                    u62 = 0;
                else
                    u62 = p56 and 1 or 0;
                end;
            elseif u3[v] or u7[v] then
                u62 = 0;
            else
                u62 = p56 and 1 or 0;
            end;

            local u63 = Buttons:FindFirstChild(v);

            if u63 then
                v58[u63] = true;

                if p57 then
                    local u64 = u63:FindFirstChildOfClass("UIScale");

                    if not u64 then
                        u64 = Instance.new("UIScale");
                        u64.Parent = u63;
                    end;

                    local u65 = nil;
                    task.delay(v61, function() -- Line: 178
                        -- upvalues: u63 (copy), u62 (copy), u65 (copy), TweenService (ref), u64 (copy), TweenInfo_new_ret (ref)
                        if not u63.Parent then
                            return;
                        end;

                        if u62 > 0 and not u65 then
                            u63.Visible = true;
                        end;

                        local v66 = TweenService:Create(u64, TweenInfo_new_ret, {
                            Scale = u62
                        });
                        v66:Play();

                        if u62 <= 0 and not u65 then
                            v66.Completed:Once(function() -- Line: 186
                                -- upvalues: u63 (ref)
                                if u63.Parent then
                                    u63.Visible = false;
                                end;
                            end);
                        end;
                    end);
                else
                    local v67 = u63:FindFirstChildOfClass("UIScale");

                    if not v67 then
                        v67 = Instance.new("UIScale");
                        v67.Parent = u63;
                    end;

                    v67.Scale = u62;
                    u63.Visible = u62 > 0;
                end;
            end;

            local v68 = u1[v];
            local u69 = v68 and Stars and Stars:FindFirstChild(v68);

            if u69 and not v59[u69] then
                v59[u69] = true;
                local u70 = starTargetFor(v68, p56);

                if p57 then
                    local v71 = tonumber(v68);
                    local v72 = not v71 and 0 or math.max(p56 and v71 - 1 or v60 - v71, 0) * 0.07;
                    local u73 = u69:FindFirstChildOfClass("UIScale");

                    if not u73 then
                        u73 = Instance.new("UIScale");
                        u73.Parent = u69;
                    end;

                    local u74 = true;
                    task.delay(v72, function() -- Line: 178
                        -- upvalues: u69 (copy), u70 (copy), u74 (copy), TweenService (ref), u73 (copy), TweenInfo_new_ret (ref)
                        if not u69.Parent then
                            return;
                        end;

                        if u70 > 0 and not u74 then
                            u69.Visible = true;
                        end;

                        local v75 = TweenService:Create(u73, TweenInfo_new_ret, {
                            Scale = u70
                        });
                        v75:Play();

                        if u70 <= 0 and not u74 then
                            v75.Completed:Once(function() -- Line: 186
                                -- upvalues: u69 (ref)
                                if u69.Parent then
                                    u69.Visible = false;
                                end;
                            end);
                        end;
                    end);
                else
                    local v76 = u69:FindFirstChildOfClass("UIScale");

                    if not v76 then
                        v76 = Instance.new("UIScale");
                        v76.Parent = u69;
                    end;

                    v76.Scale = u70;
                end;
            end;
        end;

        local v77 = #u8 * 0.07;

        for _, child in Buttons:GetChildren() do
            if child:IsA("GuiButton") and (child.Name ~= "Menu" and not v58[child]) then
                v58[child] = true;
                local Name = child.Name;
                local u78;

                if u34 then
                    if u6[Name] then
                        u78 = 0;
                    else
                        u78 = p56 and 1 or 0;
                    end;
                elseif u3[Name] or u7[Name] then
                    u78 = 0;
                else
                    u78 = p56 and 1 or 0;
                end;

                if p57 then
                    local u79 = child:FindFirstChildOfClass("UIScale");

                    if not u79 then
                        u79 = Instance.new("UIScale");
                        u79.Parent = child;
                    end;

                    local u80 = nil;
                    task.delay(v77, function() -- Line: 178
                        -- upvalues: child (copy), u78 (copy), u80 (copy), TweenService (ref), u79 (copy), TweenInfo_new_ret (ref)
                        if not child.Parent then
                            return;
                        end;

                        if u78 > 0 and not u80 then
                            child.Visible = true;
                        end;

                        local v81 = TweenService:Create(u79, TweenInfo_new_ret, {
                            Scale = u78
                        });
                        v81:Play();

                        if u78 <= 0 and not u80 then
                            v81.Completed:Once(function() -- Line: 186
                                -- upvalues: child (ref)
                                if child.Parent then
                                    child.Visible = false;
                                end;
                            end);
                        end;
                    end);
                else
                    local v82 = child:FindFirstChildOfClass("UIScale");

                    if not v82 then
                        v82 = Instance.new("UIScale");
                        v82.Parent = child;
                    end;

                    v82.Scale = u78;
                    child.Visible = u78 > 0;
                end;
            end;
        end;

        if Stars then
            for _, child in Stars:GetChildren() do
                if child:IsA("GuiObject") and (child.Name ~= "Menu" and not v59[child]) then
                    v59[child] = true;
                    local u83 = p56 and 1 or 0;

                    if p57 then
                        local v84 = tonumber(child.Name);
                        local v85 = not v84 and 0 or math.max(p56 and v84 - 1 or v60 - v84, 0) * 0.07;
                        local u86 = child:FindFirstChildOfClass("UIScale");

                        if not u86 then
                            u86 = Instance.new("UIScale");
                            u86.Parent = child;
                        end;

                        local u87 = true;
                        task.delay(v85, function() -- Line: 178
                            -- upvalues: child (copy), u83 (copy), u87 (copy), TweenService (ref), u86 (copy), TweenInfo_new_ret (ref)
                            if not child.Parent then
                                return;
                            end;

                            if u83 > 0 and not u87 then
                                child.Visible = true;
                            end;

                            local v88 = TweenService:Create(u86, TweenInfo_new_ret, {
                                Scale = u83
                            });
                            v88:Play();

                            if u83 <= 0 and not u87 then
                                v88.Completed:Once(function() -- Line: 186
                                    -- upvalues: child (ref)
                                    if child.Parent then
                                        child.Visible = false;
                                    end;
                                end);
                            end;
                        end);
                    else
                        local v89 = child:FindFirstChildOfClass("UIScale");

                        if not v89 then
                            v89 = Instance.new("UIScale");
                            v89.Parent = child;
                        end;

                        v89.Scale = u83;
                    end;
                end;
            end;
        end;

        local Menu = Buttons:FindFirstChild("Menu");

        if Menu then
            local v90 = Menu:FindFirstChildOfClass("UIScale");

            if not v90 then
                v90 = Instance.new("UIScale");
                v90.Parent = Menu;
            end;

            v90.Scale = 1;
            Menu.Visible = true;
        end;
    end;

    if Stars then
        Stars = Stars:FindFirstChild("Menu");
    end;

    if Stars then
        Stars.Activated:Connect(function() -- Line: 594
            -- upvalues: setMenuState (copy), u48 (ref)
            setMenuState(not u48, true);
        end);
    end;

    local Menu = Buttons:FindFirstChild("Menu");

    if Menu then
        Menu.Activated:Connect(function() -- Line: 600
            -- upvalues: setMenuState (copy), u48 (ref)
            setMenuState(not u48, true);
        end);
    end;

    setMenuState(false, false);

    if u34 then
        return;
    end;

    for _, child in workspace:WaitForChild("Prompts"):GetChildren() do
        if child.Name ~= "Traits" and (child.Name ~= "Endless" and (child.Name ~= "Classes" and (child.Name ~= "Dungeon_Select" and (child.Name ~= "BossRush" and (child.Name ~= "Raid" and (child.Name ~= "BuyShop" and child.Name ~= "SellShop")))))) then
            task.spawn(function() -- Line: 649
                -- upvalues: u9 (ref), child (copy), UIController (ref), wireAutoOpen (ref)
                local v91 = u9.Frames:WaitForChild(child.Name, 5);

                if not v91 then
                    warn((`[Left] No matching frame for prompt "{child.Name}" in Frames — skipping`));

                    return;
                end;

                local u92 = UIController._cached[v91];

                if not u92 then
                    u92 = UIController.new(v91);
                    local v93 = v91:FindFirstChild("Exit", true) or v91:FindFirstChild("Close", true);

                    if v93 and v93:IsA("GuiButton") then
                        v93.MouseButton1Click:Connect(function() -- Line: 664
                            -- upvalues: u92 (ref)
                            u92:close();
                        end);
                    end;
                end;

                local ProximityPrompt = child:FindFirstChild("ProximityPrompt");

                if not ProximityPrompt then
                    return;
                end;

                if child:GetAttribute("AutoOpen") then
                    wireAutoOpen(ProximityPrompt, function() -- Line: 683
                        -- upvalues: u92 (ref)
                        if not u92.isOpen then
                            u92:open();
                        end;
                    end, function() -- Line: 687
                        -- upvalues: u92 (ref)
                        u92:close();
                    end);
                else
                    ProximityPrompt.Triggered:Connect(function() -- Line: 691
                        -- upvalues: u92 (ref)
                        u92:toggle();
                    end);
                end;
            end);
        end;
    end;

    local ItemShop = u9.Frames:WaitForChild("ItemShop", 5);
    local Prompts = workspace:FindFirstChild("Prompts");
    Prompts = Prompts;
    local v94;

    if Prompts then
        v94 = Prompts:FindFirstChild("BuyShop");
    else
        v94 = Prompts;
    end;

    local v95 = Prompts and Prompts:FindFirstChild("SellShop");

    if ItemShop and (v94 or v95) then
        local u96 = UIController._cached[ItemShop];

        if not u96 then
            u96 = UIController.new(ItemShop);
            local v97 = ItemShop:FindFirstChild("Exit", true) or ItemShop:FindFirstChild("Close", true);

            if v97 and v97:IsA("GuiButton") then
                v97.MouseButton1Click:Connect(function() -- Line: 719
                    -- upvalues: u96 (ref)
                    u96:close();
                end);
            end;
        end;

        local ItemShop2 = require(script.Parent.ItemShop);
        local u98 = {};
        local u99 = nil;

        local function wireShopPrompt(p100: userdata?, u101: string) -- Line: 739
            -- upvalues: u98 (copy), u99 (ref), ItemShop2 (copy), u96 (ref), ItemShop (copy)
            if not p100 then
                return;
            end;

            local ProximityPrompt = p100:FindFirstChild("ProximityPrompt");

            if not ProximityPrompt then
                return;
            end;

            if not p100:GetAttribute("AutoOpen") then
                ProximityPrompt.Triggered:Connect(function() -- Line: 776
                    -- upvalues: ItemShop (ref), ItemShop2 (ref), u101 (copy), u96 (ref)
                    if ItemShop.Visible and ItemShop2.GetMode() == u101 then
                        u96:close();

                        return;
                    end;

                    ItemShop2.SetMode(u101);
                    u96:open();
                end);

                return;
            end;

            ProximityPrompt.PromptShown:Connect(function() -- Line: 748
                -- upvalues: u98 (ref), u101 (copy), u99 (ref), ItemShop2 (ref), u96 (ref)
                u98[u101] = true;
                u99 = nil;
                ItemShop2.SetMode(u101);

                if not u96.isOpen then
                    u96:open();
                end;
            end);
            ProximityPrompt.PromptHidden:Connect(function() -- Line: 759
                -- upvalues: u98 (ref), u101 (copy), u99 (ref), u96 (ref)
                u98[u101] = nil;

                if next(u98) ~= nil then
                    return;
                end;

                local u102 = {};
                u99 = u102;
                task.delay(0.35, function() -- Line: 765
                    -- upvalues: u99 (ref), u102 (copy), u98 (ref), u96 (ref)
                    if u99 == u102 and next(u98) == nil then
                        u99 = nil;
                        u96:close();
                    end;
                end);
            end);
        end;

        wireShopPrompt(v94, "Buy");
        wireShopPrompt(v95, "Sell");
    end;

    local Left_Toggle = u9.HUD:FindFirstChild("Left_Toggle");

    if Left_Toggle and Left2 then
        local u103 = true;
        local u104 = Left2:GetAttribute("OriginalPosition") or Left2.Position;
        local Attribute = Left2:GetAttribute("Hide");
        Left_Toggle.Activated:Connect(function() -- Line: 806
            -- upvalues: u103 (ref), Left_Toggle (copy), spr (ref), Left2 (copy), u104 (copy), Attribute (copy)
            u103 = not u103;
            Left_Toggle.Text = u103 and "<" or ">";
            local Status_Text = Left_Toggle:FindFirstChild("Status_Text");

            if Status_Text then
                Status_Text.Text = u103 and "Hide" or "Show";
            end;

            if u103 then
                spr.target(Left2, 0.8, 2, {
                    Position = u104
                });

                return;
            end;

            local v105 = u104;

            if Attribute == "Left" then
                v105 = UDim2.new(-1, 0, v105.Y.Scale, v105.Y.Offset);
            elseif Attribute == "Right" then
                v105 = UDim2.new(2, 0, v105.Y.Scale, v105.Y.Offset);
            elseif Attribute == "Up" then
                v105 = UDim2.new(v105.X.Scale, v105.X.Offset, -1, 0);
            elseif Attribute == "Bottom" then
                v105 = UDim2.fromScale(v105.X.Scale, v105.Y.Scale + 1);
            end;

            spr.target(Left2, 0.8, 2, {
                Position = v105
            });
        end);
    end;

    local v106 = Index[ReplicatedStorage.Configuration.GROUP_ITEM.Value];
    u9.HUD.Right.GroupJoin.NameLabel.Text = v106 and v106.Name or ReplicatedStorage.Configuration.GROUP_ITEM.Value;
    u9.HUD.Right.GroupJoin.Visible = not Registry:Get("PlayerData").Data.GroupItemRewarded;
    Registry:Get("PlayerData"):OnChange(function(p107, p108, p109, p110) -- Line: 842
        -- upvalues: u9 (ref), Registry (ref)
        if p108[1] == "GroupItemRewarded" then
            u9.HUD.Right.GroupJoin.Visible = not Registry:Get("PlayerData").Data.GroupItemRewarded;
        end;
    end);
end;

return v5;