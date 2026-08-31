--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Codes
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Codes
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GroupService = game:GetService("GroupService");
game:GetService("UserInputService");
local CollectionService = game:GetService("CollectionService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local CheckData = require(ReplicatedStorage.GameInfo.CheckData);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local v4 = {};
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = false;
local u10 = nil;

local function PromptGroupJoin() -- Line: 72
    -- upvalues: u2 (ref), GroupService (copy), u10 (ref)
    local v11, u12 = u2:GetGroupId():await();

    if not v11 then
        warn("[Codes] Failed to get group ID:", u12);

        return false;
    end;

    local success, result = pcall(function() -- Line: 79
        -- upvalues: GroupService (ref), u12 (copy)
        return GroupService:PromptJoinAsync(u12);
    end);

    if not success then
        warn("[Codes] PromptJoinAsync failed:", result);

        return false;
    end;

    if result ~= Enum.GroupMembershipStatus.Joined and result ~= Enum.GroupMembershipStatus.AlreadyMember then
        return false;
    end;

    u10 = true;

    return true;
end;

local function EnsureGroupMembership() -- Line: 100
    -- upvalues: u10 (ref), u2 (ref), PromptGroupJoin (copy)
    if u10 == nil then
        local v13, v14 = u2:IsInGroup():await();
        u10 = v13 and v14 and v14 or false;
    end;

    return u10 and true or PromptGroupJoin();
end;

local function SubmitCode() -- Line: 115
    -- upvalues: u9 (ref), u6 (ref), u8 (ref), u10 (ref), u2 (ref), PromptGroupJoin (copy), Knit (copy)
    if u9 then
        return;
    end;

    local Text = u6.Text;

    if Text == "" or string.gsub(Text, "%s+", "") == "" then
        return;
    end;

    u9 = true;

    if u8 then
        u8.Text = "...";
    end;

    if u10 == nil then
        local v15, v16 = u2:IsInGroup():await();
        u10 = v15 and v16 and v16 or false;
    end;

    if not (u10 or PromptGroupJoin()) then
        Knit.GetController("NotificationController"):Show("CODE_REQUIRES_GROUP");
        task.delay(1, function() -- Line: 135
            -- upvalues: u9 (ref), u8 (ref)
            u9 = false;

            if u8 then
                u8.Text = "CLAIM";
            end;
        end);

        return;
    end;

    local v17, v18, v19, v20 = u2:RedeemCode(Text):await();
    local Controller = Knit.GetController("NotificationController");

    if v17 and v18 then
        u6.Text = "";
        Controller:Show("CODE_SUCCESS");
    elseif v17 then
        Controller:Show(v19, v20);
    else
        Controller:Show("CODE_FAILED");
    end;

    task.delay(1, function() -- Line: 160
        -- upvalues: u9 (ref), u8 (ref)
        u9 = false;

        if u8 then
            u8.Text = "CLAIM";
        end;
    end);
end;

local function ApplyCheckRarity(p21: userdata, p22: string?) -- Line: 176
    -- upvalues: RarityGradient (copy)
    local View = p21:FindFirstChild("View");

    if not View then
        return;
    end;

    local v23 = RarityGradient.colorSequence(p22);

    if not v23 then
        return;
    end;

    local ColorFrame = View:FindFirstChild("ColorFrame");

    if ColorFrame then
        ColorFrame = ColorFrame:FindFirstChildOfClass("UIGradient");
    end;

    if ColorFrame then
        ColorFrame.Color = v23;
        ColorFrame.Enabled = true;
    end;

    local StrokeFrame = View:FindFirstChild("StrokeFrame");

    if StrokeFrame then
        StrokeFrame = StrokeFrame:FindFirstChildOfClass("UIStroke");
    end;

    if StrokeFrame then
        StrokeFrame = StrokeFrame:FindFirstChild("RarityGradient");
    end;

    if StrokeFrame and StrokeFrame:IsA("UIGradient") then
        StrokeFrame.Color = v23;
        StrokeFrame.Enabled = true;
    end;
end;

local function RenderCheckClaimed(p24: userdata) -- Line: 201
    local Check = p24:FindFirstChild("Check");

    if not Check then
        return;
    end;

    local Title = Check:FindFirstChild("Title");

    if Title and Title:IsA("TextLabel") then
        Title.Text = "CLAIMED";
    end;

    local ImageLabel = Check:FindFirstChild("ImageLabel");

    if ImageLabel then
        ImageLabel = ImageLabel:FindFirstChild("UIGradient");
    end;

    if ImageLabel and ImageLabel:IsA("UIGradient") then
        ImageLabel.Enabled = false;
    end;
end;

local function SetupChecks(p25: userdata) -- Line: 219
    -- upvalues: u3 (ref), CheckData (copy), CollectionService (copy), ApplyCheckRarity (copy), RenderCheckClaimed (copy), Knit (copy)
    local Check_Holder = p25:FindFirstChild("Check_Holder");

    if not Check_Holder then
        warn("[Codes] Check_Holder not found in Codes.Content");

        return;
    end;

    local u26 = {};

    if u3 then
        local v27, v28 = u3:GetClaimedChecks():await();

        if v27 and type(v28) == "table" then
            for _, v in v28 do
                u26[v] = true;
            end;
        end;
    end;

    for i, v in CheckData.Checks do
        local u29 = Check_Holder:FindFirstChild("Check" .. i);

        if u29 then
            local Username = u29:FindFirstChild("Username");

            if Username and Username:IsA("TextLabel") then
                Username.Text = v.Username or "";
            end;

            local Title = u29:FindFirstChild("Title");

            if Title and Title:IsA("TextLabel") then
                Title.Text = v.Role or "";
            end;

            if v.RewardName then
                u29:SetAttribute("Tip", v.RewardName);

                if not CollectionService:HasTag(u29, "ToolTip") then
                    CollectionService:AddTag(u29, "ToolTip");
                end;
            end;

            local Item = u29:FindFirstChild("Item");

            if Item then
                local ItemImage = Item:FindFirstChild("ItemImage");

                if ItemImage and (ItemImage:IsA("ImageLabel") and v.Image) then
                    ItemImage.Image = v.Image;
                end;

                local View = Item:FindFirstChild("View");
                local v30 = View and View:FindFirstChild("Amount");

                if v30 and v30:IsA("TextLabel") then
                    if v.Amount then
                        v30.Text = "x" .. v.Amount;
                        v30.Visible = true;
                    else
                        v30.Visible = false;
                    end;
                end;

                ApplyCheckRarity(Item, v.Rarity);
            end;

            if u26[i] then
                RenderCheckClaimed(u29);
            end;

            local Check = u29:FindFirstChild("Check");

            if Check and Check:IsA("GuiButton") then
                local u31 = false;
                Check.MouseButton1Click:Connect(function() -- Line: 295
                    -- upvalues: u31 (ref), u26 (copy), i (copy), Knit (ref), u3 (ref), RenderCheckClaimed (ref), u29 (copy), v (copy)
                    if u31 or u26[i] then
                        return;
                    end;

                    u31 = true;
                    local Controller = Knit.GetController("NotificationController");
                    local v32, v33;

                    if u3 then
                        v32, v33 = u3:ClaimCheck(i):await();
                    else
                        v32 = nil;
                        v33 = nil;
                    end;

                    if v32 and v33 == "CLAIMED" then
                        u26[i] = true;
                        RenderCheckClaimed(u29);
                        Controller:Show("CHECK_CLAIMED", v.RewardName);
                    elseif v32 and v33 == "ALREADY" then
                        u26[i] = true;
                        RenderCheckClaimed(u29);
                    else
                        Controller:Show("CHECK_FOLLOW_REQUIRED");
                    end;

                    u31 = false;
                end);
            end;
        end;
    end;
end;

function v4._Init(p34) -- Line: 329
    -- upvalues: u1 (ref), u2 (ref), Knit (copy), u3 (ref), u5 (ref), UIController (copy), SetupChecks (copy), u6 (ref), u7 (ref), u8 (ref), SubmitCode (copy), LocalPlayer (copy)
    u1 = p34;
    u2 = Knit.GetService("CodesService");
    u3 = Knit.GetService("CheckService");
    u5 = u1.Frames:FindFirstChild("Codes");

    if not u5 then
        warn("[Codes] Codes frame not found in hud.Frames");

        return;
    end;

    local u35 = UIController.getByName("Codes") or (UIController._cached[u5] or UIController.new(u5));
    local v36 = u5:FindFirstChild("Exit", true) or u5:FindFirstChild("Close", true);

    if v36 and v36:IsA("GuiButton") then
        v36.MouseButton1Click:Connect(function() -- Line: 367
            -- upvalues: u35 (copy)
            u35:close();
        end);
    else
        warn("[Codes] Exit/Close button not found in Codes frame");
    end;

    local Content = u5:FindFirstChild("Content");

    if not Content then
        warn("[Codes] Content frame not found in Codes");

        return;
    end;

    task.spawn(SetupChecks, Content);
    local Input = Content:FindFirstChild("Input");

    if Input then
        u6 = Input:FindFirstChild("Input");
    end;

    if not u6 then
        warn("[Codes] TextBox not found in Codes.Content.Input");

        return;
    end;

    u7 = Content:FindFirstChild("Claim");

    if u7 then
        u8 = u7:FindFirstChild("Title");
    end;

    if u7 then
        u7.MouseButton1Click:Connect(function() -- Line: 406
            -- upvalues: SubmitCode (ref)
            SubmitCode();
        end);
    else
        warn("[Codes] Submit button not found in Codes.Content.Claim");
    end;

    u6.FocusLost:Connect(function(p37) -- Line: 416
        -- upvalues: SubmitCode (ref)
        if p37 then
            SubmitCode();
        end;
    end);
    u2.CodeRedeemed:Connect(function(p38) -- Line: 425
        print("[Codes] Successfully redeemed:", p38);
    end);
    task.spawn(function() -- Line: 438
        -- upvalues: LocalPlayer (ref), u35 (copy)
        local Settings = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Settings", 30);

        if not Settings then
            return;
        end;

        local Main = Settings:WaitForChild("Main", 10);

        if Main then
            Main = Main:FindFirstChild("Options");
        end;

        if Main then
            Main = Main:FindFirstChild("Codes");
        end;

        if Main and Main:IsA("GuiButton") then
            Main.Activated:Connect(function() -- Line: 446
                -- upvalues: u35 (ref)
                u35:open();
            end);

            return;
        end;

        warn("[Codes] Settings.Main.Options.Codes button not found");
    end);
    print("[Codes] Client controller initialized");
end;

return v4;