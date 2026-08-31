--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     topbarplus
  Path:     game.StarterPlayer.StarterPlayerScripts.Satchel.Satchel.Packages._Index.legitatx_topbarplus@3.0.5.topbarplus
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("LocalizationService");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("TextService");
local StarterGui = game:GetService("StarterGui");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local u1 = script;
local Reference = require(u1.Reference);
local Object = Reference.getObject();
local v2;

if Object then
    v2 = Object.Value;
else
    v2 = Object;
end;

if v2 and v2 ~= u1 then
    return require(v2);
end;

if not Object then
    Reference.addToReplicatedStorage();
end;

local GoodSignal = require(u1.Packages.GoodSignal);
local Janitor = require(u1.Packages.Janitor);
local Utility = require(u1.Utility);
require(u1.Attribute);
local Themes = require(u1.Features.Themes);
local Gamepad = require(u1.Features.Gamepad);
local Overflow = require(u1.Features.Overflow);
local u3 = {};
u3.__index = u3;
local Themes2 = u1.Features.Themes;
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local u4 = {};
local u5 = GoodSignal.new();
local Elements = u1.Elements;
local u6 = 0;

if GuiService.TopbarInset.Height == 0 then
    GuiService:GetPropertyChangedSignal("TopbarInset"):Wait();
end;

u3.baseDisplayOrderChanged = GoodSignal.new();
u3.baseDisplayOrder = 10;
u3.baseTheme = require(Themes2.Default);
u3.isOldTopbar = GuiService.TopbarInset.Height == 36;
u3.iconsDictionary = u4;
u3.container = require(Elements.Container)(u3);
u3.topbarEnabled = true;
u3.iconAdded = GoodSignal.new();
u3.iconRemoved = GoodSignal.new();
u3.iconChanged = GoodSignal.new();

function u3.getIcons() -- Line: 112
    -- upvalues: u3 (copy)
    return u3.iconsDictionary;
end;

function u3.getIconByUID(p7) -- Line: 116
    -- upvalues: u3 (copy)
    local v8 = u3.iconsDictionary[p7];

    if v8 then
        return v8;
    end;
end;

function u3.getIcon(p9) -- Line: 123
    -- upvalues: u3 (copy), u4 (copy)
    local IconByUID = u3.getIconByUID(p9);

    if IconByUID then
        return IconByUID;
    end;

    for _, v in pairs(u4) do
        if v.name == p9 then
            return v;
        end;
    end;
end;

function u3.setTopbarEnabled(p10, p11) -- Line: 135
    -- upvalues: u3 (copy)
    if typeof(p10) ~= "boolean" then
        p10 = u3.topbarEnabled;
    end;

    if not p11 then
        u3.topbarEnabled = p10;
    end;

    for _, v in pairs(u3.container) do
        v.Enabled = p10;
    end;
end;

function u3.modifyBaseTheme(p12) -- Line: 147
    -- upvalues: Themes (copy), u3 (copy), u4 (copy)
    local Modifications = Themes.getModifications(p12);

    for _, v in pairs(Modifications) do
        local v13 = v;

        for _, v3 in pairs(u3.baseTheme) do
            Themes.merge(v3, v13);
        end;
    end;

    for _, v in pairs(u4) do
        v:setTheme(u3.baseTheme);
    end;
end;

function u3.setDisplayOrder(p14) -- Line: 159
    -- upvalues: u3 (copy)
    u3.baseDisplayOrder = p14;
    u3.baseDisplayOrderChanged:Fire(p14);
end;

task.defer(Gamepad.start, u3);
task.defer(Overflow.start, u3);

for _, v in pairs(u3.container) do
    v.Parent = PlayerGui;
end;

if u3.isOldTopbar then
    u3.modifyBaseTheme(require(Themes2.Classic));
end;

function u3.new() -- Line: 179
    -- upvalues: u3 (copy), Janitor (copy), Utility (copy), u4 (copy), GoodSignal (copy), u1 (copy), Elements (copy), u6 (ref), UserInputService (copy), u5 (copy), StarterGui (copy)
    local u15 = {};
    setmetatable(u15, u3);
    local v16 = Janitor.new();
    u15.janitor = v16;
    u15.themesJanitor = v16:add(Janitor.new());
    u15.singleClickJanitor = v16:add(Janitor.new());
    u15.captionJanitor = v16:add(Janitor.new());
    u15.joinJanitor = v16:add(Janitor.new());
    u15.menuJanitor = v16:add(Janitor.new());
    u15.dropdownJanitor = v16:add(Janitor.new());
    local u17 = Utility.generateUID();
    u4[u17] = u15;
    v16:add(function() -- Line: 196
        -- upvalues: u4 (ref), u17 (copy)
        u4[u17] = nil;
    end);
    u15.selected = v16:add(GoodSignal.new());
    u15.deselected = v16:add(GoodSignal.new());
    u15.toggled = v16:add(GoodSignal.new());
    u15.viewingStarted = v16:add(GoodSignal.new());
    u15.viewingEnded = v16:add(GoodSignal.new());
    u15.stateChanged = v16:add(GoodSignal.new());
    u15.notified = v16:add(GoodSignal.new());
    u15.noticeStarted = v16:add(GoodSignal.new());
    u15.noticeChanged = v16:add(GoodSignal.new());
    u15.endNotices = v16:add(GoodSignal.new());
    u15.toggleKeyAdded = v16:add(GoodSignal.new());
    u15.fakeToggleKeyChanged = v16:add(GoodSignal.new());
    u15.alignmentChanged = v16:add(GoodSignal.new());
    u15.updateSize = v16:add(GoodSignal.new());
    u15.resizingComplete = v16:add(GoodSignal.new());
    u15.joinedParent = v16:add(GoodSignal.new());
    u15.menuSet = v16:add(GoodSignal.new());
    u15.dropdownSet = v16:add(GoodSignal.new());
    u15.updateMenu = v16:add(GoodSignal.new());
    u15.startMenuUpdate = v16:add(GoodSignal.new());
    u15.childThemeModified = v16:add(GoodSignal.new());
    u15.indicatorSet = v16:add(GoodSignal.new());
    u15.dropdownChildAdded = v16:add(GoodSignal.new());
    u15.menuChildAdded = v16:add(GoodSignal.new());
    u15.iconModule = u1;
    u15.UID = u17;
    u15.isEnabled = true;
    u15.isSelected = false;
    u15.isViewing = false;
    u15.joinedFrame = false;
    u15.parentIconUID = false;
    u15.deselectWhenOtherIconSelected = true;
    u15.totalNotices = 0;
    u15.activeState = "Deselected";
    u15.alignment = "";
    u15.originalAlignment = "";
    u15.appliedTheme = {};
    u15.appearance = {};
    u15.cachedInstances = {};
    u15.cachedNamesToInstances = {};
    u15.cachedCollectives = {};
    u15.bindedToggleKeys = {};
    u15.customBehaviours = {};
    u15.toggleItems = {};
    u15.bindedEvents = {};
    u15.notices = {};
    u15.menuIcons = {};
    u15.dropdownIcons = {};
    u15.childIconsDict = {};
    u15.isOldTopbar = u3.isOldTopbar;
    u15.creationTime = os.clock();
    u15.widget = v16:add(require(Elements.Widget)(u15, u3));
    u15:setAlignment();
    u6 = u6 + 1;
    u15:setOrder(u6);
    u15:setTheme(u3.baseTheme);
    local Instance = u15:getInstance("ClickRegion");

    local function handleToggle() -- Line: 271
        -- upvalues: u15 (copy)
        if u15.locked then
            return;
        end;

        if u15.isSelected then
            u15:deselect("User", u15);

            return;
        end;

        u15:select("User", u15);
    end;

    local u18 = false;
    local u19 = false;
    Instance.MouseButton1Click:Connect(function() -- Line: 283
        -- upvalues: u18 (ref), u19 (ref), u15 (copy)
        if u18 then
            return;
        end;

        u19 = true;
        task.delay(0.01, function() -- Line: 288
            -- upvalues: u19 (ref)
            u19 = false;
        end);

        if u15.locked then
            return;
        end;

        if u15.isSelected then
            u15:deselect("User", u15);

            return;
        end;

        u15:select("User", u15);
    end);
    Instance.TouchTap:Connect(function() -- Line: 293
        -- upvalues: u19 (ref), u18 (ref), u15 (copy)
        if u19 then
            return;
        end;

        u18 = true;
        task.delay(0.01, function() -- Line: 300
            -- upvalues: u18 (ref)
            u18 = false;
        end);

        if u15.locked then
            return;
        end;

        if u15.isSelected then
            u15:deselect("User", u15);

            return;
        end;

        u15:select("User", u15);
    end);
    v16:add(UserInputService.InputBegan:Connect(function(p20, p21) -- Line: 307
        -- upvalues: u15 (copy)
        if u15.locked then
            return;
        end;

        if u15.bindedToggleKeys[p20.KeyCode] and not p21 then
            if u15.locked then
                return;
            end;

            if u15.isSelected then
                u15:deselect("User", u15);

                return;
            end;

            u15:select("User", u15);
        end;
    end));

    local function viewingEnded() -- Line: 329
        -- upvalues: u15 (copy)
        if u15.locked then
            return;
        end;

        u15.isViewing = false;
        u15.viewingEnded:Fire(true);
        u15:setState(nil, "User", u15);
    end;

    u15.joinedParent:Connect(function() -- Line: 337
        -- upvalues: u15 (copy)
        if u15.isViewing then
            if u15.locked then
                return;
            end;

            u15.isViewing = false;
            u15.viewingEnded:Fire(true);
            u15:setState(nil, "User", u15);
        end;
    end);
    Instance.MouseEnter:Connect(function() -- Line: 342
        -- upvalues: UserInputService (ref), u15 (copy)
        local v22 = not UserInputService.KeyboardEnabled;

        if u15.locked then
            return;
        end;

        u15.isViewing = true;
        u15.viewingStarted:Fire(true);

        if not v22 then
            u15:setState("Viewing", "User", u15);
        end;
    end);
    local u23 = 0;
    v16:add(UserInputService.TouchEnded:Connect(viewingEnded));
    Instance.MouseLeave:Connect(viewingEnded);
    Instance.SelectionGained:Connect(function(p24) -- Line: 319, Name: viewingStarted
        -- upvalues: u15 (copy)
        if u15.locked then
            return;
        end;

        u15.isViewing = true;
        u15.viewingStarted:Fire(true);

        if not p24 then
            u15:setState("Viewing", "User", u15);
        end;
    end);
    Instance.SelectionLost:Connect(viewingEnded);
    Instance.MouseButton1Down:Connect(function() -- Line: 351
        -- upvalues: u15 (copy), UserInputService (ref), u23 (ref)
        if not u15.locked and UserInputService.TouchEnabled then
            u23 = u23 + 1;
            local u25 = u23;
            task.delay(0.2, function() -- Line: 355
                -- upvalues: u25 (copy), u23 (ref), u15 (ref)
                if u25 == u23 then
                    if u15.locked then
                        return;
                    end;

                    u15.isViewing = true;
                    u15.viewingStarted:Fire(true);
                    u15:setState("Viewing", "User", u15);
                end;
            end);
        end;
    end);
    Instance.MouseButton1Up:Connect(function() -- Line: 362
        -- upvalues: u23 (ref)
        u23 = u23 + 1;
    end);
    local Instance2 = u15:getInstance("IconOverlay");
    u15.viewingStarted:Connect(function() -- Line: 368
        -- upvalues: Instance2 (copy), u15 (copy)
        Instance2.Visible = not u15.overlayDisabled;
    end);
    u15.viewingEnded:Connect(function() -- Line: 371
        -- upvalues: Instance2 (copy)
        Instance2.Visible = false;
    end);
    v16:add(u5:Connect(function(p26) -- Line: 376
        -- upvalues: u15 (copy)
        if p26 ~= u15 and (u15.deselectWhenOtherIconSelected and p26.deselectWhenOtherIconSelected) then
            u15:deselect("AutoDeselect", p26);
        end;
    end));
    local debug_info_ret = debug.info(2, "s");
    local string_split_ret = string.split(debug_info_ret, ".");
    local v27 = game;
    local v28 = nil;

    for _, v in pairs(string_split_ret) do
        v27 = v27:FindFirstChild(v);

        if not v27 then
            break;
        end;

        if v27:IsA("ScreenGui") then
            v28 = v27;
        end;
    end;

    if v27 and (v28 and v28.ResetOnSpawn == true) then
        Utility.localPlayerRespawned(function() -- Line: 401
            -- upvalues: u15 (copy)
            u15:destroy();
        end);
    end;

    u15:getInstance("NoticeLabel");
    u15.toggled:Connect(function(p29) -- Line: 408
        -- upvalues: u15 (copy), u3 (ref)
        u15.noticeChanged:Fire(u15.totalNotices);

        for i, _ in pairs(u15.childIconsDict) do
            local IconByUID = u3.getIconByUID(i);
            IconByUID.noticeChanged:Fire(IconByUID.totalNotices);

            if not p29 and IconByUID.isSelected then
                for _, _ in pairs(IconByUID.childIconsDict) do
                    IconByUID:deselect("HideParentFeature", u15);
                end;
            end;
        end;
    end);
    u15.selected:Connect(function() -- Line: 431
        -- upvalues: u15 (copy), StarterGui (ref)
        if #u15.dropdownIcons > 0 then
            if StarterGui:GetCore("ChatActive") and u15.alignment ~= "Right" then
                u15.chatWasPreviouslyActive = true;
                StarterGui:SetCore("ChatActive", false);
            end;

            if StarterGui:GetCoreGuiEnabled("PlayerList") and u15.alignment ~= "Left" then
                u15.playerlistWasPreviouslyActive = true;
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
            end;
        end;
    end);
    u15.deselected:Connect(function() -- Line: 444
        -- upvalues: u15 (copy), StarterGui (ref)
        if u15.chatWasPreviouslyActive then
            u15.chatWasPreviouslyActive = nil;
            StarterGui:SetCore("ChatActive", true);
        end;

        if u15.playerlistWasPreviouslyActive then
            u15.playerlistWasPreviouslyActive = nil;
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
        end;
    end);
    task.delay(0.1, function() -- Line: 459
        -- upvalues: u15 (copy)
        if u15.activeState == "Deselected" then
            u15.stateChanged:Fire("Deselected");
            u15:refresh();
        end;
    end);
    u3.iconAdded:Fire(u15);

    return u15;
end;

function u3.setName(p30, p31) -- Line: 475
    p30.widget.Name = p31;
    p30.name = p31;

    return p30;
end;

function u3.setState(p32, p33, p34, p35) -- Line: 481
    -- upvalues: Utility (copy), u5 (copy)
    local v36 = Utility.formatStateName(p33 or (p32.isSelected and "Selected" or "Deselected"));

    if p32.activeState == v36 then
        return;
    end;

    local isSelected = p32.isSelected;
    p32.activeState = v36;

    if v36 == "Deselected" then
        p32.isSelected = false;

        if isSelected then
            p32.toggled:Fire(false, p34, p35);
            p32.deselected:Fire(p34, p35);
        end;

        p32:_setToggleItemsVisible(false, p34, p35);
    elseif v36 == "Selected" then
        p32.isSelected = true;

        if not isSelected then
            p32.toggled:Fire(true, p34, p35);
            p32.selected:Fire(p34, p35);
            u5:Fire(p32, p34, p35);
        end;

        p32:_setToggleItemsVisible(true, p34, p35);
    end;

    p32.stateChanged:Fire(v36, p34, p35);
end;

function u3.getInstance(u37, u38) -- Line: 514
    -- upvalues: Themes (copy)
    local v39 = u37.cachedNamesToInstances[u38];

    if v39 then
        return v39;
    end;

    local function cacheInstance(u40, u41) -- Line: 522
        -- upvalues: u37 (copy)
        if not u37.cachedInstances[u41] then
            local Attribute = u41:GetAttribute("Collective");

            if Attribute then
                Attribute = u37.cachedCollectives[Attribute];
            end;

            if Attribute then
                table.insert(Attribute, u41);
            end;

            u37.cachedNamesToInstances[u40] = u41;
            u37.cachedInstances[u41] = true;
            u41.Destroying:Once(function() -- Line: 532
                -- upvalues: u37 (ref), u40 (copy), u41 (copy)
                u37.cachedNamesToInstances[u40] = nil;
                u37.cachedInstances[u41] = nil;
            end);
        end;
    end;

    local widget = u37.widget;
    cacheInstance("Widget", widget);

    if u38 == "Widget" then
        return widget;
    end;

    local u42 = nil;

    local function scanChildren(p43) -- Line: 545
        -- upvalues: u37 (copy), Themes (ref), scanChildren (copy), cacheInstance (copy), u38 (copy), u42 (ref)
        for _, child in pairs(p43:GetChildren()) do
            local Attribute = child:GetAttribute("WidgetUID");

            if not Attribute or Attribute == u37.UID then
                local v44 = Themes.getRealInstance(child) or child;
                scanChildren(v44);

                if v44:IsA("GuiBase") or (v44:IsA("UIBase") or v44:IsA("ValueBase")) then
                    local Name = v44.Name;
                    cacheInstance(Name, v44);

                    if Name == u38 then
                        u42 = v44;
                    end;
                end;
            end;
        end;
    end;

    scanChildren(widget);

    return u42;
end;

function u3.getCollective(p45, p46) -- Line: 575
    local v47 = p45.cachedCollectives[p46];

    if v47 then
        return v47;
    end;

    local v48 = {};

    for i, _ in pairs(p45.cachedInstances) do
        if i:GetAttribute("Collective") == p46 then
            table.insert(v48, i);
        end;
    end;

    p45.cachedCollectives[p46] = v48;

    return v48;
end;

function u3.getInstanceOrCollective(p49, p50) -- Line: 596
    local v51 = {};
    local Instance = p49:getInstance(p50);

    if Instance then
        table.insert(v51, Instance);
    end;

    if #v51 == 0 then
        v51 = p49:getCollective(p50);
    end;

    return v51;
end;

function u3.getStateGroup(p52, p53) -- Line: 610
    local v54 = p53 or p52.activeState;
    local v55 = p52.appearance[v54];

    if not v55 then
        v55 = {};
        p52.appearance[v54] = v55;
    end;

    return v55;
end;

function u3.refreshAppearance(p56, p57, p58) -- Line: 620
    -- upvalues: Themes (copy)
    Themes.refresh(p56, p57, p58);

    return p56;
end;

function u3.refresh(p59) -- Line: 625
    p59:refreshAppearance(p59.widget);
    p59.updateSize:Fire();

    return p59;
end;

function u3.updateParent(p60) -- Line: 631
    -- upvalues: u3 (copy)
    local IconByUID = u3.getIconByUID(p60.parentIconUID);

    if IconByUID then
        IconByUID.updateSize:Fire();
    end;
end;

function u3.setBehaviour(p61, p62, p63, p64, p65) -- Line: 638
    p61.customBehaviours[p62 .. "-" .. p63] = p64;

    if p65 then
        local InstanceOrCollective = p61:getInstanceOrCollective(p62);

        for _, v in pairs(InstanceOrCollective) do
            p61:refreshAppearance(v, p63);
        end;
    end;
end;

function u3.modifyTheme(p66, p67, p68) -- Line: 651
    -- upvalues: Themes (copy)
    return p66, Themes.modify(p66, p67, p68);
end;

function u3.modifyChildTheme(p69, p70, p71) -- Line: 656
    -- upvalues: u3 (copy)
    p69.childModifications = p70;
    p69.childModificationsUID = p71;

    for i, _ in pairs(p69.childIconsDict) do
        u3.getIconByUID(i):modifyTheme(p70, p71);
    end;

    p69.childThemeModified:Fire();

    return p69;
end;

function u3.removeModification(p72, p73) -- Line: 669
    -- upvalues: Themes (copy)
    Themes.remove(p72, p73);

    return p72;
end;

function u3.removeModificationWith(p74, p75, p76, p77) -- Line: 674
    -- upvalues: Themes (copy)
    Themes.removeWith(p74, p75, p76, p77);

    return p74;
end;

function u3.setTheme(p78, p79) -- Line: 679
    -- upvalues: Themes (copy)
    Themes.set(p78, p79);

    return p78;
end;

function u3.setEnabled(p80, p81) -- Line: 684
    p80.isEnabled = p81;
    p80.widget.Visible = p81;
    p80:updateParent();

    return p80;
end;

function u3.select(p82, p83, p84) -- Line: 691
    p82:setState("Selected", p83, p84);

    return p82;
end;

function u3.deselect(p85, p86, p87) -- Line: 696
    p85:setState("Deselected", p86, p87);

    return p85;
end;

function u3.notify(p88, p89, p90) -- Line: 701
    -- upvalues: Elements (copy), u3 (copy)
    if not p88.notice then
        p88.notice = require(Elements.Notice)(p88, u3);
    end;

    p88.noticeStarted:Fire(p89, p90);

    return p88;
end;

function u3.clearNotices(p91) -- Line: 715
    p91.endNotices:Fire();

    return p91;
end;

function u3.disableOverlay(p92, p93) -- Line: 720
    p92.overlayDisabled = p93;

    return p92;
end;

u3.disableStateOverlay = u3.disableOverlay;

function u3.setImage(p94, p95, p96) -- Line: 726
    p94:modifyTheme({
        "IconImage",
        "Image",
        p95,
        p96
    });

    return p94;
end;

function u3.setLabel(p97, p98, p99) -- Line: 731
    p97:modifyTheme({
        "IconLabel",
        "Text",
        p98,
        p99
    });

    return p97;
end;

function u3.setOrder(p100, p101, p102) -- Line: 736
    p100:modifyTheme({
        "Widget",
        "LayoutOrder",
        p101,
        p102
    });

    return p100;
end;

function u3.setCornerRadius(p103, p104, p105) -- Line: 741
    p103:modifyTheme({
        "IconCorners",
        "CornerRadius",
        p104,
        p105
    });

    return p103;
end;

function u3.align(p106, p107, p108) -- Line: 746
    -- upvalues: u3 (copy)
    local v109 = tostring(p107):lower();
    local v110 = (v109 == "mid" or v109 == "centre") and "center" or v109;
    local v111 = v110 ~= "left" and (v110 ~= "center" and v110 ~= "right") and "left" or v110;
    local v112 = v111 == "center" and u3.container.TopbarCentered or u3.container.TopbarStandard;
    local Holders = v112.Holders;
    local v113 = string.upper((string.sub(v111, 1, 1))) .. string.sub(v111, 2);

    if not p108 then
        p106.originalAlignment = v113;
    end;

    local joinedFrame = p106.joinedFrame;
    local v114 = Holders[v113];
    p106.screenGui = v112;
    p106.alignmentHolder = v114;

    if not p106.isDestroyed then
        p106.widget.Parent = joinedFrame or v114;
    end;

    p106.alignment = v113;
    p106.alignmentChanged:Fire(v113);
    u3.iconChanged:Fire(p106);

    return p106;
end;

u3.setAlignment = u3.align;

function u3.setLeft(p115) -- Line: 775
    p115:setAlignment("Left");

    return p115;
end;

function u3.setMid(p116) -- Line: 780
    p116:setAlignment("Center");

    return p116;
end;

function u3.setRight(p117) -- Line: 785
    p117:setAlignment("Right");

    return p117;
end;

function u3.setWidth(p118, p119, p120) -- Line: 790
    p118:modifyTheme({
        "Widget",
        "Size",
        UDim2.fromOffset(p119, p118.widget.Size.Y.Offset),
        p120
    });
    p118:modifyTheme({
        "Widget",
        "DesiredWidth",
        p119,
        p120
    });

    return p118;
end;

function u3.setImageScale(p121, p122, p123) -- Line: 800
    p121:modifyTheme({
        "IconImageScale",
        "Value",
        p122,
        p123
    });

    return p121;
end;

function u3.setImageRatio(p124, p125, p126) -- Line: 805
    p124:modifyTheme({
        "IconImageRatio",
        "AspectRatio",
        p125,
        p126
    });

    return p124;
end;

function u3.setTextSize(p127, p128, p129) -- Line: 810
    p127:modifyTheme({
        "IconLabel",
        "TextSize",
        p128,
        p129
    });

    return p127;
end;

function u3.setTextFont(p130, p131, p132, p133, p134) -- Line: 815
    local v135 = p132 or Enum.FontWeight.Regular;
    local v136 = p133 or Enum.FontStyle.Normal;
    local v137 = nil;
    local v138 = typeof(p131);

    if v138 == "number" then
        v137 = Font.fromId(p131, v135, v136);
    elseif v138 == "EnumItem" then
        v137 = Font.fromEnum(p131);
    elseif v138 == "string" and not p131:match("rbxasset") then
        v137 = Font.fromName(p131, v135, v136);
    end;

    p130:modifyTheme({
        "IconLabel",
        "FontFace",
        v137 or Font.new(p131, v135, v136),
        p134
    });

    return p130;
end;

function u3.bindToggleItem(p139, p140) -- Line: 836
    if not (p140:IsA("GuiObject") or p140:IsA("LayerCollector")) then
        error("Toggle item must be a GuiObject or LayerCollector!");
    end;

    p139.toggleItems[p140] = true;
    p139:_updateSelectionInstances();

    return p139;
end;

function u3.unbindToggleItem(p141, p142) -- Line: 845
    p141.toggleItems[p142] = nil;
    p141:_updateSelectionInstances();

    return p141;
end;

function u3._updateSelectionInstances(p143) -- Line: 851
    for i, _ in pairs(p143.toggleItems) do
        local v144 = {};

        for _, descendant in pairs(i:GetDescendants()) do
            if (descendant:IsA("TextButton") or descendant:IsA("ImageButton")) and descendant.Active then
                table.insert(v144, descendant);
            end;
        end;

        p143.toggleItems[i] = v144;
    end;
end;

function u3._setToggleItemsVisible(p145, p146, p147, p148) -- Line: 865
    for i, _ in pairs(p145.toggleItems) do
        if not p148 or (p148 == p145 or p148.toggleItems[i] == nil) then
            i[i:IsA("LayerCollector") and "Enabled" or "Visible"] = p146;
        end;
    end;
end;

function u3.bindEvent(u149, p150, u151) -- Line: 877
    local v152 = u149[p150];
    local v153;

    if v152 then
        if typeof(v152) == "table" then
            v153 = v152.Connect;
        else
            v153 = false;
        end;
    else
        v153 = v152;
    end;

    assert(v153, "argument[1] must be a valid topbarplus icon event name!");
    local v154 = typeof(u151) == "function";
    assert(v154, "argument[2] must be a function!");
    u149.bindedEvents[p150] = v152:Connect(function(...) -- Line: 881
        -- upvalues: u151 (copy), u149 (copy)
        u151(u149, ...);
    end);

    return u149;
end;

function u3.unbindEvent(p155, p156) -- Line: 887
    local v157 = p155.bindedEvents[p156];

    if v157 then
        v157:Disconnect();
        p155.bindedEvents[p156] = nil;
    end;

    return p155;
end;

function u3.bindToggleKey(p158, p159) -- Line: 896
    local v160 = typeof(p159) == "EnumItem";
    assert(v160, "argument[1] must be a KeyCode EnumItem!");
    p158.bindedToggleKeys[p159] = true;
    p158.toggleKeyAdded:Fire(p159);
    p158:setCaption("_hotkey_");

    return p158;
end;

function u3.unbindToggleKey(p161, p162) -- Line: 904
    local v163 = typeof(p162) == "EnumItem";
    assert(v163, "argument[1] must be a KeyCode EnumItem!");
    p161.bindedToggleKeys[p162] = nil;

    return p161;
end;

function u3.call(u164, u165, ...) -- Line: 910
    local table_pack_ret = table.pack(...);
    task.spawn(function() -- Line: 912
        -- upvalues: u165 (copy), u164 (copy), table_pack_ret (copy)
        u165(u164, table.unpack(table_pack_ret));
    end);

    return u164;
end;

function u3.addToJanitor(p166, p167, p168, p169) -- Line: 918
    p166.janitor:add(p167, p168, p169);

    return p166;
end;

function u3.lock(p170) -- Line: 923
    p170:getInstance("ClickRegion").Visible = false;
    p170.locked = true;

    return p170;
end;

function u3.unlock(p171) -- Line: 931
    p171:getInstance("ClickRegion").Visible = true;
    p171.locked = false;

    return p171;
end;

function u3.debounce(p172, p173) -- Line: 938
    p172:lock();
    task.wait(p173);
    p172:unlock();

    return p172;
end;

function u3.autoDeselect(p174, p175) -- Line: 945
    p174.deselectWhenOtherIconSelected = p175 == nil and true or p175;

    return p174;
end;

function u3.oneClick(u176, p177) -- Line: 955
    local singleClickJanitor = u176.singleClickJanitor;
    singleClickJanitor:clean();

    if p177 or p177 == nil then
        singleClickJanitor:add(u176.selected:Connect(function() -- Line: 961
            -- upvalues: u176 (copy)
            u176:deselect("OneClick", u176);
        end));
    end;

    u176.oneClickEnabled = true;

    return u176;
end;

function u3.setCaption(p178, p179) -- Line: 969
    -- upvalues: Elements (copy)
    if p179 == "_hotkey_" and p178.captionText then
        return p178;
    end;

    local captionJanitor = p178.captionJanitor;
    p178.captionJanitor:clean();

    if not p179 or p179 == "" then
        p178.caption = nil;
        p178.captionText = nil;

        return p178;
    end;

    local v180 = captionJanitor:add(require(Elements.Caption)(p178));
    v180:SetAttribute("CaptionText", p179);
    p178.caption = v180;
    p178.captionText = p179;

    return p178;
end;

function u3.setCaptionHint(p181, p182) -- Line: 987
    local v183 = typeof(p182) == "EnumItem";
    assert(v183, "argument[1] must be a KeyCode EnumItem!");
    p181.fakeToggleKey = p182;
    p181.fakeToggleKeyChanged:Fire(p182);
    p181:setCaption("_hotkey_");

    return p181;
end;

function u3.leave(p184) -- Line: 995
    p184.joinJanitor:clean();

    return p184;
end;

function u3.joinMenu(p185, p186) -- Line: 1001
    -- upvalues: Utility (copy)
    Utility.joinFeature(p185, p186, p186.menuIcons, p186:getInstance("Menu"));
    p186.menuChildAdded:Fire(p185);

    return p185;
end;

function u3.setMenu(p187, p188) -- Line: 1007
    p187.menuSet:Fire(p188);

    return p187;
end;

function u3.setFrozenMenu(p189, p190) -- Line: 1012
    p189:freezeMenu(p190);
    p189:setMenu(p190);
end;

function u3.freezeMenu(u191) -- Line: 1017
    u191:select("FrozenMenu", u191);
    u191:bindEvent("deselected", function(p192) -- Line: 1021
        -- upvalues: u191 (copy)
        p192:select("FrozenMenu", u191);
    end);
    u191:modifyTheme({ "IconSpot", "Visible", false });
end;

function u3.joinDropdown(p193, p194) -- Line: 1027
    -- upvalues: Utility (copy)
    p194:getDropdown();
    Utility.joinFeature(p193, p194, p194.dropdownIcons, p194:getInstance("DropdownScroller"));
    p194.dropdownChildAdded:Fire(p193);

    return p193;
end;

function u3.getDropdown(p195) -- Line: 1034
    -- upvalues: Elements (copy)
    local dropdown = p195.dropdown;

    if not dropdown then
        dropdown = require(Elements.Dropdown)(p195);
        p195.dropdown = dropdown;
        p195:clipOutside(dropdown);
    end;

    return dropdown;
end;

function u3.setDropdown(p196, p197) -- Line: 1044
    p196:getDropdown();
    p196.dropdownSet:Fire(p197);

    return p196;
end;

function u3.clipOutside(p198, p199) -- Line: 1050
    -- upvalues: Utility (copy)
    local v200 = Utility.clipOutside(p198, p199);
    p198:refreshAppearance(p199);

    return p198, v200;
end;

function u3.setIndicator(p201, p202) -- Line: 1061
    -- upvalues: Elements (copy), u3 (copy)
    if not p201.indicator then
        p201.indicator = p201.janitor:add(require(Elements.Indicator)(p201, u3));
    end;

    p201.indicatorSet:Fire(p202);
end;

function u3.destroy(p203) -- Line: 1076
    -- upvalues: u3 (copy)
    if p203.isDestroyed then
        return;
    end;

    p203:clearNotices();

    if p203.parentIconUID then
        p203:leave();
    end;

    p203.isDestroyed = true;
    p203.janitor:clean();
    u3.iconRemoved:Fire(p203);
end;

u3.Destroy = u3.destroy;

return u3;