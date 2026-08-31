--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     caches
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.services.caches
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../obj/ObjectCache");
local u2 = require("../mod/utility");

return {
    init = function(p3: table) -- Line: 7, Name: init
        -- upvalues: u2 (copy), u1 (copy)
        local Part = Instance.new("Part");
        Part.Transparency = 1;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.Locked = true;
        local Folder = Instance.new("Folder");
        Folder.Name = "DO_NOT_REMOVE_ForgeSharedPartCache";
        Folder.Archivable = false;
        Folder.Parent = workspace.Terrain;
        u2.protectParent(p3, Folder);
        local u5 = u1.new(Part, Folder, {
            size = 150,

            on_free = function(p4) -- Line: 27, Name: on_free
                -- upvalues: Folder (copy)
                local value = p4.value;
                value.Transparency = 1;
                value.Anchored = true;
                value.CanQuery = false;
                value.CanCollide = false;
                value.CollisionGroup = "ForgeMouseIgnore";
                value.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                value.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                value.Parent = Folder;
                value:ClearAllChildren();
            end
        });
        local v6 = {
            shared_part = u5
        };
        table.insert(p3, function() -- Line: 55
            -- upvalues: u5 (ref)
            u5:destroy();
        end);

        return v6;
    end
};