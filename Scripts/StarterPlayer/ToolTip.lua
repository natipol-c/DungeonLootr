--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ToolTip
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.ToolTip
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local TweenInfo_new_ret = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = 0;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = {};

local function positionAtMouse() -- Line: 46
    -- upvalues: u1 (ref), UserInputService (copy)
    if not u1 then
        return;
    end;

    local MouseLocation = UserInputService:GetMouseLocation();
    u1.Position = UDim2.fromOffset(MouseLocation.X + 18, MouseLocation.Y);
end;

local function stopFollow() -- Line: 52
    -- upvalues: u7 (ref), u8 (ref)
    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;

    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;
end;

local function hideTip(p10) -- Line: 63
    -- upvalues: u4 (ref), u7 (ref), u8 (ref), u5 (ref), u6 (ref), TweenService (copy), u2 (ref), TweenInfo_new_ret2 (copy), u1 (ref)
    if u4 ~= p10 then
        return;
    end;

    u4 = nil;

    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;

    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    local u11 = u5;

    if u6 then
        u6:Cancel();
    end;

    u6 = TweenService:Create(u2, TweenInfo_new_ret2, {
        Scale = 0
    });
    u6:Play();
    u6.Completed:Once(function() -- Line: 75
        -- upvalues: u5 (ref), u11 (copy), u4 (ref), u1 (ref)
        if u5 == u11 and u4 == nil then
            u1.Visible = false;
        end;
    end);
end;

local function showTip(u12) -- Line: 83
    -- upvalues: u1 (ref), u4 (ref), u5 (ref), u3 (ref), UserInputService (copy), u7 (ref), u8 (ref), RunService (copy), positionAtMouse (copy), hideTip (copy), u6 (ref), TweenService (copy), u2 (ref), TweenInfo_new_ret (copy)
    if not u1 then
        return;
    end;

    local Attribute = u12:GetAttribute("Tip");

    if Attribute == nil or Attribute == "" then
        return;
    end;

    u4 = u12;
    u5 = u5 + 1;
    u3.Text = tostring(Attribute);

    if u1 then
        local MouseLocation = UserInputService:GetMouseLocation();
        u1.Position = UDim2.fromOffset(MouseLocation.X + 18, MouseLocation.Y);
    end;

    u1.Visible = true;

    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;

    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    u7 = RunService.RenderStepped:Connect(positionAtMouse);
    u8 = u12:GetAttributeChangedSignal("Tip"):Connect(function() -- Line: 99
        -- upvalues: u4 (ref), u12 (copy), hideTip (ref), u3 (ref)
        if u4 ~= u12 then
            return;
        end;

        local Attribute2 = u12:GetAttribute("Tip");

        if Attribute2 == nil or Attribute2 == "" then
            hideTip(u12);

            return;
        end;

        u3.Text = tostring(Attribute2);
    end);

    if u6 then
        u6:Cancel();
    end;

    u6 = TweenService:Create(u2, TweenInfo_new_ret, {
        Scale = 1
    });
    u6:Play();
end;

local function bindElement(u13) -- Line: 116
    -- upvalues: u9 (copy), showTip (copy), hideTip (copy)
    if not u13:IsA("GuiObject") then
        return;
    end;

    if u9[u13] then
        return;
    end;

    local v14 = {};
    u9[u13] = v14;
    table.insert(v14, u13.MouseEnter:Connect(function() -- Line: 124
        -- upvalues: showTip (ref), u13 (copy)
        showTip(u13);
    end));
    table.insert(v14, u13.MouseLeave:Connect(function() -- Line: 127
        -- upvalues: hideTip (ref), u13 (copy)
        hideTip(u13);
    end));
    table.insert(v14, u13.InputBegan:Connect(function(p15) -- Line: 132
        -- upvalues: showTip (ref), u13 (copy)
        if p15.UserInputType == Enum.UserInputType.Touch then
            showTip(u13);
        end;
    end));
    table.insert(v14, u13.InputEnded:Connect(function(p16) -- Line: 137
        -- upvalues: hideTip (ref), u13 (copy)
        if p16.UserInputType == Enum.UserInputType.Touch then
            hideTip(u13);
        end;
    end));
end;

local function unbindElement(p17) -- Line: 144
    -- upvalues: u9 (copy), hideTip (copy)
    local v18 = u9[p17];

    if v18 then
        for _, v in v18 do
            v:Disconnect();
        end;

        u9[p17] = nil;
    end;

    hideTip(p17);
end;

return function(p19) -- Line: 155
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), CollectionService (copy), bindElement (copy), u9 (copy), hideTip (copy)
    u1 = p19:WaitForChild("ToolTip");
    u2 = u1:WaitForChild("UIScale");
    u3 = u1:WaitForChild("TextLabel");
    u2.Scale = 0;
    u1.Visible = false;
    u1.Active = false;
    u1.Interactable = false;
    CollectionService:GetInstanceAddedSignal("ToolTip"):Connect(function(p20) -- Line: 166
        -- upvalues: bindElement (ref)
        task.defer(bindElement, p20);
    end);
    CollectionService:GetInstanceRemovedSignal("ToolTip"):Connect(function(p21) -- Line: 169
        -- upvalues: u9 (ref), hideTip (ref)
        local v22 = u9[p21];

        if v22 then
            for _, v in v22 do
                v:Disconnect();
            end;

            u9[p21] = nil;
        end;

        hideTip(p21);
    end);

    for _, v in CollectionService:GetTagged("ToolTip") do
        task.defer(bindElement, v);
    end;
end;