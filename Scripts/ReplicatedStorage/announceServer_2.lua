--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     announceServer
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Admin.announceServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

local TextService = game:GetService("TextService");
local Players = game:GetService("Players");
local Chat = game:GetService("Chat");

return function(p1, p2) -- Line: 5
    -- upvalues: TextService (copy), Players (copy), Chat (copy)
    local v3 = TextService:FilterStringAsync(p2, p1.Executor.UserId, Enum.TextFilterContext.PublicChat);

    for _, v in ipairs(Players:GetPlayers()) do
        if Chat:CanUsersChatAsync(p1.Executor.UserId, v.UserId) then
            p1:SendEvent(v, "Message", v3:GetChatForUserAsync(v.UserId), p1.Executor);
        end;
    end;

    return "Created announcement.";
end;