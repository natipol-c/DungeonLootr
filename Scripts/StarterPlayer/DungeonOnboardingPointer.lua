--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DungeonOnboardingPointer
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.DungeonOnboardingPointer
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "DungeonOnboardingPointer"
});
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local LocalPlayer = Players.LocalPlayer;
local u2 = false;
local u3 = false;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = 0;
local u10 = false;
local u11 = false;
local u12 = false;
local u13 = false;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = 0;
local u24 = nil;

local function GetCharacterRoot() -- Line: 90
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        return Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart");
    end;

    return nil;
end;

local function GetModelRoot(p25: userdata) -- Line: 97
    if p25:IsA("Model") then
        return p25.PrimaryPart or (p25:FindFirstChild("HumanoidRootPart") or p25:FindFirstChildWhichIsA("BasePart"));
    end;

    return nil;
end;

local function SetMessage(p26: string) -- Line: 106
    -- upvalues: u16 (ref), u17 (ref), u18 (ref), u15 (ref), u14 (ref)
    if u16 then
        u16.Text = "Tutorial";
    end;

    if u17 then
        u17.Visible = false;
    end;

    if u18 then
        u18.Visible = false;
    end;

    if u15 then
        u15.Text = p26;
    end;

    if u14 then
        u14.Visible = true;
    end;
end;

local function HideMessage() -- Line: 114
    -- upvalues: u23 (ref), u14 (ref)
    u23 = u23 + 1;

    if u14 then
        u14.Visible = false;
    end;
end;

local function ShowMessage(p27: string, p28: number?) -- Line: 120
    -- upvalues: u23 (ref), u16 (ref), u17 (ref), u18 (ref), u15 (ref), u14 (ref), u2 (ref), u3 (ref)
    u23 = u23 + 1;
    local u29 = u23;

    if u16 then
        u16.Text = "Tutorial";
    end;

    if u17 then
        u17.Visible = false;
    end;

    if u18 then
        u18.Visible = false;
    end;

    if u15 then
        u15.Text = p27;
    end;

    if u14 then
        u14.Visible = true;
    end;

    if p28 then
        task.delay(p28, function() -- Line: 125
            -- upvalues: u2 (ref), u3 (ref), u23 (ref), u29 (copy), u14 (ref)
            if u2 and (not u3 and (u23 == u29 and u14)) then
                u14.Visible = false;
            end;
        end);
    end;
end;

local function TweenHighlightTo(p30: userdata) -- Line: 137
    -- upvalues: u19 (ref), TweenService (copy), TweenInfo_new_ret (copy)
    if not u19 then
        return;
    end;

    local v31 = u19:FindFirstAncestorWhichIsA("ScreenGui");

    if not v31 then
        return;
    end;

    local AbsolutePosition = v31.AbsolutePosition;
    local AbsolutePosition2 = p30.AbsolutePosition;
    local AbsoluteSize = p30.AbsoluteSize;
    u19.Visible = true;
    TweenService:Create(u19, TweenInfo_new_ret, {
        Position = UDim2.fromOffset(AbsolutePosition2.X + AbsoluteSize.X / 2 - AbsolutePosition.X, AbsolutePosition2.Y + AbsoluteSize.Y / 2 - AbsolutePosition.Y),
        Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
    }):Play();
end;

local function HideHighlight() -- Line: 151
    -- upvalues: u19 (ref)
    if u19 then
        u19.Visible = false;
    end;
end;

local function IsValidEnemy(p32: userdata) -- Line: 161
    if not (p32:IsA("Model") and p32.Parent) then
        return false;
    end;

    if p32:GetAttribute("IsLootRoomGuard") == true then
        return false;
    end;

    if p32:GetAttribute("MimicMob") == true then
        return false;
    end;

    if p32:GetAttribute("IsSpecialBoss") == true then
        return false;
    end;

    local v33 = p32:FindFirstChildWhichIsA("Humanoid");

    if v33 and v33.Health <= 0 then
        return false;
    end;

    local v34;

    if p32:IsA("Model") then
        v34 = p32.PrimaryPart or (p32:FindFirstChild("HumanoidRootPart") or p32:FindFirstChildWhichIsA("BasePart"));
    else
        v34 = nil;
    end;

    return v34 and true or false;
end;

local function FindNearestEnemy() -- Line: 172
    -- upvalues: LocalPlayer (copy), CollectionService (copy), IsValidEnemy (copy)
    local Character = LocalPlayer.Character;
    local v35;

    if Character then
        v35 = Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart");
    else
        v35 = nil;
    end;

    if not v35 then
        return nil;
    end;

    local Position = v35.Position;
    local v36 = (1 / 0);
    local v37 = nil;

    for _, v in CollectionService:GetTagged("NPC") do
        if IsValidEnemy(v) then
            local v38;

            if v:IsA("Model") then
                v38 = v.PrimaryPart or (v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart"));
            else
                v38 = nil;
            end;

            if v38 then
                local Magnitude = (v38.Position - Position).Magnitude;

                if Magnitude < v36 then
                    v37 = v;
                    v36 = Magnitude;
                end;
            end;
        end;
    end;

    return v37;
end;

local function IsUnlockedChest(p39: userdata) -- Line: 190
    if not p39:IsA("Model") or p39:GetAttribute("DungeonChest") ~= true then
        return false;
    end;

    local ChestPrompt = p39:FindFirstChild("ChestPrompt", true);
    local v40;

    if ChestPrompt == nil then
        v40 = false;
    else
        v40 = ChestPrompt:IsA("ProximityPrompt") and ChestPrompt.Enabled == true;
    end;

    return v40;
end;

local function FindNearestUnlockedChest() -- Line: 198
    -- upvalues: LocalPlayer (copy), IsUnlockedChest (copy)
    local Character = LocalPlayer.Character;
    local v41;

    if Character then
        v41 = Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart");
    else
        v41 = nil;
    end;

    if not v41 then
        return nil;
    end;

    local Position = v41.Position;
    local v42 = (1 / 0);
    local v43 = nil;

    for _, descendant in workspace:GetDescendants() do
        if IsUnlockedChest(descendant) then
            local v44;

            if descendant:IsA("Model") then
                v44 = descendant.PrimaryPart or (descendant:FindFirstChild("HumanoidRootPart") or descendant:FindFirstChildWhichIsA("BasePart"));
            else
                v44 = nil;
            end;

            if v44 then
                local Magnitude = (v44.Position - Position).Magnitude;

                if Magnitude < v42 then
                    v43 = descendant;
                    v42 = Magnitude;
                end;
            end;
        end;
    end;

    return v43;
end;

local function FindObjective() -- Line: 216
    -- upvalues: u5 (ref), IsUnlockedChest (copy), FindNearestEnemy (copy)
    if u5 and (u5.Parent and IsUnlockedChest(u5)) then
        return u5;
    end;

    u5 = nil;

    return FindNearestEnemy();
end;

local function PointAt(p45: userdata?) -- Line: 226
    -- upvalues: u6 (ref), u8 (ref), LocalPlayer (copy), u7 (ref), ReplicatedStorage (copy)
    if u6 then
        u6:Destroy();
        u6 = nil;
    end;

    if u8 then
        u8:Destroy();
        u8 = nil;
    end;

    if not p45 then
        return;
    end;

    local Character = LocalPlayer.Character;
    local v46;

    if Character then
        v46 = Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart");
    else
        v46 = nil;
    end;

    local v47;

    if p45:IsA("Model") then
        v47 = p45.PrimaryPart or (p45:FindFirstChild("HumanoidRootPart") or p45:FindFirstChildWhichIsA("BasePart"));
    else
        v47 = nil;
    end;

    if not (v46 and v47) then
        return;
    end;

    local OnboardingArrowAttachment = v46:FindFirstChild("OnboardingArrowAttachment");

    if OnboardingArrowAttachment and OnboardingArrowAttachment:IsA("Attachment") then
        u7 = OnboardingArrowAttachment;
    else
        u7 = Instance.new("Attachment");
        u7.Name = "OnboardingArrowAttachment";
        u7.Orientation = Vector3.new(0, 0, 90);
        u7.Parent = v46;
    end;

    u8 = Instance.new("Attachment");
    u8.Name = "OnboardingArrowAttachment";
    u8.Orientation = Vector3.new(0, 0, 90);
    u8.Parent = v47;
    local v48 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("VFX") and ReplicatedStorage.Assets.VFX:FindFirstChild("OnboardingBeam");

    if not (v48 and v48:IsA("Beam")) then
        warn("[DungeonOnboardingPointer] Assets.VFX.OnboardingBeam missing");

        return;
    end;

    local v49 = v48:Clone();
    v49.Attachment0 = u7;
    v49.Attachment1 = u8;
    v49.Parent = v46;
    u6 = v49;
end;

local function OnRoomCleared() -- Line: 276
    -- upvalues: u10 (ref), u13 (ref), u2 (ref), u3 (ref), FindNearestUnlockedChest (copy), u5 (ref), u23 (ref), u16 (ref), u17 (ref), u18 (ref), u15 (ref), u14 (ref)
    if u10 or u13 then
        return;
    end;

    u13 = true;
    task.spawn(function() -- Line: 279
        -- upvalues: u2 (ref), u3 (ref), u10 (ref), u13 (ref), FindNearestUnlockedChest (ref), u5 (ref), u23 (ref), u16 (ref), u17 (ref), u18 (ref), u15 (ref), u14 (ref)
        local v50 = nil;

        for i = 1, 12 do
            if not u2 or (u3 or u10) then
                u13 = false;

                return;
            end;

            v50 = FindNearestUnlockedChest();

            if v50 then
                break;
            end;

            task.wait(0.25);
            local _ = i;
        end;

        u13 = false;

        if not u2 or (u3 or u10) then
            return;
        end;

        if not v50 then
            return;
        end;

        u10 = true;
        u5 = v50;
        u23 = u23 + 1;

        if u16 then
            u16.Text = "Tutorial";
        end;

        if u17 then
            u17.Visible = false;
        end;

        if u18 then
            u18.Visible = false;
        end;

        if u15 then
            u15.Text = "Nice clear! Grab your loot chest — follow the beam.";
        end;

        if u14 then
            u14.Visible = true;
        end;
    end);
end;

local function HighlightReturnButton() -- Line: 304
    -- upvalues: u21 (ref), u20 (ref), u2 (ref), TweenHighlightTo (copy)
    if not u21 then
        return;
    end;

    local u51 = u21;

    local function completionVisible() -- Line: 308
        -- upvalues: u20 (ref)
        local v52;

        if u20 == nil then
            v52 = false;
        else
            v52 = u20.Visible == true;
        end;

        return v52;
    end;

    task.spawn(function() -- Line: 312
        -- upvalues: u2 (ref), u20 (ref), u51 (copy), TweenHighlightTo (ref)
        local v53 = false;

        for i = 1, 3600 do
            if not u2 then
                return;
            end;

            local v54;

            if u20 == nil then
                v54 = false;
            else
                v54 = u20.Visible == true;
            end;

            if v54 and u51.Visible == true then
                local v55 = u51:FindFirstChildOfClass("UIScale");

                if (v55 == nil and true or v55.Scale >= 0.99) and (u51.AbsoluteSize.X > 0 and u51.AbsoluteSize.Y > 0) then
                    v53 = true;
                    break;
                end;
            end;

            task.wait(0.05);
            local _ = i;
        end;

        if not (v53 and u2) then
            return;
        end;

        local AbsoluteSize = u51.AbsoluteSize;
        local AbsolutePosition = u51.AbsolutePosition;

        for i = 1, 40 do
            task.wait(0.05);

            if not u2 then
                return;
            end;

            local AbsoluteSize2 = u51.AbsoluteSize;
            local AbsolutePosition2 = u51.AbsolutePosition;

            if (AbsoluteSize2 - AbsoluteSize).Magnitude < 1 and (AbsolutePosition2 - AbsolutePosition).Magnitude < 1 then
                break;
            end;

            AbsolutePosition = AbsolutePosition2;
            AbsoluteSize = AbsoluteSize2;
            local _ = i;
        end;

        if u2 then
            local v56;

            if u20 == nil then
                v56 = false;
            else
                v56 = u20.Visible == true;
            end;

            if v56 then
                TweenHighlightTo(u51);
            end;
        end;
    end);
end;

local function ResolveSkill4() -- Line: 353
    -- upvalues: u22 (ref), Knit (copy)
    if u22 and u22.Parent then
        return u22;
    end;

    local Main = Knit.PlayerGui:FindFirstChild("Main");

    if Main then
        Main = Main:FindFirstChild("HUD");
    end;

    if Main then
        Main = Main:FindFirstChild("Actions");
    end;

    if Main then
        Main = Main:FindFirstChild("Bottom");
    end;

    if Main then
        Main = Main:FindFirstChild("Actions");
    end;

    if Main then
        Main = Main:FindFirstChild("4");
    end;

    u22 = Main;

    return u22;
end;

local function RunSkillTutorial(p57: number) -- Line: 367
    -- upvalues: u2 (ref), u3 (ref), u9 (ref), ResolveSkill4 (copy), TweenHighlightTo (copy), LocalPlayer (copy), u19 (ref), u23 (ref), u16 (ref), u17 (ref), u18 (ref), u15 (ref), u14 (ref)
    local v58 = nil;

    for i = 1, 40 do
        if not u2 or (u3 or u9 ~= p57) then
            return;
        end;

        v58 = ResolveSkill4();

        if v58 and v58.AbsoluteSize.X > 0 then
            break;
        end;

        task.wait(0.05);
        local _ = i;
    end;

    if not v58 or (not u2 or (u3 or u9 ~= p57)) then
        return;
    end;

    TweenHighlightTo(v58);
    local u59 = false;
    local v60 = {};

    local function markUsed() -- Line: 385
        -- upvalues: u59 (ref)
        u59 = true;
    end;

    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("Skill4_OnCooldown");
    table.insert(v60, AttributeChangedSignal:Connect(function() -- Line: 386
        -- upvalues: LocalPlayer (ref), u59 (ref)
        if LocalPlayer:GetAttribute("Skill4_OnCooldown") then
            u59 = true;
        end;
    end));
    local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("Skill4_Charges");
    table.insert(v60, AttributeChangedSignal2:Connect(markUsed));

    if v58:IsA("GuiButton") then
        table.insert(v60, v58.Activated:Connect(markUsed));
    end;

    while not u59 do
        if not u2 or (u3 or u9 ~= p57) then
            for _, v in v60 do
                v:Disconnect();
            end;

            return;
        end;

        task.wait(0.1);
    end;

    for _, v in v60 do
        v:Disconnect();
    end;

    if not u2 or (u3 or u9 ~= p57) then
        return;
    end;

    if u19 then
        u19.Visible = false;
    end;

    u23 = u23 + 1;
    local u61 = u23;

    if u16 then
        u16.Text = "Tutorial";
    end;

    if u17 then
        u17.Visible = false;
    end;

    if u18 then
        u18.Visible = false;
    end;

    if u15 then
        u15.Text = "Keep fighting!";
    end;

    if u14 then
        u14.Visible = true;
    end;

    task.delay(4, function() -- Line: 125
        -- upvalues: u2 (ref), u3 (ref), u23 (ref), u61 (copy), u14 (ref)
        if u2 and (not u3 and (u23 == u61 and u14)) then
            u14.Visible = false;
        end;
    end);
end;

local function Stop() -- Line: 411
    -- upvalues: u2 (ref), u3 (ref), u9 (ref), u4 (ref), u5 (ref), u6 (ref), u8 (ref), u23 (ref), u14 (ref), u19 (ref)
    if not u2 then
        return;
    end;

    u2 = false;
    u3 = false;
    u9 = u9 + 1;
    u4 = nil;
    u5 = nil;

    if u6 then
        u6:Destroy();
        u6 = nil;
    end;

    if u8 then
        u8:Destroy();
        u8 = nil;
    end;

    u23 = u23 + 1;

    if u14 then
        u14.Visible = false;
    end;

    if u19 then
        u19.Visible = false;
    end;
end;

local function Start() -- Line: 423
    -- upvalues: u2 (ref), u3 (ref), u10 (ref), u13 (ref), u11 (ref), u12 (ref), u5 (ref), u4 (ref), u9 (ref), u23 (ref), u16 (ref), u17 (ref), u18 (ref), u15 (ref), u14 (ref), IsUnlockedChest (copy), FindNearestEnemy (copy), PointAt (copy), RunSkillTutorial (copy)
    if u2 then
        return;
    end;

    u2 = true;
    u3 = false;
    u10 = false;
    u13 = false;
    u11 = false;
    u12 = false;
    u5 = nil;
    u4 = nil;
    u9 = u9 + 1;
    local u62 = u9;
    u23 = u23 + 1;

    if u16 then
        u16.Text = "Tutorial";
    end;

    if u17 then
        u17.Visible = false;
    end;

    if u18 then
        u18.Visible = false;
    end;

    if u15 then
        u15.Text = "Defeat the enemies in this area to clear it!";
    end;

    if u14 then
        u14.Visible = true;
    end;

    task.spawn(function() -- Line: 440
        -- upvalues: u2 (ref), u3 (ref), u9 (ref), u62 (copy), u5 (ref), IsUnlockedChest (ref), FindNearestEnemy (ref), u4 (ref), PointAt (ref)
        while u2 and (not u3 and u9 == u62) do
            local v63;

            if u5 and (u5.Parent and IsUnlockedChest(u5)) then
                v63 = u5;
            else
                u5 = nil;
                v63 = FindNearestEnemy();
            end;

            if v63 ~= u4 then
                u4 = v63;
                PointAt(v63);
            end;

            task.wait(0.3);
        end;
    end);
    task.spawn(function() -- Line: 453
        -- upvalues: RunSkillTutorial (ref), u62 (copy)
        RunSkillTutorial(u62);
    end);
end;

local function Evaluate() -- Line: 456
    -- upvalues: LocalPlayer (copy), Start (copy), u2 (ref), u3 (ref), u9 (ref), u4 (ref), u5 (ref), u6 (ref), u8 (ref), u23 (ref), u14 (ref), u19 (ref)
    local v64;

    if LocalPlayer:GetAttribute("InDungeon") == true then
        v64 = LocalPlayer:GetAttribute("Onboarding") == true;
    else
        v64 = false;
    end;

    if v64 then
        Start();

        return;
    end;

    if not u2 then
        return;
    end;

    u2 = false;
    u3 = false;
    u9 = u9 + 1;
    u4 = nil;
    u5 = nil;

    if u6 then
        u6:Destroy();
        u6 = nil;
    end;

    if u8 then
        u8:Destroy();
        u8 = nil;
    end;

    u23 = u23 + 1;

    if u14 then
        u14.Visible = false;
    end;

    if u19 then
        u19.Visible = false;
    end;
end;

local function ResolveGui() -- Line: 464
    -- upvalues: Knit (copy), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u22 (ref)
    local Main = Knit.PlayerGui:FindFirstChild("Main");

    if not Main then
        return;
    end;

    local Frames = Main:FindFirstChild("Frames");

    if Frames then
        u14 = Frames:FindFirstChild("Onboarding");

        if u14 then
            u15 = u14:FindFirstChild("Description");
            u16 = u14:FindFirstChild("Title");
            u17 = u14:FindFirstChild("Step");
            u18 = u14:FindFirstChild("SkipTutorial");
        end;

        u19 = Frames:FindFirstChild("Onboarding_Highlight");
    end;

    local HUD = Main:FindFirstChild("HUD");
    local v65;

    if HUD then
        v65 = HUD:FindFirstChild("Dungeon_Container");
    else
        v65 = HUD;
    end;

    if v65 then
        v65 = v65:FindFirstChild("Completion_Info");
    end;

    u20 = v65;

    if u20 then
        u21 = u20:FindFirstChild("ReturnButton", true);
    end;

    if HUD then
        HUD = HUD:FindFirstChild("Actions");
    end;

    if HUD then
        HUD = HUD:FindFirstChild("Bottom");
    end;

    if HUD then
        HUD = HUD:FindFirstChild("Actions");
    end;

    if HUD then
        HUD = HUD:FindFirstChild("4");
    end;

    u22 = HUD;
end;

local function connect(p66: string, p67: function) -- Line: 497
    -- upvalues: u24 (ref)
    local v68 = u24 and u24[p66];

    if v68 and v68.Connect then
        v68:Connect(p67);

        return;
    end;

    warn((`[DungeonOnboardingPointer] DungeonRunService.{p66} signal missing`));
end;

local function ConnectSignals() -- Line: 506
    -- upvalues: u24 (ref), u2 (ref), u3 (ref), u10 (ref), u13 (ref), FindNearestUnlockedChest (copy), u5 (ref), u23 (ref), u16 (ref), u17 (ref), u18 (ref), u15 (ref), u14 (ref), u12 (ref), u11 (ref), u4 (ref), u6 (ref), u8 (ref), u21 (ref), u20 (ref), TweenHighlightTo (copy)
    if not u24 then
        return;
    end;

    local function v73(p69, p70) -- Line: 512
        -- upvalues: u2 (ref), u3 (ref), u10 (ref), u13 (ref), FindNearestUnlockedChest (ref), u5 (ref), u23 (ref), u16 (ref), u17 (ref), u18 (ref), u15 (ref), u14 (ref), u12 (ref)
        if not u2 or u3 then
            return;
        end;

        if p69 == "RoomCleared" then
            if not u10 then
                if u13 then
                    return;
                end;

                u13 = true;
                task.spawn(function() -- Line: 279
                    -- upvalues: u2 (ref), u3 (ref), u10 (ref), u13 (ref), FindNearestUnlockedChest (ref), u5 (ref), u23 (ref), u16 (ref), u17 (ref), u18 (ref), u15 (ref), u14 (ref)
                    local v71 = nil;

                    for i = 1, 12 do
                        if not u2 or (u3 or u10) then
                            u13 = false;

                            return;
                        end;

                        v71 = FindNearestUnlockedChest();

                        if v71 then
                            break;
                        end;

                        task.wait(0.25);
                        local _ = i;
                    end;

                    u13 = false;

                    if not u2 or (u3 or u10) then
                        return;
                    end;

                    if not v71 then
                        return;
                    end;

                    u10 = true;
                    u5 = v71;
                    u23 = u23 + 1;

                    if u16 then
                        u16.Text = "Tutorial";
                    end;

                    if u17 then
                        u17.Visible = false;
                    end;

                    if u18 then
                        u18.Visible = false;
                    end;

                    if u15 then
                        u15.Text = "Nice clear! Grab your loot chest — follow the beam.";
                    end;

                    if u14 then
                        u14.Visible = true;
                    end;
                end);
            end;
        elseif (p69 == "BossPhase" or p69 == "BossWarp") and not u12 then
            u12 = true;
            u5 = nil;
            u23 = u23 + 1;
            local u72 = u23;

            if u16 then
                u16.Text = "Tutorial";
            end;

            if u17 then
                u17.Visible = false;
            end;

            if u18 then
                u18.Visible = false;
            end;

            if u15 then
                u15.Text = "This is the boss — defeat it to extract your loot!";
            end;

            if u14 then
                u14.Visible = true;
            end;

            task.delay(1.5, function() -- Line: 125
                -- upvalues: u2 (ref), u3 (ref), u23 (ref), u72 (copy), u14 (ref)
                if u2 and (not u3 and (u23 == u72 and u14)) then
                    u14.Visible = false;
                end;
            end);
        end;
    end;

    local v74 = u24 and u24.PhaseChange;

    if v74 and v74.Connect then
        v74:Connect(v73);
    else
        warn("[DungeonOnboardingPointer] DungeonRunService.PhaseChange signal missing");
    end;

    local function v77(p75) -- Line: 529
        -- upvalues: u2 (ref), u3 (ref), u11 (ref), u10 (ref), u23 (ref), u16 (ref), u17 (ref), u18 (ref), u15 (ref), u14 (ref)
        if not u2 or u3 then
            return;
        end;

        if not u11 and (u10 and (tonumber(p75) or 0) > 1) then
            u11 = true;
            u23 = u23 + 1;
            local u76 = u23;

            if u16 then
                u16.Text = "Tutorial";
            end;

            if u17 then
                u17.Visible = false;
            end;

            if u18 then
                u18.Visible = false;
            end;

            if u15 then
                u15.Text = "The loot you collect can be used for upgrading and crafting later!";
            end;

            if u14 then
                u14.Visible = true;
            end;

            task.delay(5, function() -- Line: 125
                -- upvalues: u2 (ref), u3 (ref), u23 (ref), u76 (copy), u14 (ref)
                if u2 and (not u3 and (u23 == u76 and u14)) then
                    u14.Visible = false;
                end;
            end);
        end;
    end;

    local v78 = u24 and u24.ZoneEntered;

    if v78 and v78.Connect then
        v78:Connect(v77);
    else
        warn("[DungeonOnboardingPointer] DungeonRunService.ZoneEntered signal missing");
    end;

    local function v85() -- Line: 538
        -- upvalues: u2 (ref), u3 (ref), u4 (ref), u6 (ref), u8 (ref), u23 (ref), u14 (ref), u21 (ref), u20 (ref), TweenHighlightTo (ref)
        if not u2 then
            return;
        end;

        u3 = true;
        u4 = nil;

        if u6 then
            u6:Destroy();
            u6 = nil;
        end;

        if u8 then
            u8:Destroy();
            u8 = nil;
        end;

        u23 = u23 + 1;

        if u14 then
            u14.Visible = false;
        end;

        if not u21 then
            return;
        end;

        local u79 = u21;

        local function _() -- Line: 308
            -- upvalues: u20 (ref)
            local v80;

            if u20 == nil then
                v80 = false;
            else
                v80 = u20.Visible == true;
            end;

            return v80;
        end;

        task.spawn(function() -- Line: 312
            -- upvalues: u2 (ref), u20 (ref), u79 (copy), TweenHighlightTo (ref)
            local v81 = false;

            for i = 1, 3600 do
                if not u2 then
                    return;
                end;

                local v82;

                if u20 == nil then
                    v82 = false;
                else
                    v82 = u20.Visible == true;
                end;

                if v82 and u79.Visible == true then
                    local v83 = u79:FindFirstChildOfClass("UIScale");

                    if (v83 == nil and true or v83.Scale >= 0.99) and (u79.AbsoluteSize.X > 0 and u79.AbsoluteSize.Y > 0) then
                        v81 = true;
                        break;
                    end;
                end;

                task.wait(0.05);
                local _ = i;
            end;

            if not (v81 and u2) then
                return;
            end;

            local AbsoluteSize = u79.AbsoluteSize;
            local AbsolutePosition = u79.AbsolutePosition;

            for i = 1, 40 do
                task.wait(0.05);

                if not u2 then
                    return;
                end;

                local AbsoluteSize2 = u79.AbsoluteSize;
                local AbsolutePosition2 = u79.AbsolutePosition;

                if (AbsoluteSize2 - AbsoluteSize).Magnitude < 1 and (AbsolutePosition2 - AbsolutePosition).Magnitude < 1 then
                    break;
                end;

                AbsolutePosition = AbsolutePosition2;
                AbsoluteSize = AbsoluteSize2;
                local _ = i;
            end;

            if u2 then
                local v84;

                if u20 == nil then
                    v84 = false;
                else
                    v84 = u20.Visible == true;
                end;

                if v84 then
                    TweenHighlightTo(u79);
                end;
            end;
        end);
    end;

    local v86 = u24 and u24.DungeonComplete;

    if v86 and v86.Connect then
        v86:Connect(v85);

        return;
    end;

    warn("[DungeonOnboardingPointer] DungeonRunService.DungeonComplete signal missing");
end;

function v1.KnitStart(p87) -- Line: 548
    -- upvalues: ResolveGui (copy), Knit (copy), u24 (ref), ConnectSignals (copy), LocalPlayer (copy), Evaluate (copy), u2 (ref), u4 (ref), Start (copy), u3 (ref), u9 (ref), u5 (ref), u6 (ref), u8 (ref), u23 (ref), u14 (ref), u19 (ref)
    ResolveGui();
    local success, result = pcall(function() -- Line: 551
        -- upvalues: Knit (ref)
        return Knit.GetService("DungeonRunService");
    end);

    if success and result then
        u24 = result;
        ConnectSignals();
    else
        warn("[DungeonOnboardingPointer] DungeonRunService unavailable — in-dungeon onboarding disabled");
    end;

    LocalPlayer:GetAttributeChangedSignal("InDungeon"):Connect(Evaluate);
    LocalPlayer:GetAttributeChangedSignal("Onboarding"):Connect(Evaluate);
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 562
        -- upvalues: u2 (ref), u4 (ref)
        if u2 then
            u4 = nil;
        end;
    end);
    local v88;

    if LocalPlayer:GetAttribute("InDungeon") == true then
        v88 = LocalPlayer:GetAttribute("Onboarding") == true;
    else
        v88 = false;
    end;

    if v88 then
        Start();

        return;
    end;

    if not u2 then
        return;
    end;

    u2 = false;
    u3 = false;
    u9 = u9 + 1;
    u4 = nil;
    u5 = nil;

    if u6 then
        u6:Destroy();
        u6 = nil;
    end;

    if u8 then
        u8:Destroy();
        u8 = nil;
    end;

    u23 = u23 + 1;

    if u14 then
        u14.Visible = false;
    end;

    if u19 then
        u19.Visible = false;
    end;
end;

return v1;