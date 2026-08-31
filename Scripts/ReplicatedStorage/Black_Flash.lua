--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Black_Flash
  Path:     game.ReplicatedStorage.Classes.Divergent.Skill_Modules.Black_Flash
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:46 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ForgeVFXUtil = require(ReplicatedStorage.Modules.ForgeVFXUtil);
local RigMap = require(ReplicatedStorage.Globals.Modules.RigMap);
local VFX = script.Parent.Parent:FindFirstChild("VFX");

if VFX then
    VFX = VFX:FindFirstChild("skill3");
end;

local u1 = setmetatable({}, {
    __mode = "k"
});
local v3 = {
    init = function(p2) -- Line: 43, Name: init
    end
};

local function clearHandle(p4: any, p5: number?) -- Line: 48
    -- upvalues: u1 (copy)
    local u6 = u1[p4];

    if not u6 then
        return;
    end;

    u1[p4] = nil;

    if p5 and p5 > 0 then
        task.delay(p5, function() -- Line: 53
            -- upvalues: u6 (copy)
            u6.Clear();
        end);

        return;
    end;

    u6.Clear();
end;

function v3.Emit(p7, p8, p9) -- Line: 61
    -- upvalues: VFX (copy), RigMap (copy), u1 (copy), ForgeVFXUtil (copy)
    if not VFX then
        warn("[Divergent/Black_Flash] VFX rig \"VFX/skill3\" not found in the class folder");

        return;
    end;

    if not p7 then
        return;
    end;

    local WeldTarget, v10 = RigMap.GetWeldTarget(p7, "Right Arm");

    if not WeldTarget then
        return;
    end;

    local v11 = u1[p7];

    if v11 then
        u1[p7] = nil;
        v11.Clear();
    end;

    local v12 = ForgeVFXUtil.Emit(VFX, {
        MaxDistance = (1 / 0),
        StripCameraShake = true,
        CFrame = v10 and v10.WorldCFrame or WeldTarget.CFrame,
        Parent = WeldTarget
    });

    if v12 then
        u1[p7] = v12;
    end;
end;

function v3.DBreset(p13) -- Line: 91
    -- upvalues: u1 (copy)
    local u14 = u1[p13];

    if not u14 then
        return;
    end;

    u1[p13] = nil;
    task.delay(2, function() -- Line: 53
        -- upvalues: u14 (copy)
        u14.Clear();
    end);
end;

return v3;