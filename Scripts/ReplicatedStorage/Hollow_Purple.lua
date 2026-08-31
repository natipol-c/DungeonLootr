--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Hollow_Purple
  Path:     game.ReplicatedStorage.Classes.Honored One.Skill_Modules.Hollow_Purple
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

if VFX then
    VFX = VFX:FindFirstChild("Skill3");
end;

return {
    init = function(p1) -- Line: 36, Name: init
    end,

    Emit = function(p2, p3, p4) -- Line: 40, Name: Emit
        -- upvalues: VFX (copy), ForgeVFXUtil (copy)
        local v5 = p4 or "Purple";
        local v6 = VFX and VFX:FindFirstChild(v5);

        if not v6 then
            warn((`[Honored One/Hollow_Purple] VFX rig "VFX/Skill3/{v5}" not found in the class folder`));

            return;
        end;

        if typeof(p3) ~= "CFrame" then
            p3 = nil;
        end;

        if p3 then
            p2 = p3;
        else
            if p2 then
                p2 = p2:FindFirstChild("HumanoidRootPart");
            end;

            if p2 then
                p2 = p2.CFrame;
            end;
        end;

        if not p2 then
            return;
        end;

        ForgeVFXUtil.Emit(v6, {
            MaxDistance = (1 / 0),
            StripCameraShake = true,
            CFrame = p2 * v6:GetPivot().Rotation
        });
    end,

    ScreenEffect = function(p7, p8) -- Line: 72, Name: ScreenEffect
        -- upvalues: ForgeVFXUtil (copy), VFX (copy)
        if not ForgeVFXUtil.IsScreenOwner(p7) then
            return;
        end;

        local v9 = VFX and VFX:FindFirstChild("ScreenEffect");

        if not v9 then
            warn("[Honored One/Hollow_Purple] VFX part \"VFX/Skill3/ScreenEffect\" not found in the class folder");

            return;
        end;

        if typeof(p8) ~= "CFrame" then
            p8 = nil;
        end;

        if p8 then
            p7 = p8;
        else
            if p7 then
                p7 = p7:FindFirstChild("HumanoidRootPart");
            end;

            if p7 then
                p7 = p7.CFrame;
            end;
        end;

        if not p7 then
            return;
        end;

        ForgeVFXUtil.Emit(v9, {
            MaxDistance = (1 / 0),
            StripCameraShake = true,
            CFrame = p7
        });
    end
};