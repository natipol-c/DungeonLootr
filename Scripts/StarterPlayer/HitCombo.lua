--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     HitCombo
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.HitCombo
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = { {
        min = 1500,
        gradient = "ERROR",
        text = "???"
    }, {
        min = 600,
        gradient = "Highest",
        text = "LEGENDARY"
    }, {
        min = 300,
        gradient = "Higher",
        text = "UNSTOPPABLE"
    }, {
        min = 150,
        gradient = "High",
        text = "COMBO GOD"
    }, {
        min = 80,
        gradient = "Mid",
        text = "INSANE"
    }, {
        min = 25,
        gradient = "Low",
        text = "GREAT"
    } };
local u2 = { {
        min = 3000000,
        gradient = "ERROR"
    }, {
        min = 1000000,
        gradient = "Highest"
    }, {
        min = 100000,
        gradient = "Higher"
    }, {
        min = 45000,
        gradient = "High"
    }, {
        min = 10000,
        gradient = "Mid"
    }, {
        min = 1000,
        gradient = "Low"
    } };
local UDim2_new_ret = UDim2.new(0, 0, 0.034, 0);
local v3 = {};
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = false;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = {};
local u16 = false;
local u17 = 0;
local u18 = {};
local u19 = nil;
local u20 = {};

local function getTier(p21: number) -- Line: 85
    -- upvalues: u1 (copy)
    for _, v in u1 do
        if v.min <= p21 then
            return v;
        end;
    end;

    return nil;
end;

local function updateGradients(p22: number) -- Line: 95
    -- upvalues: u1 (copy), u18 (copy), u7 (ref)
    local v23 = nil;

    for _, v in u1 do
        if v.min <= p22 then
            v23 = v;
            break;
        end;
    end;

    for _, v in u18 do
        v.Enabled = false;
    end;

    if v23 then
        local v24 = u7:FindFirstChild(v23.gradient);

        if v24 and v24:IsA("UIGradient") then
            v24.Enabled = true;
        end;
    end;
end;

local function updateComboText(p25: number) -- Line: 109
    -- upvalues: u1 (copy), u8 (ref)
    local v26 = nil;

    for _, v in u1 do
        if v.min <= p25 then
            v26 = v;
            break;
        end;
    end;

    u8.Text = v26 and v26.text or "COMBO";
end;

local function getDmgTier(p27: number) -- Line: 115
    -- upvalues: u2 (copy)
    for _, v in u2 do
        if v.min <= p27 then
            return v;
        end;
    end;

    return nil;
end;

local function updateDmgGradients(p28: number) -- Line: 125
    -- upvalues: u2 (copy), u20 (copy), u19 (ref)
    local v29 = nil;

    for _, v in u2 do
        if v.min <= p28 then
            v29 = v;
            break;
        end;
    end;

    for _, v in u20 do
        v.Enabled = false;
    end;

    if v29 then
        local v30 = u19:FindFirstChild(v29.gradient);

        if v30 and v30:IsA("UIGradient") then
            v30.Enabled = true;
        end;
    end;
end;

local function formatNumber(p31: number) -- Line: 139
    local math_floor_ret = math.floor(p31);
    local v32 = tostring(math_floor_ret);
    local v33 = {};

    for i = #v32, 1, -3 do
        local math_max_ret = math.max(i - 2, 1);
        table.insert(v33, 1, v32:sub(math_max_ret, i));
        local _ = i;
    end;

    return table.concat(v33, ",");
end;

local function stopRumble() -- Line: 152
    -- upvalues: u14 (ref), u15 (ref)
    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;

    for i, v in u15 do
        if i.Parent then
            i.Position = v;
        end;
    end;

    u15 = {};
end;

local function startRumble() -- Line: 166
    -- upvalues: u14 (ref), u5 (ref), u15 (ref), RunService (copy)
    if u14 then
        return;
    end;

    for _, child in u5:GetChildren() do
        if child:IsA("GuiObject") then
            u15[child] = child.Position;
        end;
    end;

    u14 = RunService.Heartbeat:Connect(function() -- Line: 176
        -- upvalues: u15 (ref)
        for i, v in u15 do
            if i.Parent then
                local math_random_ret = math.random(-2, 2);
                local math_random_ret2 = math.random(-2, 2);
                i.Position = UDim2.new(v.X.Scale, v.X.Offset + math_random_ret, v.Y.Scale, v.Y.Offset + math_random_ret2);
            end;
        end;
    end);
end;

local function bounceComboFrame() -- Line: 191
    -- upvalues: u11 (ref), TweenService (copy), u10 (ref), u17 (ref), u16 (ref), startRumble (copy)
    if u11 then
        return;
    end;

    u11 = true;
    local v34 = TweenService:Create(u10, TweenInfo.new(0.075, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Scale = 1.15
    });
    v34:Play();
    v34.Completed:Wait();
    local v35 = TweenService:Create(u10, TweenInfo.new(0.075, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Scale = 1
    });
    v35:Play();
    v35.Completed:Wait();
    u11 = false;

    if u17 >= 150 and u16 then
        startRumble();
    end;
end;

local function startBarDepletion() -- Line: 223
    -- upvalues: u12 (ref), u6 (ref), u9 (ref), TweenService (copy), UDim2_new_ret (copy)
    if u12 then
        u12:Cancel();
        u12 = nil;
    end;

    u6.Size = u9;
    u12 = TweenService:Create(u6, TweenInfo.new(13, Enum.EasingStyle.Linear), {
        Size = UDim2_new_ret
    });
    u12:Play();
end;

local function resetAll() -- Line: 243
    -- upvalues: stopRumble (copy), u12 (ref), u6 (ref), u9 (ref), u10 (ref), u7 (ref), u8 (ref), u17 (ref), u11 (ref), u18 (copy), u19 (ref), u20 (copy)
    stopRumble();

    if u12 then
        u12:Cancel();
        u12 = nil;
    end;

    u6.Size = u9;
    u10.Scale = 1;
    u7.Text = "0";
    u8.Text = "COMBO";
    u17 = 0;
    u11 = false;

    for _, v in u18 do
        v.Enabled = false;
    end;

    if u19 then
        u19.Text = "0";

        for _, v in u20 do
            v.Enabled = false;
        end;
    end;
end;

local function fadeIn() -- Line: 272
    -- upvalues: u13 (ref), u4 (ref), TweenService (copy), u16 (ref)
    if u13 then
        u13:Cancel();
        u13 = nil;
    end;

    u4.Visible = true;
    u13 = TweenService:Create(u4, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    });
    u13:Play();
    u16 = true;
end;

local function fadeOut() -- Line: 288
    -- upvalues: u13 (ref), TweenService (copy), u4 (ref), u16 (ref), resetAll (copy)
    if u13 then
        u13:Cancel();
        u13 = nil;
    end;

    u13 = TweenService:Create(u4, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        GroupTransparency = 1
    });
    u13:Play();
    u13.Completed:Connect(function() -- Line: 300
        -- upvalues: u16 (ref), u4 (ref), resetAll (ref)
        u16 = false;
        u4.Visible = false;
        resetAll();
    end);
end;

local function onHitCountChanged() -- Line: 309
    -- upvalues: LocalPlayer (copy), u17 (ref), u16 (ref), fadeOut (copy), resetAll (copy), fadeIn (copy), u7 (ref), u1 (copy), u18 (copy), u8 (ref), startBarDepletion (copy), stopRumble (copy), bounceComboFrame (copy)
    local v36 = LocalPlayer:GetAttribute("Hit_Count") or 0;
    u17 = v36;

    if v36 == 0 then
        if u16 then
            fadeOut();
        end;

        return;
    end;

    if not u16 then
        resetAll();
        fadeIn();
    end;

    u7.Text = tostring(v36);
    local v37 = nil;

    for _, v in u1 do
        if v.min <= v36 then
            v37 = v;
            break;
        end;
    end;

    for _, v in u18 do
        v.Enabled = false;
    end;

    if v37 then
        local v38 = u7:FindFirstChild(v37.gradient);

        if v38 and v38:IsA("UIGradient") then
            v38.Enabled = true;
        end;
    end;

    local v39 = nil;

    for _, v in u1 do
        if v.min <= v36 then
            v39 = v;
            break;
        end;
    end;

    u8.Text = v39 and v39.text or "COMBO";
    startBarDepletion();
    stopRumble();
    task.spawn(bounceComboFrame);
end;

local function onDamageChanged() -- Line: 344
    -- upvalues: u19 (ref), LocalPlayer (copy), formatNumber (copy), u2 (copy), u20 (copy)
    if not u19 then
        return;
    end;

    local v40 = LocalPlayer:GetAttribute("Damage_Dealt") or 0;
    u19.Text = formatNumber(v40);
    local v41 = nil;

    for _, v in u2 do
        if v.min <= v40 then
            v41 = v;
            break;
        end;
    end;

    for _, v in u20 do
        v.Enabled = false;
    end;

    if v41 then
        local v42 = u19:FindFirstChild(v41.gradient);

        if v42 and v42:IsA("UIGradient") then
            v42.Enabled = true;
        end;
    end;
end;

function v3._Init(p43) -- Line: 353
    -- upvalues: u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u18 (copy), u19 (ref), u20 (copy), u10 (ref), LocalPlayer (copy), onHitCountChanged (copy), onDamageChanged (copy)
    local v44 = p43:FindFirstChild("HUD") and p43.HUD:FindFirstChild("Dungeon_Container");

    if not v44 then
        warn("[HitCombo] Dungeon_Container not found");

        return;
    end;

    u4 = v44:FindFirstChild("Hit_Combo_Canvas");

    if not u4 then
        warn("[HitCombo] Hit_Combo_Canvas not found");

        return;
    end;

    u4.Parent = v44.Parent;
    u5 = u4:FindFirstChild("Combo_Frame");
    local v45 = u5 and u5:FindFirstChild("Bar");
    u6 = v45;
    local v46 = u5 and u5:FindFirstChild("Hit_Count");
    u7 = v46;
    local v47 = u5 and u5:FindFirstChild("Combo_Text");
    u8 = v47;

    if not (u5 and (u6 and (u7 and u8))) then
        warn("[HitCombo] Missing required UI elements inside Combo_Frame");

        return;
    end;

    u9 = u6:GetAttribute("Full_Size");

    if not u9 then
        warn("[HitCombo] Bar is missing \'Full_Size\' UDim2 attribute, falling back to current Size");
        u9 = u6.Size;
    end;

    for _, child in u7:GetChildren() do
        if child:IsA("UIGradient") then
            table.insert(u18, child);
            child.Enabled = false;
        end;
    end;

    u19 = u5:FindFirstChild("Damage_Label");

    if u19 then
        for _, child in u19:GetChildren() do
            if child:IsA("UIGradient") then
                table.insert(u20, child);
                child.Enabled = false;
            end;
        end;
    end;

    u10 = u5:FindFirstChildOfClass("UIScale");

    if not u10 then
        u10 = Instance.new("UIScale");
        u10.Parent = u5;
    end;

    u10.Scale = 1;
    u4.GroupTransparency = 1;
    u4.Visible = false;
    LocalPlayer:GetAttributeChangedSignal("Hit_Count"):Connect(onHitCountChanged);
    LocalPlayer:GetAttributeChangedSignal("Damage_Dealt"):Connect(onDamageChanged);
    print("[HitCombo] Initialized");
end;

return v3;