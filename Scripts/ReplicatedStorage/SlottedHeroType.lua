--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SlottedHeroType
  Path:     game.ReplicatedStorage.CmdrClient.Types.SlottedHeroType
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

local Index = require(game.ReplicatedStorage.GameInfo.ItemData).Index;

local function FindPlayerBase(p1: string) -- Line: 7
    local v2 = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Bases");

    if not v2 then
        return nil;
    end;

    for _, child in v2:GetChildren() do
        local v3 = child:FindFirstChild("Important") and child.Important:FindFirstChild("Sign") and child.Important.Sign:FindFirstChild("SignPart");

        if v3 then
            local v4 = v3:FindFirstChildWhichIsA("SurfaceGui");

            if v4 then
                v4 = v4:FindFirstChild("TextLabel");
            end;

            if v4 and v4.Text == p1 .. "\'s Base" then
                return child;
            end;
        end;
    end;

    return nil;
end;

local function GetSlottedHeroes(p5) -- Line: 28
    -- upvalues: Index (copy)
    local v6 = {};
    local v7 = p5:FindFirstChild("Important") and p5.Important:FindFirstChild("NPCPads");

    if not v7 then
        return v6;
    end;

    for _, child in v7:GetChildren() do
        local v8 = tonumber(child.Name);

        if v8 then
            local Character = child:FindFirstChild("Character");

            if Character then
                local Attribute = Character:GetAttribute("ItemId");

                if Attribute then
                    local v9 = Character:GetAttribute("Unstealable") or false;
                    local v10 = Index[Attribute];
                    local v11;

                    if v10 then
                        v11 = v10.Name or Attribute;
                    else
                        v11 = Attribute;
                    end;

                    table.insert(v6, {
                        SlotIndex = v8,
                        ItemId = Attribute,
                        DisplayName = v11,
                        Unstealable = v9,
                        Value = v8 .. ":" .. Attribute
                    });
                end;
            end;
        end;
    end;

    table.sort(v6, function(p12, p13) -- Line: 59
        return p12.SlotIndex < p13.SlotIndex;
    end);

    return v6;
end;

return function(p14) -- Line: 66
    -- upvalues: FindPlayerBase (copy), GetSlottedHeroes (copy)
    p14:RegisterType("slottedHero", {
        DisplayName = "Slotted Hero",

        Transform = function(p15, p16) -- Line: 70, Name: Transform
            local v17 = tonumber(p15);

            if v17 then
                local v18 = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Bases");

                if v18 then
                    for _, child in v18:GetChildren() do
                        local v19 = child.Important and child.Important:FindFirstChild("NPCPads");

                        if v19 then
                            local v20 = v19:FindFirstChild((tostring(v17)));

                            if v20 then
                                local Character = v20:FindFirstChild("Character");

                                if Character then
                                    local Attribute = Character:GetAttribute("ItemId");

                                    if Attribute then
                                        return v17 .. ":" .. Attribute;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            return p15;
        end,

        Validate = function(p21) -- Line: 98, Name: Validate
            if p21:match("^%d+:.+$") then
                return true;
            end;

            return false, "Select a hero from autocomplete (format: SlotIndex:HeroId)";
        end,

        Parse = function(p22) -- Line: 105, Name: Parse
            return p22;
        end,

        Autocomplete = function(p23, p24) -- Line: 109, Name: Autocomplete
            -- upvalues: FindPlayerBase (ref), GetSlottedHeroes (ref)
            local v25 = {};

            for _, v in game.Players:GetPlayers() do
                local v26 = FindPlayerBase(v.Name);

                if v26 then
                    for _, v2 in GetSlottedHeroes(v26) do
                        local _ = v2.Value;

                        if v2.Unstealable then
                            local _ = v2.Value .. " [PROTECTED]";
                        end;

                        if p23 == "" or (v2.Value:lower():find(p23:lower(), 1, true) or (v2.DisplayName:lower():find(p23:lower(), 1, true) or tostring(v2.SlotIndex):find(p23, 1, true))) then
                            table.insert(v25, v2.Value);
                        end;
                    end;
                end;
            end;

            return v25;
        end
    });
end;