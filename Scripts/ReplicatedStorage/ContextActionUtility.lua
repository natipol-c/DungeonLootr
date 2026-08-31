--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ContextActionUtility
  Path:     game.ReplicatedStorage.ExternalModules.ContextActionUtility
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {};
local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local TouchEnabled = UserInputService.TouchEnabled;
local u2;

if TouchEnabled then
    u2 = PlayerGui:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton");
else
    u2 = nil;
end;

local u3 = {};
local u4 = {
    UDim2.new(-0.4169, 0, 0.715, 0),
    UDim2.new(-0.165, 0, -0.165, 0),
    UDim2.new(0.715, 0, -0.4169, 0),
    UDim2.new(-1.1077, 0, -0.0396, 0),
    UDim2.new(-0.858, 0, -0.858, 0),
    UDim2.new(-0.0396, 0, -1.1077, 0)
};

local function GetNextSlot() -- Line: 153
    -- upvalues: u3 (copy), u4 (copy)
    local v5 = {};

    for _, v in pairs(u3) do
        v5[v.Slot] = true;
    end;

    for i = 1, #u4 do
        if not v5[i] then
            return i;
        end;

        local _ = i;
    end;

    return nil;
end;

local function ConnectButton(u6, u7) -- Line: 170
    -- upvalues: u3 (copy), GuiService (copy)
    local v8 = u3[u6];
    local Button = v8.Button;
    local v9 = v8.Connections or {};
    v9.Begin = Button.InputBegan:Connect(function(p10) -- Line: 175, Name: inputBeganHandler
        -- upvalues: u7 (copy), u6 (copy), Button (copy)
        u7(u6, Enum.UserInputState.Begin, p10);
        Button.ImageColor3 = Button.BorderColor3;
        local title = Button:FindFirstChild("title");

        if title then
            title.TextColor3 = Button.BorderColor3;
        end;
    end);
    v9.Changed = Button.InputChanged:Connect(function(p11) -- Line: 187, Name: inputChangedHandler
        -- upvalues: u7 (copy), u6 (copy)
        u7(u6, Enum.UserInputState.Change, p11);
    end);

    local function inputEndedHandler(p12) -- Line: 193
        -- upvalues: u7 (copy), u6 (copy), Button (copy)
        u7(u6, Enum.UserInputState.End, p12);
        Button.ImageColor3 = Button.BackgroundColor3;
        local title = Button:FindFirstChild("title");

        if title then
            title.TextColor3 = Button.BackgroundColor3;
        end;
    end;

    v9.MenuOpened = GuiService.MenuOpened:Connect(inputEndedHandler);
    v9.End = Button.InputEnded:Connect(inputEndedHandler);
    Button.MouseLeave:Connect(function() -- Line: 206, Name: mouseLeaveHandler
        -- upvalues: Button (copy)
        Button.ImageColor3 = Button.BackgroundColor3;
        local title = Button:FindFirstChild("title");

        if title then
            title.TextColor3 = Button.BackgroundColor3;
        end;
    end);
end;

local function DisconnectButton(p13) -- Line: 216
    -- upvalues: u3 (copy)
    local v14 = u3[p13];

    if not v14.Connections then
        return;
    end;

    for _, v in pairs(v14.Connections) do
        if v then
            v:Disconnect();
        end;
    end;

    v14.Connections = {};
end;

local function newDefaultButton(p15, p16) -- Line: 228
    -- upvalues: u4 (copy)
    local ImageButton = Instance.new("ImageButton");
    ImageButton.Name = p15 .. "Button";
    ImageButton.BackgroundTransparency = 1;
    ImageButton.Size = UDim2.new(0.8, 0, 0.8, 0);
    ImageButton.Image = "rbxassetid://5713982324";
    ImageButton.ImageTransparency = 0.5;
    ImageButton.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    ImageButton.BorderColor3 = Color3.fromRGB(125, 125, 125);
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.5, 0);
    UICorner.Parent = ImageButton;
    ImageButton.Position = u4[p16];

    return ImageButton;
end;

local function BindButton(p17, p18) -- Line: 251
    -- upvalues: u3 (copy), DisconnectButton (copy), GetNextSlot (copy), newDefaultButton (copy), u2 (ref), ConnectButton (copy)
    local v19 = u3[p17];
    local v20, v21;

    if v19 then
        print("is Data");

        if v19.Connections then
            print("is Connections");
            DisconnectButton(p17);
        end;

        if v19.Slot then
            print("is Slot");
            v20 = v19.Slot;
        else
            v20 = GetNextSlot();
        end;

        if v19.Button then
            print("is Button");
            v21 = v19.Button;
            v21.ImageColor3 = v21.BackgroundColor3;
            local title = v21:FindFirstChild("title");

            if title then
                title.TextColor3 = v21.BackgroundColor3;
            end;
        else
            v21 = newDefaultButton(p17, v20);
        end;
    else
        v20 = GetNextSlot();
        v21 = newDefaultButton(p17, v20);
    end;

    v21.Parent = u2;
    u3[p17] = {
        Name = p17,
        Button = v21,
        Slot = v20,
        Connections = {}
    };
    ConnectButton(p17, p18);
end;

local function UnbindButton(p22) -- Line: 292
    -- upvalues: u3 (copy), DisconnectButton (copy)
    local v23 = u3[p22];

    if not v23 then
        return;
    end;

    DisconnectButton(p22);

    if v23.Button then
        v23.Button:Destroy();
    end;

    u3[p22] = nil;
end;

local function DisableButton(p24) -- Line: 305
    -- upvalues: u3 (copy), DisconnectButton (copy)
    local v25 = u3[p24];
    DisconnectButton(p24);
    local Button = v25.Button;
    Button.ImageColor3 = Button.BackgroundColor3;
    local title = Button:FindFirstChild("title");

    if title then
        title.TextColor3 = Button.BackgroundColor3;
    end;
end;

local function FixDefaultJumpButton() -- Line: 318
    -- upvalues: u2 (ref)
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.5, 0);
    UICorner.Parent = u2;
end;

local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(0.5, 0);
UICorner.Parent = u2;
v1.Archivable = ContextActionService.Archivable;
v1.ClassName = ContextActionService.ClassName;
v1.Name = ContextActionService.Name;
v1.Parent = ContextActionService.Parent;
v1.LocalToolEquipped = ContextActionService.LocalToolEquipped;
v1.LocalToolUnequipped = ContextActionService.LocalToolUnequipped;

function v1.BindAction(p26, p27, p28, p29, ...) -- Line: 338
    -- upvalues: ContextActionService (copy), TouchEnabled (copy), BindButton (copy)
    ContextActionService:BindAction(p27, p28, false, ...);

    if p29 and TouchEnabled then
        BindButton(p27, p28);
    end;
end;

function v1.BindActionAtPriority(p30, p31, p32, p33, p34, ...) -- Line: 345
    -- upvalues: ContextActionService (copy), TouchEnabled (copy), BindButton (copy)
    ContextActionService:BindAction(p31, p32, false, p34, ...);

    if p33 and TouchEnabled then
        BindButton(p31, p32);
    end;
end;

function v1.UnbindAction(p35, p36) -- Line: 352
    -- upvalues: ContextActionService (copy), TouchEnabled (copy), u3 (copy), DisconnectButton (copy)
    ContextActionService:UnbindAction(p36);

    if TouchEnabled then
        local v37 = u3[p36];

        if not v37 then
            return;
        end;

        DisconnectButton(p36);

        if v37.Button then
            v37.Button:Destroy();
        end;

        u3[p36] = nil;
    end;
end;

function v1.DisableAction(p38, p39, p40) -- Line: 360
    -- upvalues: ContextActionService (copy), TouchEnabled (copy), u3 (copy), DisconnectButton (copy)
    ContextActionService:UnbindAction(p39);

    if TouchEnabled then
        local v41 = u3[p39];
        DisconnectButton(p39);
        local Button = v41.Button;
        Button.ImageColor3 = Button.BackgroundColor3;
        local title = Button:FindFirstChild("title");

        if title then
            title.TextColor3 = Button.BackgroundColor3;
        end;
    end;
end;

function v1.SetTitle(p42, p43, p44) -- Line: 367
    -- upvalues: u3 (copy)
    local v45 = u3[p43];

    if not v45 then
        return;
    end;

    local Button = v45.Button;

    if not Button then
        return;
    end;

    local title = Button:FindFirstChild("title");

    if not title then
        title = Instance.new("TextLabel");
        title.Name = "title";
        title.AnchorPoint = Vector2.new(0.5, 0.5);
        title.Position = UDim2.new(0.5, 0, 0.5, 0);
        title.BackgroundTransparency = 1;
        title.Size = UDim2.new(0.75, 0, 0.45, 0);
        title.Font = Enum.Font.SourceSansBold;
        title.TextScaled = true;
        title.TextTransparency = 0.5;
        title.TextColor3 = Color3.new(255, 255, 255);
        title.TextXAlignment = Enum.TextXAlignment.Center;
        title.TextYAlignment = Enum.TextYAlignment.Center;
    end;

    title.Visible = true;
    title.Text = p44 or p43;
    title.Parent = Button;
end;

function v1.SetImage(p46, p47, p48) -- Line: 395
    -- upvalues: u3 (copy)
    local v49 = u3[p47];

    if not v49 then
        return;
    end;

    v49.Button.Image = p48;
end;

function v1.SetPressedColor(p50, p51, p52) -- Line: 402
    -- upvalues: u3 (copy)
    local v53 = u3[p51];

    if not v53 then
        return;
    end;

    local Button = v53.Button;

    if not Button then
        return;
    end;

    print("Setting Pressed Color");
    Button.BorderColor3 = p52;
end;

function v1.SetReleasedColor(p54, p55, p56) -- Line: 412
    -- upvalues: u3 (copy)
    local v57 = u3[p55];

    if not v57 then
        return;
    end;

    local Button = v57.Button;

    if not Button then
        return;
    end;

    Button.ImageColor3 = p56;
    Button.BackgroundColor3 = p56;
    local title = Button:FindFirstChild("title");

    if title then
        title.TextColor3 = p56;
    end;
end;

function v1.MakeButtonSquare(p58, p59) -- Line: 426
    -- upvalues: u3 (copy)
    local v60 = u3[p59];

    if not v60 then
        return;
    end;

    local Button = v60.Button;

    if not Button then
        return;
    end;

    local v61 = Button:FindFirstChildOfClass("UICorner");

    if v61 then
        v61.CornerRadius = UDim.new(0, 0);
    end;
end;

function v1.MakeButtonRound(p62, p63, p64) -- Line: 439
    -- upvalues: u3 (copy)
    local v65 = u3[p63];

    if not v65 then
        return;
    end;

    local Button = v65.Button;

    if not Button then
        return;
    end;

    local v66 = Button:FindFirstChildOfClass("UICorner");

    if not v66 then
        Instance.new("UICorner", Button);
    end;

    v66.CornerRadius = UDim.new(p64 or 0.5, 0);
end;

function v1.GetButton(p67, p68) -- Line: 456
    -- upvalues: u3 (copy)
    local v69 = u3[p68];

    if v69 then
        return v69.Button;
    end;

    return nil;
end;

return v1;