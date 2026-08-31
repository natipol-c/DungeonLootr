--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AreaWarpController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.AreaWarpController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LoadingOverlay = require(ReplicatedStorage.ClientTools.LoadingOverlay);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;
local v6 = Knit.CreateController({
    Name = "AreaWarpController"
});

local function applyWarpVisibility() -- Line: 90
    -- upvalues: u4 (ref), u5 (ref)
    if not u4 then
        return;
    end;

    for _, child in u4:GetChildren() do
        if child:IsA("BillboardGui") then
            child.Enabled = not u5;
        end;
    end;
end;

local function getDestinationPart(p7: string) -- Line: 102
    -- upvalues: u3 (ref)
    local v8 = u3 and u3:FindFirstChild(p7);

    if v8 and v8:IsA("BasePart") then
        return v8;
    end;

    return nil;
end;

local function waitForAreaPart(p9: string) -- Line: 109
    -- upvalues: u3 (ref)
    if not u3 then
        return nil;
    end;

    local v10 = u3:WaitForChild(p9, 5);

    if v10 and v10:IsA("BasePart") then
        return v10;
    end;

    return nil;
end;

local function warpTo(p11: userdata) -- Line: 116
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    HumanoidRootPart.CFrame = p11.CFrame + Vector3.new(0, 3, 0);
end;

local function warpToArea(p12: string) -- Line: 131
    -- upvalues: u3 (ref), LoadingOverlay (copy), LocalPlayer (copy)
    local u13 = u3 and u3:FindFirstChild(p12);

    if not (u13 and u13:IsA("BasePart")) then
        u13 = nil;
    end;

    if u13 then
        LoadingOverlay.Run({
            StatusText = "Moving",

            Action = function() -- Line: 140, Name: Action
                -- upvalues: u13 (copy), LocalPlayer (ref)
                local Character = LocalPlayer.Character;

                if not Character then
                    return;
                end;

                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

                if not HumanoidRootPart then
                    return;
                end;

                HumanoidRootPart.CFrame = u13.CFrame + Vector3.new(0, 3, 0);
            end
        });

        return;
    end;

    warn("[AreaWarpController] No destination part for area:", p12);
end;

function v6.WarpToArea(p14: table, p15: string) -- Line: 151
    -- upvalues: warpToArea (copy)
    warpToArea(p15);
end;

local function wireBillboard(u16: userdata) -- Line: 155
    -- upvalues: u3 (ref), u1 (copy), warpToArea (copy)
    if not u16:IsA("BillboardGui") then
        return;
    end;

    local Frame = u16:FindFirstChild("Frame");

    if not Frame then
        warn("[AreaWarpController] Billboard missing Frame:", u16.Name);

        return;
    end;

    local ImageButton = Frame:FindFirstChild("ImageButton");

    if not (ImageButton and ImageButton:IsA("ImageButton")) then
        warn("[AreaWarpController] Billboard missing ImageButton:", u16.Name);

        return;
    end;

    local u17 = ImageButton:FindFirstChildOfClass("UIGradient");
    local TextLabel = Frame:FindFirstChild("TextLabel");
    local v18;

    if TextLabel then
        v18 = TextLabel:FindFirstChildOfClass("UIStroke");
    else
        v18 = TextLabel;
    end;

    local Adornee = u16.Adornee;

    if not (Adornee and (Adornee:IsA("BasePart") and Adornee)) then
        local Name = u16.Name;

        if u3 then
            Adornee = u3:WaitForChild(Name, 5);

            if not (Adornee and Adornee:IsA("BasePart")) then
                Adornee = nil;
            end;
        else
            Adornee = nil;
        end;
    end;

    if Adornee then
        if not u16.Adornee then
            u16.Adornee = Adornee;
        end;

        table.insert(u1, {
            button = ImageButton,
            textLabel = TextLabel,
            stroke = v18,
            part = Adornee
        });
    else
        warn("[AreaWarpController] No Adornee/part for distance fade:", u16.Name);
    end;

    ImageButton.MouseEnter:Connect(function() -- Line: 195
        -- upvalues: u17 (copy)
        if u17 then
            u17.Enabled = false;
        end;
    end);
    ImageButton.MouseLeave:Connect(function() -- Line: 198
        -- upvalues: u17 (copy)
        if u17 then
            u17.Enabled = true;
        end;
    end);
    ImageButton.Activated:Connect(function() -- Line: 203
        -- upvalues: warpToArea (ref), u16 (copy)
        warpToArea(u16.Name);
    end);
end;

local function wireHudPlayButton() -- Line: 236
    -- upvalues: Knit (copy), UserInputService (copy), ReplicatedStorage (copy), warpToArea (copy)
    local Main = Knit.PlayerGui:WaitForChild("Main", 10);

    if Main then
        Main = Main:WaitForChild("HUD", 10);
    end;

    if Main then
        Main = Main:WaitForChild("Play", 10);
    end;

    if not (Main and Main:IsA("ImageButton")) then
        warn("[AreaWarpController] Main.HUD.Play button not found");

        return;
    end;

    if UserInputService.TouchEnabled then
        local Attribute = Main:GetAttribute("Mobile_Position");

        if typeof(Attribute) == "UDim2" then
            Main.Position = Attribute;
        else
            warn("[AreaWarpController] Main.HUD.Play missing UDim2 \'Mobile_Position\' attribute");
        end;
    end;

    if ReplicatedStorage:GetAttribute("IsDungeon") ~= true then
        Main.Activated:Connect(function() -- Line: 269
            -- upvalues: warpToArea (ref)
            warpToArea("Play");
        end);
    end;
end;

local function updateFades() -- Line: 281
    -- upvalues: u5 (ref), LocalPlayer (copy), u1 (copy)
    if u5 then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local Position = Character.Position;

    for _, v in u1 do
        local part = v.part;

        if part and part.Parent then
            local math_clamp_ret = math.clamp((40 - (Position - part.Position).Magnitude) / 10, 0, 1);
            v.button.ImageTransparency = math_clamp_ret;

            if v.textLabel then
                v.textLabel.TextTransparency = math_clamp_ret;
            end;

            if v.stroke then
                v.stroke.Transparency = math_clamp_ret;
            end;
        end;
    end;
end;

function v6.KnitInit(p19) -- Line: 303
end;

function v6.KnitStart(p20) -- Line: 305
    -- upvalues: wireHudPlayButton (copy), ReplicatedStorage (copy), u3 (ref), u4 (ref), Knit (copy), wireBillboard (copy), u5 (ref), u2 (ref), RunService (copy), updateFades (copy), applyWarpVisibility (copy)
    wireHudPlayButton();

    if ReplicatedStorage:GetAttribute("IsDungeon") == true then
        return;
    end;

    u3 = workspace:WaitForChild("Areas"):WaitForChild("Areas_Model");
    u4 = Knit.PlayerGui:WaitForChild("Areas");

    for _, child in u4:GetChildren() do
        wireBillboard(child);
    end;

    u4.ChildAdded:Connect(function(p21) -- Line: 336
        -- upvalues: wireBillboard (ref), u5 (ref)
        wireBillboard(p21);

        if p21:IsA("BillboardGui") then
            p21.Enabled = not u5;
        end;
    end);
    u2 = RunService.Heartbeat:Connect(updateFades);
    local Service = Knit.GetService("SettingsService");
    local v22, v23 = Service:GetSettings():await();

    if v22 and (v23 and v23.DisableAreaWarp) then
        u5 = true;
    end;

    applyWarpVisibility();
    Service.SettingChanged:Connect(function(p24, p25) -- Line: 357
        -- upvalues: u5 (ref), applyWarpVisibility (ref)
        if p24 ~= "DisableAreaWarp" then
            return;
        end;

        u5 = p25 == true;
        applyWarpVisibility();
    end);
end;

return v6;