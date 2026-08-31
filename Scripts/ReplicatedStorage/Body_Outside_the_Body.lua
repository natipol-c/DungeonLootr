--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Body_Outside_the_Body
  Path:     game.ReplicatedStorage.Classes.Founder.Mastery_Passives.Body_Outside_the_Body
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local RigUtil = require(ReplicatedStorage.Modules.RigUtil);
local PhantomAttack = require(ReplicatedStorage.Modules.PhantomAttack);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local v1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(255, 214, 122);
v1.Name = "Body_Outside_the_Body";
v1.Trigger = "OnSkillUse";
v1.Cooldown = 3;
v1.Level = 30;

local function damageAt(p2, p3, p4, p5, p6) -- Line: 62
    -- upvalues: RigUtil (copy)
    local Character = p2.Character;

    if not Character then
        return;
    end;

    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    OverlapParams_new_ret.FilterDescendantsInstances = { Character };
    local v7 = p3 * CFrame.new(0, 0, -(p5 or 0) / 2);
    local v8 = {};

    for _, v in workspace:GetPartBoundsInBox(v7, p4, OverlapParams_new_ret) do
        local v9 = v:FindFirstAncestorOfClass("Model");

        if v9 and (not v8[v9] and RigUtil.IsHittableTarget(v9)) then
            v8[v9] = true;
        end;
    end;

    for i in v8 do
        if not i:HasTag("Ignore_Damage") and (not i:GetAttribute("Dead") or i:GetAttribute("Can_Finish")) then
            p2:ApplyDamage(i, (p2:ResolveSkillDamage(p6, i)));
        end;
    end;
end;

function v1.Execute(u10, p11) -- Line: 91
    -- upvalues: SkillRuntime (copy), damageAt (copy), PhantomAttack (copy), Color3_fromRGB_ret (copy)
    if math.random() > 0.3 then
        return;
    end;

    if p11 then
        p11 = p11.SkillModule;
    end;

    if not p11 then
        return;
    end;

    local AnimationName = p11.AnimationName;
    local EffectModule = p11.EffectModule;

    if not (AnimationName and EffectModule) then
        return;
    end;

    local Player = u10.Player;
    local Character = u10.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not (Player and Character) then
        return;
    end;

    local CFrame_lookAt_ret = CFrame.lookAt(Character.Position + Character.CFrame.LookVector * 15, Character.Position);
    local u12 = p11.HitboxSize or u10.ClassData.HitboxSize;
    local u13 = p11.HitboxRange or 0;
    local u14 = (p11.DamageMultiplier or 1) * 0.7;
    local v15 = SkillRuntime.EnsureAnimation(u10, AnimationName);

    if v15 then
        local u16 = {};

        local function disconnectAll() -- Line: 120
            -- upvalues: u16 (copy)
            for _, v in u16 do
                v:Disconnect();
            end;

            table.clear(u16);
        end;

        u16[#u16 + 1] = v15:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 124
            -- upvalues: damageAt (ref), u10 (copy), CFrame_lookAt_ret (copy), u12 (copy), u13 (copy), u14 (copy)
            damageAt(u10, CFrame_lookAt_ret, u12, u13, u14);
        end);
        u16[#u16 + 1] = v15:GetMarkerReachedSignal("DBreset"):Connect(disconnectAll);
        task.delay(4, disconnectAll);
    end;

    PhantomAttack.SpawnVisual(Player, {
        FadeDuration = 0.8,
        PauseAtEnd = 0.3,
        ClassName = Player:GetAttribute("Active_Class") or u10.ClassName,
        AnimationName = AnimationName,
        EffectModule = EffectModule,
        Position = CFrame_lookAt_ret,
        Color = Color3_fromRGB_ret,
        Lifetime = p11.MaxDuration or 3
    });
end;

return v1;