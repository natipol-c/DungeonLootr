--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BuffsDisplay
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.BuffsDisplay
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local BuffPotionData = require(GameInfo:WaitForChild("BuffPotionData"));
local PotionData = require(GameInfo:WaitForChild("PotionData"));
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local ItemDescriptions = require(GameInfo:WaitForChild("ItemDescriptions"));
local BuffData = require(GameInfo:WaitForChild("BuffData"));
local spr = require(script.Parent.Parent.ClientUtils.spr);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = {};
local LocalPlayer = Players.LocalPlayer;
local u6 = {};
local u7 = nil;
local u8 = nil;

local function FormatTime(p9: number) -- Line: 52
    local math_floor_ret = math.floor(p9);
    local math_max_ret = math.max(0, math_floor_ret);
    local math_floor_ret2 = math.floor(math_max_ret / 3600);
    local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
    local v10 = math_max_ret % 60;

    if math_floor_ret2 > 0 then
        return string.format("%d:%02d:%02d", math_floor_ret2, math_floor_ret3, v10);
    end;

    return string.format("%d:%02d", math_floor_ret3, v10);
end;

local function ResolvePotionDef(p11: string) -- Line: 64
    -- upvalues: BuffPotionData (copy), PotionData (copy)
    return BuffPotionData.GetPotion(p11) or PotionData.GetPotion(p11);
end;

local function CreateEntry(p12: string, p13: userdata) -- Line: 69
    -- upvalues: BuffPotionData (copy), PotionData (copy), u5 (copy), u4 (ref), Image_Data (copy), FormatTime (copy), ItemDescriptions (copy), spr (copy), u3 (ref)
    local PotionId = p13.PotionId;
    local v14 = BuffPotionData.GetPotion(PotionId) or PotionData.GetPotion(PotionId);

    if not v14 then
        return;
    end;

    local v15 = u5[p12];

    if v15 and v15.frame then
        v15.frame:Destroy();
    end;

    local v16 = u4:Clone();
    v16.Name = p12;
    v16.Visible = true;
    local ItemImage = v16:FindFirstChild("ItemImage");

    if ItemImage then
        local v17 = Image_Data.BuffPotions and Image_Data.BuffPotions[p13.PotionId] or (v14.Icon or "");

        if v17 ~= "" and v17 ~= "rbxassetid://0" then
            ItemImage.Image = v17;
        end;
    end;

    local TimeText = v16:FindFirstChild("TimeText");

    if TimeText then
        TimeText.Text = FormatTime(p13.RemainingSeconds or 0);
    end;

    local Button = v16:FindFirstChild("Button");
    local Frame = v16:FindFirstChild("Frame");

    if Frame and Button then
        local Attribute = Frame:GetAttribute("Full_Size");
        local Info_Text = Frame:FindFirstChild("Info_Text");

        if Info_Text then
            Info_Text.Text = v14.Description or ItemDescriptions.Get(p13.PotionId);
        end;

        local Time_Left = Frame:FindFirstChild("Time_Left");

        if Time_Left then
            Time_Left.Text = "Time Left: " .. FormatTime(p13.RemainingSeconds or 0);
        end;

        Frame.Size = UDim2.new(0, 0, 0, 0);
        Frame.Visible = false;
        local u18 = 0;
        local u19 = false;
        Button.MouseEnter:Connect(function() -- Line: 129
            -- upvalues: u19 (ref), u18 (ref), Frame (copy), Attribute (copy), spr (ref)
            u19 = true;
            u18 = u18 + 1;
            Frame.Visible = true;

            if Attribute then
                spr.target(Frame, 0.6, 3, {
                    Size = Attribute
                });
            end;
        end);
        Button.MouseLeave:Connect(function() -- Line: 140
            -- upvalues: u19 (ref), u18 (ref), Attribute (copy), spr (ref), Frame (copy)
            u19 = false;
            u18 = u18 + 1;
            local u20 = u18;

            if Attribute then
                spr.target(Frame, 0.6, 3, {
                    Size = UDim2.new(0, 0, 0, 0)
                });
            end;

            task.delay(0.5, function() -- Line: 151
                -- upvalues: u20 (copy), u18 (ref), u19 (ref), Frame (ref)
                if u20 ~= u18 or u19 then
                    return;
                end;

                if Frame and Frame.Size.X.Offset < 2 then
                    Frame.Visible = false;
                end;
            end);
        end);
    end;

    v16.Parent = u3;
    u5[p12] = {
        elapsed = 0,
        frame = v16,
        initialSeconds = p13.RemainingSeconds or 0,
        potionId = p13.PotionId
    };
end;

local function RemoveEntry(p21: string) -- Line: 173
    -- upvalues: u5 (copy)
    local v22 = u5[p21];

    if v22 then
        if v22.frame then
            v22.frame:Destroy();
        end;

        u5[p21] = nil;
    end;
end;

local u23 = -1;
local os_clock_ret = os.clock();

local function UpdateTimers() -- Line: 188
    -- upvalues: os_clock_ret (ref), LocalPlayer (copy), u5 (copy), u23 (ref), FormatTime (copy)
    local os_clock_ret2 = os.clock();
    local v24 = os_clock_ret2 - os_clock_ret;
    os_clock_ret = os_clock_ret2;

    if LocalPlayer:GetAttribute("InDungeon") == true then
        for _, v in u5 do
            v.elapsed = v.elapsed + v24;
        end;
    end;

    local math_floor_ret = math.floor(os_clock_ret2);

    if math_floor_ret == u23 then
        return;
    end;

    u23 = math_floor_ret;

    for _, v in u5 do
        local v25 = v.initialSeconds - v.elapsed;
        local v26 = v25 <= 0 and "0:00" or FormatTime(v25);
        local v27 = v.frame and v.frame:FindFirstChild("TimeText");

        if v27 then
            v27.Text = v26;
        end;

        local v28 = v.frame and v.frame:FindFirstChild("Frame");

        if v28 then
            local Time_Left = v28:FindFirstChild("Time_Left");

            if Time_Left then
                Time_Left.Text = "Time Left: " .. v26;
            end;
        end;
    end;
end;

local function Rebuild() -- Line: 227
    -- upvalues: u2 (ref), u5 (copy), CreateEntry (copy)
    local v29 = u2.Data.ActiveBuffs or {};
    print("[BuffsDisplay DEBUG] Rebuild called. ActiveBuffs from Replica:");

    if next(v29) then
        for i, v in v29 do
            print((`  → {i}: PotionId={v.PotionId} RemainingSeconds={v.RemainingSeconds}`));
        end;
    else
        print("  → (empty)");
    end;

    for i, v in v29 do
        local v30 = u5[i];

        if v30 and v30.potionId == v.PotionId then
            if v30 and v30.potionId == v.PotionId then
                local v31 = v.RemainingSeconds or 0;

                if v30.initialSeconds - v30.elapsed + 1 < v31 then
                    v30.elapsed = 0;
                    v30.initialSeconds = v31;
                end;
            end;
        else
            CreateEntry(i, v);
        end;
    end;

    for i, _ in u5 do
        if not v29[i] then
            local v32 = u5[i];

            if v32 then
                if v32.frame then
                    v32.frame:Destroy();
                end;

                u5[i] = nil;
            end;
        end;
    end;
end;

local function SyncRunBuffEntry(p33: string, p34: number, p35: number) -- Line: 274
    -- upvalues: BuffData (copy), u6 (copy), u4 (ref), u3 (ref)
    local RunBuffByAttr = BuffData.GetRunBuffByAttr(p33);

    if not RunBuffByAttr then
        return;
    end;

    local Def = RunBuffByAttr.Def;
    local v36 = BuffData.RunBuffDisplayMagnitude(p33, p34) or 0;
    local v37 = BuffData.FormatDescription(Def, v36);
    local string_format_ret = string.format("x%d", (math.max(1, p35)));
    local v38 = u6[p33];

    if v38 and v38.frame then
        local TimeText = v38.frame:FindFirstChild("TimeText");

        if TimeText then
            TimeText.Text = string_format_ret;
        end;

        local Description = v38.frame:FindFirstChild("Description");

        if Description then
            Description.Text = v37;
        end;

        return;
    end;

    local v39 = u4:Clone();
    v39.Name = "RunBuff_" .. Def.Id;
    v39.Visible = true;
    local ItemImage = v39:FindFirstChild("ItemImage");

    if ItemImage then
        local v40 = BuffData.ResolveIcon(Def);

        if v40 and (v40 ~= "" and v40 ~= "rbxassetid://0") then
            ItemImage.Image = v40;
        end;
    end;

    local TimeText = v39:FindFirstChild("TimeText");

    if TimeText then
        TimeText.Text = string_format_ret;
    end;

    local Description = v39:FindFirstChild("Description");

    if Description then
        Description.Text = v37;
        Description.Visible = false;
        local Button = v39:FindFirstChild("Button");

        if Button then
            Button.MouseEnter:Connect(function() -- Line: 318
                -- upvalues: Description (copy)
                Description.Visible = true;
            end);
            Button.MouseLeave:Connect(function() -- Line: 319
                -- upvalues: Description (copy)
                Description.Visible = false;
            end);
        end;
    end;

    v39.Parent = u3;
    u6[p33] = {
        frame = v39
    };
end;

local function RemoveRunBuffEntry(p41: string) -- Line: 328
    -- upvalues: u6 (copy)
    local v42 = u6[p41];

    if v42 then
        if v42.frame then
            v42.frame:Destroy();
        end;

        u6[p41] = nil;
    end;
end;

local function RebuildRunBuffs() -- Line: 337
    -- upvalues: BuffData (copy), LocalPlayer (copy), SyncRunBuffEntry (copy), u6 (copy)
    for _, v in BuffData.RunBuffProjection do
        local Attr = v.Attr;
        local Attribute = LocalPlayer:GetAttribute(Attr);

        if Attribute and Attribute ~= 0 then
            SyncRunBuffEntry(Attr, Attribute, LocalPlayer:GetAttribute((Attr:gsub("^RunBuff_", "RunBuffStacks_"))) or 1);
        else
            local v43 = u6[Attr];

            if v43 then
                if v43.frame then
                    v43.frame:Destroy();
                end;

                u6[Attr] = nil;
            end;
        end;
    end;
end;

function v1._Init(p44) -- Line: 353
    -- upvalues: u3 (ref), u4 (ref), u2 (ref), Registry (copy), Rebuild (copy), u7 (ref), RunService (copy), UpdateTimers (copy), u8 (ref), LocalPlayer (copy), RebuildRunBuffs (copy)
    u3 = p44.HUD:FindFirstChild("Buffs");

    if not u3 then
        warn("[BuffsDisplay] HUD.Buffs frame not found");

        return;
    end;

    u4 = u3:FindFirstChild("Template");

    if not u4 then
        warn("[BuffsDisplay] HUD.Buffs.Template not found");

        return;
    end;

    u4.Visible = false;
    u2 = Registry:Get("PlayerData");
    u2:OnChange(function(p45, p46) -- Line: 371
        -- upvalues: Rebuild (ref)
        if p46[1] == "ActiveBuffs" then
            Rebuild();
        end;
    end);
    u7 = RunService.Heartbeat:Connect(UpdateTimers);
    u8 = LocalPlayer.AttributeChanged:Connect(function(p47) -- Line: 382
        -- upvalues: RebuildRunBuffs (ref)
        if p47:sub(1, 7) == "RunBuff" then
            RebuildRunBuffs();
        end;
    end);
    Rebuild();
    RebuildRunBuffs();
end;

function v1.Destroy() -- Line: 395
    -- upvalues: u7 (ref), u8 (ref), u5 (copy), u6 (copy)
    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;

    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    for i, _ in u5 do
        local v48 = u5[i];

        if v48 then
            if v48.frame then
                v48.frame:Destroy();
            end;

            u5[i] = nil;
        end;
    end;

    table.clear(u5);

    for i, _ in u6 do
        local v49 = u6[i];

        if v49 then
            if v49.frame then
                v49.frame:Destroy();
            end;

            u6[i] = nil;
        end;
    end;

    table.clear(u6);
end;

return v1;