--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PatchNotes
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.PatchNotes
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local PatchNoteData = require(ReplicatedStorage.GameInfo.PatchNoteData);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local UIController = require(script.Parent.Parent.Controllers.UIController);
local RevealCascade = require(script.Parent.Parent.ClientUtils.RevealCascade);
local RewardCardRender = require(script.Parent.Parent.ClientUtils.RewardCardRender);
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = {};
local u18 = {};
local u19 = 0;
local u20 = nil;
local u21 = {};
local u22 = 0;
local u23 = nil;

local function GetService() -- Line: 76
    -- upvalues: u4 (ref), Knit (copy)
    if not u4 then
        u4 = Knit.GetService("PatchNotesService");
    end;

    return u4;
end;

local function IsClaimed(p24) -- Line: 84
    -- upvalues: u3 (ref)
    local v25 = u3 and u3.Data.ClaimedPatchNotes;
    local v26;

    if v25 == nil then
        v26 = false;
    else
        v26 = v25[p24] == true;
    end;

    return v26;
end;

local function SetButtonActive(p27, p28) -- Line: 90
    for _, v in { "Background", "Outline" } do
        local v29 = p27:FindFirstChild(v);

        if v29 then
            local Active = v29:FindFirstChild("Active");
            local Inactive = v29:FindFirstChild("Inactive");

            if Active then
                Active.Enabled = p28;
            end;

            if Inactive then
                Inactive.Enabled = not p28;
            end;
        end;
    end;
end;

local function RefreshClaimState() -- Line: 103
    -- upvalues: u20 (ref), PatchNoteData (copy), u15 (ref), u16 (ref), u3 (ref), SetButtonActive (copy), u21 (copy)
    if not (u20 and PatchNoteData.HasRewards(u20)) then
        u15.Visible = false;
        u16.Visible = false;

        return;
    end;

    local Id = u20.Id;
    local v30 = u3 and u3.Data.ClaimedPatchNotes;
    local v31;

    if v30 == nil then
        v31 = false;
    else
        v31 = v30[Id] == true;
    end;

    if v31 then
        u15.Visible = false;
        u16.Visible = true;
        SetButtonActive(u16, true);

        return;
    end;

    u16.Visible = false;
    u15.Visible = true;
    SetButtonActive(u15, u21[u20.Id] == true);
end;

local function MarkRead(p32) -- Line: 122
    -- upvalues: u21 (copy), u20 (ref), RefreshClaimState (copy)
    if u21[p32] then
        return;
    end;

    u21[p32] = true;

    if u20 and u20.Id == p32 then
        RefreshClaimState();
    end;
end;

local function ClearScrollWatch() -- Line: 131
    -- upvalues: u23 (ref)
    if u23 then
        u23:Disconnect();
        u23 = nil;
    end;
end;

local function AtBottom() -- Line: 139
    -- upvalues: u11 (ref)
    return u11.CanvasPosition.Y >= u11.AbsoluteCanvasSize.Y - u11.AbsoluteWindowSize.Y - 4;
end;

local function BodyFits() -- Line: 145
    -- upvalues: u11 (ref)
    return u11.AbsoluteCanvasSize.Y <= u11.AbsoluteWindowSize.Y + 4;
end;

local function BeginReadGate(p33) -- Line: 150
    -- upvalues: u23 (ref), u22 (ref), u21 (copy), u3 (ref), PatchNoteData (copy), RunService (copy), u11 (ref), u20 (ref), RefreshClaimState (copy)
    if u23 then
        u23:Disconnect();
        u23 = nil;
    end;

    u22 = u22 + 1;
    local u34 = u22;
    local Id = p33.Id;

    if not u21[Id] then
        local v35 = u3 and u3.Data.ClaimedPatchNotes;
        local v36;

        if v35 == nil then
            v36 = false;
        else
            v36 = v35[Id] == true;
        end;

        if not v36 and PatchNoteData.HasRewards(p33) then
            task.spawn(function() -- Line: 160
                -- upvalues: RunService (ref), u22 (ref), u34 (copy), u11 (ref), Id (copy), u21 (ref), u20 (ref), RefreshClaimState (ref), u23 (ref)
                RunService.Heartbeat:Wait();
                RunService.Heartbeat:Wait();

                if u22 ~= u34 then
                    return;
                end;

                if u11.AbsoluteCanvasSize.Y > u11.AbsoluteWindowSize.Y + 4 then
                    local u37 = false;
                    u23 = u11:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 172
                        -- upvalues: u22 (ref), u34 (ref), u11 (ref), u37 (ref), Id (ref), u21 (ref), u20 (ref), RefreshClaimState (ref), u23 (ref)
                        if u22 ~= u34 then
                            return;
                        end;

                        if u11.CanvasPosition.Y >= u11.AbsoluteCanvasSize.Y - u11.AbsoluteWindowSize.Y - 4 then
                            if not u37 then
                                u37 = true;
                                task.delay(2, function() -- Line: 177
                                    -- upvalues: u22 (ref), u34 (ref), u11 (ref), Id (ref), u21 (ref), u20 (ref), RefreshClaimState (ref), u23 (ref), u37 (ref)
                                    if u22 == u34 and u11.CanvasPosition.Y >= u11.AbsoluteCanvasSize.Y - u11.AbsoluteWindowSize.Y - 4 then
                                        local v38 = Id;

                                        if not u21[v38] then
                                            u21[v38] = true;

                                            if u20 and u20.Id == v38 then
                                                RefreshClaimState();
                                            end;
                                        end;

                                        if u23 then
                                            u23:Disconnect();
                                            u23 = nil;
                                        end;
                                    else
                                        u37 = false;
                                    end;
                                end);
                            end;
                        else
                            u37 = false;
                        end;
                    end);

                    return;
                end;

                local v39 = Id;

                if u21[v39] then
                    return;
                end;

                u21[v39] = true;

                if u20 and u20.Id == v39 then
                    RefreshClaimState();
                end;
            end);
        end;
    end;
end;

local function BuildRewardCards(p40) -- Line: 194
    -- upvalues: u18 (copy), u13 (ref), RewardCardRender (copy), u14 (ref)
    for _, v in u18 do
        v:Destroy();
    end;

    table.clear(u18);
    local v41 = p40.Rewards or {};
    u13.Visible = #v41 > 0;

    for _, v in v41 do
        if RewardCardRender.isRenderable(v) then
            local v42 = u14:Clone();
            v42.Name = "Reward";
            v42.Visible = true;

            for _, v2 in { "Lock_Image", "Delete_Cover", "Item_Level" } do
                local v43 = v42:FindFirstChild(v2);

                if v43 then
                    v43.Visible = false;
                end;
            end;

            local Selection_Button = v42:FindFirstChild("Selection_Button");

            if Selection_Button then
                Selection_Button.Active = false;
                Selection_Button.Visible = false;
            end;

            RewardCardRender.populateRewardCard(v42, v);
            v42.Parent = u13;
            table.insert(u18, v42);
        end;
    end;
end;

local function UpdateSelectedHighlight() -- Line: 228
    -- upvalues: u17 (copy), u20 (ref)
    for i, v in u17 do
        local Container = v:FindFirstChild("Container");

        if Container then
            Container = Container:FindFirstChild("Selected");
        end;

        if Container then
            local v44;

            if u20 == nil then
                v44 = false;
            else
                v44 = i == u20.Id;
            end;

            Container.Visible = v44;
        end;
    end;
end;

local function SelectNote(p45) -- Line: 238
    -- upvalues: u20 (ref), u9 (ref), u10 (ref), u12 (ref), u11 (ref), BuildRewardCards (copy), UpdateSelectedHighlight (copy), RefreshClaimState (copy), BeginReadGate (copy)
    u20 = p45;
    u9.Text = p45.Headline;
    u10.Text = p45.Date;
    u12.Text = p45.Body;
    u11.CanvasPosition = Vector2.new(0, 0);
    BuildRewardCards(p45);
    UpdateSelectedHighlight();
    RefreshClaimState();
    BeginReadGate(p45);
end;

local function ClearList() -- Line: 253
    -- upvalues: u17 (copy)
    for _, v in u17 do
        v:Destroy();
    end;

    table.clear(u17);
end;

local function BuildList() -- Line: 260
    -- upvalues: u17 (copy), u19 (ref), PatchNoteData (copy), u8 (ref), u3 (ref), SelectNote (copy), u7 (ref), RevealCascade (copy), u5 (ref), u20 (ref)
    for _, v in u17 do
        v:Destroy();
    end;

    table.clear(u17);
    u19 = u19 + 1;
    local u46 = u19;
    local Ordered = PatchNoteData.GetOrdered();
    local v47 = {};

    for i, v in Ordered do
        local v48 = u8:Clone();
        v48.Name = "Note_" .. v.Id;
        v48.Visible = true;
        v48.LayoutOrder = i;
        local Container = v48:FindFirstChild("Container");
        local v49;

        if Container then
            v49 = Container:FindFirstChild("Headline_Name");
        else
            v49 = Container;
        end;

        if v49 then
            v49.Text = v.Headline;
        end;

        local v50;

        if Container then
            v50 = Container:FindFirstChild("Selected");
        else
            v50 = Container;
        end;

        if v50 then
            v50.Visible = false;
        end;

        if Container then
            Container = Container:FindFirstChild("Reward_Notice");
        end;

        if Container then
            local v51 = PatchNoteData.HasRewards(v);

            if v51 then
                local Id = v.Id;
                local v52 = u3 and u3.Data.ClaimedPatchNotes;
                local v53;

                if v52 == nil then
                    v53 = false;
                else
                    v53 = v52[Id] == true;
                end;

                v51 = not v53;
            end;

            Container.Visible = v51;
        end;

        v48.MouseButton1Click:Connect(function() -- Line: 286
            -- upvalues: SelectNote (ref), v (copy)
            SelectNote(v);
        end);
        v48.Parent = u7;
        u17[v.Id] = v48;
        table.insert(v47, v48);
    end;

    RevealCascade.play(v47, {
        isCurrent = function() -- Line: 296, Name: isCurrent
            -- upvalues: u5 (ref), u19 (ref), u46 (copy)
            return u5.Visible and u19 == u46;
        end
    });
    local v54 = u20 and PatchNoteData.GetById(u20.Id) or Ordered[1];

    if v54 then
        SelectNote(v54);
    end;
end;

local function OpenNotes() -- Line: 309
    -- upvalues: u6 (ref), BuildList (copy)
    u6:open();
    BuildList();
end;

local function OnClaimClicked() -- Line: 314
    -- upvalues: u20 (ref), PatchNoteData (copy), u3 (ref), u21 (copy), SetButtonActive (copy), u15 (ref), u4 (ref), Knit (copy), RefreshClaimState (copy)
    local u55 = u20;

    if not (u55 and PatchNoteData.HasRewards(u55)) then
        return;
    end;

    local Id = u55.Id;
    local v56 = u3 and u3.Data.ClaimedPatchNotes;
    local v57;

    if v56 == nil then
        v57 = false;
    else
        v57 = v56[Id] == true;
    end;

    if v57 or not u21[u55.Id] then
        return;
    end;

    SetButtonActive(u15, false);
    task.spawn(function() -- Line: 320
        -- upvalues: u4 (ref), Knit (ref), u55 (copy), u20 (ref), RefreshClaimState (ref)
        pcall(function() -- Line: 321
            -- upvalues: u4 (ref), Knit (ref), u55 (ref)
            if not u4 then
                u4 = Knit.GetService("PatchNotesService");
            end;

            u4:ClaimReward(u55.Id):await();
        end);

        if u20 == u55 then
            RefreshClaimState();
        end;
    end);
end;

function v1.Open() -- Line: 333
    -- upvalues: u6 (ref), BuildList (copy)
    u6:open();
    BuildList();
end;

function v1._Init(p58) -- Line: 338
    -- upvalues: u2 (ref), u3 (ref), Registry (copy), u5 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u6 (ref), UIController (copy), OnClaimClicked (copy), u17 (copy), PatchNoteData (copy), RefreshClaimState (copy), LocalPlayer (copy), OpenNotes (copy)
    u2 = p58;
    u3 = Registry:Get("PlayerData");
    u5 = u2.Frames:WaitForChild("Notes");
    local Contents = u5:WaitForChild("Contents");
    u7 = Contents.LeftSection:WaitForChild("Selection");
    u8 = u7:WaitForChild("Template");
    u8.Visible = false;
    local Container = Contents.RightSection:WaitForChild("Container");
    u9 = Container:WaitForChild("Headline");
    u10 = Container:WaitForChild("Date");
    u11 = Container.Info.CanvasGroup:WaitForChild("ScrollingFrame");
    u12 = u11:WaitForChild("Info");
    u13 = Container:WaitForChild("Reward_List");
    u14 = u13:WaitForChild("Item_Template");
    u14.Visible = false;
    u15 = Container:WaitForChild("Claim");
    u16 = Container:WaitForChild("Claimed");
    u5.Visible = false;
    u6 = UIController.getByName("Notes") or UIController.new(u5);
    local Exit = u5:FindFirstChild("Exit");

    if Exit and Exit:IsA("GuiButton") then
        Exit.MouseButton1Click:Connect(function() -- Line: 367
            -- upvalues: u6 (ref)
            u6:close();
        end);
    end;

    u15.MouseButton1Click:Connect(OnClaimClicked);
    u3:OnChange(function(p59, p60) -- Line: 377
        -- upvalues: u17 (ref), PatchNoteData (ref), u3 (ref), RefreshClaimState (ref)
        if p60[1] ~= "ClaimedPatchNotes" then
            return;
        end;

        for i, v in u17 do
            local Container2 = v:FindFirstChild("Container");

            if Container2 then
                Container2 = Container2:FindFirstChild("Reward_Notice");
            end;

            if Container2 then
                local ById = PatchNoteData.GetById(i);
                local v61;

                if ById == nil then
                    v61 = false;
                else
                    v61 = PatchNoteData.HasRewards(ById);

                    if v61 then
                        local v62 = u3 and u3.Data.ClaimedPatchNotes;
                        local v63;

                        if v62 == nil then
                            v63 = false;
                        else
                            v63 = v62[i] == true;
                        end;

                        v61 = not v63;
                    end;
                end;

                Container2.Visible = v61;
            end;
        end;

        RefreshClaimState();
    end);
    task.spawn(function() -- Line: 391
        -- upvalues: LocalPlayer (ref), OpenNotes (ref)
        local Settings = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Settings", 30);

        if not Settings then
            return;
        end;

        local Main = Settings:WaitForChild("Main", 10);

        if Main then
            Main = Main:FindFirstChild("Options");
        end;

        if Main then
            Main = Main:FindFirstChild("Notes");
        end;

        if Main and Main:IsA("GuiButton") then
            Main.Activated:Connect(OpenNotes);

            return;
        end;

        warn("[PatchNotes] Settings.Main.Options.Notes button not found");
    end);
    print("[PatchNotes] Client UI initialized");
end;

return v1;