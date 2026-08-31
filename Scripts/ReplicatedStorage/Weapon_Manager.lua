--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Weapon_Manager
  Path:     game.ReplicatedStorage.Player.Modules.Weapon_Manager
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
u1.ActiveStates = {};
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local Weapon_Data = require(ReplicatedStorage.Weapons.Weapon_Data);
local Enemy_Manager = require(ReplicatedStorage.Enemies.Modules.Enemy_Manager);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Packages.maid);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local NPC = require(game.ServerScriptService.Management.Classes.NPC);
local Value = ReplicatedStorage.Configuration.DEFAULT_WALK_SPEED.Value;
local Trait_Data = require(ReplicatedStorage.Weapons.Weapon_Traits.Trait_Data);
ReplicatedStorage.Weapons:FindFirstChild("Weapon_Skills");
local Attack = ReplicatedStorage.Player.Remotes.Inputs.Attack;
local Dash = ReplicatedStorage.Player.Remotes.Inputs.Dash;
local Parry = ReplicatedStorage.Player.Remotes.Inputs.Parry;
local _ = ReplicatedStorage.Player.Remotes.Inputs.Skill;
local CombatFeedback = ReplicatedStorage.Player.Remotes.CombatFeedback;
local u2 = {
    Forward = "rbxassetid://124950580680349",
    Back = "rbxassetid://83997425524864",
    Right = "rbxassetid://113060103391425",
    Left = "rbxassetid://74421859798541"
};
local Combat_Sounds = ReplicatedStorage.Assets:WaitForChild("Combat_Sounds");
local u3 = {};

local function GetSoundsFromFolder(p4) -- Line: 67
    -- upvalues: u3 (copy), Combat_Sounds (copy)
    if u3[p4] then
        return u3[p4];
    end;

    local v5 = Combat_Sounds:FindFirstChild(p4);

    if v5 then
        u3[p4] = v5:GetChildren();

        return u3[p4];
    end;

    warn("Combat sound folder not found:", p4);

    return {};
end;

local function PlayCombatSound(p6, p7, p8) -- Line: 77
    -- upvalues: GetSoundsFromFolder (copy)
    local v9 = GetSoundsFromFolder(p6);

    if #v9 == 0 then
        return;
    end;

    local u10 = v9[math.random(1, #v9)]:Clone();
    u10.PlaybackSpeed = 1 + (math.random() * 2 - 1) * 0.35;
    u10.Volume = p8 or 1;
    u10.Parent = p7;
    u10:Play();
    u10.Ended:Once(function() -- Line: 85
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
end;

local function GetDodgeDirection(p11: vector, p12: vector) -- Line: 91
    local Unit = Vector3.new(p11.X, 0, p11.Z).Unit;
    local Unit2 = Vector3.new(p12.X, 0, p12.Z).Unit;
    local v13 = Unit:Dot(Unit2);
    local Y = Unit:Cross(Unit2).Y;

    return v13 > 0.7 and "Forward" or (v13 < -0.7 and "Back" or (Y > 0 and "Right" or "Left"));
end;

local function FireParticles(p14: userdata) -- Line: 114
    if not p14:HasTag("ParticleObject") then
        p14:AddTag("ParticleObject");
    end;

    p14:SetAttribute("Fire", not p14:GetAttribute("Fire"));
end;

local function ActivateParticles(p15: userdata, p16: boolean) -- Line: 122
    if not p15:HasTag("ParticleObject") then
        p15:AddTag("ParticleObject");
    end;

    p15:SetAttribute("FX_Activate", p16);
end;

local ContentProvider = game:GetService("ContentProvider");

function u1.Load_Animations(u17: table, p18: userdata, p19: any) -- Line: 131
    -- upvalues: ContentProvider (copy)
    local Humanoid = p18.Character:FindFirstChild("Humanoid");

    for _, child in pairs(p19:GetChildren()) do
        local v20 = Humanoid:FindFirstChild("Animator"):LoadAnimation(child);
        v20.Priority = Enum.AnimationPriority.Action2;
        u17.Animations[child.Name] = v20;
    end;

    local u21 = {};

    for _, v in u17.Animations do
        table.insert(u21, v.Animation);
    end;

    task.spawn(function() -- Line: 148
        -- upvalues: ContentProvider (ref), u21 (copy), u17 (copy)
        ContentProvider:PreloadAsync(u21);

        for _, v in u17.Animations do
            v:Play(0, 0, 0);
            v:Stop(0);
        end;
    end);

    return true;
end;

function u1.Load_Dodge_Animations(u22: table, p23: userdata) -- Line: 162
    -- upvalues: u2 (copy), ContentProvider (copy)
    local Animator = p23.Character:FindFirstChild("Humanoid"):FindFirstChild("Animator");

    if not Animator then
        warn("No Animator found for dodge animations");

        return false;
    end;

    u22.DodgeAnimations = {};

    for i, v in u2 do
        local Animation = Instance.new("Animation");
        Animation.AnimationId = v;
        local v24 = Animator:LoadAnimation(Animation);
        v24.Priority = Enum.AnimationPriority.Action3;
        u22.DodgeAnimations[i] = v24;
    end;

    local u25 = {};

    for _, v in u22.DodgeAnimations do
        table.insert(u25, v.Animation);
    end;

    task.spawn(function() -- Line: 187
        -- upvalues: ContentProvider (ref), u25 (copy), u22 (copy)
        ContentProvider:PreloadAsync(u25);

        for _, v in u22.DodgeAnimations do
            v:Play(0, 0, 0);
            v:Stop(0);
        end;
    end);

    return true;
end;

local function findWeaponPrefab(p26) -- Line: 199
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTagged("Weapon_Prefab") do
        if v:IsDescendantOf(p26) then
            return v;
        end;
    end;

    return nil;
end;

function u1.PlayTurnFX(p27, p28) -- Line: 208
    local v29 = p28 or p27.Wep_Data.FX_Order[p27.Turn_Count];

    if not v29 then
        return;
    end;

    local v30 = p27.FX[v29];

    if not v30 then
        warn("Missing FX part: " .. v29);

        return;
    end;

    if not v30:HasTag("ParticleObject") then
        v30:AddTag("ParticleObject");
    end;

    v30:SetAttribute("Fire", not v30:GetAttribute("Fire"));
end;

function u1.ResolveSkillDamage(p31: table, p32: number, p33: userdata) -- Line: 221
    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(p33);
    local v34 = (p31.Player:GetAttribute("Damage_Up") or 1) + (p31.Player:GetAttribute("PotionBuff_DamagePercent") or 0);
    local v35;

    if PlayerFromCharacter then
        v35 = p31.Wep_Data.PVP_Damage or math.floor(p31.Wep_Data.Damage * 0.15);
    else
        v35 = p31.Wep_Data.Damage;
    end;

    local v36 = p31._TraitDamageMult or 1;
    local v37 = p31.Player:GetAttribute("AchBoost_DamagePercent") or 0;

    return math.floor(v35 * p32 * v34 * v36 * (1 + (v37 > 0 and v37 / 100 or 0)) * 1);
end;

function u1.Apply_Damage(u38: table, p39: any, p40: number?) -- Line: 249
    -- upvalues: PlayCombatSound (copy), NPC (copy), SharedUtils (copy), u1 (copy), Knit (copy), Trait_Data (copy)
    local Humanoid = p39:FindFirstChild("Humanoid");

    if not Humanoid then
        warn("Couldn\'t find humanoid for " .. p39.Name);

        return 0;
    end;

    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(p39);
    local PrimaryPart = p39.PrimaryPart;
    local v41 = p40 or u38.Wep_Data.Damage;
    local v42 = (u38.Player:GetAttribute("Damage_Up") or 1) + (u38.Player:GetAttribute("PotionBuff_DamagePercent") or 0);
    local v43 = v41 * v42;

    if PlayerFromCharacter and not p40 then
        v43 = (u38.Wep_Data.PVP_Damage or math.floor(u38.Wep_Data.Damage * 0.15)) * v42;
    end;

    local v44 = u38.Player:GetAttribute("AchBoost_DamagePercent") or 0;

    if v44 > 0 then
        v43 = v43 * (1 + v44 / 100);
    end;

    local v45 = v43 * (u38._TraitDamageMult or 1);
    u38._TraitDamageMult = 1;
    local v46 = u38.Wep_Data.CritChance or 0;
    local v47 = u38.Wep_Data.CritMultiplier or 1.5;
    local v48;

    if v46 > 0 and math.random() < v46 then
        v45 = v45 * v47;
        v48 = true;
    else
        v48 = false;
    end;

    local math_floor_ret = math.floor(v45);
    local v49 = PrimaryPart or p39:FindFirstChild("HumanoidRootPart");

    if v49 then
        PlayCombatSound(u38.Wep_Data.HitSoundFolder or "Hit", v49, u38.Wep_Data.HitVolume or 1);
    end;

    if PlayerFromCharacter or not PrimaryPart then
        if PlayerFromCharacter then
            if not (u38.Player:GetAttribute("PVPEnabled") and PlayerFromCharacter:GetAttribute("PVPEnabled")) then
                return 0;
            end;

            if PlayerFromCharacter:GetAttribute("Onboarding") then
                return 0;
            end;

            if u38.Player:GetAttribute("Onboarding") then
                return 0;
            end;

            u1.FlagPVPCombat(u38.Character, p39);
            local creator = p39:FindFirstChild("creator");

            if not creator then
                creator = Instance.new("ObjectValue");
                creator.Name = "creator";
                creator.Parent = p39;
            end;

            creator.Value = u38.Player;
            task.delay(3, function() -- Line: 350
                -- upvalues: creator (ref), u38 (copy)
                if creator and creator.Value == u38.Player then
                    creator.Value = nil;
                end;
            end);

            if Humanoid and Humanoid.Health > 0 then
                Humanoid:TakeDamage(math_floor_ret);
            end;

            if PrimaryPart then
                if v48 then
                    SharedUtils.ShowCritDamage(PrimaryPart, math_floor_ret);
                else
                    SharedUtils.ShowDamage(PrimaryPart, math_floor_ret);
                end;

                SharedUtils.hitEffect(p39);
            end;

            if Humanoid.Health <= 0 then
                Knit.GetService("DataService"):Increment(u38.Player, { "Kills" }, 1);
                Trait_Data.FireHook(u38.TraitContext, "OnKill", u38, p39);
            end;
        end;

        return math_floor_ret;
    end;

    local v50 = NPC._cache[p39];

    if v50 and (v50.State ~= "Dead" and not v50.Body:GetAttribute("Dead") or v50.Body:GetAttribute("Can_Finish") == true) then
        v50:TakeDamage(math_floor_ret, u38.Player.Character);

        if v48 then
            SharedUtils.ShowCritDamage(PrimaryPart, math_floor_ret);
        else
            SharedUtils.ShowDamage(PrimaryPart, math_floor_ret);
        end;

        SharedUtils.hitEffect(p39);
    end;

    return math_floor_ret;
end;

function u1.Hitbox(p51) -- Line: 380
    local HumanoidRootPart = p51.Player.Character:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        local HitboxSize = p51.Wep_Data.HitboxSize;
        local v52;

        if HumanoidRootPart:FindFirstChild("Hitbox") then
            v52 = HumanoidRootPart:FindFirstChild("Hitbox");
            v52.Size = HitboxSize;
            v52.CanTouch = true;
            HumanoidRootPart:FindFirstChild("Hitbox"):FindFirstChild("Hitbox_Weld").C0 = CFrame.new(0, 0, -p51.Wep_Data.Range / 2);
        else
            v52 = Instance.new("Part");
            v52.Name = "Hitbox";
            v52.CFrame = HumanoidRootPart.CFrame;
            v52.Size = HitboxSize;
            v52.Transparency = 1;
            v52.CanCollide = false;
            v52.CanTouch = true;
            v52.Anchored = false;
            v52.Massless = true;
            v52.Parent = HumanoidRootPart;
            local Weld = Instance.new("Weld");
            Weld.Name = "Hitbox_Weld";
            Weld.Parent = v52;
            Weld.Part0 = HumanoidRootPart;
            Weld.Part1 = v52;
            Weld.C0 = CFrame.new(0, 0, -p51.Wep_Data.Range / 2);
        end;

        if p51.Hitbox_Connection then
            p51.Hitbox_Connection:Disconnect();
        end;

        local OverlapParams_new_ret = OverlapParams.new();
        OverlapParams_new_ret.ExcludeInstances = { p51.Character };
        local PartBoundsInBox = workspace:GetPartBoundsInBox(v52.CFrame, v52.Size, OverlapParams_new_ret);
        local v53 = {
            [p51.Player.Character] = true
        };
        local v54 = {};

        for _, v in PartBoundsInBox do
            local v55 = v:FindFirstAncestorOfClass("Model");

            if v55 and (not v53[v55] and (v55:FindFirstChild("Humanoid") and (not game.Players:GetPlayerFromCharacter(v55) or v.Parent == v55))) then
                v53[v55] = true;
                table.insert(v54, v55);
            end;
        end;

        return v54;
    end;
end;

function u1.CanDodge(p56) -- Line: 448
    if p56.Last_Dodge_Time and tick() - p56.Last_Dodge_Time < (p56.DodgeCooldown or 2) then
        return false;
    end;

    if p56.Is_Dodging then
        return false;
    end;

    if p56.Is_Stunned then
        return false;
    end;

    if p56.Character:GetAttribute("IsTheft") then
        return false;
    end;

    return not p56.Player:GetAttribute("IsTheft");
end;

function u1.CanAttack(p57) -- Line: 475
    if p57.Is_Dodging then
        return false;
    end;

    if p57.Post_Dodge_Lockout then
        return false;
    end;

    if p57.Is_Attacking then
        return false;
    end;

    if p57.Got_Parried then
        return false;
    end;

    if p57.Is_Stunned then
        return false;
    end;

    if p57.Character:GetAttribute("IsTheft") then
        return false;
    end;

    return not p57.Player:GetAttribute("IsTheft");
end;

function u1.Dodge(u58: table, p59: vector) -- Line: 510
    -- upvalues: Trait_Data (copy), GetDodgeDirection (copy), SharedUtils (copy), Debris (copy)
    if not u58:CanDodge() then
        return;
    end;

    local Character = u58.Player.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and Character:FindFirstChild("Humanoid")) then
        return;
    end;

    u58.Is_Dodging = true;
    Trait_Data.FireHook(u58.TraitContext, "OnDodge", u58, p59);
    u58.Last_Dodge_Time = tick();
    u58.Player:SetAttribute("Dodge_Cooldown_Duration", u58.DodgeCooldown or 2);
    u58.Player:SetAttribute("Dodge_Cooldown_Active", true);
    task.delay(u58.DodgeCooldown or 2, function() -- Line: 528
        -- upvalues: u58 (copy)
        if u58.Player then
            u58.Player:SetAttribute("Dodge_Cooldown_Active", false);
        end;
    end);
    u58.Player:SetAttribute("Protected", true);
    u58.Player:SetAttribute("iFrame", true);
    Character:SetAttribute("Protected", true);
    Character:SetAttribute("iFrame", true);

    for i, v in u58.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.1);
        end;
    end;

    u58.Is_Attacking = false;
    local v60;

    if p59.Magnitude == 0 then
        v60 = HumanoidRootPart.CFrame.LookVector;
    else
        v60 = p59.Unit;
    end;

    local v61 = GetDodgeDirection(HumanoidRootPart.CFrame.LookVector, v60);
    u58.CurrentDodgeDirection = v61;

    if u58.DodgeAnimations[v61] then
        u58.DodgeAnimations[v61]:Play(0, 1, 1);
    end;

    SharedUtils.iFrameEffect(Character, 0.35);
    pcall(function() -- Line: 568
        -- upvalues: SharedUtils (ref), HumanoidRootPart (copy)
        SharedUtils.PlaySoundAt(HumanoidRootPart, "Dodge", 0.5);
    end);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "DodgeVelocity";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = v60 * 85;
    BodyVelocity.Parent = HumanoidRootPart;
    Debris:AddItem(BodyVelocity, 0.175);
    task.delay(0.7, function() -- Line: 583
        -- upvalues: u58 (copy), Character (copy)
        u58.CurrentDodgeDirection = nil;
        u58.Is_Dodging = false;
        u58.Player:SetAttribute("Protected", false);
        u58.Player:SetAttribute("iFrame", false);
        Character:SetAttribute("Protected", false);
        Character:SetAttribute("iFrame", false);
        u58:Slowdown(false);
        u58.Post_Dodge_Lockout = true;
        task.delay(0.15, function() -- Line: 599
            -- upvalues: u58 (ref)
            u58.Post_Dodge_Lockout = false;
        end);
    end);
end;

local u62 = {
    Common = nil,
    Uncommon = nil,
    Rare = "Rare_Glow",
    Epic = "Epic_Glow",
    Legendary = "Legendary_Glow",
    Mythic = "Mythic_Glow"
};

function u1._ApplyAuras(p63, p64) -- Line: 614
    -- upvalues: CollectionService (copy), Trait_Data (copy), u62 (copy), ReplicatedStorage (copy)
    p63.AuraInstances = {};
    local v65 = {};

    for _, v in CollectionService:GetTagged("Weapon_Mesh") do
        if v:IsDescendantOf(p63.Weapon_Prefab) then
            table.insert(v65, v);
        end;
    end;

    local v66 = #v65 > 0 and (#p64 > 0 and Trait_Data.Index[p64[1]]);

    if v66 then
        local v67 = v66.Aura or u62[v66.Tier];
        local v68 = v67 and ReplicatedStorage.Assets.Auras:FindFirstChild(v67);

        if v68 then
            for _, v in v65 do
                local v69 = v;

                for _, child in v68:GetChildren() do
                    local v70 = child:Clone();

                    if v70:IsA("BasePart") then
                        local Weld = Instance.new("Weld");
                        Weld.Part0 = v69;
                        Weld.Part1 = v70;
                        Weld.Parent = v70;
                        v70.CFrame = v69.CFrame;
                    end;

                    v70.Parent = v69;
                    table.insert(p63.AuraInstances, v70);
                end;
            end;
        end;
    end;
end;

function u1.new(u71: userdata, p72: string, p73: any, p74: any) -- Line: 653
    -- upvalues: u1 (copy), Weapon_Data (copy), Trait_Data (copy), ReplicatedStorage (copy), CollectionService (copy), PlayCombatSound (copy), SharedUtils (copy), Enemy_Manager (copy), CombatFeedback (copy), Attack (copy), Dash (copy), Parry (copy)
    if u1.ActiveStates[u71] then
        u1.ActiveStates[u71]:Destroy();
    end;

    local u75 = setmetatable({}, u1);
    u75.Weapon_Type = p72;
    local v76 = {};

    for i, v in Weapon_Data[p72] do
        if type(v) == "table" then
            v76[i] = table.clone(v);
        else
            v76[i] = v;
        end;
    end;

    local v77 = Trait_Data.ApplyTraits(v76, p73);
    local UpgradeData = require(ReplicatedStorage.GameInfo.UpgradeData);
    local v78 = p74 or 0;

    if v78 > 0 then
        local DamageMultiplier = UpgradeData.GetDamageMultiplier(v78);
        v76.Damage = math.floor(v76.Damage * DamageMultiplier);

        if v76.PVP_Damage then
            v76.PVP_Damage = math.floor(v76.PVP_Damage * DamageMultiplier);
        end;
    end;

    u75.Wep_Data = v76;
    u75.UpgradeLevel = v78;
    u75.TraitContext = v77;
    u75.DodgeCooldown = u75.Wep_Data.DodgeCooldown or 2;
    u75.Player = u71;
    u75.Character = u71.Character;
    u75.Humanoid = u75.Character.Humanoid;
    u75.Turn_Count = 1;
    u75.Weapon_Animations = ReplicatedStorage.Weapons[p72].Animations;
    local Character = u71.Character;
    local v79 = nil;

    for _, v in CollectionService:GetTagged("Weapon_Prefab") do
        if v:IsDescendantOf(Character) then
            v79 = v;
            break;
        end;
    end;

    u75.Weapon_Prefab = v79;
    u75:_ApplyAuras(p73, v77, u75.Weapon_Prefab);
    u75.Weapon_IsModel = u75.Weapon_Prefab:IsA("Model");
    u75.Animations = {};
    u75.DodgeAnimations = {};
    u75.Animations_Loaded = false;
    u75.Animation_Connections = {};
    u75.Weapon_Connections = {};
    u75.Hitbox_Connection = nil;
    u75.Parry_Animation = u75.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.Animations.Parry_Anim);
    u75.Is_Attacking = false;
    u75.Is_Dead = false;
    u75.Is_Dodging = false;
    u75.Is_Parrying = false;
    u75.Is_Protected = false;
    u75.Is_Stunned = false;
    u75.Post_Dodge_Lockout = false;
    u75.Parry_On_Cooldown = false;
    u75.Parry_Cooldown_End = 0;
    u75.Got_Parried = false;
    u75.SlowingDown = false;
    u75:Slowdown(false);

    if u75.Wep_Data.DodgeCooldown then
        u75.DodgeCooldown = u75.Wep_Data.DodgeCooldown;
    end;

    local v80 = u75.Player:GetAttribute("AchBoost_DodgeCooldown") or 0;

    if v80 > 0 then
        u75.DodgeCooldown = math.max(0.5, u75.DodgeCooldown - v80);
    end;

    u75.Last_Dodge_Time = 0;
    u75.FX = {};
    u75.FX_Folder = u75.Weapon_Prefab:FindFirstChild("FX");

    if u75.FX_Folder then
        for _, child in u75.FX_Folder:GetChildren() do
            u75.FX[child.Name] = child;
        end;
    end;

    if not u75.Animations_Loaded and u75:Load_Animations(u71, u75.Weapon_Animations) then
        u75.Animations_Loaded = true;
    end;

    u75:Load_Dodge_Animations(u71);
    local Parried_Reaction = ReplicatedStorage.Assets.Animations:FindFirstChild("Parried_Reaction");
    local v81 = Parried_Reaction and u75.Character.Humanoid:FindFirstChild("Animator");

    if v81 then
        u75.StunAnimation = v81:LoadAnimation(Parried_Reaction);
        u75.StunAnimation.Priority = Enum.AnimationPriority.Action4;
    end;

    if u75.Animations_Loaded then
        for i, v in u75.Animations do
            if i:match("^Attack_") then
                u75.Animation_Connections[i .. "_hit"] = v:GetMarkerReachedSignal("hit"):Connect(function(p82) -- Line: 777
                    -- upvalues: u75 (copy), PlayCombatSound (ref), u1 (ref), SharedUtils (ref), Enemy_Manager (ref), Trait_Data (ref), CombatFeedback (ref)
                    if not u75.Character:GetAttribute("Skill_Attack_Bypass") and u75.Is_Using_Skill then
                        return;
                    end;

                    PlayCombatSound(u75.Wep_Data.SwingSoundFolder or "Sword_Swings", u75.Player.Character.HumanoidRootPart, u75.Wep_Data.SwingVolume or 0.4);

                    if u75.Wep_Data.FX_Order ~= {} then
                        if p82 == "" or not p82 then
                            p82 = nil;
                        end;

                        u75:PlayTurnFX(p82);
                    end;

                    u75._TraitDamageMult = 1;
                    local v83 = 0;

                    for _, v2 in u75:Hitbox() do
                        if not v2:HasTag("Ignore_Damage") and (not v2:GetAttribute("Dead") or v2:GetAttribute("Can_Finish")) then
                            local HumanoidRootPart = v2:FindFirstChild("HumanoidRootPart");
                            local v84 = nil;
                            local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(v2);

                            if not PlayerFromCharacter then
                                local ByModel = Enemy_Manager.GetByModel(v2);

                                if ByModel and ByModel.Is_Alive then
                                    v84 = u75:Apply_Damage(v2);
                                    v83 = v83 + 1;
                                elseif v2:HasTag("Enemy") then
                                    v84 = u75:Apply_Damage(v2);
                                    v83 = v83 + 1;
                                end;

                                Trait_Data.FireHook(u75.TraitContext, "OnHit", u75, v2, v84);

                                if u75.Wep_Data.OnHit then
                                    u75.Wep_Data.OnHit(u75, v2, v84);
                                end;

                                if HumanoidRootPart:FindFirstChild("NormalHit") then
                                    HumanoidRootPart.NormalHit:SetAttribute("Fire", not HumanoidRootPart.NormalHit:GetAttribute("Fire"));
                                end;

                                if v83 > 0 then
                                    CombatFeedback:FireClient(u75.Player, "Hit", 1);
                                end;
                            end;

                            if u75.Player:GetAttribute("PVPEnabled") and (PlayerFromCharacter:GetAttribute("PVPEnabled") and not u75:CheckPVPParry(v2, false)) then
                                u1.FlagPVPCombat(u75.Character, v2);

                                if PlayerFromCharacter:GetAttribute("iFrame") then
                                    if HumanoidRootPart then
                                        SharedUtils.ShowText(HumanoidRootPart, "Dodged", Color3.fromRGB(100, 200, 255));
                                    end;

                                    if HumanoidRootPart:FindFirstChild("Dodge_Effect") then
                                        HumanoidRootPart.Dodge_Effect:SetAttribute("Fire", not HumanoidRootPart.Dodge_Effect:GetAttribute("Fire"));
                                    end;
                                elseif PlayerFromCharacter:GetAttribute("Protected") then
                                    if HumanoidRootPart then
                                        SharedUtils.ShowText(HumanoidRootPart, "Protected", Color3.fromRGB(255, 255, 255));
                                    end;

                                    if HumanoidRootPart:FindFirstChild("Dodge_Effect") then
                                        HumanoidRootPart.Dodge_Effect:SetAttribute("Fire", not HumanoidRootPart.Dodge_Effect:GetAttribute("Fire"));
                                    end;
                                else
                                    v84 = u75:Apply_Damage(v2);
                                    v83 = v83 + 1;
                                end;

                                Trait_Data.FireHook(u75.TraitContext, "OnHit", u75, v2, v84);

                                if u75.Wep_Data.OnHit then
                                    u75.Wep_Data.OnHit(u75, v2, v84);
                                end;

                                if HumanoidRootPart:FindFirstChild("NormalHit") then
                                    HumanoidRootPart.NormalHit:SetAttribute("Fire", not HumanoidRootPart.NormalHit:GetAttribute("Fire"));
                                end;

                                if v83 > 0 then
                                    CombatFeedback:FireClient(u75.Player, "Hit", 1);
                                end;
                            end;
                        end;
                    end;
                end);
                u75.Animation_Connections[i .. "_reset"] = v:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 875
                    -- upvalues: u75 (copy), Trait_Data (ref)
                    if u75.SlowingDown then
                        u75.SlowingDown = false;
                        u75:Slowdown(false);
                    end;

                    local v85 = u75;
                    v85.Turn_Count = v85.Turn_Count + 1;

                    if u75.Turn_Count > u75.Wep_Data.TurnCount then
                        u75.Turn_Count = 1;
                    end;

                    u75.Is_Attacking = false;

                    if u75.Wep_Data.OnSwingEnd then
                        u75.Wep_Data.OnSwingEnd(u75);
                    end;

                    Trait_Data.FireHook(u75.TraitContext, "OnSwingEnd", u75);
                    u75.Character:SetAttribute("Combat_Facing", false);
                end);
            end;
        end;
    else
        warn("Animations not loaded for " .. p72);
    end;

    u75.Weapon_Connections.Attack = Attack.OnServerEvent:Connect(function(p86, ...) -- Line: 906
        -- upvalues: u71 (copy), u75 (copy)
        if p86 == u71 then
            if u75.Player:GetAttribute("IsTheft") then
                return;
            end;

            u75:Attack();
        end;
    end);
    u75.Weapon_Connections.Dash = Dash.OnServerEvent:Connect(function(p87, p88) -- Line: 913
        -- upvalues: u71 (copy), u75 (copy)
        if p87 == u71 then
            if u75.Player:GetAttribute("IsTheft") then
                return;
            end;

            u75:Dodge(p88 or Vector3.new(0, 0, 0));
        end;
    end);
    u75.Weapon_Connections.Parry = Parry.OnServerEvent:Connect(function(p89, ...) -- Line: 920
        -- upvalues: u71 (copy), u75 (copy)
        if p89 == u71 then
            if u75.Player:GetAttribute("IsTheft") then
                return;
            end;

            u75:Parry();
        end;
    end);
    u71:SetAttribute("Current_Weapon", p72);
    u1.ActiveStates[u71] = u75;

    return u75;
end;

function u1.Slowdown(p90, p91) -- Line: 935
    -- upvalues: Value (copy)
    local v92 = p90.Humanoid:GetAttribute("BuffMoveSpeedBonus") or 0;

    if p91 then
        p90.Humanoid.WalkSpeed = Value * 0.5 * (1 + v92);

        return;
    end;

    p90.Humanoid.WalkSpeed = Value * (1 + v92);
end;

function u1.Attack(p93) -- Line: 948
    -- upvalues: Trait_Data (copy)
    if not p93:CanAttack() then
        return;
    end;

    if not p93.SlowingDown then
        p93.SlowingDown = true;
        p93:Slowdown(true);
    end;

    p93.Character:SetAttribute("Combat_Facing", true);
    local _ = p93.Turn_Count;
    p93.Is_Attacking = true;
    local v94 = p93.Wep_Data.AttackSpeed or 1;
    local v95 = p93.Player:GetAttribute("AchBoost_AttackSpeed") or 0;
    local v96 = p93.Player:GetAttribute("PotionBuff_AttackSpeed") or 0;

    if v95 > 0 then
        v94 = v94 * (1 + v95 / 100) * (1 + v96);
    end;

    p93.Animations["Attack_" .. p93.Turn_Count]:Play(0.12, 1, v94);

    if p93.Wep_Data.OnSwing then
        p93.Wep_Data.OnSwing(p93);
    end;

    Trait_Data.FireHook(p93.TraitContext, "OnSwing", p93);
end;

function u1.Parry(u97) -- Line: 983
    -- upvalues: SharedUtils (copy)
    if u97.Is_Parrying then
        return;
    end;

    if u97.Parry_On_Cooldown then
        return;
    end;

    if u97.Is_Stunned then
        return;
    end;

    local Character = u97.Player.Character;

    if not Character then
        return;
    end;

    if not Character:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    u97.Is_Parrying = true;
    u97.Parry_On_Cooldown = true;
    u97.Parry_Cooldown_End = tick() + 2;
    u97.Player:SetAttribute("Parry_Cooldown_Duration", 2);
    u97.Player:SetAttribute("Parry_Cooldown_Active", true);

    if u97.Parry_Animation then
        u97.Parry_Animation:Play(0, 1, 1);
    end;

    Character:SetAttribute("Parry", true);
    local v98 = 0.25 * (1 + (u97.Wep_Data.ParryWindowMult or 0));
    local v99 = u97.Player:GetAttribute("AchBoost_ParryFrames") or 0;

    if v99 > 0 then
        v98 = v98 + v99 / 60;
    end;

    SharedUtils.parryEffect(Character, v98);
    task.delay(v98, function() -- Line: 1022
        -- upvalues: u97 (copy), Character (copy)
        u97.Is_Parrying = false;

        if Character then
            Character:SetAttribute("Parry", false);
        end;
    end);
    task.delay(2, function() -- Line: 1030
        -- upvalues: u97 (copy)
        if tick() >= u97.Parry_Cooldown_End then
            u97.Parry_On_Cooldown = false;

            if u97.Player then
                u97.Player:SetAttribute("Parry_Cooldown_Active", false);
            end;
        end;
    end);
end;

function u1.CheckParry(p100: userdata, p101: userdata?) -- Line: 1042
    -- upvalues: SharedUtils (copy), u1 (copy)
    if not p100 then
        return false;
    end;

    if not p100:GetAttribute("Parry") then
        return false;
    end;

    local HumanoidRootPart = p100:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        SharedUtils.ShowTextPopup(HumanoidRootPart, "PARRY!", Color3.fromRGB(255, 215, 0));

        if math.random(1, 2) == 1 then
            SharedUtils.PlaySoundAt(HumanoidRootPart, "Parry1", 1);
        else
            SharedUtils.PlaySoundAt(HumanoidRootPart, "Parry2", 1);
        end;
    end;

    if p100:GetAttribute("Parry_ConsumeOnHit") then
        p100:SetAttribute("Parry", false);
        p100:SetAttribute("Parry_ConsumeOnHit", nil);
    end;

    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(p100);

    if PlayerFromCharacter then
        local State = u1.GetState(PlayerFromCharacter);

        if State then
            State.Parry_Cooldown_End = tick() + 0.7;

            if State.Player then
                State.Player:SetAttribute("Parry_Cooldown_Duration", 0.7);
                State.Player:SetAttribute("Parry_Cooldown_Active", true);
            end;

            task.delay(0.7, function() -- Line: 1081
                -- upvalues: State (copy)
                if State and tick() >= State.Parry_Cooldown_End then
                    State.Parry_On_Cooldown = false;

                    if State.Player then
                        State.Player:SetAttribute("Parry_Cooldown_Active", false);
                    end;
                end;
            end);
        end;

        local State2 = require(game:GetService("ServerScriptService").Management.Modules.Class_Manager).GetState(PlayerFromCharacter);

        if State2 then
            State2:_FireMasteryPassive("OnParry", {
                AttackerBody = p101,
                ParryingPlayer = PlayerFromCharacter
            });
        end;
    end;

    return true;
end;

function u1.Stun(u102, p103) -- Line: 1112
    if u102.Is_Stunned then
        return;
    end;

    u102.Is_Stunned = true;
    u102.Is_Attacking = false;
    u102.SlowingDown = false;
    local v104 = p103 or 1;

    for i, v in u102.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.1);
        end;
    end;

    if u102.Humanoid then
        u102.Humanoid.WalkSpeed = 0;
        u102.Humanoid.JumpPower = 0;
    end;

    if u102.StunAnimation then
        u102.StunAnimation:Play(0.1);
    end;

    u102:ApplyStunVisual(u102.Character, v104);
    task.delay(v104, function() -- Line: 1141
        -- upvalues: u102 (copy)
        u102.Is_Stunned = false;

        if u102.StunAnimation and u102.StunAnimation.IsPlaying then
            u102.StunAnimation:Stop(0.2);
        end;

        if u102.Humanoid then
            u102.Humanoid.JumpPower = 50;
            u102:Slowdown(false);
        end;
    end);
end;

function u1.ApplyStunVisual(p105, p106, p107) -- Line: 1157
    -- upvalues: TweenService (copy)
    if not p106 then
        return;
    end;

    local StunHighlight = p106:FindFirstChild("StunHighlight");

    if StunHighlight then
        StunHighlight:Destroy();
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.Name = "StunHighlight";
    Highlight.FillColor = Color3.fromRGB(255, 50, 50);
    Highlight.OutlineColor = Color3.fromRGB(255, 215, 0);
    Highlight.FillTransparency = 0.3;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = p106;
    local v108 = TweenService:Create(Highlight, TweenInfo.new(p107, Enum.EasingStyle.Linear), {
        FillTransparency = 1,
        OutlineTransparency = 1
    });
    v108:Play();
    v108.Completed:Once(function() -- Line: 1179
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);
end;

function u1.FlagPVPCombat(p109, p110) -- Line: 1185
    for _, v in { p109, p110 } do
        if v then
            v:SetAttribute("In_PVP", true);
            local u111 = tick() + 15;
            v:SetAttribute("PVP_Combat_End", u111);
            task.delay(15, function() -- Line: 1192
                -- upvalues: v (copy), u111 (copy)
                if v:GetAttribute("PVP_Combat_End") == u111 then
                    v:SetAttribute("In_PVP", false);
                end;
            end);
        end;
    end;
end;

function u1.ApplyDodgeReward(u112) -- Line: 1203
    -- upvalues: TweenService (copy)
    local Character = u112.Character;
    local Player = u112.Player;

    if not (Character and Player) then
        return;
    end;

    Player:SetAttribute("Protected", true);
    Player:SetAttribute("iFrame", true);
    Character:SetAttribute("Protected", true);
    Character:SetAttribute("iFrame", true);
    local DodgeRewardHighlight = Character:FindFirstChild("DodgeRewardHighlight");

    if DodgeRewardHighlight then
        DodgeRewardHighlight:Destroy();
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.Name = "DodgeRewardHighlight";
    Highlight.FillColor = Color3.fromRGB(80, 160, 255);
    Highlight.OutlineColor = Color3.fromRGB(150, 220, 255);
    Highlight.FillTransparency = 0.4;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = Character;
    local v113 = TweenService:Create(Highlight, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
        FillTransparency = 1,
        OutlineTransparency = 1
    });
    v113:Play();
    v113.Completed:Once(function() -- Line: 1234
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);
    task.delay(1.5, function() -- Line: 1239
        -- upvalues: u112 (copy), Player (copy), Character (copy)
        if not u112.Is_Dodging then
            Player:SetAttribute("Protected", false);
            Player:SetAttribute("iFrame", false);
            Character:SetAttribute("Protected", false);
            Character:SetAttribute("iFrame", false);
            u112:Slowdown(false);
        end;
    end);
end;

function u1.CheckPVPParry(p114, p115, p116) -- Line: 1253
    -- upvalues: u1 (copy), SharedUtils (copy), PlayCombatSound (copy)
    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(p115);

    if not PlayerFromCharacter then
        return false;
    end;

    if not (p114.Player:GetAttribute("PVPEnabled") and PlayerFromCharacter:GetAttribute("PVPEnabled")) then
        return false;
    end;

    if not p115:GetAttribute("Parry") then
        return false;
    end;

    local HumanoidRootPart = p115:FindFirstChild("HumanoidRootPart");
    local State = u1.GetState(PlayerFromCharacter);
    u1.FlagPVPCombat(p114.Character, p115);

    if p116 then
        if State then
            State.Is_Parrying = false;
            p115:SetAttribute("Parry", false);
            State:Stun(1);
        end;

        if HumanoidRootPart then
            SharedUtils.ShowText(HumanoidRootPart, "Guard Break!", Color3.fromRGB(255, 100, 0));
            PlayCombatSound("Hit", HumanoidRootPart, 0.8);
        end;

        return false;
    end;

    p114:Stun(1);

    if HumanoidRootPart then
        SharedUtils.ShowTextPopup(HumanoidRootPart, "PARRY!", Color3.fromRGB(255, 215, 0));
        local math_random_ret = math.random(1, 2);
        SharedUtils.PlaySoundAt(HumanoidRootPart, "Parry" .. math_random_ret, 1);
    end;

    if State then
        State.Parry_Cooldown_End = tick() + 4;

        if p114.Player then
            State.Player:SetAttribute("Parry_Cooldown_Duration", 4);
            State.Player:SetAttribute("Parry_Cooldown_Active", true);
        end;

        task.delay(4, function() -- Line: 1309
            -- upvalues: State (copy)
            if State and tick() >= State.Parry_Cooldown_End then
                State.Parry_On_Cooldown = false;

                if State.Player then
                    State.Player:SetAttribute("Parry_Cooldown_Active", false);
                end;
            end;
        end);
    end;

    return true;
end;

function u1.GetState(p117: userdata) -- Line: 1323
    -- upvalues: u1 (copy)
    return u1.ActiveStates[p117];
end;

function u1.Destroy(p118) -- Line: 1327
    -- upvalues: u1 (copy)
    if p118.Player then
        p118.Player:SetAttribute("Protected", nil);
        p118.Player:SetAttribute("iFrame", nil);
        u1.ActiveStates[p118.Player] = nil;
    end;

    if p118.Character then
        p118.Character:SetAttribute("In_PVP", false);
        p118.Character:SetAttribute("PVP_Combat_End", nil);
    end;

    for _, v in p118.Animation_Connections do
        v:Disconnect();
    end;

    table.clear(p118.Animation_Connections);

    for _, v in p118.Weapon_Connections do
        v:Disconnect();
    end;

    table.clear(p118.Weapon_Connections);

    if p118.Hitbox_Connection then
        p118.Hitbox_Connection:Disconnect();
        p118.Hitbox_Connection = nil;
    end;

    for _, v in p118.Animations do
        if v.IsPlaying then
            v:Stop();
        end;
    end;

    for _, v in p118.Animations do
        v:Stop();
        v:Destroy();
    end;

    table.clear(p118.Animations);
    p118.Animations_Loaded = false;

    if p118.DodgeAnimations then
        for _, v in p118.DodgeAnimations do
            if v.IsPlaying then
                v:Stop();
            end;

            v:Destroy();
        end;

        table.clear(p118.DodgeAnimations);
    end;

    p118.CurrentDodgeDirection = nil;

    if p118.StunAnimation then
        if p118.StunAnimation.IsPlaying then
            p118.StunAnimation:Stop();
        end;

        p118.StunAnimation:Destroy();
        p118.StunAnimation = nil;
    end;

    p118.Is_Stunned = false;

    if p118.Character then
        local StunHighlight = p118.Character:FindFirstChild("StunHighlight");

        if StunHighlight then
            StunHighlight:Destroy();
        end;

        local DodgeRewardHighlight = p118.Character:FindFirstChild("DodgeRewardHighlight");

        if DodgeRewardHighlight then
            DodgeRewardHighlight:Destroy();
        end;
    end;

    table.clear(p118.FX);

    if p118.Weapon_Prefab and p118.Weapon_Prefab.Parent then
        p118.Weapon_Prefab:Destroy();
    end;

    p118.Player:SetAttribute("Dodge_Cooldown_Active", nil);
    p118.Player:SetAttribute("Dodge_Cooldown_Duration", nil);
    p118.Player:SetAttribute("Parry_Cooldown_Active", nil);
    p118.Player:SetAttribute("Parry_Cooldown_Duration", nil);

    if p118.AuraInstances then
        for _, v in p118.AuraInstances do
            if v and v.Parent then
                v:Destroy();
            end;
        end;

        table.clear(p118.AuraInstances);
    end;

    p118.TraitContext = nil;
    p118.Player = nil;
    p118.Character = nil;
    p118.Wep_Data = nil;
end;

return u1;