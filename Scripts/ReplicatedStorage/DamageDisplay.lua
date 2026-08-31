--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DamageDisplay
  Path:     game.ReplicatedStorage.Modules.DamageDisplay
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ObjectCache = require(ReplicatedStorage.Modules.ObjectCache);
local DamageNumberData = require(ReplicatedStorage.GameInfo.DamageNumberData);
local Random_new_ret = Random.new();
local u1 = nil;
local u2 = nil;
local u3 = {};

function u3.SetAnimation(p4: string?) -- Line: 48
    -- upvalues: u2 (ref), DamageNumberData (copy), u3 (copy)
    if p4 == nil then
        u2 = nil;
    elseif DamageNumberData.Get(p4) then
        u2 = p4;
    else
        warn((`[DamageDisplay] Unknown animation '{tostring(p4)}' — keeping '{u3.GetAnimation()}'`));
    end;

    return u3.GetAnimation();
end;

function u3.GetAnimation() -- Line: 60
    -- upvalues: u2 (ref), DamageNumberData (copy)
    local v5 = u2 and DamageNumberData.Get(u2) or DamageNumberData.GetActive();

    return v5 and v5.Name or nil;
end;

function u3.GetAnimationNames() -- Line: 66
    -- upvalues: DamageNumberData (copy)
    return DamageNumberData.GetNames();
end;

local function getCache() -- Line: 72
    -- upvalues: u1 (ref), RunService (copy), ReplicatedStorage (copy), ObjectCache (copy)
    if u1 then
        return u1;
    end;

    if not RunService:IsClient() then
        return nil;
    end;

    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild("UI");
    end;

    if Assets then
        Assets = Assets:FindFirstChild("DamageDisplay");
    end;

    if Assets then
        u1 = ObjectCache.new(Assets, 60);

        return u1;
    end;

    warn("[DamageDisplay] Missing template ReplicatedStorage.Assets.UI.DamageDisplay");

    return nil;
end;

function u3.Init() -- Line: 94
    -- upvalues: getCache (copy)
    getCache();
end;

local function scaleSize(p6, p7: number) -- Line: 101
    return UDim2.new(p6.X.Scale * p7, p6.X.Offset, p6.Y.Scale * p7, p6.Y.Offset);
end;

function u3.DisplayDamage(p8: any, p9: any, p10, p11: table?) -- Line: 114
    -- upvalues: getCache (copy), u2 (ref), DamageNumberData (copy), scaleSize (copy), Random_new_ret (copy)
    local u12 = getCache();

    if not u12 then
        return;
    end;

    local v13 = u2 and DamageNumberData.Get(u2) or DamageNumberData.GetActive();

    if not v13 then
        return;
    end;

    local v14 = p11 and (p11.SizeScale or 1) or 1;
    local v15 = p11 and (p11.VelocityScale or 1) or 1;

    if p11 then
        p11 = p11.IsCrit;
    end;

    if typeof(p8) ~= "CFrame" then
        p8 = CFrame.new(p8);
    end;

    if typeof(p9) ~= "string" then
        local math_round_ret = math.round(p9);
        p9 = tostring(math_round_ret);
    end;

    local Part = u12:GetPart(p8);
    local DamageDisplay = Part.DamageDisplay;
    local DamageLabel = DamageDisplay.Frame.DamageLabel;
    local UIStroke = DamageLabel.UIStroke;
    DamageLabel.Text = p9;
    DamageLabel.TextTransparency = 0;
    UIStroke.Transparency = 0;
    DamageDisplay.Enabled = true;
    local u16 = false;
    v13.Render({
        Part = Part,
        Billboard = DamageDisplay,
        Label = DamageLabel,
        Stroke = UIStroke,
        Spawn = p8,
        Color = p10,
        IsCrit = p11 == true,
        SizeScale = v14,
        VelocityScale = v15,
        ScaleSize = scaleSize,
        RNG = Random_new_ret,

        Release = function() -- Line: 148, Name: release
            -- upvalues: u16 (ref), Part (copy), DamageDisplay (copy), u12 (copy)
            if u16 then
                return;
            end;

            u16 = true;
            Part.Anchored = true;
            DamageDisplay.Enabled = false;
            u12:ReturnPart(Part);
        end
    });
end;

return u3;