--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RarityGradient
  Path:     game.ReplicatedStorage.Modules.RarityGradient
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local u1 = {
    RARITY_GRADIENT_NAME = "RarityGradient"
};
local u2 = {};

function u1.colorSequence(p3: string?) -- Line: 65
    -- upvalues: RarityColors (copy), u2 (copy)
    local v4;

    if p3 then
        v4 = RarityColors[p3] or nil;
    else
        v4 = nil;
    end;

    if not v4 then
        return nil;
    end;

    local v5 = u2[p3];

    if v5 then
        return v5;
    end;

    local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, v4.BackgroundColor3), ColorSequenceKeypoint.new(1, v4.BorderColor3) });
    u2[p3] = ColorSequence_new_ret;

    return ColorSequence_new_ret;
end;

function u1.toggle(p6: userdata?, p7: string?) -- Line: 81
    if not p6 then
        return;
    end;

    for _, child in p6:GetChildren() do
        if child:IsA("UIGradient") then
            child.Enabled = child.Name == p7;
        end;
    end;
end;

function u1.apply(p8: userdata, p9: string?) -- Line: 97
    -- upvalues: RarityColors (copy), u1 (copy)
    local v10 = false;

    for _, descendant in p8:GetDescendants() do
        if descendant:IsA("UIGradient") and RarityColors[descendant.Name] then
            v10 = true;
            local v11;

            if p9 == nil then
                v11 = false;
            else
                v11 = descendant.Name == p9;
            end;

            descendant.Enabled = v11;
        end;
    end;

    if v10 then
        return;
    end;

    local v12 = u1.colorSequence(p9);

    for _, descendant in p8:GetDescendants() do
        if descendant:IsA("UIGradient") and descendant.Name == "RarityGradient" then
            if v12 then
                descendant.Color = v12;
                descendant.Enabled = true;
            else
                descendant.Enabled = false;
            end;
        end;
    end;
end;

function u1.set(p13: userdata?, p14: string?, p15: number?) -- Line: 129
    -- upvalues: u1 (copy)
    if not p13 then
        return nil;
    end;

    local v16 = nil;

    for _, child in p13:GetChildren() do
        if child:IsA("UIGradient") and child.Name == "RarityGradient" then
            v16 = child;
            break;
        end;
    end;

    if not v16 then
        v16 = Instance.new("UIGradient");
        v16.Name = "RarityGradient";
        v16.Parent = p13;
    end;

    local v17 = u1.colorSequence(p14);

    if v17 then
        v16.Color = v17;
        v16.Enabled = true;
    else
        v16.Enabled = false;
    end;

    if p15 ~= nil then
        v16.Rotation = p15;
    end;

    return v16;
end;

return u1;