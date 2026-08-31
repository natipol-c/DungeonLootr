--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Shadow_Pursuit
  Path:     game.ReplicatedStorage.Classes.Kage.Mastery_Passives.Shadow_Pursuit
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:00 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local v1 = {
    Name = "Shadow_Pursuit",
    Trigger = "OnDodge",
    Cooldown = 3,
    Level = 13
};

local function _EnsureAnimation(p2) -- Line: 45
    -- upvalues: ReplicatedStorage (copy)
    if p2.Animations.ShadowPursuit_Ability_1 then
        return p2.Animations.ShadowPursuit_Ability_1;
    end;

    local v3 = ReplicatedStorage.Classes:FindFirstChild(p2.ClassName);

    if not v3 then
        return nil;
    end;

    local Skill_Animations = v3:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local Ability_1 = Skill_Animations:FindFirstChild("Ability_1");

    if not Ability_1 then
        return nil;
    end;

    local v4 = p2.Humanoid and p2.Humanoid:FindFirstChildOfClass("Animator");

    if not v4 then
        return nil;
    end;

    local v5 = v4:LoadAnimation(Ability_1);
    v5.Priority = Enum.AnimationPriority.Action3;
    v5:Play(0, 0, 0);
    v5:Stop(0);
    p2.Animations.ShadowPursuit_Ability_1 = v5;

    return v5;
end;

local function _PerformHit(p6) -- Line: 71
    local HitboxSize = p6.ClassData.HitboxSize;
    local Range = p6.ClassData.Range;
    p6.ClassData.HitboxSize = Vector3.new(20, 20, 28);
    p6.ClassData.Range = 28;
    local v7 = p6:Hitbox();
    p6.ClassData.HitboxSize = HitboxSize;
    p6.ClassData.Range = Range;
    local v8 = 0;

    for _, v in v7 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p6:ApplyDamage(v, (p6:ResolveSkillDamage(3.5, v)));
            v8 = v8 + 1;
        end;
    end;

    return v8;
end;

local function _FindNearestEnemy(p9) -- Line: 95
    -- upvalues: CollectionService (copy)
    local v10 = p9.Character and p9.Character:FindFirstChild("HumanoidRootPart");

    if not v10 then
        return nil;
    end;

    local Position = v10.Position;
    local v11 = 61;
    local v12 = nil;

    for _, v in CollectionService:GetTagged("Enemy") do
        if v.Parent and not v:GetAttribute("Dead") then
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local Magnitude = (HumanoidRootPart.Position - Position).Magnitude;

                if Magnitude <= 60 and Magnitude < v11 then
                    v11 = Magnitude;
                    v12 = {
                        model = v,
                        hrp = HumanoidRootPart
                    };
                end;
            end;
        end;
    end;

    return v12;
end;

local function _WarpBehind(p13, p14) -- Line: 120
    local v15 = p13.Character and p13.Character:FindFirstChild("HumanoidRootPart");

    if not (v15 and p14.hrp) then
        return;
    end;

    local v16 = p14.hrp.CFrame * CFrame.new(0, 0, 5);
    v15.CFrame = CFrame.new(v16.Position, p14.hrp.Position);
end;

function v1.Execute(u17, p18) -- Line: 130
    -- upvalues: _EnsureAnimation (copy), SharedUtils (copy), _FindNearestEnemy (copy), _WarpBehind (copy), _PerformHit (copy)
    if u17.Is_Using_Skill then
        return;
    end;

    local v19 = _EnsureAnimation(u17);

    if not v19 then
        return;
    end;

    local Character = u17.Character;
    local v20;

    if Character then
        v20 = Character:FindFirstChild("HumanoidRootPart");
    else
        v20 = Character;
    end;

    if not v20 then
        return;
    end;

    u17.Is_Using_Skill = true;
    u17.Is_Attacking = true;
    Character:SetAttribute("Dodge", true);
    task.delay(1.2, function() -- Line: 148
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);

    for i, v in u17.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    SharedUtils.PlaySoundAt(v20, "Dark_Chase", 1);
    local v21 = _FindNearestEnemy(u17);

    if v21 then
        _WarpBehind(u17, v21);
    end;

    v19:Play(0, 1, 1);
    local u24 = v19:GetMarkerReachedSignal("hit"):Connect(function(p22) -- Line: 175
        -- upvalues: u17 (copy), SharedUtils (ref), _PerformHit (ref)
        local v23 = u17.Character and u17.Character:FindFirstChild("HumanoidRootPart");

        if not v23 then
            return;
        end;

        SharedUtils.PlaySoundAt(v23, "Earth_Hammer", 1);

        if p22 == "" or not p22 then
            p22 = nil;
        end;

        u17:PlayTurnFX(p22);
        _PerformHit(u17);
    end);
    local u25 = nil;
    u25 = v19:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 186
        -- upvalues: u17 (copy), u24 (ref), u25 (ref), Character (copy)
        u17:PlayFX("Smoke");

        if u24 then
            u24:Disconnect();
        end;

        if u25 then
            u25:Disconnect();
        end;

        u17.Is_Using_Skill = false;
        u17.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
    task.delay(2, function() -- Line: 201
        -- upvalues: u17 (copy), u24 (ref), u25 (ref), Character (copy)
        if u17.Is_Using_Skill then
            u17.Is_Using_Skill = false;
            u17.Is_Attacking = false;
        end;

        if u24 then
            u24:Disconnect();
        end;

        if u25 then
            u25:Disconnect();
        end;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);
end;

return v1;