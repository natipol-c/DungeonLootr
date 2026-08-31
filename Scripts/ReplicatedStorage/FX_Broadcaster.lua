--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     FX_Broadcaster
  Path:     game.ReplicatedStorage.Globals.Modules.FX_Broadcaster
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};

local function getRemote() -- Line: 22
    -- upvalues: ReplicatedStorage (copy)
    local Player = ReplicatedStorage:FindFirstChild("Player");

    if Player then
        Player = Player:FindFirstChild("Remotes");
    end;

    if Player then
        Player = Player:FindFirstChild("FX");
    end;

    return Player;
end;

function v1.Fire(p2: userdata, p3: string, p4: string, p5: string) -- Line: 29
    -- upvalues: ReplicatedStorage (copy)
    if not p2 then
        return;
    end;

    local Player = ReplicatedStorage:FindFirstChild("Player");

    if Player then
        Player = Player:FindFirstChild("Remotes");
    end;

    if Player then
        Player = Player:FindFirstChild("FX");
    end;

    if Player then
        Player:FireAllClients(p2, p3, p4, p5);
    end;
end;

function v1.SetLoop(p6: userdata, p7: string, p8: string, p9: string, p10: boolean) -- Line: 39
    -- upvalues: ReplicatedStorage (copy)
    if not p6 then
        return;
    end;

    p6:SetAttribute("FXLoop_" .. p9, p10 or nil);
    local Player = ReplicatedStorage:FindFirstChild("Player");

    if Player then
        Player = Player:FindFirstChild("Remotes");
    end;

    if Player then
        Player = Player:FindFirstChild("FX");
    end;

    if Player then
        Player:FireAllClients(p6, p7, p8, p9, p10);
    end;
end;

return v1;