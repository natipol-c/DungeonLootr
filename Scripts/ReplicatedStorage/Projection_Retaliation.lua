--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Projection_Retaliation
  Path:     game.ReplicatedStorage.Classes.Framebreaker.Mastery_Passives.Projection_Retaliation
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:56 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Debris");
require(ReplicatedStorage.Modules.SharedUtils);
local v1 = {};
local Color3_fromRGB_ret = Color3.fromRGB(0, 200, 180);
local u2 = { "Right_Slash", "Left_Slash", "Right_Slash" };
local u3 = nil;

local function GetRemote() -- Line: 35
    -- upvalues: u3 (ref), ReplicatedStorage (copy)
    if u3 then
        return u3;
    end;

    local Remotes = ReplicatedStorage.Player:FindFirstChild("Remotes");

    if not Remotes then
        return nil;
    end;

    u3 = Remotes:FindFirstChild("PhantomAttack");

    if not u3 then
        u3 = Instance.new("RemoteEvent");
        u3.Name = "PhantomAttack";
        u3.Parent = Remotes;
    end;

    return u3;
end;

local function FireParticles(p4: userdata) -- Line: 53
    if not p4:HasTag("ParticleObject") then
        p4:AddTag("ParticleObject");
    end;

    p4:SetAttribute("Fire", not p4:GetAttribute("Fire"));
end;

local function GetCircleCFrames(p5: vector, p6: number, p7: number) -- Line: 61
    local v8 = 6.283185307179586 / p6;
    local v9 = math.random() * 3.141592653589793 * 2;
    local v10 = {};

    for i = 0, p6 - 1 do
        local v11 = v9 + v8 * i;
        local v12 = math.cos(v11) * p7;
        local v13 = math.sin(v11) * p7;
        local v14 = p5 + Vector3.new(v12, 0, v13);
        table.insert(v10, CFrame.lookAt(v14, p5));
        local _ = i;
    end;

    return v10;
end;

v1.Name = "Projection_Retaliation";
v1.Trigger = "OnParry";
v1.Cooldown = 0;
v1.Level = 13;

function v1.Execute(u15, p16) -- Line: 84
    -- upvalues: u3 (ref), ReplicatedStorage (copy), GetCircleCFrames (copy), u2 (copy), Color3_fromRGB_ret (copy)
    print("Parry detected");
    local AttackerBody = p16.AttackerBody;

    if not AttackerBody then
        return;
    end;

    local HumanoidRootPart = AttackerBody:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local Character = u15.Character;

    if not (Character and Character.Parent) then
        return;
    end;

    local Player = u15.Player;

    if not Player then
        return;
    end;

    local v17;

    if u3 then
        v17 = u3;
    else
        local Remotes = ReplicatedStorage.Player:FindFirstChild("Remotes");

        if Remotes then
            u3 = Remotes:FindFirstChild("PhantomAttack");

            if not u3 then
                u3 = Instance.new("RemoteEvent");
                u3.Name = "PhantomAttack";
                u3.Parent = Remotes;
            end;

            v17 = u3;
        else
            v17 = nil;
        end;
    end;

    if not v17 then
        return;
    end;

    local v18 = GetCircleCFrames(HumanoidRootPart.Position, 3, 8);
    local v19 = Player:GetAttribute("Active_Class") or "";

    for _, v in v18 do
        task.spawn(function() -- Line: 110
            -- upvalues: AttackerBody (copy), u15 (copy)
            for i = 1, 3 do
                if not AttackerBody or (not AttackerBody.Parent or AttackerBody:GetAttribute("Dead") and not AttackerBody:GetAttribute("Can_Finish")) then
                    break;
                end;

                u15:ApplyDamage(AttackerBody, (u15:ResolveSkillDamage(0.6, AttackerBody)));
                local HumanoidRootPart2 = AttackerBody:FindFirstChild("HumanoidRootPart");
                local v20 = HumanoidRootPart2 and HumanoidRootPart2:FindFirstChild("NormalHit");

                if v20 then
                    if not v20:HasTag("ParticleObject") then
                        v20:AddTag("ParticleObject");
                    end;

                    v20:SetAttribute("Fire", not v20:GetAttribute("Fire"));
                end;

                local v21;

                if i < 3 then
                    task.wait(0.1);
                    v21 = i;
                else
                    v21 = i;
                end;
            end;
        end);
        v17:FireAllClients(Player, {
            AnimationName = "Ability_2",
            FadeDuration = 0.8,
            PauseAtEnd = 0.3,
            AttackSpeed = 1,
            ClassName = v19,
            FXNames = u2,
            Color = Color3_fromRGB_ret,
            SwingSoundFolder = u15.ClassData.SwingSoundFolder,
            Position = v
        });
    end;
end;

return v1;