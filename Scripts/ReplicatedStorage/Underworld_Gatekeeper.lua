--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Underworld_Gatekeeper
  Path:     game.ReplicatedStorage.GameInfo.Boss_Phases.Underworld_Gatekeeper
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local v1 = {};

local function swapCosmetics(p2) -- Line: 39
end;

local function swapMovesetAnimations(p3) -- Line: 49
end;

function v1.OnEnter(p4) -- Line: 54
    local npc = p4.npc;
    local v5;

    if npc then
        v5 = npc.Body;
    else
        v5 = npc;
    end;

    if not (v5 and v5.PrimaryPart) then
        return;
    end;

    v5:SetAttribute("Is_Stunned", true);
    v5:SetAttribute("DashIFrameUntil", os.clock() + 1.6);
    task.wait(1.6);

    if not v5.Parent or npc.State == "Dead" then
        return;
    end;

    npc.Damage = npc.Damage * 1.25;
    v5:SetAttribute("Is_Stunned", false);
end;

return v1;