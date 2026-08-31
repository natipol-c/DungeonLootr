--[[
  Type:     LocalScript
  Method:   decompile
  Name:     AdminSoundHandler
  Path:     game.StarterPlayer.StarterPlayerScripts.AdminSoundHandler
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:19 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local AdminSoundEvent = ReplicatedStorage.Remotes.AdminSoundEvent;
local u1 = nil;
u1 = Players.PlayerRemoving:Connect(function(p2: userdata, p3: any) -- Line: 17, Name: OnPlayerLeaving
    -- upvalues: LocalPlayer (ref), u1 (ref)
    LocalPlayer = nil;
    u1:Disconnect();
    u1 = nil;
end);

function AdminSoundEvent.OnClientInvoke(p4: userdata, p5: string, p6: any) -- Line: 24
    -- upvalues: LocalPlayer (ref)
    local FullName = p4:GetFullName();
    local v7 = p4:FindFirstChildOfClass("ObjectValue");

    if not v7 then
        return `ObjectValue Not Found In {FullName} For Player: {LocalPlayer}. Likely Scope Mismatch.`;
    end;

    if v7.Value ~= LocalPlayer then
        return `ObjectValue Value In {FullName} Is Not Same As {LocalPlayer}.`;
    end;

    if typeof(p4[p5]) == "function" then
        p4[p5](p4);
    else
        p4[p5] = p6;
    end;

    return `Playing Sound: {FullName} For Player: {LocalPlayer}`;
end;