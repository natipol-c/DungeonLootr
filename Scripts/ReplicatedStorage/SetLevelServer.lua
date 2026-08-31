--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SetLevelServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.SetLevelServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LevelData = require(ReplicatedStorage.GameInfo.LevelData);

return function(p1, p2, p3, p4) -- Line: 12
    -- upvalues: Knit (copy), LevelData (copy)
    local v5 = (p4 or "player"):lower();
    local Service = Knit.GetService("DataService");
    local Service2 = Knit.GetService("StatService");
    local v6 = Service:Get(p2);

    if not v6 then
        return `Failed: No data found for {p2.Name}`;
    end;

    local Data = v6.Data.Data;

    if v5 ~= "class" then
        local math_clamp_ret = math.clamp(p3, 1, LevelData.PLAYER_LEVEL_CAP);
        local v7 = Data.PlayerLevel or 1;
        Service:Set(p2, { "PlayerLevel" }, math_clamp_ret);
        Service:Set(p2, { "PlayerXP" }, 0);
        p2:SetAttribute("PlayerLevel", math_clamp_ret);
        local v8 = (math_clamp_ret - v7) * LevelData.SKILL_POINTS_PER_LEVEL;

        if v8 ~= 0 then
            Service:Increment(p2, { "UnspentSkillPoints" }, v8);
        end;

        Service2:RecalculateAll(p2);

        return `Set {p2.Name}'s level to {math_clamp_ret} (was {v7}, {v8 >= 0 and "+" or ""}{v8} skill points)`;
    end;

    local ActiveClass = Data.ActiveClass;

    if not ActiveClass or ActiveClass == "" then
        return `Failed: {p2.Name} has no active class`;
    end;

    local math_clamp_ret = math.clamp(p3, 1, LevelData.CLASS_LEVEL_CAP);
    local v9 = Data.ClassMastery and Data.ClassMastery[ActiveClass];
    local v10 = v9 and (v9.Level or 1) or 1;
    Service:Set(p2, { "ClassMastery", ActiveClass }, {
        XP = 0,
        Level = math_clamp_ret,
        HighestLevel = v9 and v9.HighestLevel or 0
    });
    local Service3 = Knit.GetService("LevelService");

    if Service3 and v10 < math_clamp_ret then
        for i = v10 + 1, math_clamp_ret do
            Service3.Client.ClassLevelUp:Fire(p2, ActiveClass, i);
            Service3:_ProcessMasteryMilestone(p2, ActiveClass, i);
            local _ = i;
        end;
    end;

    Service2:RecalculateAll(p2);

    return `Set {p2.Name}'s {ActiveClass} mastery level to {math_clamp_ret} (was {v10})`;
end;