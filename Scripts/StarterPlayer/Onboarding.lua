--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Onboarding
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Onboarding
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local maid = require(ReplicatedStorage.Packages.maid);
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u3 = { "Easy", "Normal", "Hard", "Nightmare", "Endless" };
local u4 = {};
local u5 = {};
local LocalPlayer = game.Players.LocalPlayer;
local u6 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;

local function ArrowTo(p16: userdata?, p17: vector?) -- Line: 104
    -- upvalues: u5 (copy), u6 (ref), LocalPlayer (copy), ReplicatedStorage (copy)
    for _, v in ipairs(u5) do
        if typeof(v) == "Instance" then
            v:Destroy();
        end;
    end;

    table.clear(u5);

    if not p16 then
        return;
    end;

    if not (u6 and u6.PrimaryPart) then
        u6 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();

        if not u6.PrimaryPart then
            u6:WaitForChild("HumanoidRootPart", 15);
        end;
    end;

    local v18 = u6.PrimaryPart:FindFirstChild("ArrowAttachment") or Instance.new("Attachment");
    v18.Orientation = Vector3.new(0, 0, 90);
    v18.Name = "ArrowAttachment";
    v18.Parent = u6.PrimaryPart;
    local Attachment = Instance.new("Attachment");
    Attachment.Position = p17 or Vector3.new(0, 0, 0);
    Attachment.Orientation = Vector3.new(0, 0, 90);
    Attachment.Name = "ArrowAttachment";
    Attachment.Parent = p16;
    table.insert(u5, Attachment);
    local v19 = ReplicatedStorage.Assets.VFX.OnboardingBeam:Clone();
    v19.Attachment0 = v18;
    v19.Attachment1 = Attachment;
    v19.Parent = u6.PrimaryPart;
    table.insert(u5, v19);
end;

local function SetInstruction(p20: string) -- Line: 145
    -- upvalues: u9 (ref), Knit (copy)
    if u9 then
        u9.Text = p20;
    end;

    local Controller = Knit.GetController("SoundController");

    if Controller then
        Controller:Play("Checkpoint");
    end;
end;

local function SetStep(p21: number?, p22: number?) -- Line: 157
    -- upvalues: u10 (ref)
    if not u10 then
        return;
    end;

    if not p21 then
        u10.Visible = false;

        return;
    end;

    u10.Visible = true;
    u10.Text = string.format("%d/%d", p21, p22 or 4);
end;

local function LogFunnelStep(p23: any, u24: number) -- Line: 173
    -- upvalues: u15 (ref), Knit (copy)
    if p23.suppressFunnel then
        return;
    end;

    if p23.loggedSteps[u24] then
        return;
    end;

    p23.loggedSteps[u24] = true;

    if not u15 then
        local success, result = pcall(function() -- Line: 179
            -- upvalues: Knit (ref)
            return Knit.GetService("AnalyticsService");
        end);

        if success then
            u15 = result;
        end;
    end;

    if u15 and u15.LogOnboardingStep then
        pcall(function() -- Line: 183
            -- upvalues: u15 (ref), u24 (copy)
            u15.LogOnboardingStep:Fire(u24);
        end);
    end;
end;

local function TweenHighlightTo(p25: userdata) -- Line: 192
    -- upvalues: u12 (ref), u13 (ref), TweenService (copy), TweenInfo_new_ret (copy)
    if not u12 then
        return;
    end;

    local v26 = u12:FindFirstAncestorWhichIsA("ScreenGui");

    if not v26 then
        return;
    end;

    local AbsolutePosition = v26.AbsolutePosition;
    local AbsolutePosition2 = p25.AbsolutePosition;
    local AbsoluteSize = p25.AbsoluteSize;
    local UDim2_fromOffset_ret = UDim2.fromOffset(AbsolutePosition2.X + AbsoluteSize.X / 2 - AbsolutePosition.X, AbsolutePosition2.Y + AbsoluteSize.Y / 2 - AbsolutePosition.Y);
    local UDim2_fromOffset_ret2 = UDim2.fromOffset(AbsoluteSize.X * 1, AbsoluteSize.Y * 1);

    if u13 then
        u13:Cancel();
    end;

    u12.Visible = true;
    u13 = TweenService:Create(u12, TweenInfo_new_ret, {
        Position = UDim2_fromOffset_ret,
        Size = UDim2_fromOffset_ret2
    });
    u13:Play();
end;

local function HideHighlight() -- Line: 229
    -- upvalues: u12 (ref), u13 (ref)
    if not u12 then
        return;
    end;

    if u13 then
        u13:Cancel();
        u13 = nil;
    end;

    u12.Visible = false;
end;

local function WaitFor(p27: function, p28: any) -- Line: 242
    while not p27() do
        if p28.cancelled then
            return false;
        end;

        task.wait(0.1);
    end;

    return true;
end;

local function ResolveSelectRefs(p29: userdata) -- Line: 254
    local Contents = p29:FindFirstChild("Contents");
    local v30;

    if Contents then
        v30 = Contents:FindFirstChild("LeftSection");
    else
        v30 = Contents;
    end;

    if Contents then
        Contents = Contents:FindFirstChild("RightSection");
    end;

    if v30 then
        v30 = v30:FindFirstChild("ScrollingFrame");
    end;

    if Contents then
        Contents = Contents:FindFirstChild("Info");
    end;

    local v31;

    if Contents then
        v31 = Contents:FindFirstChild("Buttons");
    else
        v31 = Contents;
    end;

    if v31 then
        v31 = v31:FindFirstChild("Enter");
    end;

    return v30, Contents, v31;
end;

local function ResolveGuideCardSelect(p32: userdata) -- Line: 269
    local function selectOf(p33: userdata) -- Line: 270
        if p33.Name == "DungeonTemplate" then
            return nil;
        end;

        local Main = p33:FindFirstChild("Main");

        if Main then
            Main = Main:FindFirstChild("Select");
        end;

        if Main and Main:IsA("GuiButton") then
            return Main;
        end;

        return nil;
    end;

    local v34 = p32:FindFirstChild("Bandits Den");

    if v34 then
        local v35;

        if v34.Name == "DungeonTemplate" then
            v35 = nil;
        else
            v35 = v34:FindFirstChild("Main");

            if v35 then
                v35 = v35:FindFirstChild("Select");
            end;

            if not (v35 and v35:IsA("GuiButton")) then
                v35 = nil;
            end;
        end;

        if v35 then
            return v35;
        end;
    end;

    for _, child in p32:GetChildren() do
        local v36;

        if child.Name == "DungeonTemplate" then
            v36 = nil;
        else
            v36 = child:FindFirstChild("Main");

            if v36 then
                v36 = v36:FindFirstChild("Select");
            end;

            if not (v36 and v36:IsA("GuiButton")) then
                v36 = nil;
            end;
        end;

        if v36 then
            return v36;
        end;
    end;

    return nil;
end;

local function ResolveNearestPodTouch() -- Line: 296
    -- upvalues: u6 (ref), CollectionService (copy)
    local v37 = u6 and u6.PrimaryPart and u6.PrimaryPart.Position;
    local v38 = nil;
    local v39 = nil;

    for _, v in CollectionService:GetTagged("Pod_Zone") do
        local Touch = v:FindFirstChild("Touch", true);

        if Touch and Touch:IsA("BasePart") then
            if not v37 then
                return Touch;
            end;

            local Magnitude = (Touch.Position - v37).Magnitude;

            if not v38 or Magnitude < v38 then
                v39 = Touch;
                v38 = Magnitude;
            end;
        end;
    end;

    return v39;
end;

local function WaitForPodTouch(p40: any, p41: number?) -- Line: 316
    -- upvalues: ResolveNearestPodTouch (copy)
    local v42 = ResolveNearestPodTouch();

    if v42 then
        return v42;
    end;

    local v43 = 0;

    while v43 < (p41 or 20) do
        if p40 and p40.cancelled then
            return nil;
        end;

        task.wait(0.5);
        v43 = v43 + 0.5;
        local v44 = ResolveNearestPodTouch();

        if v44 then
            return v44;
        end;
    end;

    return nil;
end;

local function RunFlow(p45) -- Line: 335
    -- upvalues: maid (copy), ReplicatedStorage (copy), u7 (ref), u8 (ref), u11 (ref), u1 (ref), ResolveSelectRefs (copy), u3 (copy), u12 (ref), u13 (ref), u10 (ref), u9 (ref), Knit (copy), WaitForPodTouch (copy), ArrowTo (copy), WaitFor (copy), u5 (copy), ResolveGuideCardSelect (copy), TweenHighlightTo (copy)
    local u46 = maid.new();
    p45.maid = u46;
    ReplicatedStorage.Remotes.SetOnboardingStatus:FireServer(true);
    u7.Visible = true;

    if u8 then
        u8.Text = "Tutorial";
    end;

    if u11 then
        u11.Visible = false;
    end;

    workspace:WaitForChild("pods", 15);

    if p45.cancelled then
        u46:DoCleaning();

        return;
    end;

    local Dungeon_Select = u1.Frames:FindFirstChild("Dungeon_Select");

    if not Dungeon_Select then
        warn("[Onboarding] Main.Frames.Dungeon_Select missing — cannot run guided flow");
        u7.Visible = false;

        return;
    end;

    local v47, v48, v49 = ResolveSelectRefs(Dungeon_Select);
    local v50;

    if v48 then
        v50 = v48:FindFirstChild("Easy");
    else
        v50 = v48;
    end;

    if not v47 then
        warn("[Onboarding] Dungeon list ScrollingFrame missing");
    end;

    if not v50 then
        warn("[Onboarding] Info.Easy difficulty button missing");
    end;

    if not v49 then
        warn("[Onboarding] Info.Buttons.Enter missing");
    end;

    local u51 = {
        dungeon = false,
        difficulty = false,
        enter = false
    };

    if v48 then
        for _, v in u3 do
            local v52 = v48:FindFirstChild(v);

            if v52 and v52:IsA("GuiButton") then
                u46:GiveTask(v52.Activated:Connect(function() -- Line: 370
                    -- upvalues: u51 (copy)
                    u51.difficulty = true;
                end));
            end;
        end;
    end;

    if v49 and v49:IsA("GuiButton") then
        u46:GiveTask(v49.Activated:Connect(function() -- Line: 377
            -- upvalues: u51 (copy)
            u51.enter = true;
        end));
    end;

    if v47 then
        local function hookCard(p53: userdata) -- Line: 385
            -- upvalues: u46 (copy), u51 (copy)
            if p53.Name == "DungeonTemplate" then
                return;
            end;

            local Main = p53:FindFirstChild("Main");

            if Main then
                Main = Main:FindFirstChild("Select");
            end;

            if Main and Main:IsA("GuiButton") then
                u46:GiveTask(Main.Activated:Connect(function() -- Line: 390
                    -- upvalues: u51 (ref)
                    u51.dungeon = true;
                end));
            end;
        end;

        for _, child in v47:GetChildren() do
            hookCard(child);
        end;

        u46:GiveTask(v47.ChildAdded:Connect(hookCard));
    end;

    while not (u51.enter or p45.cancelled) do
        u51.dungeon = false;
        u51.difficulty = false;

        if u12 then
            if u13 then
                u13:Cancel();
                u13 = nil;
            end;

            u12.Visible = false;
        end;

        if u10 then
            u10.Visible = true;
            u10.Text = string.format("%d/%d", 1, 4);
        end;

        if u9 then
            u9.Text = "Welcome, adventurer! Follow the beam to a dungeon pod and step inside.";
        end;

        local Controller = Knit.GetController("SoundController");

        if Controller then
            Controller:Play("Checkpoint");
        end;

        local v54 = WaitForPodTouch(p45);

        if v54 then
            ArrowTo(v54);
        elseif not Dungeon_Select.Visible then
            warn("[Onboarding] no Pod_Zone Touch found to point at after waiting");
        end;

        if not WaitFor(function() -- Line: 421
            -- upvalues: Dungeon_Select (copy)
            return Dungeon_Select.Visible;
        end, p45) then
            break;
        end;

        for _, v in ipairs(u5) do
            if typeof(v) == "Instance" then
                v:Destroy();
            end;
        end;

        table.clear(u5);

        if u51.enter then
            break;
        end;

        if u10 then
            u10.Visible = true;
            u10.Text = string.format("%d/%d", 2, 4);
        end;

        if u9 then
            u9.Text = "Choose your dungeon — tap SELECT on Bandit\'s Den to begin.";
        end;

        local Controller2 = Knit.GetController("SoundController");

        if Controller2 then
            Controller2:Play("Checkpoint");
        end;

        task.wait(0.2);

        if p45.cancelled then
            break;
        end;

        local v55;

        if v47 then
            v55 = ResolveGuideCardSelect(v47);
        else
            v55 = v47;
        end;

        if v55 then
            TweenHighlightTo(v55);
        end;

        if not WaitFor(function() -- Line: 434
            -- upvalues: Dungeon_Select (copy), u51 (copy)
            return not Dungeon_Select.Visible or (u51.dungeon or u51.enter);
        end, p45) then
            break;
        end;

        if Dungeon_Select.Visible then
            if u10 then
                u10.Visible = true;
                u10.Text = string.format("%d/%d", 3, 4);
            end;

            if u9 then
                u9.Text = "Pick a difficulty — Easy is perfect for your first run.";
            end;

            local Controller3 = Knit.GetController("SoundController");

            if Controller3 then
                Controller3:Play("Checkpoint");
            end;

            if v50 then
                TweenHighlightTo(v50);
            end;

            if not WaitFor(function() -- Line: 445
                -- upvalues: Dungeon_Select (copy), u51 (copy)
                return not Dungeon_Select.Visible or (u51.difficulty or u51.enter);
            end, p45) then
                break;
            end;

            if Dungeon_Select.Visible then
                if u10 then
                    u10.Visible = true;
                    u10.Text = string.format("%d/%d", 4, 4);
                end;

                if u9 then
                    u9.Text = "Tap the green ENTER button to start your run!";
                end;

                local Controller4 = Knit.GetController("SoundController");

                if Controller4 then
                    Controller4:Play("Checkpoint");
                end;

                if v49 then
                    TweenHighlightTo(v49);
                end;

                if not WaitFor(function() -- Line: 456
                    -- upvalues: Dungeon_Select (copy), u51 (copy)
                    return not Dungeon_Select.Visible or u51.enter;
                end, p45) then
                    break;
                end;

                local _ = u51.enter;
            end;
        end;
    end;

    for _, v in ipairs(u5) do
        if typeof(v) == "Instance" then
            v:Destroy();
        end;
    end;

    table.clear(u5);

    if u12 then
        if u13 then
            u13:Cancel();
            u13 = nil;
        end;

        u12.Visible = false;
    end;

    u46:DoCleaning();

    if p45.cancelled then
        return;
    end;

    if u10 then
        u10.Visible = false;
    end;

    if u9 then
        u9.Text = "Great choice! Sit tight — you\'ll be warped into the dungeon shortly. Good luck!";
    end;

    local Controller = Knit.GetController("SoundController");

    if Controller then
        Controller:Play("Checkpoint");
    end;
end;

local function CancelActiveRun() -- Line: 481
    -- upvalues: u14 (ref), u5 (copy), u12 (ref), u13 (ref), u10 (ref)
    local v56 = u14;
    u14 = nil;

    if v56 then
        v56.cancelled = true;

        if v56.maid then
            v56.maid:DoCleaning();
        end;
    end;

    for _, v in ipairs(u5) do
        if typeof(v) == "Instance" then
            v:Destroy();
        end;
    end;

    table.clear(u5);

    if u12 then
        if u13 then
            u13:Cancel();
            u13 = nil;
        end;

        u12.Visible = false;
    end;

    if not u10 then
        return;
    end;

    u10.Visible = false;
end;

local function TryExpressWarp(p57) -- Line: 497
    -- upvalues: LocalPlayer (copy), u7 (ref), u8 (ref), u11 (ref), u10 (ref), u5 (copy), u12 (ref), u13 (ref), u9 (ref), Knit (copy)
    if LocalPlayer:GetAttribute("InDungeon") == true then
        return false;
    end;

    u7.Visible = true;

    if u8 then
        u8.Text = "Tutorial";
    end;

    if u11 then
        u11.Visible = false;
    end;

    if u10 then
        u10.Visible = false;
    end;

    for _, v in ipairs(u5) do
        if typeof(v) == "Instance" then
            v:Destroy();
        end;
    end;

    table.clear(u5);

    if u12 then
        if u13 then
            u13:Cancel();
            u13 = nil;
        end;

        u12.Visible = false;
    end;

    if u9 then
        u9.Text = "Warping you into your first dungeon — get ready!";
    end;

    local Controller = Knit.GetController("SoundController");

    if Controller then
        Controller:Play("Checkpoint");
    end;

    local u58 = nil;
    pcall(function() -- Line: 510
        -- upvalues: u58 (ref), Knit (ref)
        u58 = Knit.GetService("DungeonQueueService");
    end);

    if not (u58 and u58.RequestStartOnboardingRun) then
        return false;
    end;

    local v59, v60 = u58:RequestStartOnboardingRun():await();

    return p57.cancelled and true or (v59 and v60 and true or false);
end;

function u4.Start(p61: boolean?) -- Line: 530
    -- upvalues: u7 (ref), u14 (ref), u5 (copy), u12 (ref), u13 (ref), u10 (ref), TryExpressWarp (copy), RunFlow (copy)
    if not u7 then
        return;
    end;

    local v62 = u14;
    u14 = nil;

    if v62 then
        v62.cancelled = true;

        if v62.maid then
            v62.maid:DoCleaning();
        end;
    end;

    for _, v in ipairs(u5) do
        if typeof(v) == "Instance" then
            v:Destroy();
        end;
    end;

    table.clear(u5);

    if u12 then
        if u13 then
            u13:Cancel();
            u13 = nil;
        end;

        u12.Visible = false;
    end;

    if u10 then
        u10.Visible = false;
    end;

    local u63 = {
        cancelled = false,
        maid = nil,
        loggedSteps = {},
        suppressFunnel = p61 == true
    };
    u14 = u63;
    task.spawn(function() -- Line: 535
        -- upvalues: TryExpressWarp (ref), u63 (copy), RunFlow (ref)
        if TryExpressWarp(u63) then
            return;
        end;

        if u63.cancelled then
            return;
        end;

        RunFlow(u63);
    end);
end;

function u4.StopLobbyUI() -- Line: 547
    -- upvalues: u14 (ref), u5 (copy), u12 (ref), u13 (ref), u10 (ref), u7 (ref)
    local v64 = u14;
    u14 = nil;

    if v64 then
        v64.cancelled = true;

        if v64.maid then
            v64.maid:DoCleaning();
        end;
    end;

    for _, v in ipairs(u5) do
        if typeof(v) == "Instance" then
            v:Destroy();
        end;
    end;

    table.clear(u5);

    if u12 then
        if u13 then
            u13:Cancel();
            u13 = nil;
        end;

        u12.Visible = false;
    end;

    if u10 then
        u10.Visible = false;
    end;

    if u7 then
        u7.Visible = false;
    end;
end;

function u4.Stop() -- Line: 557
    -- upvalues: u4 (copy), ReplicatedStorage (copy)
    u4.StopLobbyUI();
    ReplicatedStorage.Remotes.SetOnboardingStatus:FireServer(false);
end;

local function ResolvePath(p65: userdata?, p66: string) -- Line: 568
    for i in string.gmatch(p66, "[^%.]+") do
        if not p65 then
            return nil;
        end;

        p65 = p65:FindFirstChild(i);
    end;

    return p65;
end;

local function IsVisible(p67: userdata?) -- Line: 578
    local v68;

    if p67 == nil then
        v68 = false;
    else
        v68 = p67.Visible == true;
    end;

    return v68;
end;

local function PromptPart(p69: string) -- Line: 583
    local Prompts = workspace:FindFirstChild("Prompts");

    if Prompts then
        Prompts = Prompts:FindFirstChild(p69);
    end;

    if not (Prompts and (Prompts:IsA("BasePart") and Prompts)) then
        Prompts = nil;
    end;

    return Prompts;
end;

local function GuidePart() -- Line: 590
    local Dialogue_NPCS = workspace:FindFirstChild("Dialogue_NPCS");

    if Dialogue_NPCS then
        Dialogue_NPCS = Dialogue_NPCS:FindFirstChild("Guide");
    end;

    if Dialogue_NPCS then
        return Dialogue_NPCS.PrimaryPart or (Dialogue_NPCS:FindFirstChild("HumanoidRootPart") or Dialogue_NPCS:FindFirstChildWhichIsA("BasePart"));
    end;

    return nil;
end;

local function FirstForgeCardButton(p70: userdata?) -- Line: 600
    if not p70 then
        return nil;
    end;

    local v71 = nil;
    local v72 = nil;

    for _, child in p70:GetChildren() do
        if child:IsA("GuiObject") and string.match(child.Name, "^ForgeItem_") then
            local Selection_Button = child:FindFirstChild("Selection_Button");

            if Selection_Button and (Selection_Button:IsA("GuiButton") and (not v71 or child.LayoutOrder < v71)) then
                v71 = child.LayoutOrder;
                v72 = Selection_Button;
            end;
        end;
    end;

    return v72;
end;

local function RunOutOfDungeonFlow(u73) -- Line: 617
    -- upvalues: maid (copy), u7 (ref), u8 (ref), u11 (ref), WaitFor (copy), TweenHighlightTo (copy), ArrowTo (copy), u10 (ref), u12 (ref), u13 (ref), u9 (ref), Knit (copy), ResolvePath (copy), u1 (ref), u5 (copy), LogFunnelStep (copy), FirstForgeCardButton (copy), LocalPlayer (copy), u4 (copy)
    local u74 = maid.new();
    u73.maid = u74;
    u7.Visible = true;

    if u8 then
        u8.Text = "Tutorial";
    end;

    if u11 then
        u11.Visible = true;
        u74:GiveTask(u11.Activated:Connect(function() -- Line: 627
            -- upvalues: u73 (copy)
            u73.skipped = true;
        end));
    end;

    local function waitStep(u75: function) -- Line: 631
        -- upvalues: WaitFor (ref), u73 (copy)
        return WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u75 (copy)
            return u73.skipped or u75();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";
    end;

    local function waitSeconds(p76: number) -- Line: 637
        -- upvalues: u73 (copy)
        local v77 = 0;

        while v77 < p76 do
            if u73.cancelled then
                return "cancel";
            end;

            if u73.skipped then
                return "skip";
            end;

            task.wait(0.1);
            v77 = v77 + 0.1;
        end;

        return "ok";
    end;

    local function onClick(p78: userdata?, p79: function) -- Line: 648
        -- upvalues: u74 (copy)
        if p78 and p78:IsA("GuiButton") then
            u74:GiveTask(p78.Activated:Connect(p79));
        end;
    end;

    local function highlight(p80: userdata?) -- Line: 658
        -- upvalues: u73 (copy), TweenHighlightTo (ref)
        if not p80 then
            return;
        end;

        for i = 1, 40 do
            if u73.cancelled or u73.skipped then
                return;
            end;

            if p80.Visible == true and (p80.AbsoluteSize.X > 0 and p80.AbsoluteSize.Y > 0) then
                break;
            end;

            task.wait(0.05);
            local _ = i;
        end;

        local AbsolutePosition = p80.AbsolutePosition;

        for i = 1, 20 do
            if u73.cancelled or u73.skipped then
                return;
            end;

            task.wait(0.05);
            local AbsolutePosition2 = p80.AbsolutePosition;

            if (AbsolutePosition2 - AbsolutePosition).Magnitude < 1 then
                break;
            end;

            AbsolutePosition = AbsolutePosition2;
            local _ = i;
        end;

        if u73.cancelled or u73.skipped then
            return;
        end;

        TweenHighlightTo(p80);
    end;

    local function beamTo(p81: function) -- Line: 682
        -- upvalues: u73 (copy), ArrowTo (ref)
        local v82 = p81();

        if not v82 then
            local v83 = 0;

            while v83 < 15 do
                if u73.cancelled or u73.skipped then
                    return;
                end;

                task.wait(0.5);
                v83 = v83 + 0.5;
                v82 = p81();

                if v82 then
                    break;
                end;
            end;
        end;

        if u73.cancelled or u73.skipped then
            return;
        end;

        ArrowTo(v82);
    end;

    local v179 = (function() -- Line: 701, Name: doSteps
        -- upvalues: u10 (ref), u12 (ref), u13 (ref), u9 (ref), Knit (ref), beamTo (copy), ResolvePath (ref), u1 (ref), WaitFor (ref), u73 (copy), u5 (ref), LogFunnelStep (ref), u74 (copy), highlight (copy), FirstForgeCardButton (ref), LocalPlayer (ref), waitSeconds (copy)
        if u10 then
            u10.Visible = true;
            u10.Text = string.format("%d/%d", 1, 5);
        end;

        if u12 then
            if u13 then
                u13:Cancel();
                u13 = nil;
            end;

            u12.Visible = false;
        end;

        if u9 then
            u9.Text = "Visit the Forge to power up your gear — follow the beam!";
        end;

        local Controller = Knit.GetController("SoundController");

        if Controller then
            Controller:Play("Checkpoint");
        end;

        beamTo(function() -- Line: 706
            local Prompts = workspace:FindFirstChild("Prompts");

            if Prompts then
                Prompts = Prompts:FindFirstChild("Forge");
            end;

            if not (Prompts and (Prompts:IsA("BasePart") and Prompts)) then
                Prompts = nil;
            end;

            return Prompts;
        end);
        local u84 = ResolvePath(u1, "Frames.Forge");

        local function u87() -- Line: 709
            -- upvalues: u84 (copy)
            local v85 = u84;
            local v86;

            if v85 == nil then
                v86 = false;
            else
                v86 = v85.Visible == true;
            end;

            return v86;
        end;

        local v88 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u87 (copy)
            return u73.skipped or u87();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v88 ~= "ok" then
            return v88 == "skip" and "complete" or "cancel";
        end;

        for _, v in ipairs(u5) do
            if typeof(v) == "Instance" then
                v:Destroy();
            end;
        end;

        table.clear(u5);
        LogFunnelStep(u73, 5);
        pcall(function() -- Line: 715
            -- upvalues: Knit (ref)
            Knit.GetService("OnboardingService"):GrantForgeMaterials():await();
        end);
        local u89 = false;
        pcall(function() -- Line: 719
            -- upvalues: Knit (ref), u74 (ref), u89 (ref)
            local Service = Knit.GetService("ForgeService");

            if Service and Service.ForgeResult then
                u74:GiveTask(Service.ForgeResult:Connect(function(p90, p91) -- Line: 722
                    -- upvalues: u89 (ref)
                    if p91 then
                        u89 = true;
                    end;
                end));
            end;
        end);
        local u92 = ResolvePath(u1, "Frames.Forge.Contents.SelectionView");
        highlight((ResolvePath(u1, "Frames.Forge.Contents.ItemHolder.Container.Add.Button")));

        if u9 then
            u9.Text = "Tap the + to choose an item to upgrade.";
        end;

        local Controller2 = Knit.GetController("SoundController");

        if Controller2 then
            Controller2:Play("Checkpoint");
        end;

        local function u95() -- Line: 732
            -- upvalues: u92 (copy)
            local v93 = u92;
            local v94;

            if v93 == nil then
                v94 = false;
            else
                v94 = v93.Visible == true;
            end;

            return v94;
        end;

        local v96 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u95 (copy)
            return u73.skipped or u95();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v96 ~= "ok" then
            return v96 == "skip" and "complete" or "cancel";
        end;

        local v97 = ResolvePath(u1, "Frames.Forge.Contents.SelectionView.ItemGrid");
        local u98 = false;

        if v97 then
            local function v100(p99: userdata) -- Line: 739
                -- upvalues: u74 (ref), u98 (ref)
                if not string.match(p99.Name, "^ForgeItem_") then
                    return;
                end;

                local Selection_Button = p99:FindFirstChild("Selection_Button");

                if Selection_Button and Selection_Button:IsA("GuiButton") then
                    u74:GiveTask(Selection_Button.Activated:Connect(function() -- Line: 743
                        -- upvalues: u98 (ref)
                        u98 = true;
                    end));
                end;
            end;

            for _, child in v97:GetChildren() do
                v100(child);
            end;

            u74:GiveTask(v97.ChildAdded:Connect(v100));
        end;

        task.wait(0.15);
        highlight((FirstForgeCardButton(v97)));

        if u9 then
            u9.Text = "Select any item — try the Rare ring you just found!";
        end;

        local Controller3 = Knit.GetController("SoundController");

        if Controller3 then
            Controller3:Play("Checkpoint");
        end;

        local function u104() -- Line: 752
            -- upvalues: u98 (ref), u92 (copy)
            local v101 = u98;

            if not v101 then
                local v102 = u92;
                local v103;

                if v102 == nil then
                    v103 = false;
                else
                    v103 = v102.Visible == true;
                end;

                v101 = not v103;
            end;

            return v101;
        end;

        local v105 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u104 (copy)
            return u73.skipped or u104();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v105 ~= "ok" then
            return v105 == "skip" and "complete" or "cancel";
        end;

        LogFunnelStep(u73, 6);
        highlight((ResolvePath(u1, "Frames.Forge.Contents.Buttons.Upgrade.Button")));

        if u9 then
            u9.Text = "Here are some upgrade stones — now hit Upgrade!";
        end;

        local Controller4 = Knit.GetController("SoundController");

        if Controller4 then
            Controller4:Play("Checkpoint");
        end;

        local function u106() -- Line: 759
            -- upvalues: u89 (ref)
            return u89;
        end;

        local v107 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u106 (copy)
            return u73.skipped or u106();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v107 ~= "ok" then
            return v107 == "skip" and "complete" or "cancel";
        end;

        LogFunnelStep(u73, 7);
        local v108;

        if u84 == nil then
            v108 = false;
        else
            v108 = u84.Visible == true;
        end;

        if v108 then
            highlight((ResolvePath(u1, "Frames.Forge.Exit")));

            if u9 then
                u9.Text = "Nice work! Close the Forge to continue.";
            end;

            local Controller5 = Knit.GetController("SoundController");

            if Controller5 then
                Controller5:Play("Checkpoint");
            end;

            local function u111() -- Line: 767
                -- upvalues: u84 (copy)
                local v109 = u84;
                local v110;

                if v109 == nil then
                    v110 = false;
                else
                    v110 = v109.Visible == true;
                end;

                return not v110;
            end;

            local v112 = WaitFor(function() -- Line: 632
                -- upvalues: u73 (ref), u111 (copy)
                return u73.skipped or u111();
            end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

            if v112 ~= "ok" then
                return v112 == "skip" and "complete" or "cancel";
            end;
        end;

        if u12 then
            if u13 then
                u13:Cancel();
                u13 = nil;
            end;

            u12.Visible = false;
        end;

        if u10 then
            u10.Visible = true;
            u10.Text = string.format("%d/%d", 2, 5);
        end;

        if u9 then
            u9.Text = "Now visit the Class Summon to roll your first class!";
        end;

        local Controller5 = Knit.GetController("SoundController");

        if Controller5 then
            Controller5:Play("Checkpoint");
        end;

        beamTo(function() -- Line: 775
            local Prompts = workspace:FindFirstChild("Prompts");

            if Prompts then
                Prompts = Prompts:FindFirstChild("Classes");
            end;

            if not (Prompts and (Prompts:IsA("BasePart") and Prompts)) then
                Prompts = nil;
            end;

            return Prompts;
        end);
        local u113 = ResolvePath(u1, "Frames.Classes");

        local function u116() -- Line: 777
            -- upvalues: u113 (copy)
            local v114 = u113;
            local v115;

            if v114 == nil then
                v115 = false;
            else
                v115 = v114.Visible == true;
            end;

            return v115;
        end;

        local v117 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u116 (copy)
            return u73.skipped or u116();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v117 ~= "ok" then
            return v117 == "skip" and "complete" or "cancel";
        end;

        for _, v in ipairs(u5) do
            if typeof(v) == "Instance" then
                v:Destroy();
            end;
        end;

        table.clear(u5);
        LogFunnelStep(u73, 8);
        highlight((ResolvePath(u1, "Frames.Classes.Spins.Spin.Normal")));

        if u9 then
            u9.Text = "Spin for your first class — good luck!";
        end;

        local Controller6 = Knit.GetController("SoundController");

        if Controller6 then
            Controller6:Play("Checkpoint");
        end;

        local u118 = LocalPlayer:GetAttribute("OnboardingSpinCount") or 0;

        local function u122() -- Line: 786
            -- upvalues: LocalPlayer (ref), u118 (copy), u113 (copy)
            local v119;

            if u118 < (LocalPlayer:GetAttribute("OnboardingSpinCount") or 0) then
                v119 = true;
            else
                local v120 = u113;
                local v121;

                if v120 == nil then
                    v121 = false;
                else
                    v121 = v120.Visible == true;
                end;

                v119 = not v121;
            end;

            return v119;
        end;

        local v123 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u122 (copy)
            return u73.skipped or u122();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v123 ~= "ok" then
            return v123 == "skip" and "complete" or "cancel";
        end;

        LogFunnelStep(u73, 9);
        local v124;

        if u113 == nil then
            v124 = false;
        else
            v124 = u113.Visible == true;
        end;

        if v124 then
            highlight((ResolvePath(u1, "Frames.Classes.Exit")));

            if u9 then
                u9.Text = "Great pull! Close this to continue.";
            end;

            local Controller7 = Knit.GetController("SoundController");

            if Controller7 then
                Controller7:Play("Checkpoint");
            end;

            local function u127() -- Line: 797
                -- upvalues: u113 (copy)
                local v125 = u113;
                local v126;

                if v125 == nil then
                    v126 = false;
                else
                    v126 = v125.Visible == true;
                end;

                return not v126;
            end;

            local v128 = WaitFor(function() -- Line: 632
                -- upvalues: u73 (ref), u127 (copy)
                return u73.skipped or u127();
            end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

            if v128 ~= "ok" then
                return v128 == "skip" and "complete" or "cancel";
            end;
        end;

        if u12 then
            if u13 then
                u13:Cancel();
                u13 = nil;
            end;

            u12.Visible = false;
        end;

        if u10 then
            u10.Visible = true;
            u10.Text = string.format("%d/%d", 3, 5);
        end;

        if u9 then
            u9.Text = "Head over to the Quests board.";
        end;

        local Controller7 = Knit.GetController("SoundController");

        if Controller7 then
            Controller7:Play("Checkpoint");
        end;

        beamTo(function() -- Line: 805
            local Prompts = workspace:FindFirstChild("Prompts");

            if Prompts then
                Prompts = Prompts:FindFirstChild("Quests");
            end;

            if not (Prompts and (Prompts:IsA("BasePart") and Prompts)) then
                Prompts = nil;
            end;

            return Prompts;
        end);
        local u129 = ResolvePath(u1, "Frames.Quests");

        local function u132() -- Line: 807
            -- upvalues: u129 (copy)
            local v130 = u129;
            local v131;

            if v130 == nil then
                v131 = false;
            else
                v131 = v130.Visible == true;
            end;

            return v131;
        end;

        local v133 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u132 (copy)
            return u73.skipped or u132();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v133 ~= "ok" then
            return v133 == "skip" and "complete" or "cancel";
        end;

        for _, v in ipairs(u5) do
            if typeof(v) == "Instance" then
                v:Destroy();
            end;
        end;

        table.clear(u5);
        LogFunnelStep(u73, 10);

        if u9 then
            u9.Text = "Complete Daily and Weekly quests here for extra rewards!";
        end;

        local Controller8 = Knit.GetController("SoundController");

        if Controller8 then
            Controller8:Play("Checkpoint");
        end;

        local v134 = waitSeconds(2);

        if v134 ~= "ok" then
            return v134 == "skip" and "complete" or "cancel";
        end;

        local v135;

        if u129 == nil then
            v135 = false;
        else
            v135 = u129.Visible == true;
        end;

        if v135 then
            highlight((ResolvePath(u1, "Frames.Quests.Exit")));

            if u9 then
                u9.Text = "Close the Quests board to continue.";
            end;

            local Controller9 = Knit.GetController("SoundController");

            if Controller9 then
                Controller9:Play("Checkpoint");
            end;

            local function u138() -- Line: 820
                -- upvalues: u129 (copy)
                local v136 = u129;
                local v137;

                if v136 == nil then
                    v137 = false;
                else
                    v137 = v136.Visible == true;
                end;

                return not v137;
            end;

            local v139 = WaitFor(function() -- Line: 632
                -- upvalues: u73 (ref), u138 (copy)
                return u73.skipped or u138();
            end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

            if v139 ~= "ok" then
                return v139 == "skip" and "complete" or "cancel";
            end;
        end;

        if u12 then
            if u13 then
                u13:Cancel();
                u13 = nil;
            end;

            u12.Visible = false;
        end;

        if u10 then
            u10.Visible = true;
            u10.Text = string.format("%d/%d", 4, 5);
        end;

        for _, v in ipairs(u5) do
            if typeof(v) == "Instance" then
                v:Destroy();
            end;
        end;

        table.clear(u5);
        local u140 = ResolvePath(u1, "HUD.Actions.Left.Buttons.Inventory");
        local v141;

        if u140 == nil then
            v141 = false;
        else
            v141 = u140.Visible == true;
        end;

        if not v141 then
            if u9 then
                u9.Text = "Open the menu to see more options.";
            end;

            local Controller9 = Knit.GetController("SoundController");

            if Controller9 then
                Controller9:Play("Checkpoint");
            end;

            highlight((ResolvePath(u1, "HUD.Actions.Left.Buttons.Menu")));

            local function u144() -- Line: 837
                -- upvalues: u140 (copy)
                local v142 = u140;
                local v143;

                if v142 == nil then
                    v143 = false;
                else
                    v143 = v142.Visible == true;
                end;

                return v143;
            end;

            local v145 = WaitFor(function() -- Line: 632
                -- upvalues: u73 (ref), u144 (copy)
                return u73.skipped or u144();
            end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

            if v145 ~= "ok" then
                return v145 == "skip" and "complete" or "cancel";
            end;
        end;

        local u146 = ResolvePath(u1, "Frames.Inventory");
        local v147;

        if u146 == nil then
            v147 = false;
        else
            v147 = u146.Visible == true;
        end;

        if not v147 then
            highlight(u140);

            if u9 then
                u9.Text = "Open your Inventory.";
            end;

            local Controller9 = Knit.GetController("SoundController");

            if Controller9 then
                Controller9:Play("Checkpoint");
            end;

            local function u150() -- Line: 846
                -- upvalues: u146 (copy)
                local v148 = u146;
                local v149;

                if v148 == nil then
                    v149 = false;
                else
                    v149 = v148.Visible == true;
                end;

                return v149;
            end;

            local v151 = WaitFor(function() -- Line: 632
                -- upvalues: u73 (ref), u150 (copy)
                return u73.skipped or u150();
            end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

            if v151 ~= "ok" then
                return v151 == "skip" and "complete" or "cancel";
            end;
        end;

        LogFunnelStep(u73, 11);
        local u152 = false;
        local v153 = ResolvePath(u1, "Frames.Inventory.Contents.InventorySection.Buttons.EquipBest");

        local function v154() -- Line: 856
            -- upvalues: u152 (ref)
            u152 = true;
        end;

        if v153 and v153:IsA("GuiButton") then
            u74:GiveTask(v153.Activated:Connect(v154));
        end;

        highlight(v153);

        if u9 then
            u9.Text = "Tap Equip Best to gear up instantly.";
        end;

        local Controller9 = Knit.GetController("SoundController");

        if Controller9 then
            Controller9:Play("Checkpoint");
        end;

        local function u155() -- Line: 859
            -- upvalues: u152 (ref)
            return u152;
        end;

        local v156 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u155 (copy)
            return u73.skipped or u155();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v156 ~= "ok" then
            return v156 == "skip" and "complete" or "cancel";
        end;

        LogFunnelStep(u73, 12);
        local u157 = false;
        local v158 = ResolvePath(u1, "Frames.Inventory.Contents.InventorySection.Buttons.Stats");

        local function v159() -- Line: 866
            -- upvalues: u157 (ref)
            u157 = true;
        end;

        if v158 and v158:IsA("GuiButton") then
            u74:GiveTask(v158.Activated:Connect(v159));
        end;

        highlight(v158);

        if u9 then
            u9.Text = "Open your Stats to spend upgrade points.";
        end;

        local Controller10 = Knit.GetController("SoundController");

        if Controller10 then
            Controller10:Play("Checkpoint");
        end;

        local function u160() -- Line: 869
            -- upvalues: u157 (ref)
            return u157;
        end;

        local v161 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u160 (copy)
            return u73.skipped or u160();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v161 ~= "ok" then
            return v161 == "skip" and "complete" or "cancel";
        end;

        LogFunnelStep(u73, 13);
        task.wait(0.15);
        local u162 = false;
        local v163 = ResolvePath(u1, "Frames.Inventory.Contents.StatUpgrade.Buttons.Auto");

        local function v164() -- Line: 877
            -- upvalues: u162 (ref)
            u162 = true;
        end;

        if v163 and v163:IsA("GuiButton") then
            u74:GiveTask(v163.Activated:Connect(v164));
        end;

        highlight(v163);

        if u9 then
            u9.Text = "Tap Auto to allocate your stats automatically.";
        end;

        local Controller11 = Knit.GetController("SoundController");

        if Controller11 then
            Controller11:Play("Checkpoint");
        end;

        local function u165() -- Line: 880
            -- upvalues: u162 (ref)
            return u162;
        end;

        local v166 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u165 (copy)
            return u73.skipped or u165();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v166 ~= "ok" then
            return v166 == "skip" and "complete" or "cancel";
        end;

        LogFunnelStep(u73, 14);
        local u167 = ResolvePath(u1, "Frames.Class");
        highlight((ResolvePath(u1, "Frames.Inventory.ClassInfo")));

        if u9 then
            u9.Text = "Open Class Info — here you can see all your classes.";
        end;

        local Controller12 = Knit.GetController("SoundController");

        if Controller12 then
            Controller12:Play("Checkpoint");
        end;

        local function u170() -- Line: 888
            -- upvalues: u167 (copy)
            local v168 = u167;
            local v169;

            if v168 == nil then
                v169 = false;
            else
                v169 = v168.Visible == true;
            end;

            return v169;
        end;

        local v171 = WaitFor(function() -- Line: 632
            -- upvalues: u73 (ref), u170 (copy)
            return u73.skipped or u170();
        end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

        if v171 ~= "ok" then
            return v171 == "skip" and "complete" or "cancel";
        end;

        LogFunnelStep(u73, 15);
        local v172;

        if u167 == nil then
            v172 = false;
        else
            v172 = u167.Visible == true;
        end;

        if v172 then
            if u9 then
                u9.Text = "This is your Archetype — your class\'s fighting style (melee, ranged, or magic). It decides how you deal damage!";
            end;

            local Controller13 = Knit.GetController("SoundController");

            if Controller13 then
                Controller13:Play("Checkpoint");
            end;

            highlight((ResolvePath(u1, "Frames.Class.Contents.LeftSection.Profile.ClassInfo.Info.Archetype")));
            local v173 = waitSeconds(6);

            if v173 ~= "ok" then
                return v173 == "skip" and "complete" or "cancel";
            end;
        end;

        local v174;

        if u167 == nil then
            v174 = false;
        else
            v174 = u167.Visible == true;
        end;

        if v174 then
            if u9 then
                u9.Text = "Now tap Exit to close the Class menu.";
            end;

            local Controller13 = Knit.GetController("SoundController");

            if Controller13 then
                Controller13:Play("Checkpoint");
            end;

            highlight((ResolvePath(u1, "Frames.Class.Exit")));

            local function u177() -- Line: 904
                -- upvalues: u167 (copy)
                local v175 = u167;
                local v176;

                if v175 == nil then
                    v176 = false;
                else
                    v176 = v175.Visible == true;
                end;

                return not v176;
            end;

            local v178 = WaitFor(function() -- Line: 632
                -- upvalues: u73 (ref), u177 (copy)
                return u73.skipped or u177();
            end, u73) and (u73.skipped and "skip" or "ok") or "cancel";

            if v178 ~= "ok" then
                return v178 == "skip" and "complete" or "cancel";
            end;
        end;

        if u12 then
            if u13 then
                u13:Cancel();
                u13 = nil;
            end;

            u12.Visible = false;
        end;

        if u10 then
            u10.Visible = true;
            u10.Text = string.format("%d/%d", 5, 5);
        end;

        if u9 then
            u9.Text = "Last thing — the Guide NPC over here can answer any questions. Good luck, adventurer!";
        end;

        local Controller13 = Knit.GetController("SoundController");

        if Controller13 then
            Controller13:Play("Checkpoint");
        end;

        beamTo(function() -- Line: 912
            local Dialogue_NPCS = workspace:FindFirstChild("Dialogue_NPCS");

            if Dialogue_NPCS then
                Dialogue_NPCS = Dialogue_NPCS:FindFirstChild("Guide");
            end;

            if Dialogue_NPCS then
                return Dialogue_NPCS.PrimaryPart or (Dialogue_NPCS:FindFirstChild("HumanoidRootPart") or Dialogue_NPCS:FindFirstChildWhichIsA("BasePart"));
            end;

            return nil;
        end);
        LogFunnelStep(u73, 16);

        return waitSeconds(4) == "cancel" and "cancel" or "complete";
    end)();

    for _, v in ipairs(u5) do
        if typeof(v) == "Instance" then
            v:Destroy();
        end;
    end;

    table.clear(u5);

    if u12 then
        if u13 then
            u13:Cancel();
            u13 = nil;
        end;

        u12.Visible = false;
    end;

    u74:DoCleaning();

    if u73.cancelled or v179 == "cancel" then
        return;
    end;

    if u10 then
        u10.Visible = false;
    end;

    if not u73.suppressFunnel then
        pcall(function() -- Line: 934
            -- upvalues: Knit (ref)
            Knit.GetService("OnboardingService"):Complete():await();
        end);
        pcall(function() -- Line: 937
            -- upvalues: Knit (ref)
            local Controller = Knit.GetController("RewardRevealController");

            if Controller then
                Controller:PlayEntries({ {
                        Type = "Package",
                        Id = "StarterCompensation",
                        Amount = 1
                    } }, "Onboarding Complete!");
            end;
        end);
    end;

    if u9 then
        u9.Text = "You\'re all set — enjoy the dungeons! Check your Items tab to open your gift.";
    end;

    local Controller = Knit.GetController("SoundController");

    if Controller then
        Controller:Play("Checkpoint");
    end;

    task.wait(3.5);
    u4.StopLobbyUI();
end;

function u4.StartOutOfDungeon(p180: boolean?) -- Line: 954
    -- upvalues: u7 (ref), u14 (ref), u5 (copy), u12 (ref), u13 (ref), u10 (ref), RunOutOfDungeonFlow (copy)
    if not u7 then
        return;
    end;

    local v181 = u14;
    u14 = nil;

    if v181 then
        v181.cancelled = true;

        if v181.maid then
            v181.maid:DoCleaning();
        end;
    end;

    for _, v in ipairs(u5) do
        if typeof(v) == "Instance" then
            v:Destroy();
        end;
    end;

    table.clear(u5);

    if u12 then
        if u13 then
            u13:Cancel();
            u13 = nil;
        end;

        u12.Visible = false;
    end;

    if u10 then
        u10.Visible = false;
    end;

    local v182 = {
        cancelled = false,
        maid = nil,
        skipped = false,
        loggedSteps = {},
        suppressFunnel = p180 == true
    };
    u14 = v182;
    task.spawn(RunOutOfDungeonFlow, v182);
end;

function u4._Init(p183) -- Line: 964
    -- upvalues: u1 (ref), u2 (ref), Registry (copy), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), ReplicatedStorage (copy), u4 (copy), LocalPlayer (copy)
    u1 = p183;
    u2 = Registry:Get("PlayerData");
    local Frames = u1:FindFirstChild("Frames");
    local v184;

    if Frames then
        v184 = Frames:FindFirstChild("Onboarding");
    else
        v184 = Frames;
    end;

    u7 = v184;

    if not u7 then
        warn("[Onboarding] Main.Frames.Onboarding missing — onboarding disabled");

        return;
    end;

    u8 = u7:FindFirstChild("Title");
    u9 = u7:FindFirstChild("Description");
    u10 = u7:FindFirstChild("Step");
    u11 = u7:FindFirstChild("SkipTutorial");
    u12 = Frames:FindFirstChild("Onboarding_Highlight");

    if u12 then
        u12.Visible = false;
    end;

    local OnboardingStep = ReplicatedStorage.Remotes:FindFirstChild("OnboardingStep");

    if OnboardingStep then
        OnboardingStep.OnClientEvent:Connect(function(p185) -- Line: 992
            -- upvalues: u4 (ref)
            if p185 == "DebugStart" then
                u4.Start(true);

                return;
            end;

            if p185 == "DebugDungeon" then
                u4.StopLobbyUI();

                return;
            end;

            if p185 == "DebugOutOfDungeon" then
                u4.StartOutOfDungeon(true);

                return;
            end;

            if p185 == "DebugEnd" then
                u4.Stop();
            end;
        end);
    end;

    if u2 and (u2.Data and u2.Data.OnboardingCompleted) then
        u7.Visible = false;

        return;
    end;

    if LocalPlayer:GetAttribute("InDungeon") == true then
        u7.Visible = false;

        return;
    end;

    if u2 and (u2.Data and u2.Data.OnboardingDidDungeon) then
        u4.StartOutOfDungeon();

        return;
    end;

    u4.Start();
end;

return u4;