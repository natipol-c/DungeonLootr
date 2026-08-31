--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GearscoreNotification
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.GearscoreNotification
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local UDim2_new_ret = UDim2.new(0, 0, 0.7, 0);
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In);
local TweenInfo_new_ret3 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local Color3_fromRGB_ret = Color3.fromRGB(80, 255, 120);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 80, 80);

local function formatCommas(p2: number) -- Line: 63
    local math_floor_ret = math.floor(p2 + 0.5);
    local v3 = tostring(math_floor_ret);
    local v4;

    repeat
        v3, v4 = v3:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v4 == 0;

    return v3;
end;

function v1._Init(p5) -- Line: 74
    -- upvalues: UDim2_new_ret (copy), LocalPlayer (copy), formatCommas (copy), RunService (copy), TweenService (copy), TweenInfo_new_ret3 (copy), TweenInfo_new_ret2 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), TweenInfo_new_ret (copy)
    local Gearscore_Notifications = p5.HUD:FindFirstChild("Gearscore_Notifications");

    if not Gearscore_Notifications then
        warn("[GearscoreNotification] HUD.Gearscore_Notifications not found");

        return;
    end;

    local CanvasGroup = Gearscore_Notifications:FindFirstChild("CanvasGroup");
    local u6;

    if CanvasGroup then
        u6 = CanvasGroup:FindFirstChild("Template");
    else
        u6 = CanvasGroup;
    end;

    local v7;

    if u6 then
        v7 = u6:FindFirstChild("Frame");
    else
        v7 = u6;
    end;

    if not v7 then
        warn("[GearscoreNotification] CanvasGroup.Template.Frame not found — template not rewired?");

        return;
    end;

    local u8 = u6:FindFirstChildWhichIsA("UIScale");
    local Gearscore_Amount = v7:FindFirstChild("Gearscore_Amount");
    local Gearscore_Arrow = v7:FindFirstChild("Gearscore_Arrow");
    local Position = u6.Position;
    local u9 = Position + UDim2_new_ret;
    CanvasGroup.Visible = false;
    CanvasGroup.GroupTransparency = 1;
    u6.Position = u9;

    if u8 then
        u8.Scale = 1;
    end;

    local u10 = LocalPlayer:GetAttribute("Stat_GearScore") or 0;
    local u11 = u10;
    local u12 = false;
    local u13 = nil;
    local u14 = 0;

    if Gearscore_Amount then
        Gearscore_Amount.Text = formatCommas(u11);
    end;

    local function rollTo(u15: number) -- Line: 114
        -- upvalues: u14 (ref), u11 (ref), Gearscore_Amount (copy), formatCommas (ref), RunService (ref)
        u14 = u14 + 1;
        local u16 = u14;
        local u17 = u11;

        if u17 == u15 then
            if Gearscore_Amount then
                Gearscore_Amount.Text = formatCommas(u15);
            end;

            return;
        end;

        task.spawn(function() -- Line: 122
            -- upvalues: u16 (copy), u14 (ref), RunService (ref), u11 (ref), u17 (copy), u15 (copy), Gearscore_Amount (ref), formatCommas (ref)
            local v18 = 0;

            while v18 < 0.45 do
                if u16 ~= u14 then
                    return;
                end;

                v18 = v18 + RunService.Heartbeat:Wait();
                local v19 = 1 - (1 - math.clamp(v18 / 0.45, 0, 1)) ^ 3;
                u11 = u17 + (u15 - u17) * v19;

                if Gearscore_Amount then
                    Gearscore_Amount.Text = formatCommas(u11);
                end;
            end;

            if u16 == u14 then
                u11 = u15;

                if Gearscore_Amount then
                    Gearscore_Amount.Text = formatCommas(u15);
                end;
            end;
        end);
    end;

    local function bump() -- Line: 141
        -- upvalues: u8 (copy), TweenService (ref), TweenInfo_new_ret3 (ref)
        if not u8 then
            return;
        end;

        u8.Scale = 1.14;
        TweenService:Create(u8, TweenInfo_new_ret3, {
            Scale = 1
        }):Play();
    end;

    local function hide() -- Line: 148
        -- upvalues: u12 (ref), u13 (ref), TweenService (ref), u6 (copy), TweenInfo_new_ret2 (ref), u9 (copy), CanvasGroup (copy)
        u12 = false;
        u13 = nil;
        TweenService:Create(u6, TweenInfo_new_ret2, {
            Position = u9
        }):Play();
        local v20 = TweenService:Create(CanvasGroup, TweenInfo_new_ret2, {
            GroupTransparency = 1
        });
        v20:Play();
        v20.Completed:Once(function() -- Line: 154
            -- upvalues: u12 (ref), CanvasGroup (ref)
            if not u12 then
                CanvasGroup.Visible = false;
            end;
        end);
    end;

    local function showChange(u21: number, p22: boolean) -- Line: 162
        -- upvalues: Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref), Gearscore_Amount (copy), Gearscore_Arrow (copy), u13 (ref), u12 (ref), CanvasGroup (copy), u6 (copy), u9 (copy), TweenService (ref), TweenInfo_new_ret (ref), Position (copy), u14 (ref), u11 (ref), formatCommas (ref), RunService (ref), u8 (copy), TweenInfo_new_ret3 (ref), hide (copy)
        local v23 = p22 and Color3_fromRGB_ret or Color3_fromRGB_ret2;

        if Gearscore_Amount then
            Gearscore_Amount.TextColor3 = v23;
        end;

        if Gearscore_Arrow then
            Gearscore_Arrow.TextColor3 = v23;
            Gearscore_Arrow.Text = p22 and "▲" or "▼";
        end;

        if u13 then
            task.cancel(u13);
            u13 = nil;
        end;

        if not u12 then
            u12 = true;
            CanvasGroup.Visible = true;

            if CanvasGroup.GroupTransparency >= 0.99 then
                u6.Position = u9;
            end;

            TweenService:Create(u6, TweenInfo_new_ret, {
                Position = Position
            }):Play();
            TweenService:Create(CanvasGroup, TweenInfo_new_ret, {
                GroupTransparency = 0
            }):Play();
        end;

        u14 = u14 + 1;
        local u24 = u14;
        local u25 = u11;

        if u25 == u21 then
            if Gearscore_Amount then
                Gearscore_Amount.Text = formatCommas(u21);
            end;
        else
            task.spawn(function() -- Line: 122
                -- upvalues: u24 (copy), u14 (ref), RunService (ref), u11 (ref), u25 (copy), u21 (copy), Gearscore_Amount (ref), formatCommas (ref)
                local v26 = 0;

                while v26 < 0.45 do
                    if u24 ~= u14 then
                        return;
                    end;

                    v26 = v26 + RunService.Heartbeat:Wait();
                    local v27 = 1 - (1 - math.clamp(v26 / 0.45, 0, 1)) ^ 3;
                    u11 = u25 + (u21 - u25) * v27;

                    if Gearscore_Amount then
                        Gearscore_Amount.Text = formatCommas(u11);
                    end;
                end;

                if u24 == u14 then
                    u11 = u21;

                    if Gearscore_Amount then
                        Gearscore_Amount.Text = formatCommas(u21);
                    end;
                end;
            end);
        end;

        if u8 then
            u8.Scale = 1.14;
            TweenService:Create(u8, TweenInfo_new_ret3, {
                Scale = 1
            }):Play();
        end;

        u13 = task.delay(1.5, hide);
    end;

    local u28 = false;
    task.delay(2, function() -- Line: 198
        -- upvalues: u28 (ref)
        u28 = true;
    end);
    LocalPlayer:GetAttributeChangedSignal("Stat_GearScore"):Connect(function() -- Line: 200
        -- upvalues: LocalPlayer (ref), u10 (ref), u28 (ref), u11 (ref), Gearscore_Amount (copy), formatCommas (ref), showChange (copy)
        local v29 = LocalPlayer:GetAttribute("Stat_GearScore") or 0;
        local v30 = v29 - u10;
        u10 = v29;

        if u28 then
            if v30 == 0 then
                return;
            end;

            showChange(v29, v30 > 0);

            return;
        end;

        u11 = v29;

        if Gearscore_Amount then
            Gearscore_Amount.Text = formatCommas(v29);
        end;
    end);
    print("[GearscoreNotification] Initialized");
end;

return v1;