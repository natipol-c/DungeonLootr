--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flaming_Arrow
  Path:     game.ReplicatedStorage.Classes.Cursed King.Skill_Modules.Flaming_Arrow
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:45 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = nil;

return {
    init = function(p2) -- Line: 15, Name: init
        -- upvalues: u1 (ref)
        u1 = p2;
    end,

    Hit = function(p3, p4) -- Line: 19, Name: Hit
        -- upvalues: u1 (ref), TweenService (copy)
        local HumanoidRootPart = p3.HumanoidRootPart;
        local v5 = script.Launch:Clone();
        v5:PivotTo(p3.HumanoidRootPart.CFrame * u1.Util.ScaleCFrame(CFrame.new(0, 0, -1)));
        v5.Parent = workspace.Effects[p3.Name];
        u1.Effects:AutoEmit(v5);
        local u6 = workspace.Effects[p3.Name][p4.ID];

        if u6:FindFirstChild("Weld") then
            u6:FindFirstChild("Weld"):Destroy();
        end;

        u6.Anchored = true;
        u6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -0.5));
        u6.Parent = workspace.Effects[p3.Name];
        u1.Effects:Emit(u6);
        u1.Effects:EnableParticles(u6);
        u6.CFrame = CFrame.lookAt(u6.Position, p4.Pos.Position);
        TweenService:Create(u6, TweenInfo.new(p4.Time + 0.05), {
            Position = p4.Pos.Position
        }):Play();
        task.wait(p4.Time);
        u1.Effects:DisableParticles(u6);
        task.delay(0.5, function() -- Line: 47
            -- upvalues: u6 (ref)
            u6:Destroy();
            u6 = nil;
        end);
        local v7 = script.Hit:Clone();
        v7:PivotTo(p4.Pos * CFrame.new(0, 0, 0));
        v7.Parent = workspace.Effects[p3.Name];
        u1.Effects:AutoEmit(v7);
    end,

    Arrow = function(p8, p9) -- Line: 64, Name: Arrow
        -- upvalues: u1 (ref)
        local v10 = script.Arrow:Clone();
        v10.Name = p9.ID;
        v10:PivotTo(p8.HumanoidRootPart.CFrame);
        v10.Parent = workspace.Effects[p8.Name];
        local Weld = Instance.new("Weld");
        Weld.C0 = u1.Util.ScaleCFrame(CFrame.new(0, 0, 0.5)) * CFrame.Angles(1.5707963267948966, 0.17453292519943295, 0);
        Weld.Part0 = v10;
        Weld.Part1 = p8["Left Arm"];
        Weld.Parent = v10;
    end,

    Start = function(p11) -- Line: 78, Name: Start
        -- upvalues: u1 (ref)
        local v12 = script.Arrow:Clone();
        v12:PivotTo(p11.HumanoidRootPart.CFrame);
        v12.Parent = workspace.Effects[p11.Name];
        local v13 = script.Windup:Clone();
        v13:PivotTo(p11.HumanoidRootPart.CFrame);
        v13.Parent = workspace.Effects[p11.Name];
        u1.Effects:AutoEmit(v13);

        for i = 0, 1 do
            local v14 = script.HandFire:Clone();
            v14:PivotTo(p11.HumanoidRootPart.CFrame);
            v14.Parent = workspace.Effects[p11.Name];
            local Weld = Instance.new("Weld");
            Weld.C0 = u1.Util.ScaleCFrame(CFrame.new(0, 1, 0));
            Weld.Part0 = v14;
            Weld.Part1 = p11[i == 1 and "Right Arm" or "Left Arm"];
            Weld.Parent = v14;
            u1.Effects:AutoEmit(v14);
            local _ = i;
        end;
    end
};