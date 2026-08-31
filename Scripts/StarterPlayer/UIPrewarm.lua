--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UIPrewarm
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.UIPrewarm
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlaceConfig = require(ReplicatedStorage.GameInfo.PlaceConfig);
local v1 = {};

local function isDungeon() -- Line: 34
    -- upvalues: ReplicatedStorage (copy), PlaceConfig (copy)
    return ReplicatedStorage:GetAttribute("IsDungeon") == true and true or PlaceConfig.IsDungeonPlace;
end;

function v1._Init(p2) -- Line: 38
    -- upvalues: ReplicatedStorage (copy), PlaceConfig (copy)
    if ReplicatedStorage:GetAttribute("IsDungeon") == true and true or PlaceConfig.IsDungeonPlace then
        return;
    end;

    local Frames = p2:FindFirstChild("Frames");

    if not Frames then
        return;
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "_UIPrewarm";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = -1;
    ScreenGui.Enabled = true;
    ScreenGui.Parent = p2.Parent;

    for _, child in Frames:GetChildren() do
        if child:IsA("GuiObject") then
            local v3 = child:Clone();
            v3.Visible = true;
            local Position = v3.Position;
            v3.Position = UDim2.new(Position.X.Scale + 3, Position.X.Offset, Position.Y.Scale + 3, Position.Y.Offset);
            v3.Parent = ScreenGui;
        end;
    end;

    task.wait(1.5);
    ScreenGui:Destroy();
end;

return v1;