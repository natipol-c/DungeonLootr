--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PhantomAttack
  Path:     game.ReplicatedStorage.Modules.PhantomAttack
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.SharedUtils);
local v1 = {};
local u2 = nil;

local function GetRemote() -- Line: 33
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if u2 then
        return u2;
    end;

    local Remotes = ReplicatedStorage.Player:FindFirstChild("Remotes");

    if not Remotes then
        return nil;
    end;

    u2 = Remotes:FindFirstChild("PhantomAttack");

    if not u2 then
        u2 = Instance.new("RemoteEvent");
        u2.Name = "PhantomAttack";
        u2.Parent = Remotes;
    end;

    return u2;
end;

local function FireParticles(p3: userdata) -- Line: 52
    if not p3:HasTag("ParticleObject") then
        p3:AddTag("ParticleObject");
    end;

    p3:SetAttribute("Fire", not p3:GetAttribute("Fire"));
end;

function v1.Fire(p4, p5) -- Line: 70
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if not (p4 and p4.Character) then
        return;
    end;

    local Character = p4.Character;
    local Player = p4.Player;

    if not (Player and Character.Parent) then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    for _, v in p4:Hitbox() do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p4:ApplyDamage(v, (p4:ResolveSkillDamage(p5.DamageMultiplier or 0.5, v)));
            local HumanoidRootPart2 = v:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart2 then
                local NormalHit = HumanoidRootPart2:FindFirstChild("NormalHit");

                if NormalHit then
                    if not NormalHit:HasTag("ParticleObject") then
                        NormalHit:AddTag("ParticleObject");
                    end;

                    NormalHit:SetAttribute("Fire", not NormalHit:GetAttribute("Fire"));
                end;
            end;
        end;
    end;

    local v6;

    if u2 then
        v6 = u2;
    else
        local Remotes = ReplicatedStorage.Player:FindFirstChild("Remotes");

        if Remotes then
            u2 = Remotes:FindFirstChild("PhantomAttack");

            if not u2 then
                u2 = Instance.new("RemoteEvent");
                u2.Name = "PhantomAttack";
                u2.Parent = Remotes;
            end;

            v6 = u2;
        else
            v6 = nil;
        end;
    end;

    if not v6 then
        return;
    end;

    v6:FireAllClients(Player, {
        ClassName = Player:GetAttribute("Active_Class") or "",
        AnimationName = p5.AnimationName or "Attack_1",
        FXNames = p5.FXNames or {},
        Color = p5.Color or Color3.new(1, 1, 1),
        FadeDuration = p5.FadeDuration or 0.8,
        PauseAtEnd = p5.PauseAtEnd or 0.3,
        AttackSpeed = p5.AttackSpeed or 1,
        SwingSoundFolder = p5.SwingSoundFolder,
        Position = HumanoidRootPart.CFrame
    });
end;

function v1.SpawnVisual(p7: userdata, p8: table) -- Line: 128
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if not (p7 and p8) then
        return;
    end;

    local v9;

    if u2 then
        v9 = u2;
    else
        local Remotes = ReplicatedStorage.Player:FindFirstChild("Remotes");

        if Remotes then
            u2 = Remotes:FindFirstChild("PhantomAttack");

            if not u2 then
                u2 = Instance.new("RemoteEvent");
                u2.Name = "PhantomAttack";
                u2.Parent = Remotes;
            end;

            v9 = u2;
        else
            v9 = nil;
        end;
    end;

    if not v9 then
        return;
    end;

    v9:FireAllClients(p7, p8);
end;

return v1;