--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Interface
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Gameplay.Interface
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    _Cache = {},
    _Categories = {},

    Cleanup = function(p1: table, p2: table) -- Line: 8, Name: Cleanup
        for i, v in pairs(p2 or p1._Cache) do
            v._Janitor:Cleanup();
            v:Destroy();

            if p1._Cache[i] then
                p1._Cache[i] = nil;
            else
                error((`Element "{i}" not found in interface cache.`));
            end;
        end;
    end,

    Create = function(p3: table, p4: table) -- Line: 21, Name: Create
        local Index = p4.Index;
        local Name = p4.Name;
        local v5 = p3._Categories[Name];

        if v5 then
            local v6 = p3._Cache[Index or Name];

            if v6 then
                if v6.IsCore then
                    warn((`Core element "{Index or Name}" already exists. Returning original element.`));

                    return v6;
                end;

                p3:Cleanup({
                    [Index or Name] = v6
                });
            end;

            local v7 = v5.new();
            p3._Cache[Index or Name] = v7;

            return v7;
        end;
    end,

    GetElement = function(p8: table, p9: string) -- Line: 52, Name: GetElement
        return p8._Cache[p9];
    end,

    Initialize = function(p10) -- Line: 56, Name: Initialize
        for _, child in ipairs(script:GetChildren()) do
            local v11 = require(child);
            local v12 = `{child}`;
            p10._Categories[v12] = v11;
        end;
    end,

    Open = function(p13: table, p14: table) -- Line: 65, Name: Open
        local Element = p14.Element;
        local Element2 = p13:GetElement(Element);

        if not Element2 then
            error((`Element "{Element}" not found.`));

            return;
        end;

        if Element2.Open then
            Element2:Open();

            return;
        end;

        warn((`No :Open() function for element "{Element}".`));
    end,

    Reset = function(p15: table, p16: table) -- Line: 81, Name: Reset
        for i, v in pairs(p16 or p15._Cache) do
            if v.Reset then
                v:Reset();
            else
                warn((`Element {i} does not have a reset function`));
            end;
        end;
    end,

    Update = function(p17: table, p18: table) -- Line: 91, Name: Update
        local Data = p18.Data;
        local Index = p18.Index;

        if not Index then
            for _, v in pairs(p17._Cache) do
                if v.Update then
                    v:Update(Data);
                end;
            end;

            return;
        end;

        local Element = p17:GetElement(Index);

        if Element then
            Element:Update(Data);

            return;
        end;

        error((`Element "{Index}" does not exist.`));
    end
};