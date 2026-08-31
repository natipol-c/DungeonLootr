--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     HideUIController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.HideUIController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local v1 = Knit.CreateController({
    Name = "HideUIController",
    _hud = nil,
    _reshowGui = nil,
    _hidden = false,
    _hiddenChildren = nil
});

function v1._ensureReshowButton(u2: table, p3: userdata) -- Line: 41
    local HideUI_Toggle = p3:FindFirstChild("HideUI_Toggle");

    if HideUI_Toggle and HideUI_Toggle:IsA("ScreenGui") then
        u2._reshowGui = HideUI_Toggle;
        local v4 = HideUI_Toggle:FindFirstChild("Show") or HideUI_Toggle:FindFirstChildWhichIsA("GuiButton", true);

        if v4 and v4:IsA("GuiButton") then
            v4.Activated:Connect(function() -- Line: 48
                -- upvalues: u2 (copy)
                u2:_requestShow();
            end);
        end;

        HideUI_Toggle.Enabled = false;

        return;
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "HideUI_Toggle";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 50;
    ScreenGui.Enabled = false;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "Show";
    TextButton.AnchorPoint = Vector2.new(0.5, 0);
    TextButton.Position = UDim2.new(0.5, 0, 0, 8);
    TextButton.Size = UDim2.fromOffset(104, 34);
    TextButton.BackgroundColor3 = Color3.fromRGB(28, 28, 30);
    TextButton.BackgroundTransparency = 0.25;
    TextButton.AutoButtonColor = true;
    TextButton.Text = "Show UI";
    TextButton.TextColor3 = Color3.fromRGB(240, 240, 240);
    TextButton.Font = Enum.Font.GothamMedium;
    TextButton.TextSize = 16;
    TextButton.Parent = ScreenGui;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = TextButton;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(120, 120, 120);
    UIStroke.Transparency = 0.4;
    UIStroke.Thickness = 1;
    UIStroke.Parent = TextButton;
    TextButton.Activated:Connect(function() -- Line: 89
        -- upvalues: u2 (copy)
        u2:_requestShow();
    end);
    ScreenGui.Parent = p3;
    u2._reshowGui = ScreenGui;
end;

function v1._apply(p5: table, p6: boolean) -- Line: 100
    p5._hidden = p6;

    if p5._hud then
        if p6 then
            if not p5._hiddenChildren then
                p5._hiddenChildren = {};

                for _, child in p5._hud:GetChildren() do
                    if child:IsA("GuiObject") and child.Visible then
                        p5._hiddenChildren[child] = true;
                        child.Visible = false;
                    end;
                end;
            end;
        elseif p5._hiddenChildren then
            for i in p5._hiddenChildren do
                if i and i.Parent then
                    i.Visible = true;
                end;
            end;

            p5._hiddenChildren = nil;
        end;
    end;

    if p5._reshowGui then
        p5._reshowGui.Enabled = p6;
    end;
end;

function v1._requestShow(p7) -- Line: 130
    -- upvalues: Knit (copy)
    p7:_apply(false);
    local Controller = Knit.GetController("SoundController");

    if Controller then
        Controller:Play("Click");
    end;

    local Service = Knit.GetService("SettingsService");
    task.spawn(function() -- Line: 137
        -- upvalues: Service (copy)
        Service:SetSetting("HideUI", false):await();
    end);
end;

function v1.KnitStart(u8) -- Line: 142
    -- upvalues: LocalPlayer (copy), Knit (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    u8._hud = PlayerGui:WaitForChild("Main"):WaitForChild("HUD");
    u8:_ensureReshowButton(PlayerGui);
    local Service = Knit.GetService("SettingsService");
    local v9, v9 = Service:GetSettings():await();

    if v9 then
        if v9 then
            v9 = v9.HideUI;
        end;
    end;

    u8:_apply(v9 == true);
    Service.SettingChanged:Connect(function(p10, p11) -- Line: 155
        -- upvalues: u8 (copy)
        if p10 ~= "HideUI" then
            return;
        end;

        u8:_apply(p11 == true);
    end);
end;

return v1;