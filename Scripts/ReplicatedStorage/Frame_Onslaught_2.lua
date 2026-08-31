--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Frame_Onslaught
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Framebreaker.Frame_Onslaught
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    AnimationName = "Ability_4",
    MaxDuration = 3.5,
    HitboxSize = Vector3.new(18, 12, 28),
    HitboxRange = 28
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._SpawnClones(u3, p4) -- Line: 47
    -- upvalues: u2 (copy)
    if not u2 then
        return;
    end;

    local u5 = p4.CloneCount or 3;
    local u6 = p4.CloneInterval or 0.04;
    local u7 = p4.CloneFadeDuration or 0.8;
    local u8 = p4.CloneColor or Color3.fromRGB(0, 200, 180);
    task.spawn(function() -- Line: 55
        -- upvalues: u5 (copy), u3 (copy), u2 (ref), u7 (copy), u8 (copy), u6 (copy)
        for i = 1, u5 do
            if not u3.Is_Using_Skill then
                break;
            end;

            u2:FireAllClients(nil, {
                Action = "Clone",
                FadeDuration = u7,
                Color = u8,
                NPCModel = u3.Character
            });
            local v9;

            if i < u5 then
                task.wait(u6);
                v9 = i;
            else
                v9 = i;
            end;
        end;
    end);
end;

function u1._PerformHit(p10, p11) -- Line: 74
    -- upvalues: u1 (copy)
    local v12 = p10:QueryHitbox(p11.HitboxSize or u1.HitboxSize, p11.HitboxRange or u1.HitboxRange);
    local v13 = p10:ResolveSkillDamage(p11.DamageMultiplier);

    for _, v in v12 do
        p10:ApplyDamage(v.Character, v13);
    end;
end;

function u1.Activate(u14, u15) -- Line: 89
    -- upvalues: u1 (copy)
    local v16 = u14.Animations[u1.AnimationName];

    if not v16 then
        warn("[Boss Frame_Onslaught] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u14.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u14.Is_Using_Skill = true;
    u14.Is_Attacking = true;
    local u17 = false;
    v16:Play(0, 1, u15.AnimSpeed or 1);
    local v19 = v16:GetMarkerReachedSignal("hit"):Connect(function(p18) -- Line: 111
        -- upvalues: u15 (copy), u14 (copy), u1 (ref)
        u14:PlayCombatSound(u15.SwingSoundFolder or (u14.ClassData.SwingSoundFolder or "Naoya_Punches"), nil, u14.ClassData.SwingVolume or 1);

        if p18 == "" or not p18 then
            p18 = nil;
        end;

        u14:PlayTurnFX(p18);
        u1._PerformHit(u14, u15);
        u1._SpawnClones(u14, u15);
    end);
    v16.Stopped:Once(function() -- Line: 125
        -- upvalues: u17 (ref)
        u17 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 130
        -- upvalues: u17 (ref)
        u17 = true;
    end);

    while not u17 do
        task.wait();
    end;

    if v19 then
        v19:Disconnect();
    end;

    u14.Is_Using_Skill = false;
    u14.Is_Attacking = false;
end;

return u1;