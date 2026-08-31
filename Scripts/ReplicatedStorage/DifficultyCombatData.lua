--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DifficultyCombatData
  Path:     game.ReplicatedStorage.GameInfo.DifficultyCombatData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Mob = {
        Easy = {
            Health = 300,
            Damage = 6
        },
        Normal = {
            Health = 2000,
            Damage = 17
        },
        Hard = {
            Health = 12200,
            Damage = 56
        },
        Nightmare = {
            Health = 32000,
            Damage = 270
        },
        Endless = {
            Health = 48000,
            Damage = 360
        }
    },
    Boss = {
        Easy = {
            Health = 2000,
            Damage = 15
        },
        Normal = {
            Health = 15000,
            Damage = 30
        },
        Hard = {
            Health = 50000,
            Damage = 125
        },
        Nightmare = {
            Health = 350000,
            Damage = 360
        },
        Endless = {
            Health = 525000,
            Damage = 480
        }
    },
    MiniBoss = {
        Easy = {
            Health = 750,
            Damage = 12
        },
        Normal = {
            Health = 7000,
            Damage = 46
        },
        Hard = {
            Health = 18700,
            Damage = 95
        },
        Nightmare = {
            Health = 105000,
            Damage = 200
        },
        Endless = {
            Health = 157000,
            Damage = 260
        }
    },
    Roles = {
        Standard = {
            Health = 1,
            Damage = 1
        },
        Heavy = {
            Health = 1.6,
            Damage = 0.9
        },
        Skirmisher = {
            Health = 0.7,
            Damage = 1.1
        },
        Ranged = {
            Health = 0.6,
            Damage = 1
        }
    },
    RoleByEnemy = {}
};

function u1.Get(p2: string, p3: string) -- Line: 85
    -- upvalues: u1 (copy)
    local v4 = u1[p2] or u1.Mob;

    return v4[p3] or v4.Normal;
end;

function u1.GetRole(p5: string?) -- Line: 91
    -- upvalues: u1 (copy)
    return u1.Roles[p5 or "Standard"] or u1.Roles.Standard;
end;

function u1.ResolveRole(p6: string?, p7: string?) -- Line: 99
    -- upvalues: u1 (copy)
    if p6 and u1.RoleByEnemy[p6] then
        return u1.RoleByEnemy[p6];
    end;

    if p7 == "Ranged" then
        return "Ranged";
    end;

    if p6 then
        if string.find(p6, "Strong") or string.find(p6, "Berserker") then
            return "Heavy";
        end;

        if string.find(p6, "Rogue") then
            return "Skirmisher";
        end;

        if string.find(p6, "Archer") then
            return "Ranged";
        end;
    end;

    return "Standard";
end;

function u1.MobStats(p8: string, p9: string?) -- Line: 114
    -- upvalues: u1 (copy)
    local v10 = u1.Get("Mob", p8);
    local Role = u1.GetRole(p9);

    return v10.Health * Role.Health, v10.Damage * Role.Damage;
end;

return u1;