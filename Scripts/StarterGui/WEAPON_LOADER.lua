--[[
  Type:     LocalScript
  Method:   decompile
  Name:     WEAPON_LOADER
  Path:     game.StarterGui.Main.Frames.Chest_RNG.Chests.Template_Scroller.ItemContainer.Weapon.Icon.WEAPON_LOADER
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:10 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_Parent = script.Parent;

local function LoadWeapon(p1) -- Line: 6
    -- upvalues: ReplicatedStorage (copy), script_Parent (copy)
    if not p1 then
        return;
    end;

    local v2 = ReplicatedStorage.Weapons:FindFirstChild(p1);

    if v2 and v2:FindFirstChild("Icon") then
        script_Parent.Image = v2.Icon.Value;
    end;
end;

task.defer(function() -- Line: 14
    -- upvalues: ReplicatedStorage (copy), script_Parent (copy)
    local Attribute = script:GetAttribute("WeaponId");

    if not Attribute then
        return;
    end;

    local v3 = ReplicatedStorage.Weapons:FindFirstChild(Attribute);

    if v3 and v3:FindFirstChild("Icon") then
        script_Parent.Image = v3.Icon.Value;
    end;
end);
script:GetAttributeChangedSignal("WeaponId"):Connect(function() -- Line: 18
    -- upvalues: ReplicatedStorage (copy), script_Parent (copy)
    local Attribute = script:GetAttribute("WeaponId");

    if not Attribute then
        return;
    end;

    local v4 = ReplicatedStorage.Weapons:FindFirstChild(Attribute);

    if v4 and v4:FindFirstChild("Icon") then
        script_Parent.Image = v4.Icon.Value;
    end;
end);