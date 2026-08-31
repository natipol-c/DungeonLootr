--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GlobalAnnouncementServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.GlobalAnnouncementServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local MessagingService = game:GetService("MessagingService");
local HttpService = game:GetService("HttpService");

return function(p1, p2) -- Line: 10
    -- upvalues: HttpService (copy), MessagingService (copy)
    local DisplayName = p1.Executor.DisplayName;
    local UserId = p1.Executor.UserId;
    local u3 = HttpService:JSONEncode({
        MessageId = HttpService:GenerateGUID(false),
        Text = p2,
        AnnouncerName = DisplayName,
        AnnouncerUserId = UserId
    });
    task.spawn(function() -- Line: 23
        -- upvalues: MessagingService (ref), u3 (copy)
        local success, result = pcall(function() -- Line: 24
            -- upvalues: MessagingService (ref), u3 (ref)
            MessagingService:PublishAsync("GlobalAnnouncement_V1", u3);
        end);

        if not success then
            warn((`[GlobalAnnouncement] MessagingService publish failed: {result}`));
        end;
    end);

    return "Global announcement sent: " .. p2;
end;