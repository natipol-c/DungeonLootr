--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PlaceConfig
  Path:     game.ReplicatedStorage.GameInfo.PlaceConfig
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Environments = {
        Main = {
            UniverseId = 9656201728,
            LobbyPlaceId = 106484206883664,
            DungeonPlaceId = 132285059959516,
            AFKPlaceId = 129976314326660,
            IsTest = false
        },
        Test = {
            UniverseId = 10004532523,
            LobbyPlaceId = 95503046258891,
            DungeonPlaceId = 89954929513873,
            AFKPlaceId = 103006040833273,
            IsTest = true
        }
    }
};
local v2, v3 = (function() -- Line: 36, Name: Resolve
    -- upvalues: u1 (copy)
    for i, v in u1.Environments do
        if game.GameId == v.UniverseId then
            return i, v;
        end;
    end;

    for i, v in u1.Environments do
        if game.PlaceId == v.LobbyPlaceId or game.PlaceId == v.DungeonPlaceId then
            return i, v;
        end;
    end;

    return "Main", u1.Environments.Main;
end)();
u1.Environment = v2;
u1.IsTestEnvironment = v3.IsTest;
u1.UniverseId = v3.UniverseId;
u1.LobbyPlaceId = v3.LobbyPlaceId;
u1.DungeonPlaceId = v3.DungeonPlaceId;
u1.AFKPlaceId = v3.AFKPlaceId;
u1.IsLobbyPlace = game.PlaceId == v3.LobbyPlaceId;
u1.IsDungeonPlace = game.PlaceId == v3.DungeonPlaceId;
local v4;

if v3.AFKPlaceId == nil then
    v4 = false;
else
    v4 = game.PlaceId == v3.AFKPlaceId;
end;

u1.IsAFKPlace = v4;

return u1;