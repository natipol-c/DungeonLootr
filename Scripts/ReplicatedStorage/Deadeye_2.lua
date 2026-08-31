--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Deadeye
  Path:     game.ReplicatedStorage.Classes.Sinister Trigger.Mastery_Passives.Deadeye
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:01 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {};
local u2 = { "Assets", "Effects", "Demon_Shot" };
local u3 = nil;

local function GetTemplate() -- Line: 62
    -- upvalues: ReplicatedStorage (copy), u2 (copy)
    local v4 = ReplicatedStorage;

    for _, v in u2 do
        v4 = v4:FindFirstChild(v);

        if not v4 then
            return nil;
        end;
    end;

    return v4;
end;

local function PreparePoolPart(p5: userdata) -- Line: 73
    if not p5:HasTag("ParticleObject") then
        p5:AddTag("ParticleObject");
    end;

    if p5:GetAttribute("Fire") == nil then
        p5:SetAttribute("Fire", false);
    end;

    p5.Anchored = true;
    p5.CanCollide = false;
    p5.CanTouch = false;
    p5.CanQuery = false;
end;

local function EnsurePool() -- Line: 86
    -- upvalues: u3 (ref), ReplicatedStorage (copy), u2 (copy), PreparePoolPart (copy)
    if u3 then
        return u3;
    end;

    local v6 = ReplicatedStorage;

    for _, v in u2 do
        v6 = v6:FindFirstChild(v);

        if not v6 then
            v6 = nil;
            break;
        end;
    end;

    if not v6 then
        warn("[Deadeye] Template not found at RS.Assets.Effects.Demon_Shot");

        return nil;
    end;

    local Deadeye_Shot_Pool = workspace:FindFirstChild("Deadeye_Shot_Pool");

    if not Deadeye_Shot_Pool then
        Deadeye_Shot_Pool = Instance.new("Folder");
        Deadeye_Shot_Pool.Name = "Deadeye_Shot_Pool";
        Deadeye_Shot_Pool.Parent = workspace;
    end;

    u3 = {
        Template = v6,
        Folder = Deadeye_Shot_Pool,
        Free = {}
    };
    local v7 = {};

    for i = 1, 6 do
        local v8 = v6:Clone();
        PreparePoolPart(v8);
        v8.Parent = Deadeye_Shot_Pool;
        table.insert(v7, v8);
        local _ = i;
    end;

    task.wait(0.03);

    for _, v in v7 do
        table.insert(u3.Free, v);
    end;

    return u3;
end;

local function AcquireShot() -- Line: 125
    -- upvalues: EnsurePool (copy), PreparePoolPart (copy)
    local v9 = EnsurePool();

    if not v9 then
        return nil;
    end;

    local table_remove_ret = table.remove(v9.Free);

    if not table_remove_ret then
        table_remove_ret = v9.Template:Clone();
        PreparePoolPart(table_remove_ret);
        table_remove_ret.Parent = v9.Folder;
        task.wait(0.03);
    end;

    return table_remove_ret;
end;

local function ReleaseShot(p10: userdata) -- Line: 141
    -- upvalues: u3 (ref)
    if not (p10 and p10.Parent) then
        return;
    end;

    if not u3 then
        return;
    end;

    table.insert(u3.Free, p10);
end;

local function FireStrike(p11: any, p12: userdata) -- Line: 152
    -- upvalues: AcquireShot (copy), SharedUtils (copy), u3 (ref)
    if not (p12 and p12.Parent) then
        return;
    end;

    if p12:GetAttribute("Dead") and not p12:GetAttribute("Can_Finish") then
        return;
    end;

    local HumanoidRootPart = p12:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u13 = AcquireShot();

    if not u13 then
        return;
    end;

    local v14 = (math.random() * 2 - 1) * 5;
    local v15 = 5 + math.random() * 5;
    local v16 = (math.random() * 2 - 1) * 5;
    local Vector3_new_ret = Vector3.new(v14, v15, v16);
    u13.CFrame = CFrame.lookAt(HumanoidRootPart.Position + Vector3_new_ret, HumanoidRootPart.Position);
    u13:SetAttribute("Fire", not u13:GetAttribute("Fire"));
    SharedUtils.PlaySoundAt(u13, "Revolver_1", 0.5);
    p11:ApplyDamage(p12, (p11:ResolveSkillDamage(1.9, p12)));
    task.delay(1, function() -- Line: 177
        -- upvalues: u13 (copy), u3 (ref)
        local v17 = u13;

        if v17 then
            if not v17.Parent then
                return;
            end;

            if not u3 then
                return;
            end;

            table.insert(u3.Free, v17);
        end;
    end);
end;

u1.Name = "Deadeye";
u1.Trigger = "OnBasicHit";
u1.Cooldown = 0;
u1.Level = 50;

function u1.Init(p18) -- Line: 192
    -- upvalues: u1 (copy)
    if not p18.MasteryPassives.OnSkillHit then
        p18.MasteryPassives.OnSkillHit = {};
    end;

    table.insert(p18.MasteryPassives.OnSkillHit, {
        Name = "Deadeye_SkillHit",
        Cooldown = 0,
        Execute = u1.Execute
    });
end;

function u1.Execute(u19, p20) -- Line: 203
    -- upvalues: FireStrike (copy)
    if math.random() > 0.5 then
        return;
    end;

    if p20 then
        p20 = p20.HitTargets;
    end;

    if not p20 or #p20 == 0 then
        return;
    end;

    for _, v in p20 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            task.delay(0.4, function() -- Line: 213
                -- upvalues: FireStrike (ref), u19 (copy), v (copy)
                FireStrike(u19, v);
            end);
        end;
    end;
end;

return u1;