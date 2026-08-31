--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EquipmentStatLines
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.EquipmentStatLines
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EquipmentData = require(ReplicatedStorage.GameInfo.EquipmentData);
local u7 = {
    BETTER_COLOR = Color3.fromRGB(60, 200, 100),
    WORSE_COLOR = Color3.fromRGB(225, 70, 70),
    NEUTRAL_COLOR = Color3.fromRGB(235, 235, 235),

    build = function(p1: any, p2: string?) -- Line: 39, Name: build
        -- upvalues: EquipmentData (copy)
        local v3 = {};

        if not p1 then
            return v3;
        end;

        for i, v in p1 do
            local v4 = {
                Key = i,
                Value = v,
                Formatted = EquipmentData.FormatStat(i, v, p2)
            };
            table.insert(v3, v4);
        end;

        table.sort(v3, function(p5, p6) -- Line: 50
            return p5.Key < p6.Key;
        end);

        return v3;
    end
};

local function addStatLine(p8: any, p9: any, p10: number, p11: string, p12: string, p13: number, p14: number?, p15: boolean) -- Line: 55
    -- upvalues: u7 (copy), EquipmentData (copy)
    local v16 = p9:Clone();
    v16.Name = "Stat_" .. p12;
    v16.LayoutOrder = p10;
    local NEUTRAL_COLOR = u7.NEUTRAL_COLOR;

    if p15 and (p14 ~= nil and p13 ~= p14) then
        local v17;

        if EquipmentData.InvertedStats[p12] then
            v17 = p13 < p14;
        else
            v17 = p14 < p13;
        end;

        if v17 then
            p11 = p11 .. "  ▲";
            NEUTRAL_COLOR = u7.BETTER_COLOR;
        else
            p11 = p11 .. "  ▼";
            NEUTRAL_COLOR = u7.WORSE_COLOR;
        end;
    end;

    v16.Text = p11;
    v16.TextColor3 = NEUTRAL_COLOR;
    v16.RichText = true;
    v16.Visible = true;
    v16.Parent = p8;
end;

function u7.render(p18, p19, p20, p21) -- Line: 98
    -- upvalues: EquipmentData (copy), addStatLine (copy)
    if not (p18 and p19) then
        return;
    end;

    for _, child in p18:GetChildren() do
        if child ~= p19 and not (child:IsA("UIListLayout") or child:IsA("UIPadding")) then
            child:Destroy();
        end;
    end;

    local v22 = {};
    local v23 = {};
    local v24, v25;

    if type(p21) == "table" and p21.GUID then
        v24 = true;
        v25 = p21.BaseDamage;

        if p21.GuaranteedStat and p21.GuaranteedStat.StatKey then
            v22[p21.GuaranteedStat.StatKey] = p21.GuaranteedStat.Value;
        end;

        if p21.Stats then
            for i, v in p21.Stats do
                v23[i] = v;
            end;
        end;
    else
        v24 = false;
        v25 = nil;
    end;

    local v26 = p20.ForgeBonuses or {};
    local v27 = 0;

    if p20.Slot == "Ring" and p20.BaseDamage then
        local v28 = v26.BaseDamage or 0;
        local v29 = EquipmentData.FormatStat("SoulBaseDamage", p20.BaseDamage);

        if v28 ~= 0 then
            v29 = v29 .. " (+" .. v28 .. ")";
        end;

        addStatLine(p18, p19, v27, v29, "SoulBaseDamage", p20.BaseDamage + v28, v25, v24);
        v27 = v27 + 1;
    end;

    if p20.GuaranteedStat and p20.GuaranteedStat.StatKey then
        local GuaranteedStat = p20.GuaranteedStat;
        local v30 = v26[GuaranteedStat.StatKey] or 0;
        local v31 = EquipmentData.FormatStat(GuaranteedStat.StatKey, GuaranteedStat.Value, p20.Slot);

        if v30 ~= 0 then
            v31 = v31 .. " (+" .. v30 .. ")";
        end;

        addStatLine(p18, p19, v27, v31, GuaranteedStat.StatKey, GuaranteedStat.Value + v30, v22[GuaranteedStat.StatKey], v24);
        v27 = v27 + 1;
    end;

    if p20.StatLines then
        for _, v in p20.StatLines do
            local v32 = v26[v.Key] or 0;
            local Formatted = v.Formatted;

            if v32 ~= 0 then
                Formatted = Formatted .. " (+" .. v32 .. ")";
            end;

            addStatLine(p18, p19, v27, Formatted, v.Key, v.Value + v32, v23[v.Key], v24);
            v27 = v27 + 1;
        end;
    end;
end;

return u7;