--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Summoned_Sword
  Path:     game.ReplicatedStorage.Classes.Awakened Devil EX.Mastery_Passives.Summoned_Sword
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:52 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local v1 = {};
local u2 = { "Assets", "Effects", "Mirage_Shot" };
local u3 = nil;

local function GetTemplate() -- Line: 60
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

local function PreparePoolPart(p5: userdata) -- Line: 74
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

local function EnsurePool() -- Line: 89
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
        warn("[Summoned Sword] Template not found at RS.Assets.Effects.Mirage_Shot");

        return nil;
    end;

    local Mirage_Shot_Pool = workspace:FindFirstChild("Mirage_Shot_Pool");

    if not Mirage_Shot_Pool then
        Mirage_Shot_Pool = Instance.new("Folder");
        Mirage_Shot_Pool.Name = "Mirage_Shot_Pool";
        Mirage_Shot_Pool.Parent = workspace;
    end;

    u3 = {
        Template = v6,
        Folder = Mirage_Shot_Pool,
        Free = {}
    };
    local v7 = {};

    for i = 1, 6 do
        local v8 = v6:Clone();
        PreparePoolPart(v8);
        v8.Parent = Mirage_Shot_Pool;
        table.insert(v7, v8);
        local _ = i;
    end;

    task.wait(0.03);

    for _, v in v7 do
        table.insert(u3.Free, v);
    end;

    return u3;
end;

local function AcquireShot() -- Line: 132
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

local function ReleaseShot(p10: userdata) -- Line: 153
    -- upvalues: u3 (ref)
    if not (p10 and p10.Parent) then
        return;
    end;

    if not u3 then
        return;
    end;

    table.insert(u3.Free, p10);
end;

local function FireStrike(p11: any, p12: userdata) -- Line: 164
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
    SharedUtils.PlaySoundAt(u13, "arrowhit", 0.5);
    p11:ApplyDamage(p12, (p11:ResolveSkillDamage(1.9, p12)));
    task.delay(1, function() -- Line: 194
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

v1.Name = "Summoned_Sword";
v1.Trigger = "OnBasicHit";
v1.Cooldown = 0;
v1.Level = 13;

function v1.Execute(u18, p19) -- Line: 206
    -- upvalues: FireStrike (copy)
    if math.random() > 0.5 then
        return;
    end;

    if p19 then
        p19 = p19.HitTargets;
    end;

    if not p19 or #p19 == 0 then
        return;
    end;

    for _, v in p19 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            task.delay(0.4, function() -- Line: 218
                -- upvalues: FireStrike (ref), u18 (copy), v (copy)
                FireStrike(u18, v);
            end);
        end;
    end;
end;

return v1;