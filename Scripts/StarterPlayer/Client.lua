--[[
  Type:     LocalScript
  Method:   decompile
  Name:     Client
  Path:     game.StarterPlayer.StarterPlayerScripts.Client
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:12 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local Packages = ReplicatedStorage.Packages;
local script_Controllers = script.Controllers;
local script_UI = script.UI;
local LocalPlayer = Players.LocalPlayer;
require(script.Gameplay.Actions);
require(script_Controllers.InputController);
local Registry = require(script_Controllers.Registry);
local Replica = require(Packages.Replica);
local Knit = require(Packages.Knit);
local success, result = pcall(function() -- Line: 28
    -- upvalues: ReplicatedStorage (copy)
    require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ForgeVFXUtil")).Init();
end);

if not success then
    warn((`[Client Init] ForgeVFX init failed: {result}`));
end;

Replica.OnNew(`Save_{LocalPlayer.UserId}`, function(p1) -- Line: 36
    -- upvalues: Registry (copy)
    Registry:Register("PlayerData", p1);
end);
Replica.RequestData();

repeat
    task.wait(0.1);
until Registry:Get("PlayerData") ~= nil;

Knit.PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
Knit.Registry = Registry;
Knit.AddControllersDeep(script_Controllers);
Knit.Start():andThen(function() -- Line: 51
    -- upvalues: script_UI (copy), Knit (copy), Registry (copy), UserInputService (copy), ReplicatedStorage (copy), LocalPlayer (copy)
    for _, child in script_UI:GetChildren() do
        if child:IsA("ModuleScript") then
            local v2 = require(child);

            if v2 and v2._Init then
                task.spawn(v2._Init, Knit.PlayerGui.Main);
            end;
        end;
    end;

    local v3 = 0;

    for _, child in script.Components:GetChildren() do
        if child:IsA("ModuleScript") then
            local v4 = require(child);

            if v4 then
                local task_spawn_ret, v5 = task.spawn(v4, Knit.PlayerGui.Main, Registry:Get("PlayerData"));

                if not task_spawn_ret then
                    warn((`[Client Init] Component {child.Name} failed: {v5}`));
                    v3 = v3 + 1;
                end;
            else
                warn((`[Client Init] Component {child.Name} returned nil`));
                v3 = v3 + 1;
            end;
        end;
    end;

    if v3 > 0 then
        warn((`[Client Init] Failed to load {v3} component(s)`));
    else
        print("[Client Init] All components loaded.");
    end;

    UserInputService.InputBegan:Connect(function(p6) -- Line: 84
    end);
    local CmdrClient = require(ReplicatedStorage:WaitForChild("CmdrClient"));
    CmdrClient:SetEnabled(false);
    CmdrClient:SetActivationKeys({ Enum.KeyCode.F2 });
    local u7;

    if UserInputService.TouchEnabled then
        u7 = Knit.PlayerGui:WaitForChild("CmdrMobile", 10);

        if u7 then
            u7.ResetOnSpawn = false;
            local Frame = u7:WaitForChild("Frame", 5);

            if Frame then
                Frame = Frame:WaitForChild("ImageButton", 5);
            end;

            if Frame then
                Frame.Activated:Connect(function() -- Line: 114
                    -- upvalues: CmdrClient (copy)
                    CmdrClient:Toggle();
                end);
            else
                warn("[Client Init] CmdrMobile.Frame.ImageButton missing; mobile console button disabled.");
            end;
        else
            warn("[Client Init] CmdrMobile GUI not found in PlayerGui; mobile console button disabled.");
        end;
    else
        u7 = nil;
    end;

    local function applyCmdrAccess() -- Line: 125
        -- upvalues: LocalPlayer (ref), CmdrClient (copy), u7 (ref)
        local v8 = LocalPlayer:GetAttribute("CmdrEnabled") == true;
        CmdrClient:SetEnabled(v8);

        if u7 then
            u7.Enabled = v8;
        end;
    end;

    local v9 = LocalPlayer:GetAttribute("CmdrEnabled") == true;
    CmdrClient:SetEnabled(v9);

    if u7 then
        u7.Enabled = v9;
    end;

    LocalPlayer:GetAttributeChangedSignal("CmdrEnabled"):Connect(applyCmdrAccess);
end);