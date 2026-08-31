--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DropController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.DropController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Packages = ReplicatedStorage:WaitForChild("Packages");
local Knit = require(Packages.Knit);
local u1 = nil;
local v2 = Knit.CreateController({
    Name = "DropController"
});

function v2.KnitInit(p3) -- Line: 17
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    u1 = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("DropSpawner"));
end;

function v2.KnitStart(u4) -- Line: 22
    -- upvalues: Knit (copy)
    Knit.GetService("DropService").SpawnDrops:Connect(function(p5: vector, p6: string, p7: number, p8: number, p9: string?, p10: string?, p11: string?) -- Line: 28
        -- upvalues: u4 (copy)
        u4:_handleSpawnDrops(p5, p6, p7, p8, p9, p10, p11);
    end);
end;

function v2._handleSpawnDrops(p12: table, p13: vector, p14: string, p15: number, p16: number, p17: string?, p18: string?, p19: string?) -- Line: 33
    -- upvalues: u1 (ref)
    if typeof(p13) ~= "Vector3" then
        warn("[DropController] Invalid position received");

        return;
    end;

    if type(p15) ~= "number" or (p15 <= 0 or p15 > 100) then
        warn("[DropController] Invalid count received:", p15);

        return;
    end;

    if type(p16) ~= "number" or p16 < 0 then
        warn("[DropController] Invalid value received:", p16);

        return;
    end;

    if p14 == "Coin" then
        u1.SpawnCoins(p13, p15, p16, p17, p19);

        return;
    end;

    if p14 == "CoinBurst" then
        u1.SpawnCoinBurst(p13, p15);

        return;
    end;

    if p14 == "Gem" then
        u1.SpawnGems(p13, p15, p16, p17, p19);

        return;
    end;

    if p14 == "Crystal" then
        u1.Spawn(p13, {
            Count = p15,
            Value = p16,
            DropType = p14,
            SourceId = p17,
            MaterialId = p18,
            BatchId = p19
        });

        return;
    end;

    if p14 == "Health" then
        u1.Spawn(p13, {
            DropType = "Health",
            Count = p15,
            Value = p16,
            SourceId = p17,
            BatchId = p19
        });

        return;
    end;

    u1.Spawn(p13, {
        Count = p15,
        Value = p16,
        DropType = p14,
        SourceId = p17,
        MaterialId = p18,
        BatchId = p19
    });
end;

return v2;