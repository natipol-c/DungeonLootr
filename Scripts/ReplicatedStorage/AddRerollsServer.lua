--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AddRerollsServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.AddRerollsServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local Knit = require(game.ReplicatedStorage.Packages.Knit);
local u1 = {
    Basic = true,
    Hyper = true
};

return function(p2: any, p3: userdata, p4: string, p5: number) -- Line: 5
    -- upvalues: u1 (copy), Knit (copy)
    local v6 = p4:sub(1, 1):upper() .. p4:sub(2):lower();

    if not u1[v6] then
        return "Invalid crystal type: " .. v6 .. ". Use Basic or Hyper.";
    end;

    Knit.GetService("WeaponService"):AddCrystals(p3, v6, p5);

    return "Added " .. p5 .. " " .. v6 .. " crystal(s) to " .. p3.Name;
end;