--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Blue
  Path:     game.ReplicatedStorage.Classes.Honored One.Skill_Modules.Blue
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:54 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ForgeVFXUtil = require(ReplicatedStorage.Modules.ForgeVFXUtil);
local CFrame_new_ret = CFrame.new(0, 0, -23);
local VFX = script.Parent.Parent:FindFirstChild("VFX");

if VFX then
    VFX = VFX:FindFirstChild("Skill1");
end;

if VFX then
    VFX = VFX:FindFirstChild("Blue");
end;

local u1 = setmetatable({}, {
    __mode = "k"
});

return {
    init = function(p2) -- Line: 53, Name: init
    end,

    Start = function(p3, p4) -- Line: 57, Name: Start
        -- upvalues: VFX (copy), ForgeVFXUtil (copy), CFrame_new_ret (copy), u1 (copy)
        if not VFX then
            warn("[Honored One/Blue] VFX rig \"VFX/Skill1/Blue\" not found in the class folder");

            return;
        end;

        local v5;

        if p3 then
            v5 = p3:FindFirstChild("HumanoidRootPart");
        else
            v5 = p3;
        end;

        if not v5 then
            return;
        end;

        local v6 = ForgeVFXUtil.Emit(VFX, {
            MaxDistance = (1 / 0),
            StripCameraShake = true,
            AttachTo = v5,
            Offset = CFrame_new_ret
        });

        if v6 then
            u1[p3] = v6;
        end;
    end,

    Detach = function(p7) -- Line: 79, Name: Detach
        -- upvalues: u1 (copy)
        local v8 = u1[p7];

        if v8 then
            v8.StopFollow();
        end;
    end,

    DBreset = function(p9) -- Line: 86, Name: DBreset
        -- upvalues: u1 (copy)
        local u10 = u1[p9];

        if u10 then
            u1[p9] = nil;
            task.delay(2, function() -- Line: 90
                -- upvalues: u10 (copy)
                u10.Clear();
            end);
        end;
    end
};