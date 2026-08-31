--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Kazahana
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Zero.Kazahana
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    AnimationName = "Ability_2",
    MaxDuration = 2,
    HitboxSize = Vector3.new(36, 12, 36),
    HitboxRange = 20,
    SwingSFXFolder = "Cero_Shoot",
    LoopFX = "Hunt",
    ClonesPerHit = 2,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.7,
    CloneColor = Color3.fromRGB(80, 150, 255)
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._SpawnClones(u3) -- Line: 67
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    task.spawn(function() -- Line: 70
        -- upvalues: u1 (ref), u3 (copy), u2 (ref)
        for i = 1, u1.ClonesPerHit do
            if not u3.Is_Using_Skill then
                break;
            end;

            u2:FireAllClients(nil, {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                Color = u1.CloneColor,
                NPCModel = u3.Character
            });
            local v4;

            if i < u1.ClonesPerHit then
                task.wait(u1.CloneInterval);
                v4 = i;
            else
                v4 = i;
            end;
        end;
    end);
end;

function u1._PerformHit(p5, p6) -- Line: 89
    -- upvalues: u1 (copy)
    local v7 = p5:QueryHitbox(p6.HitboxSize or u1.HitboxSize, p6.HitboxRange or u1.HitboxRange);
    local v8 = p5:ResolveSkillDamage(p6.DamageMultiplier);

    for _, v in v7 do
        p5:ApplyDamage(v.Character, v8);
    end;
end;

function u1.Activate(u9, u10) -- Line: 104
    -- upvalues: u1 (copy)
    local v11 = u9.Animations[u1.AnimationName];

    if not v11 then
        warn("[Boss Kazahana] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u9.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u9.Is_Using_Skill = true;
    u9.Is_Attacking = true;
    local u12 = false;

    local function enableHuntFX() -- Line: 123
        -- upvalues: u12 (ref), u9 (copy), u1 (ref)
        if u12 then
            return;
        end;

        u12 = true;
        u9:PlayTurnFX(u1.LoopFX);
    end;

    local function disableHuntFX() -- Line: 128
        -- upvalues: u12 (ref), u9 (copy), u1 (ref)
        if not u12 then
            return;
        end;

        u12 = false;
        u9:PlayTurnFX(u1.LoopFX);
    end;

    v11:Play(0, 1, u10.AnimSpeed or 1);
    local v13 = v11:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 139
        -- upvalues: u12 (ref), u9 (copy), u1 (ref), u10 (copy)
        if not u12 then
            u12 = true;
            u9:PlayTurnFX(u1.LoopFX);
        end;

        u9:PlayCombatSound(u10.SwingSoundFolder or u1.SwingSFXFolder, nil, u9.ClassData.SwingVolume or 0.5);
        u1._SpawnClones(u9);
        u1._PerformHit(u9, u10);
    end);
    local u14 = false;
    local v15 = v11:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 151
        -- upvalues: u14 (ref)
        u14 = true;
    end);
    v11.Stopped:Once(function() -- Line: 154
        -- upvalues: u14 (ref)
        u14 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 157
        -- upvalues: u14 (ref)
        u14 = true;
    end);

    while not u14 do
        task.wait();
    end;

    if v13 then
        v13:Disconnect();
    end;

    if v15 then
        v15:Disconnect();
    end;

    if u12 then
        u12 = false;
        u9:PlayTurnFX(u1.LoopFX);
    end;

    u9.Is_Using_Skill = false;
    u9.Is_Attacking = false;
end;

return u1;