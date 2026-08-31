--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ContentCreator
  Path:     game.ReplicatedStorage.CmdrClient.Commands.ContentCreator
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "ContentCreator",
    Description = "Content Creator utilities: FreezeTime true/false | NoUI true/false | Freecam",
    Group = "ContentCreator",
    Aliases = { "cc" },
    Args = { {
            Type = "ccAction",
            Name = "Action",
            Description = "FreezeTime | NoUI | Freecam (tab to autocomplete)"
        }, {
            Type = "ccToggle",
            Name = "State",
            Description = "true/false — required for FreezeTime and NoUI, ignored for Freecam",
            Optional = true
        } },

    ClientRun = function(p1: any, p2: string, p3: boolean?) -- Line: 31, Name: ClientRun
        if string.lower(p2 or "") ~= "noui" then
            return nil;
        end;

        if p3 == nil then
            return "Usage: cc NoUI true/false";
        end;

        local LocalPlayer = game:GetService("Players").LocalPlayer;

        if LocalPlayer then
            LocalPlayer = LocalPlayer:FindFirstChildOfClass("PlayerGui");
        end;

        if LocalPlayer then
            LocalPlayer = LocalPlayer:FindFirstChild("Main");
        end;

        if not LocalPlayer then
            return "[cc NoUI] PlayerGui.Main not found.";
        end;

        LocalPlayer.Enabled = not p3;

        return p3 and "[cc NoUI] Main UI hidden." or "[cc NoUI] Main UI restored.";
    end
};