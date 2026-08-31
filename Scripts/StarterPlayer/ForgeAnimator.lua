--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ForgeAnimator
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.ForgeAnimator
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = {};
local TweenInfo_new_ret = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local TweenInfo_new_ret3 = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local TweenInfo_new_ret4 = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local TweenInfo_new_ret5 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret6 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local TweenInfo_new_ret7 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret8 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local UDim2_new_ret = UDim2.new(0, 0, 0, 0);
local u2 = nil;
local u3 = false;
local u4 = nil;

local function GetSoundController() -- Line: 78
    -- upvalues: u4 (ref), Knit (copy)
    if not u4 then
        u4 = Knit.GetController("SoundController");
    end;

    return u4;
end;

local function Resolve() -- Line: 87
    -- upvalues: u2 (ref), Players (copy)
    if u2 then
        return u2;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChild("PlayerGui");
    end;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChild("TopLevel");
    end;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChild("Forge");
    end;

    local v5;

    if LocalPlayer then
        v5 = LocalPlayer:FindFirstChild("Container");
    else
        v5 = LocalPlayer;
    end;

    if not v5 then
        return nil;
    end;

    u2 = {
        Forge = LocalPlayer,
        Container = v5,
        Hammer = v5:FindFirstChild("Hammer"),
        Spark = v5:FindFirstChild("Spark"),
        Sword = v5:FindFirstChild("Sword"),
        SwordFail = v5:FindFirstChild("Sword_Fail"),
        SwordSuccess = v5:FindFirstChild("Sword_Success"),
        Status = v5:FindFirstChild("Status")
    };
    local v6 = u2.Status and u2.Status:FindFirstChild("Success");
    u2.StatusSuccess = v6;
    local v7 = u2.Status and u2.Status:FindFirstChild("Fail");
    u2.StatusFail = v7;

    return u2;
end;

local function ResetParts(p8) -- Line: 114
    -- upvalues: UDim2_new_ret (copy)
    p8.Forge.GroupTransparency = 1;
    p8.Forge.Visible = false;

    if p8.Hammer then
        p8.Hammer.Rotation = 0;
        p8.Hammer.ImageTransparency = 0;
    end;

    if p8.Spark then
        p8.Spark.Size = UDim2_new_ret;
    end;

    if p8.Sword then
        p8.Sword.Visible = true;
    end;

    if p8.SwordFail then
        p8.SwordFail.Visible = false;
    end;

    if p8.SwordSuccess then
        p8.SwordSuccess.Visible = false;
    end;

    if p8.Status then
        p8.Status.TextTransparency = 1;
        local Attribute = p8.Status:GetAttribute("Start");

        if typeof(Attribute) == "UDim2" then
            p8.Status.Position = Attribute;
        end;
    end;

    if p8.StatusSuccess then
        p8.StatusSuccess.Enabled = true;
    end;

    if p8.StatusFail then
        p8.StatusFail.Enabled = false;
    end;
end;

local function RunSequence(u9: any, u10: boolean, u11: boolean, p12: boolean) -- Line: 142
    -- upvalues: ResetParts (copy), TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret4 (copy), u4 (ref), Knit (copy), TweenInfo_new_ret5 (copy), TweenInfo_new_ret6 (copy), UDim2_new_ret (copy), TweenInfo_new_ret8 (copy), TweenInfo_new_ret7 (copy), TweenInfo_new_ret3 (copy), TweenInfo_new_ret2 (copy)
    ResetParts(u9);
    u9.Forge.Visible = true;

    if p12 then
        u9.Forge.GroupTransparency = 0;

        if u9.Hammer then
            u9.Hammer.Rotation = -61;
        end;
    else
        TweenService:Create(u9.Forge, TweenInfo_new_ret, {
            GroupTransparency = 0
        }):Play();
        task.wait(0.5);

        if u9.Hammer then
            local v13 = TweenService:Create(u9.Hammer, TweenInfo_new_ret4, {
                Rotation = -61
            });
            v13:Play();
            v13.Completed:Wait();
        else
            task.wait(0.35);
        end;
    end;

    if not u4 then
        u4 = Knit.GetController("SoundController");
    end;

    local v14 = u4;

    if v14 then
        v14:Play(u10 and "Enchant" or "enchant_downgrade");
    end;

    local u15 = u9.Spark and u9.Spark:GetAttribute("Full_Size");

    if u9.Spark and typeof(u15) == "UDim2" then
        task.spawn(function() -- Line: 172
            -- upvalues: TweenService (ref), u9 (copy), TweenInfo_new_ret5 (ref), u15 (copy), TweenInfo_new_ret6 (ref), UDim2_new_ret (ref)
            TweenService:Create(u9.Spark, TweenInfo_new_ret5, {
                Size = u15
            }):Play();
            task.wait(0.3);
            TweenService:Create(u9.Spark, TweenInfo_new_ret6, {
                Size = UDim2_new_ret
            }):Play();
        end);
    end;

    task.spawn(function() -- Line: 180
        -- upvalues: u9 (copy), u10 (copy), u11 (copy), TweenService (ref), TweenInfo_new_ret8 (ref), TweenInfo_new_ret7 (ref)
        task.wait(0.04);

        if u9.Sword then
            u9.Sword.Visible = false;
        end;

        local v16 = u10 and u9.SwordSuccess or u9.SwordFail;

        if v16 then
            v16.Visible = true;
        end;

        if u9.Status then
            u9.Status.Text = u10 and "Success! +1" or (u11 and "Fail! -1" or "Fail!");

            if u9.StatusSuccess then
                u9.StatusSuccess.Enabled = u10;
            end;

            if u9.StatusFail then
                u9.StatusFail.Enabled = not u10;
            end;

            local Attribute = u9.Status:GetAttribute("End");
            TweenService:Create(u9.Status, TweenInfo_new_ret8, {
                TextTransparency = 0,
                Position = typeof(Attribute) == "UDim2" and Attribute and Attribute or u9.Status.Position
            }):Play();
        end;

        task.wait(0.06);

        if u9.Hammer then
            TweenService:Create(u9.Hammer, TweenInfo_new_ret7, {
                ImageTransparency = 1
            }):Play();
        end;
    end);
    task.wait(0.44999999999999996 + (p12 and 0.12 or 1));
    TweenService:Create(u9.Forge, p12 and TweenInfo_new_ret3 or TweenInfo_new_ret2, {
        GroupTransparency = 1
    }):Play();
    task.wait(p12 and 0.06 or 0.3);
    ResetParts(u9);
end;

function v1.Play(p17, p18) -- Line: 226
    -- upvalues: Resolve (copy), u3 (ref), RunSequence (copy), ResetParts (copy)
    local v19 = Resolve();

    if not v19 then
        warn("[ForgeAnimator] PlayerGui.TopLevel.Forge.Container not found — skipping animation");

        return;
    end;

    if u3 then
        return;
    end;

    u3 = true;
    local v20;

    if p17 then
        v20 = p17.Success == true;
    else
        v20 = p17;
    end;

    if p17 then
        p17 = p17.Downgraded == true;
    end;

    local success, result = pcall(RunSequence, v19, v20, p17, p18 == true);

    if not success then
        warn("[ForgeAnimator] sequence error:", result);
        pcall(ResetParts, v19);
    end;

    u3 = false;
end;

return v1;