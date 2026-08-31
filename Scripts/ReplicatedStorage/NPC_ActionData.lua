--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     NPC_ActionData
  Path:     game.ReplicatedStorage.GameInfo.NPC_ActionData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    Index = {
        Bastion = {
            WeaponSource = "Flaming Spear",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            FX_Order = nil,
            TurnCount = nil,
            SwingSoundFolder = nil,
            SwingVolume = nil
        },
        Assassin = {
            WeaponSource = "Assassin Dagger",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.5,
            AttackSpeed = 0.5
        },
        Ronin = {
            WeaponSource = "Katana",
            Scope = "All",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.5,
            AttackSpeed = 0.5
        },
        Avalen = {
            WeaponSource = "Frost Axe",
            Scope = "All",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6
        },
        Homura = {
            WeaponSource = "Blazing Katana",
            Scope = "All",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Astraeon = {
            WeaponSource = "Heavens Bow",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.8,
            AttackSpeed = 0.8
        },
        Akihiro = {
            WeaponSource = "Water Katana",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.8,
            AttackSpeed = 0.8
        },
        Mistwalker = {
            WeaponSource = "Mistblade",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.8,
            AttackSpeed = 0.8
        },
        Kyo = {
            WeaponSource = "Flaming Fist",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.8,
            AttackSpeed = 0.8
        },
        ["Ice Angel"] = {
            WeaponSource = "Ice Magic",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6
        },
        ["Vermillion Blade"] = {
            WeaponSource = "Wolf Katana",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.8,
            AttackSpeed = 0.8
        },
        Valen = {
            WeaponSource = "Yamato",
            Scope = "Challenge",
            WindUpSpeed = 0.2,
            WindUpDuration = 0.4,
            CombatSpeed = 0.9,
            AttackSpeed = 0.9
        },
        Kieru = {
            WeaponSource = "Masamune",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Betrayer = {
            WeaponSource = "Demonic Warblades",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6
        },
        Duskwraith = {
            WeaponSource = "Demon Daggers",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Tenebris = {
            WeaponSource = "Chaos Scythe",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.8,
            AttackSpeed = 0.8
        },
        ["Primate King"] = {
            WeaponSource = "Azure Dragon",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.8,
            AttackSpeed = 0.8
        },
        Zetsugen = {
            WeaponSource = "Cursed Hand",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6
        },
        Chainsaw = {
            WeaponSource = "Chainsaws",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6
        },
        Solryn = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            Archetype = "Ranged",
            ProjectileId = "Random",
            ProjectileSpeed = 60,
            ProjectileArc = -80,
            PreferredRange = 35,
            RetreatRange = 12
        },
        Enzo = {
            WeaponSource = "Demonic Daggers",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6
        },
        Kagura = {
            WeaponSource = "Flaming Spear",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Koga = {
            WeaponSource = "Kinsatsu",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Galran = {
            WeaponSource = "Lionheart Sword",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Myra = {
            WeaponSource = "Dragon Gauntlets",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Eidolon = {
            WeaponSource = "Demon Daggers",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        ["Goblin Chief"] = {
            WeaponSource = "Frost Axe",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        ["Knight Lord"] = {
            WeaponSource = "Flaming Spear",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        ["Bandit Chief"] = {
            WeaponSource = "Lionheart Sword",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Corpsman = {
            WeaponSource = "Katana",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.5,
            AttackSpeed = 0.5
        },
        Protector = {
            WeaponSource = "Katana",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.5,
            AttackSpeed = 0.5
        },
        Oathbreaker = {
            WeaponSource = "Buster",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Garm = {
            WeaponSource = "Buster",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Sigrune = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6
        },
        Phantom = {
            WeaponSource = "Dragon Gauntlets",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Umbra = {
            WeaponSource = "Umbral Rapier",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6
        },
        Druid = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            Archetype = "Ranged",
            ProjectileId = "M",
            ProjectileSpeed = 60,
            ProjectileArc = -80,
            PreferredRange = 35,
            RetreatRange = 12
        },
        Runel = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            Archetype = "Ranged",
            ProjectileId = "M",
            ProjectileSpeed = 60,
            ProjectileArc = -80,
            PreferredRange = 35,
            RetreatRange = 12
        },
        Cantor = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            Archetype = "Ranged",
            ProjectileId = "M",
            ProjectileSpeed = 60,
            ProjectileArc = -80,
            PreferredRange = 35,
            RetreatRange = 12
        },
        Shaman = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            Archetype = "Ranged",
            ProjectileId = "D",
            ProjectileSpeed = 60,
            ProjectileArc = -80,
            PreferredRange = 35,
            RetreatRange = 12
        },
        Imperius = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            Archetype = "Ranged",
            ProjectileId = "F",
            ProjectileSpeed = 60,
            ProjectileArc = -80,
            PreferredRange = 35,
            RetreatRange = 12
        },
        Sovereign = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            Archetype = "Ranged",
            ProjectileId = "D",
            ProjectileSpeed = 60,
            ProjectileArc = -80,
            PreferredRange = 35,
            RetreatRange = 12
        },
        ["Crimson Mage"] = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            Archetype = "Ranged",
            ProjectileId = "F",
            ProjectileSpeed = 60,
            ProjectileArc = -80,
            PreferredRange = 35,
            RetreatRange = 12
        },
        ["Ebon Crow"] = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            Archetype = "Ranged",
            ProjectileId = "D",
            ProjectileSpeed = 60,
            ProjectileArc = -80,
            PreferredRange = 35,
            RetreatRange = 12
        },
        ["Nyx Blackthorn"] = {
            WeaponSource = "Great Mage Staff",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.6,
            AttackSpeed = 0.6,
            Archetype = "Ranged",
            ProjectileId = "D",
            ProjectileSpeed = 60,
            ProjectileArc = -80,
            PreferredRange = 35,
            RetreatRange = 12
        },
        Bandit_Enforcer = {
            WeaponSource = "Greatsword",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Goblin_Warchief = {
            WeaponSource = "Flame Bastion",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Knight_Champion = {
            WeaponSource = "Oathbreaker",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Dark_Revenant = {
            WeaponSource = "Shadow Vagrant",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        },
        Frost_Warden = {
            WeaponSource = "Founder",
            Scope = "Challenge",
            WindUpSpeed = 0.1,
            WindUpDuration = 0.4,
            CombatSpeed = 0.7,
            AttackSpeed = 0.7
        }
    }
};
local u2 = nil;

function u1.Resolve(p3: string, p4: boolean) -- Line: 483
    -- upvalues: u1 (copy), u2 (ref), ReplicatedStorage (copy)
    local v5 = u1.Index[p3];

    if not v5 then
        return nil;
    end;

    if v5.Scope == "Challenge" and not p4 then
        return nil;
    end;

    if not u2 then
        local success, result = pcall(require, ReplicatedStorage.Weapons.Weapon_Data);

        if not success then
            warn("[NPC_ActionData] Could not load Weapon_Data:", result);

            return nil;
        end;

        u2 = result;
    end;

    local WeaponSource = v5.WeaponSource;
    local v6 = u2[WeaponSource];

    if v6 then
        return {
            WeaponSource = WeaponSource,
            AttackSpeed = v5.AttackSpeed or (v6.AttackSpeed or 1),
            FX_Order = v5.FX_Order or (v6.FX_Order or {}),
            TurnCount = v5.TurnCount or (v6.TurnCount or 4),
            SwingSoundFolder = v5.SwingSoundFolder or (v6.SwingSoundFolder or "Sword_Swings"),
            SwingVolume = v5.SwingVolume or (v6.SwingVolume or 1),
            WindUpSpeed = v5.WindUpSpeed,
            WindUpDuration = v5.WindUpDuration,
            CombatSpeed = v5.CombatSpeed,
            Archetype = v5.Archetype,
            ProjectileId = v5.ProjectileId,
            ProjectileSpeed = v5.ProjectileSpeed or 60,
            ProjectileArc = v5.ProjectileArc or -80,
            PreferredRange = v5.PreferredRange or 35,
            RetreatRange = v5.RetreatRange or 12,
            Spells = v5.Spells,
            HealRadius = v5.HealRadius,
            HealMaxTargets = v5.HealMaxTargets,
            HealPercent = v5.HealPercent,
            ZoneCount = v5.ZoneCount,
            ZoneRadius = v5.ZoneRadius,
            ZoneSpread = v5.ZoneSpread,
            ZoneDelay = v5.ZoneDelay,
            ZoneDamageMult = v5.ZoneDamageMult,
            WardRadius = v5.WardRadius,
            WardMaxTargets = v5.WardMaxTargets,
            WardPercent = v5.WardPercent
        };
    end;

    warn((`[NPC_ActionData] Weapon_Data entry not found: {WeaponSource}`));

    return nil;
end;

return u1;