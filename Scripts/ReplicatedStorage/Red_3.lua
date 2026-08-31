--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Red
  Path:     game.ReplicatedStorage.Classes.Honored One.Skill_Modules.Red
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:54 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ForgeVFXUtil = require(ReplicatedStorage.Modules.ForgeVFXUtil);
local VFX = script.Parent.Parent:FindFirstChild("VFX");
local u1;

if VFX then
    u1 = VFX:FindFirstChild("Skill2");
else
    u1 = VFX;
end;

if u1 then
    u1 = u1:FindFirstChild("Red_Var1");
end;

if VFX then
    VFX = VFX:FindFirstChild("Skill2 Hold");
end;

if VFX then
    VFX = VFX:FindFirstChild("Red_Var2");
end;

local function emitAt(p2: userdata?, p3: string, p4: any, p5: any) -- Line: 36
    -- upvalues: ForgeVFXUtil (copy)
    if not p2 then
        warn((`[Honored One/Red] VFX rig "{p3}" not found in the class folder`));

        return;
    end;

    if typeof(p5) ~= "CFrame" then
        p5 = nil;
    end;

    if p5 then
        p4 = p5;
    else
        if p4 then
            p4 = p4:FindFirstChild("HumanoidRootPart");
        end;

        if p4 then
            p4 = p4.CFrame;
        end;
    end;

    if not p4 then
        return;
    end;

    ForgeVFXUtil.Emit(p2, {
        MaxDistance = (1 / 0),
        StripCameraShake = true,
        CFrame = p4 * p2:GetPivot().Rotation
    });
end;

return {
    init = function(p6) -- Line: 58, Name: init
    end,

    Tap = function(p7, p8) -- Line: 62, Name: Tap
        -- upvalues: emitAt (copy), u1 (copy)
        emitAt(u1, "VFX/Skill2/Red_Var1", p7, p8);
    end,

    Hold = function(p9, p10) -- Line: 66, Name: Hold
        -- upvalues: emitAt (copy), VFX (copy)
        emitAt(VFX, "VFX/Skill2 Hold/Red_Var2", p9, p10);
    end
};