--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     announceServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.Admin.announceServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local TextService = game:GetService("TextService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Knit = require(game.ReplicatedStorage.Packages.Knit);

return function(u1, u2) -- Line: 6
    -- upvalues: RunService (copy), TextService (copy), Players (copy), Knit (copy)
    if not RunService:IsStudio() then
        local success, result = pcall(function() -- Line: 10
            -- upvalues: TextService (ref), u2 (copy), u1 (copy)
            return TextService:FilterStringAsync(u2, u1.Executor.UserId, Enum.TextFilterContext.PublicChat);
        end);

        if success then
            u2 = result:GetNonChatStringForBroadcastAsync();
        end;
    end;

    local DisplayName = u1.Executor.DisplayName;
    local UserId = u1.Executor.UserId;

    for _, v in ipairs(Players:GetPlayers()) do
        Knit.GetService("NotificationService"):SendMessageToPlr(v, "ANNOUNCEMENT", u2, DisplayName, UserId);
    end;

    return "Announcement sent: " .. u2;
end;