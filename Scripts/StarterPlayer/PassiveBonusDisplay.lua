--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PassiveBonusDisplay
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.PassiveBonusDisplay
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local GameInfo = game:GetService("ReplicatedStorage"):WaitForChild("GameInfo");
local PassiveBonusData = require(GameInfo:WaitForChild("PassiveBonusData"));
local spr = require(script.Parent.Parent.ClientUtils.spr);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = {};

local function CreateEntry(p6: string, p7: table) -- Line: 38
    -- upvalues: PassiveBonusData (copy), u5 (copy), u4 (ref), spr (copy), u3 (ref)
    local v8 = PassiveBonusData.Get(p6);

    if not v8 then
        return;
    end;

    local v9 = u5[p6];

    if v9 and v9.frame then
        v9.frame:Destroy();
    end;

    local v10 = u4:Clone();
    v10.Name = p6;
    v10.LayoutOrder = v8.LayoutOrder or 0;
    v10.Visible = true;
    local ItemImage = v10:FindFirstChild("ItemImage");

    if ItemImage and (v8.Icon and (v8.Icon ~= "" and v8.Icon ~= "rbxassetid://0")) then
        ItemImage.Image = v8.Icon;
    end;

    local TimeText = v10:FindFirstChild("TimeText");

    if TimeText then
        TimeText.Text = v8.FormatDisplay and (v8.FormatDisplay(p7) or "") or "";
    end;

    local Button = v10:FindFirstChild("Button");
    local Frame = v10:FindFirstChild("Frame");

    if Frame and Button then
        local Attribute = Frame:GetAttribute("Full_Size");
        local Info_Text = Frame:FindFirstChild("Info_Text");

        if Info_Text then
            Info_Text.Text = v8.Description or "";
        end;

        local Time_Left = Frame:FindFirstChild("Time_Left");

        if Time_Left then
            Time_Left.Text = v8.FormatDetail and v8.FormatDetail(p7) or "";
        end;

        Frame.Size = UDim2.new(0, 0, 0, 0);
        Frame.Visible = false;
        local u11 = 0;
        local u12 = false;
        Button.MouseEnter:Connect(function() -- Line: 92
            -- upvalues: u12 (ref), u11 (ref), Frame (copy), Attribute (copy), spr (ref)
            u12 = true;
            u11 = u11 + 1;
            Frame.Visible = true;

            if Attribute then
                spr.target(Frame, 0.6, 3, {
                    Size = Attribute
                });
            end;
        end);
        Button.MouseLeave:Connect(function() -- Line: 103
            -- upvalues: u12 (ref), u11 (ref), Attribute (copy), spr (ref), Frame (copy)
            u12 = false;
            u11 = u11 + 1;
            local u13 = u11;

            if Attribute then
                spr.target(Frame, 0.6, 3, {
                    Size = UDim2.new(0, 0, 0, 0)
                });
            end;

            task.delay(0.5, function() -- Line: 113
                -- upvalues: u13 (copy), u11 (ref), u12 (ref), Frame (ref)
                if u13 ~= u11 or u12 then
                    return;
                end;

                if Frame and Frame.Size.X.Offset < 2 then
                    Frame.Visible = false;
                end;
            end);
        end);
    end;

    v10.Parent = u3;
    u5[p6] = {
        frame = v10,
        id = p6
    };
end;

local function RemoveEntry(p14: string) -- Line: 132
    -- upvalues: u5 (copy)
    local v15 = u5[p14];

    if v15 then
        if v15.frame then
            v15.frame:Destroy();
        end;

        u5[p14] = nil;
    end;
end;

local function UpdateEntry(p16: string, p17: table) -- Line: 143
    -- upvalues: PassiveBonusData (copy), u5 (copy)
    local v18 = PassiveBonusData.Get(p16);
    local v19 = u5[p16];

    if not (v18 and (v19 and v19.frame)) then
        return;
    end;

    local TimeText = v19.frame:FindFirstChild("TimeText");

    if TimeText then
        TimeText.Text = v18.FormatDisplay and (v18.FormatDisplay(p17) or "") or "";
    end;

    local Frame = v19.frame:FindFirstChild("Frame");
    local v20 = Frame and Frame:FindFirstChild("Time_Left");

    if v20 then
        v20.Text = v18.FormatDetail and v18.FormatDetail(p17) or "";
    end;
end;

local function Rebuild() -- Line: 163
    -- upvalues: u2 (ref), u5 (copy), UpdateEntry (copy), CreateEntry (copy)
    local v21 = u2.Data.PassiveBonuses or {};

    for i, v in v21 do
        if u5[i] then
            UpdateEntry(i, v);
        else
            CreateEntry(i, v);
        end;
    end;

    for i in u5 do
        if not v21[i] then
            local v22 = u5[i];

            if v22 then
                if v22.frame then
                    v22.frame:Destroy();
                end;

                u5[i] = nil;
            end;
        end;
    end;
end;

function v1._Init(p23) -- Line: 186
    -- upvalues: u3 (ref), u4 (ref), u2 (ref), Registry (copy), Rebuild (copy)
    u3 = p23.HUD:FindFirstChild("PassiveBonuses");

    if not u3 then
        warn("[PassiveBonusDisplay] HUD.PassiveBonuses frame not found");

        return;
    end;

    u4 = u3:FindFirstChild("Template");

    if not u4 then
        warn("[PassiveBonusDisplay] HUD.PassiveBonuses.Template not found");

        return;
    end;

    u4.Visible = false;
    u2 = Registry:Get("PlayerData");
    u2:OnChange(function(p24, p25) -- Line: 204
        -- upvalues: Rebuild (ref)
        if p25[1] == "PassiveBonuses" then
            Rebuild();
        end;
    end);
    Rebuild();
end;

function v1.Destroy() -- Line: 216
    -- upvalues: u5 (copy)
    for i in u5 do
        local v26 = u5[i];

        if v26 then
            if v26.frame then
                v26.frame:Destroy();
            end;

            u5[i] = nil;
        end;
    end;

    table.clear(u5);
end;

return v1;