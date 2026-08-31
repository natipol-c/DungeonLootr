--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GearScoreData
  Path:     game.ReplicatedStorage.GameInfo.GearScoreData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Brackets = { {
            Name = "Highest",
            Min = 5000
        }, {
            Name = "High",
            Min = 2000
        }, {
            Name = "Mid",
            Min = 500
        }, {
            Name = "Low",
            Min = 0
        } }
};

function u1.GetBracket(p2: number) -- Line: 28
    -- upvalues: u1 (copy)
    for _, v in u1.Brackets do
        if v.Min <= p2 then
            return v.Name;
        end;
    end;

    return "Low";
end;

function u1.ApplyBracketGradient(p3: userdata, p4: number) -- Line: 39
    -- upvalues: u1 (copy)
    local Bracket = u1.GetBracket(p4);

    for _, child in p3:GetChildren() do
        if child:IsA("UIGradient") then
            child.Enabled = child.Name == Bracket;
        end;
    end;
end;

function u1.FormatShort(p5: number) -- Line: 50
    if p5 >= 1000 then
        return string.format("%.1fK", p5 / 1000);
    end;

    local math_floor_ret = math.floor(p5);

    return tostring(math_floor_ret);
end;

function u1.FormatCommas(p6: number) -- Line: 59
    if p6 >= 1000000 then
        return string.format("%.1fM", p6 / 1000000);
    end;

    local math_floor_ret = math.floor(p6);
    local v7 = tostring(math_floor_ret);
    local v8;

    repeat
        v7, v8 = string.gsub(v7, "^(-?%d+)(%d%d%d)", "%1,%2");
    until v8 == 0;

    return v7;
end;

return u1;