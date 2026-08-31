--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Moonfall
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Artemis.Moonfall
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 2,
    RainDuration = 3,
    TickInterval = 0.25,
    HitboxSize = Vector3.new(32, 25, 32)
};

local function runRain(p2, p3, p4) -- Line: 44
    -- upvalues: u1 (copy), Players (copy)
    local v5 = p4.TickInterval or u1.TickInterval;
    local v6 = p4.HitboxSize or u1.HitboxSize;
    local math_floor_ret = math.floor((p4.RainDuration or u1.RainDuration) / v5);
    local v7 = p2:ResolveSkillDamage(p4.DamageMultiplier);

    for i = 1, math_floor_ret do
        local v8 = p2.Character and (p2.Character.Parent and p2.Character:FindFirstChild("HumanoidRootPart"));

        if not v8 then
            break;
        end;

        local OverlapParams_new_ret = OverlapParams.new();
        OverlapParams_new_ret.ExcludeInstances = { p2.Character };
        local v9 = {};

        for _, v in workspace:GetPartBoundsInBox(CFrame.new(v8.Position), v6, OverlapParams_new_ret) do
            local v10 = v:FindFirstAncestorOfClass("Model");

            if v10 and (not v9[v10] and (Players:GetPlayerFromCharacter(v10) and v10:FindFirstChildOfClass("Humanoid"))) then
                v9[v10] = true;
            end;
        end;

        for i2 in v9 do
            if not i2:HasTag("Ignore_Damage") and (not i2:GetAttribute("Dead") or i2:GetAttribute("Can_Finish")) then
                p2:ApplyDamage(i2, v7);
            end;
        end;

        if i < math_floor_ret then
            task.wait(v5);
        end;
    end;

    if p3 and p3.Parent then
        p3:SetAttribute("FX_Activate", false);
    end;
end;

function u1.Activate(u11, u12) -- Line: 103
    -- upvalues: u1 (copy), runRain (copy)
    local v13 = u11.Animations[u1.AnimationName];

    if not v13 then
        warn("[Boss Moonfall] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u11.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u11.Is_Using_Skill = true;
    u11.Is_Attacking = true;
    local u14 = false;
    v13:Play(0, 1, u12.AnimSpeed or 1);
    local v17 = v13:GetMarkerReachedSignal("hit"):Connect(function(p15) -- Line: 125
        -- upvalues: u12 (copy), u11 (copy), runRain (ref)
        u11:PlayCombatSound(u12.SwingSoundFolder or u11.ClassData.SwingSoundFolder or "Bow_Shot", nil, u11.ClassData.SwingVolume or 0.8);
        local v16 = u11.FX and u11.FX.Rain;

        if v16 then
            v16:SetAttribute("FX_Activate", true);
        end;

        task.spawn(runRain, u11, v16, u12);
    end);
    v13.Stopped:Once(function() -- Line: 141
        -- upvalues: u14 (ref)
        u14 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 146
        -- upvalues: u14 (ref)
        u14 = true;
    end);

    while not u14 do
        task.wait();
    end;

    if v17 then
        v17:Disconnect();
    end;

    u11.Is_Using_Skill = false;
    u11.Is_Attacking = false;
end;

return u1;