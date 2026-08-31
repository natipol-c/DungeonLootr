--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     MenuHotkeyController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.MenuHotkeyController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local Packages = ReplicatedStorage:WaitForChild("Packages");
local Knit = require(Packages:WaitForChild("Knit"));
local UIController = require(script.Parent.UIController);
local v1 = Knit.CreateController({
    Name = "MenuHotkeyController"
});
local u2 = {
    Inventory = "Inventory",
    ClassMenu = "Class"
};
local u3 = {
    Inventory = true,
    Class = true
};

function v1.KnitStart(p4) -- Line: 62
    -- upvalues: Knit (copy), UserInputService (copy), Players (copy), u2 (copy), u3 (copy), ReplicatedStorage (copy), UIController (copy)
    local Controller = Knit.GetController("InputBindingController");
    UserInputService.InputBegan:Connect(function(p5, p6) -- Line: 65
        -- upvalues: Players (ref), Controller (copy), Knit (ref), u2 (ref), u3 (ref), ReplicatedStorage (ref), UIController (ref)
        if p6 and (Players.LocalPlayer:GetAttribute("OpenWindow") or not Controller:CompletesAnyCombo(p5)) then
            return;
        end;

        local ActionForInput = Controller:GetActionForInput(p5);

        if not ActionForInput then
            return;
        end;

        if ActionForInput == "SettingsMenu" then
            local Controller2 = Knit.GetController("SettingsController");

            if Controller2 then
                Controller2:ToggleSettings();
            end;

            return;
        end;

        local v7 = u2[ActionForInput];

        if not v7 then
            return;
        end;

        if u3[v7] and ReplicatedStorage:GetAttribute("IsDungeon") == true then
            return;
        end;

        local ByName = UIController.getByName(v7);

        if ByName then
            ByName:toggle();
        end;
    end);
end;

return v1;