--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Phantom.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Color3_fromRGB_ret = Color3.fromRGB(80, 30, 130);
local u1 = nil;

local function getShadowDashRemote() -- Line: 53
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    if u1 and u1.Parent then
        return u1;
    end;

    local Player = ReplicatedStorage:FindFirstChild("Player");

    if Player then
        Player = Player:FindFirstChild("Remotes");
    end;

    u1 = Player and Player:FindFirstChild("ShadowDash") or nil;

    return u1;
end;

local function grantEmpower(u2) -- Line: 67
    u2._phantomBuffUntil = os.clock() + 5;

    if u2._phantomBuffActive then
        return;
    end;

    local v3 = u2:GetEffectiveStat("DamageMultiplier") * 0.25;
    u2._phantomBuffActive = true;
    u2._phantomBuffDelta = v3;
    u2:ModifyStat("DamageMultiplier", v3);
    task.spawn(function() -- Line: 76
        -- upvalues: u2 (copy)
        while os.clock() < (u2._phantomBuffUntil or 0) do
            task.wait(0.25);

            if not u2._phantomBuffActive then
                return;
            end;
        end;

        u2:ModifyStat("DamageMultiplier", -(u2._phantomBuffDelta or 0));
        u2._phantomBuffActive = false;
    end);
end;

local function detonate(p4: any, p5: vector) -- Line: 89
    -- upvalues: grantEmpower (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p5);
    Part.Parent = workspace;
    p4:PlayAspectBurst("Umbral_Explode", Part, "Umbral_Explode");
    task.delay(1, function() -- Line: 102
        -- upvalues: Part (copy)
        if Part and Part.Parent then
            Part:Destroy();
        end;
    end);
    local v6 = false;

    for _, v in p4:FindEnemiesNearPosition(p5, 12) do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) and p4:CanApplyStatusTo(v) then
            p4:ApplyDamage(v, p4:ResolveSkillDamage(1.5, v));
            local v7 = v:FindFirstChildWhichIsA("Humanoid");

            if v:GetAttribute("Dead") or v7 and v7.Health <= 0 then
                v6 = true;
            end;
        end;
    end;

    if v6 then
        grantEmpower(p4);
    end;
end;

return {
    Name = "Phantom",
    Procs = {
        {
            Name = "Phantom_AfterImage",
            Trigger = "OnDodge",
            Cooldown = 0,

            Execute = function(u8, p9) -- Line: 130, Name: OnDodge
                -- upvalues: u1 (ref), ReplicatedStorage (copy), Color3_fromRGB_ret (copy), detonate (copy)
                local Player = u8.Player;
                local Character = u8.Character;

                if Character then
                    Character = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart;
                end;

                if not (Player and Character) then
                    return;
                end;

                if p9 then
                    p9 = p9.Direction;
                end;

                local v10 = (typeof(p9) ~= "Vector3" or p9.Magnitude <= 0.01) and Vector3.new(0, 0, 0) or p9.Unit * 14;
                local u11 = Character.Position - v10;
                local v12;

                if u1 and u1.Parent then
                    v12 = u1;
                else
                    local Player2 = ReplicatedStorage:FindFirstChild("Player");

                    if Player2 then
                        Player2 = Player2:FindFirstChild("Remotes");
                    end;

                    u1 = Player2 and Player2:FindFirstChild("ShadowDash") or nil;
                    v12 = u1;
                end;

                if v12 then
                    v12:FireAllClients(Player, {
                        Action = "Clone",
                        FadeDuration = 0.5,
                        Color = Color3_fromRGB_ret,
                        Offset = -v10
                    });
                end;

                task.delay(0.35, function() -- Line: 159
                    -- upvalues: u8 (copy), detonate (ref), u11 (copy)
                    if not (u8.Character and u8.Character.Parent) then
                        return;
                    end;

                    detonate(u8, u11);
                end);
            end
        }
    }
};