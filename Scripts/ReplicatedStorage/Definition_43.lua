--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Definition
  Path:     game.ReplicatedStorage.Mutations.Sanguine.Definition
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local Color3_fromRGB_ret = Color3.fromRGB(200, 40, 60);

return {
    Name = "Sanguine",

    ModifyOutgoingDamage = function(p1: any, p2: any, p3: number) -- Line: 51, Name: ModifyOutgoingDamage
        -- upvalues: SharedUtils (copy), Color3_fromRGB_ret (copy)
        if not p2 or p3 <= 0 then
            return nil;
        end;

        if not p1:GetEnemyNPC(p2) then
            return nil;
        end;

        local os_clock_ret = os.clock();

        if (p1._sanguineWindowUntil or 0) <= os_clock_ret then
            if os_clock_ret < (p1._sanguineCDUntil or 0) then
                return nil;
            end;

            if math.random() > 0.1 then
                return nil;
            end;

            p1._sanguineWindowUntil = os_clock_ret + 3;
            p1._sanguineCDUntil = os_clock_ret + 15;
        end;

        local Character = p1.Character;
        local v4;

        if Character then
            v4 = Character:FindFirstChild("Humanoid");
        else
            v4 = Character;
        end;

        if not v4 or v4.Health <= 0 then
            return nil;
        end;

        local math_min_ret = math.min(p3 * 0.1, v4.MaxHealth * 0.05);

        if math_min_ret <= 0 then
            return nil;
        end;

        v4.Health = math.min(v4.MaxHealth, v4.Health + math_min_ret);
        local v5 = Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart;

        if v5 then
            SharedUtils.ShowStatusDamage(v5, math.floor(math_min_ret + 0.5), Color3_fromRGB_ret, "+");
        end;

        return nil;
    end
};