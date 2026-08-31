--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     loader
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_loader@2.0.0.loader
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:39 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    LoadChildren = function(p1: userdata, p2: function?) -- Line: 44, Name: LoadChildren
        local v3 = {};

        for _, child in p1:GetChildren() do
            if child:IsA("ModuleScript") and (not p2 or p2(child)) then
                local v4 = require(child);
                v3[child.Name] = v4;
            end;
        end;

        return v3;
    end,

    LoadDescendants = function(p5: userdata, p6: function?) -- Line: 74, Name: LoadDescendants
        local v7 = {};

        for _, descendant in p5:GetDescendants() do
            if descendant:IsA("ModuleScript") and (not p6 or p6(descendant)) then
                local v8 = require(descendant);
                v7[descendant.Name] = v8;
            end;
        end;

        return v7;
    end,

    MatchesName = function(u9: string) -- Line: 97, Name: MatchesName
        return function(p10: userdata) -- Line: 98
            -- upvalues: u9 (copy)
            return p10.Name:match(u9) ~= nil;
        end;
    end,

    SpawnAll = function(p11: table, p12: string) -- Line: 125, Name: SpawnAll
        for i, v in p11 do
            local u13 = v[p12];

            if type(u13) == "function" then
                task.spawn(function() -- Line: 129
                    -- upvalues: i (copy), u13 (copy), v (copy)
                    debug.setmemorycategory(i);
                    u13(v);
                end);
            end;
        end;
    end
};