--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cleave_Rampage
  Path:     game.ReplicatedStorage.Classes.Cursed King.Skill_Modules.Cleave_Rampage
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:45 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;

return {
    init = function(p2) -- Line: 14, Name: init
        -- upvalues: u1 (ref)
        u1 = p2;
    end,

    Hit = function(p3) -- Line: 20, Name: Hit
        -- upvalues: u1 (ref)
        local v4 = script.CleaveRampage:Clone();
        v4:PivotTo(p3.HumanoidRootPart.CFrame);
        v4.Parent = workspace.Effects[p3.Name];
        u1.Effects:AutoEmit(v4);
    end,

    Windup = function(p5) -- Line: 31, Name: Windup
    end
};