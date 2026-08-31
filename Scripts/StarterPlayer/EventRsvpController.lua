--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EventRsvpController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.EventRsvpController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SocialService = game:GetService("SocialService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "EventRsvpController"
});
local u2 = false;

local function handlePrompt(u3: string) -- Line: 29
    -- upvalues: u2 (ref), SocialService (copy)
    if u2 then
        return;
    end;

    if type(u3) ~= "string" or u3 == "" then
        return;
    end;

    u2 = true;
    local success, result = pcall(function() -- Line: 38
        -- upvalues: SocialService (ref), u3 (copy)
        return SocialService:GetEventRsvpStatusAsync(u3);
    end);

    if success and result == Enum.RsvpStatus.Going then
        u2 = false;

        return;
    end;

    local success2, result2 = pcall(function() -- Line: 46
        -- upvalues: SocialService (ref), u3 (copy)
        SocialService:PromptRsvpToEventAsync(u3);
    end);

    if not success2 then
        warn((`[EventRsvpController] PromptRsvpToEventAsync failed for "{u3}": {result2}`));
    end;

    u2 = false;
end;

function v1.KnitStart(p4) -- Line: 56
    -- upvalues: Knit (copy), handlePrompt (copy)
    local success, result = pcall(Knit.GetService, "EventRsvpService");

    if success and (result and result.PromptRsvp) then
        result.PromptRsvp:Connect(handlePrompt);

        return;
    end;

    warn("[EventRsvpController] EventRsvpService.PromptRsvp unavailable — RSVP prompts disabled");
end;

return v1;