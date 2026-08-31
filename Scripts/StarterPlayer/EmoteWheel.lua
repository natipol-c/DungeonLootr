--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EmoteWheel
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.EmoteWheel
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"));
local EmoteData = require(ReplicatedStorage:WaitForChild("GameInfo"):WaitForChild("EmoteData"));
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;

local function GetControls() -- Line: 66
    -- upvalues: u1 (ref), LocalPlayer (copy)
    if u1 then
        return u1;
    end;

    local success, result = pcall(function() -- Line: 68
        -- upvalues: LocalPlayer (ref)
        local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts");

        return require(PlayerScripts:WaitForChild("PlayerModule")):GetControls();
    end);

    if success and result then
        u1 = result;
    end;

    return u1;
end;

local function ForcedDirVector(p2, p3: string) -- Line: 82
    local v4;

    if p3 == "Forward" then
        v4 = p2.LookVector;
    elseif p3 == "Back" then
        v4 = -p2.LookVector;
    elseif p3 == "Left" then
        v4 = -p2.RightVector;
    elseif p3 == "Right" then
        v4 = p2.RightVector;
    else
        v4 = -p2.LookVector;
    end;

    local Vector3_new_ret = Vector3.new(v4.X, 0, v4.Z);

    return Vector3_new_ret.Magnitude < 0.001 and Vector3.new(0, 0, 0) or Vector3_new_ret.Unit;
end;

local u5 = Enum.RenderPriority.Input.Value + 1;
local TweenInfo_new_ret = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local Color3_fromRGB_ret = Color3.fromRGB(96, 220, 120);
local u6 = {
    Attack = true,
    Dodge = true,
    ParryBlock = true,
    Skill1 = true,
    Skill2 = true,
    Skill3 = true,
    Skill4 = true,
    SkillE = true
};
local TweenInfo_new_ret2 = TweenInfo.new(2.5, Enum.EasingStyle.Linear);
local TweenInfo_new_ret3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local CFrame_new_ret = CFrame.new(Vector3.new(0, 0.5, -12), Vector3.new(0, 0.5, 0));
local CFrame_new_ret2 = CFrame.new(0, 0.5, 0);
local v7 = {};
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = false;
local u19 = nil;
local u20 = 0;
local u21 = {};
local Color3_fromRGB_ret2 = Color3.fromRGB(49, 49, 49);
local u22 = {};
local u23 = {};
local u24 = "";
local u25 = "Name";
local u26 = 1;
local u27 = nil;

local function CloneCharacter() -- Line: 190
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    local v28 = {};

    for _, descendant in Character:GetDescendants() do
        if not descendant.Archivable then
            descendant.Archivable = true;
            table.insert(v28, descendant);
        end;
    end;

    local Archivable = Character.Archivable;
    Character.Archivable = true;
    local v29 = Character:Clone();
    Character.Archivable = Archivable;

    for _, v in v28 do
        v.Archivable = false;
    end;

    for _, descendant in v29:GetDescendants() do
        if descendant:IsA("BaseScript") or (descendant:IsA("Tool") or (descendant:IsA("ForceField") or (descendant:IsA("BillboardGui") or descendant.Name == "Holder"))) then
            descendant:Destroy();
        end;
    end;

    return v29;
end;

local function BuildPreview(p30: userdata, p31: string, p32: table) -- Line: 224
    -- upvalues: CloneCharacter (copy), CFrame_new_ret2 (copy), CFrame_new_ret (copy), EmoteData (copy)
    if not (p30 and p30.Parent) then
        return;
    end;

    local v33 = p30:FindFirstChildOfClass("WorldModel");

    if v33 then
        for _, child in v33:GetChildren() do
            child:Destroy();
        end;
    else
        v33 = Instance.new("WorldModel");
        v33.Parent = p30;
    end;

    local v34 = CloneCharacter();

    if not v34 then
        return;
    end;

    local HumanoidRootPart = v34:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        v34.PrimaryPart = HumanoidRootPart;
        v34:PivotTo(CFrame_new_ret2);
    end;

    v34.Parent = v33;
    local v35 = p30:FindFirstChildOfClass("Camera");

    if not v35 then
        v35 = Instance.new("Camera");
        v35.Parent = p30;
    end;

    v35.FieldOfView = 30;
    v35.CFrame = CFrame_new_ret;
    p30.CurrentCamera = v35;
    local v36 = {
        track = nil,
        clone = v34
    };
    table.insert(p32, v36);
    local v37 = v34:FindFirstChildOfClass("Humanoid");

    if v37 then
        local u38 = v37:FindFirstChildOfClass("Animator");

        if not u38 then
            u38 = Instance.new("Animator");
            u38.Parent = v37;
        end;

        local Animation = EmoteData.GetAnimation(p31);

        if Animation then
            local success, result = pcall(function() -- Line: 270
                -- upvalues: u38 (ref), Animation (copy)
                return u38:LoadAnimation(Animation);
            end);

            if success and result then
                result.Priority = Enum.AnimationPriority.Action4;
                result.Looped = true;
                result:Play();
                v36.track = result;
            end;
        end;
    end;
end;

local function ClearPreviewStore(p39: table) -- Line: 283
    for _, v in p39 do
        if v.track then
            pcall(function() -- Line: 286
                -- upvalues: v (copy)
                v.track:Stop();
            end);
        end;

        if v.clone then
            v.clone:Destroy();
        end;
    end;

    table.clear(p39);
end;

local function GetEmotes() -- Line: 297
    -- upvalues: u14 (ref)
    local v40 = u14 and u14.Data;

    if v40 then
        v40 = v40.Emotes;
    end;

    return {
        Owned = v40 and (v40.Owned or {}) or {},
        Wheel = v40 and (v40.Wheel or {}) or {},
        Favorites = v40 and v40.Favorites or {}
    };
end;

local function PlaySound(p41: string) -- Line: 307
    -- upvalues: u17 (ref)
    if u17 then
        u17:Play(p41);
    end;
end;

local function ResetDeleting(p42: userdata?, p43: boolean?) -- Line: 317
    -- upvalues: TweenService (copy), TweenInfo_new_ret3 (copy)
    if not p42 then
        return;
    end;

    if p43 then
        p42.ImageTransparency = 1;

        return;
    end;

    TweenService:Create(p42, TweenInfo_new_ret3, {
        ImageTransparency = 1
    }):Play();
end;

local function EndHold() -- Line: 329
    -- upvalues: u19 (ref), u20 (ref), TweenService (copy), TweenInfo_new_ret3 (copy)
    local u44 = u19;

    if not u44 then
        return;
    end;

    u19 = nil;
    u20 = u20 + 1;

    if u44.fadeTween then
        pcall(function() -- Line: 335
            -- upvalues: u44 (copy)
            u44.fadeTween:Cancel();
        end);
    end;

    local deleting = u44.deleting;

    if not deleting then
        return;
    end;

    TweenService:Create(deleting, TweenInfo_new_ret3, {
        ImageTransparency = 1
    }):Play();
end;

local function BeginHold(u45: number, u46: userdata?) -- Line: 342
    -- upvalues: u19 (ref), u20 (ref), TweenService (copy), TweenInfo_new_ret3 (copy), u21 (copy), GetEmotes (copy), TweenInfo_new_ret2 (copy), u15 (ref), u17 (ref)
    local u47 = u19 and u19;

    if u47 then
        u19 = nil;
        u20 = u20 + 1;

        if u47.fadeTween then
            pcall(function() -- Line: 335
                -- upvalues: u47 (copy)
                u47.fadeTween:Cancel();
            end);
        end;

        local deleting = u47.deleting;

        if deleting then
            TweenService:Create(deleting, TweenInfo_new_ret3, {
                ImageTransparency = 1
            }):Play();
        end;
    end;

    u21[u45] = nil;

    if not GetEmotes().Wheel[tostring(u45)] then
        return;
    end;

    u20 = u20 + 1;
    local u48 = u20;
    local u49 = {
        fadeTween = nil,
        slot = u45,
        deleting = u46,
        token = u48
    };
    u19 = u49;

    if u46 then
        u46.ImageTransparency = 1;
    end;

    task.delay(0.5, function() -- Line: 357
        -- upvalues: u19 (ref), u49 (copy), u48 (copy), u46 (copy), TweenService (ref), TweenInfo_new_ret2 (ref)
        if u19 ~= u49 or u49.token ~= u48 then
            return;
        end;

        if u46 then
            local v50 = TweenService:Create(u46, TweenInfo_new_ret2, {
                ImageTransparency = 0
            });
            u49.fadeTween = v50;
            v50:Play();
        end;
    end);
    task.delay(3, function() -- Line: 369
        -- upvalues: u19 (ref), u49 (copy), u48 (copy), u21 (ref), u45 (copy), u15 (ref), u17 (ref), u46 (copy)
        if u19 ~= u49 or u49.token ~= u48 then
            return;
        end;

        u19 = nil;
        u21[u45] = true;
        u15:SetWheelSlot(u45, nil):catch(warn);

        if u17 then
            u17:Play("UI_Begin");
        end;

        local v51 = u46;

        if not v51 then
            return;
        end;

        v51.ImageTransparency = 1;
    end);
end;

local function BuildWheel() -- Line: 379
    -- upvalues: ClearPreviewStore (copy), u22 (copy), GetEmotes (copy), EmoteData (copy), u10 (ref), u9 (ref), u15 (ref), BuildPreview (copy)
    ClearPreviewStore(u22);
    local v52 = GetEmotes();

    for i = 1, EmoteData.WHEEL_SLOTS do
        local v53 = u10:FindFirstChild((tostring(i)));
        local v54;

        if v53 then
            local ViewportFrame = v53:FindFirstChild("ViewportFrame");
            local TextLabel = v53:FindFirstChild("TextLabel");
            local v55 = v52.Wheel[tostring(i)];
            local v56 = u9:FindFirstChild((tostring(i)));

            if v56 then
                v56 = v56:FindFirstChild("Deleting");
            end;

            if v56 and v56:IsA("ImageLabel") then
                v56.ImageTransparency = 1;
            end;

            if v55 and not EmoteData.IsPlayable(v55) then
                u15:SetWheelSlot(i, nil):catch(warn);
                v55 = nil;
            end;

            local v57;

            if v55 then
                v57 = EmoteData.Get(v55) or nil;
            else
                v57 = nil;
            end;

            if v57 then
                if TextLabel then
                    TextLabel.Visible = true;
                    TextLabel.Text = v57.DisplayName;
                end;

                if ViewportFrame then
                    ViewportFrame.Visible = true;
                    BuildPreview(ViewportFrame, v55, u22);
                    v54 = i;
                else
                    v54 = i;
                end;
            else
                if TextLabel then
                    TextLabel.Visible = false;
                end;

                if ViewportFrame then
                    ViewportFrame.Visible = false;
                    v54 = i;
                else
                    v54 = i;
                end;
            end;
        else
            v54 = i;
        end;
    end;
end;

local function ItemsPerPage() -- Line: 431
    -- upvalues: u12 (ref)
    local v58 = u12:FindFirstChildOfClass("UIGridLayout");
    local AbsoluteSize = u12.AbsoluteSize;

    if not v58 or (AbsoluteSize.X < 1 or AbsoluteSize.Y < 1) then
        return 6;
    end;

    local v59 = v58.CellSize.Y.Scale * AbsoluteSize.Y + v58.CellSize.Y.Offset;
    local v60 = v58.CellPadding.X.Scale * AbsoluteSize.X + v58.CellPadding.X.Offset;
    local v61 = v58.CellPadding.Y.Scale * AbsoluteSize.Y + v58.CellPadding.Y.Offset;
    local v62 = (AbsoluteSize.X + v60) / math.max(1, v58.CellSize.X.Scale * AbsoluteSize.X + v58.CellSize.X.Offset + v60);
    local math_floor_ret = math.floor(v62);
    local math_max_ret = math.max(1, math_floor_ret);
    local v63 = (AbsoluteSize.Y + v61) / math.max(1, v59 + v61);
    local math_floor_ret2 = math.floor(v63);
    local math_max_ret2 = math.max(1, math_floor_ret2);

    return math.max(1, math_max_ret * math_max_ret2);
end;

local function EquippedSlotOf(p64, p65) -- Line: 447
    for i, v in pairs(p64) do
        if v == p65 then
            return i;
        end;
    end;

    return nil;
end;

local function BuildOrderedIds(u66) -- Line: 460
    -- upvalues: EmoteData (copy), u25 (ref), u24 (ref)
    local v67 = {};
    local v68 = {};
    local v69 = {};

    for i in pairs(u66.Owned) do
        if EmoteData.IsValid(i) then
            if u66.Favorites[i] then
                table.insert(v67, i);
            else
                local v70 = i;
                local v71 = nil;

                for i2, v in pairs(u66.Wheel) do
                    if v == v70 then
                        v71 = i2;
                        break;
                    end;
                end;

                if v71 then
                    table.insert(v69, v70);
                else
                    table.insert(v68, v70);
                end;
            end;
        end;
    end;

    local function comparator(p72, p73) -- Line: 474
        -- upvalues: EmoteData (ref), u25 (ref), u66 (copy)
        local v74 = EmoteData.Get(p72);
        local v75 = EmoteData.Get(p73);

        if u25 == "Date" then
            local v76 = u66.Owned[p72] or 0;
            local v77 = u66.Owned[p73] or 0;

            if v76 == v77 then
                return (v74.Order or 0) < (v75.Order or 0);
            end;

            return v77 < v76;
        end;

        local v78 = v74.DisplayName:lower();
        local v79 = v75.DisplayName:lower();

        if v78 == v79 then
            return (v74.Order or 0) < (v75.Order or 0);
        end;

        return v78 < v79;
    end;

    table.sort(v67, comparator);
    table.sort(v69, comparator);
    table.sort(v68, comparator);
    local v80 = {};

    for _, v in ipairs(v67) do
        table.insert(v80, v);
    end;

    for _, v in ipairs(v69) do
        table.insert(v80, v);
    end;

    for _, v in ipairs(v68) do
        table.insert(v80, v);
    end;

    if u24 == "" then
        return v80;
    end;

    local v81 = u24:lower();
    local v82 = {};

    for _, v in ipairs(v80) do
        if EmoteData.Get(v).DisplayName:lower():find(v81, 1, true) then
            table.insert(v82, v);
        end;
    end;

    return v82;
end;

local function OnCardActivated(p83: string) -- Line: 513
    -- upvalues: GetEmotes (copy), u15 (ref), u17 (ref), EmoteData (copy)
    local v84 = GetEmotes();
    local v85 = nil;

    for i, v in pairs(v84.Wheel) do
        if v == p83 then
            v85 = i;
            break;
        end;
    end;

    if v85 then
        u15:SetWheelSlot(v85, nil):catch(warn);

        if u17 then
            u17:Play("UI_Begin");
        end;
    else
        local v86 = nil;

        for i = 1, EmoteData.WHEEL_SLOTS do
            if not v84.Wheel[tostring(i)] then
                v86 = i;
                break;
            end;

            local _ = i;
        end;

        if v86 then
            u15:SetWheelSlot(v86, p83):catch(warn);
        end;
    end;
end;

local function BuildBrowser() -- Line: 537
    -- upvalues: ClearPreviewStore (copy), u23 (copy), u12 (ref), u13 (ref), GetEmotes (copy), BuildOrderedIds (copy), ItemsPerPage (copy), u26 (ref), u11 (ref), EmoteData (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (ref), BuildPreview (copy), OnCardActivated (copy), u15 (ref)
    ClearPreviewStore(u23);

    for _, child in u12:GetChildren() do
        if child:IsA("GuiButton") and child ~= u13 then
            child:Destroy();
        end;
    end;

    local v87 = GetEmotes();
    local v88 = BuildOrderedIds(v87);
    local v89 = ItemsPerPage();
    local math_ceil_ret = math.ceil(#v88 / v89);
    local math_max_ret = math.max(1, math_ceil_ret);
    u26 = math.clamp(u26, 1, math_max_ret);
    local TextBox = u11.Page.Frame:FindFirstChild("TextBox");

    if TextBox then
        TextBox.Text = string.format("%d/%d", u26, math_max_ret);
    end;

    local v90 = (u26 - 1) * v89 + 1;

    for i = v90, math.min(#v88, v90 + v89 - 1) do
        local u91 = v88[i];
        local v92 = EmoteData.Get(u91);
        local v93 = u13:Clone();
        v93.Name = "Card_" .. u91;
        v93.Visible = true;
        v93.LayoutOrder = i;
        v93.Parent = u12;
        local EmoteName = v93:FindFirstChild("EmoteName", true);

        if EmoteName then
            EmoteName.Text = v92.DisplayName;
        end;

        local v94 = v93:FindFirstChildOfClass("UIStroke");
        local _ = i;
        local v95 = nil;

        for i2, v in pairs(v87.Wheel) do
            if v == u91 then
                v95 = i2;
                break;
            end;
        end;

        local v96 = v95 ~= nil;

        if v94 then
            v94.Color = v96 and Color3_fromRGB_ret or Color3_fromRGB_ret2;
        end;

        local FavoriteButton = v93:FindFirstChild("FavoriteButton");
        local v97;

        if FavoriteButton then
            v97 = FavoriteButton:FindFirstChild("Fill");
        else
            v97 = FavoriteButton;
        end;

        if v97 then
            v97.Visible = v87.Favorites[u91] == true;
        end;

        local Viewport = v93:FindFirstChild("Viewport");

        if Viewport then
            Viewport = Viewport:FindFirstChild("ViewportFrame");
        end;

        if Viewport then
            BuildPreview(Viewport, u91, u23);
        end;

        v93.Activated:Connect(function() -- Line: 597
            -- upvalues: OnCardActivated (ref), u91 (copy)
            OnCardActivated(u91);
        end);

        if FavoriteButton then
            FavoriteButton.Activated:Connect(function() -- Line: 601
                -- upvalues: u15 (ref), u91 (copy)
                u15:ToggleFavorite(u91):catch(warn);
            end);
        end;
    end;
end;

local function Render() -- Line: 608
    -- upvalues: BuildWheel (copy), BuildBrowser (copy)
    BuildWheel();
    BuildBrowser();
end;

local function StopActiveEmote(p98: boolean?) -- Line: 620
    -- upvalues: u27 (ref), RunService (copy), u15 (ref)
    local u99 = u27;
    u27 = nil;

    if not u99 then
        return;
    end;

    if u99.hrp and u99.hrp.Parent then
        pcall(function() -- Line: 627
            -- upvalues: u99 (copy)
            u99.hrp.Anchored = u99.hrpWasAnchored;
        end);
    end;

    if u99.forced then
        pcall(function() -- Line: 634
            -- upvalues: RunService (ref)
            RunService:UnbindFromRenderStep("EmoteForcedMovement");
        end);

        if u99.humanoid and u99.humanoid.Parent then
            pcall(function() -- Line: 636
                -- upvalues: u99 (copy)
                if u99.walkSpeedWas ~= nil then
                    u99.humanoid.WalkSpeed = u99.walkSpeedWas;
                end;

                if u99.autoRotateWas ~= nil then
                    u99.humanoid.AutoRotate = u99.autoRotateWas;
                end;
            end);
        end;

        if u99.hrp and u99.hrp.Parent then
            pcall(function() -- Line: 642
                -- upvalues: u99 (copy)
                u99.hrp.AssemblyLinearVelocity = Vector3.new(0, u99.hrp.AssemblyLinearVelocity.Y, 0);
            end);
        end;
    end;

    for _, v in u99.conns do
        pcall(function() -- Line: 649
            -- upvalues: v (copy)
            v:Disconnect();
        end);
    end;

    if u99.track then
        pcall(function() -- Line: 652
            -- upvalues: u99 (copy)
            u99.track:Stop();
        end);
    end;

    if p98 ~= false and (u99.broadcast and u15) then
        u15:StopEmote():catch(function() -- Line: 656
        end);
    end;

    if u15 then
        u15:SetEmoteActive(false):catch(function() -- Line: 664
        end);
    end;
end;

local function PlayEmote(p100: string) -- Line: 668
    -- upvalues: EmoteData (copy), StopActiveEmote (copy), LocalPlayer (copy), RunService (copy), u5 (copy), u27 (ref), u1 (ref), UserInputService (copy), u16 (ref), u6 (copy), u15 (ref)
    local v101 = EmoteData.HasFX(p100);
    StopActiveEmote(not v101);
    local Character = LocalPlayer.Character;
    local u102;

    if Character then
        u102 = Character:FindFirstChildOfClass("Humanoid");
    else
        u102 = Character;
    end;

    if not u102 then
        return;
    end;

    local u103 = u102:FindFirstChildOfClass("Animator");

    if not u103 then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if u102:GetState() == Enum.HumanoidStateType.Dead then
        return;
    end;

    if u102.FloorMaterial == Enum.Material.Air then
        return;
    end;

    if Character:GetAttribute("SkillIFrame") then
        return;
    end;

    if HumanoidRootPart and HumanoidRootPart.Anchored then
        return;
    end;

    local Animation = EmoteData.GetAnimation(p100);

    if not Animation then
        return;
    end;

    local success, result = pcall(function() -- Line: 702
        -- upvalues: u103 (copy), Animation (copy)
        return u103:LoadAnimation(Animation);
    end);

    if not (success and result) then
        return;
    end;

    result.Priority = Enum.AnimationPriority.Action4;
    local v104 = EmoteData.AllowsMovement(p100);
    local ForcedMovement = EmoteData.GetForcedMovement(p100);
    local v105;

    if HumanoidRootPart then
        v105 = HumanoidRootPart.Anchored;

        if not (v104 or ForcedMovement) then
            HumanoidRootPart.Anchored = true;
        end;
    else
        v105 = false;
    end;

    result:Play();
    local v106 = {};

    if not (v104 or ForcedMovement) then
        local function cancelIfMoving() -- Line: 747
            -- upvalues: u102 (copy), StopActiveEmote (ref)
            if u102.MoveDirection.Magnitude > 0 then
                StopActiveEmote();
            end;
        end;

        local PropertyChangedSignal = u102:GetPropertyChangedSignal("MoveDirection");
        table.insert(v106, PropertyChangedSignal:Connect(cancelIfMoving));
        task.defer(cancelIfMoving);
    end;

    if v104 or ForcedMovement then
        local Health = u102.Health;
        table.insert(v106, u102.HealthChanged:Connect(function(p107) -- Line: 759
            -- upvalues: Health (ref), StopActiveEmote (ref)
            if p107 < Health then
                StopActiveEmote();

                return;
            end;

            Health = p107;
        end));
    end;

    local v108, v109;

    if ForcedMovement then
        v108 = u102.WalkSpeed;
        v109 = u102.AutoRotate;
        u102.WalkSpeed = ForcedMovement.Speed;
        u102.AutoRotate = false;
        pcall(function() -- Line: 782
            -- upvalues: RunService (ref)
            RunService:UnbindFromRenderStep("EmoteForcedMovement");
        end);
        RunService:BindToRenderStep("EmoteForcedMovement", u5, function() -- Line: 783
            -- upvalues: u27 (ref), result (copy), HumanoidRootPart (copy), u1 (ref), LocalPlayer (ref), StopActiveEmote (ref), ForcedMovement (copy), u102 (copy)
            if not u27 or u27.track ~= result then
                return;
            end;

            if not (HumanoidRootPart and HumanoidRootPart.Parent) then
                return;
            end;

            local v110;

            if u1 then
                v110 = u1;
            else
                local success2, result2 = pcall(function() -- Line: 68
                    -- upvalues: LocalPlayer (ref)
                    local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts");

                    return require(PlayerScripts:WaitForChild("PlayerModule")):GetControls();
                end);

                if success2 and result2 then
                    u1 = result2;
                end;

                v110 = u1;
            end;

            if v110 and v110:GetMoveVector().Magnitude > 0.1 then
                StopActiveEmote();

                return;
            end;

            local CFrame2 = HumanoidRootPart.CFrame;
            local Direction = ForcedMovement.Direction;
            local v111;

            if Direction == "Forward" then
                v111 = CFrame2.LookVector;
            elseif Direction == "Back" then
                v111 = -CFrame2.LookVector;
            elseif Direction == "Left" then
                v111 = -CFrame2.RightVector;
            elseif Direction == "Right" then
                v111 = CFrame2.RightVector;
            else
                v111 = -CFrame2.LookVector;
            end;

            local Vector3_new_ret = Vector3.new(v111.X, 0, v111.Z);
            local v112 = Vector3_new_ret.Magnitude < 0.001 and Vector3.new(0, 0, 0) or Vector3_new_ret.Unit;

            if v112.Magnitude > 0 then
                u102:Move(v112, false);
            end;
        end);
    else
        v108 = nil;
        v109 = nil;
    end;

    table.insert(v106, UserInputService.JumpRequest:Connect(function() -- Line: 800
        -- upvalues: StopActiveEmote (ref)
        StopActiveEmote();
    end));
    table.insert(v106, u102.Died:Connect(function() -- Line: 803
        -- upvalues: StopActiveEmote (ref)
        StopActiveEmote();
    end));
    table.insert(v106, result.Stopped:Connect(function() -- Line: 806
        -- upvalues: StopActiveEmote (ref)
        StopActiveEmote();
    end));
    table.insert(v106, UserInputService.InputBegan:Connect(function(p113, p114) -- Line: 809
        -- upvalues: u16 (ref), u6 (ref), StopActiveEmote (ref)
        if p114 then
            return;
        end;

        local ActionForInput = u16:GetActionForInput(p113);

        if ActionForInput and u6[ActionForInput] then
            StopActiveEmote();
        end;
    end));
    u27 = {
        track = result,
        conns = v106,
        hrp = HumanoidRootPart,
        hrpWasAnchored = v105,
        broadcast = v101,
        forced = ForcedMovement ~= nil,
        humanoid = ForcedMovement and u102 and u102 or nil,
        walkSpeedWas = v108,
        autoRotateWas = v109
    };

    if u15 then
        u15:SetEmoteActive(true):catch(function() -- Line: 833
        end);
    end;

    if v101 and u15 then
        u15:PerformEmote(p100):catch(function() -- Line: 837
        end);
    end;
end;

local function Open() -- Line: 843
    -- upvalues: u18 (ref), BuildWheel (copy), BuildBrowser (copy), u8 (ref), TweenService (copy), TweenInfo_new_ret (copy)
    if u18 then
        return;
    end;

    u18 = true;
    BuildWheel();
    BuildBrowser();
    u8.Visible = true;
    u8.Interactable = true;
    TweenService:Create(u8, TweenInfo_new_ret, {
        GroupTransparency = 0
    }):Play();
end;

local function Close() -- Line: 852
    -- upvalues: u18 (ref), u19 (ref), u20 (ref), TweenService (copy), TweenInfo_new_ret3 (copy), u8 (ref), TweenInfo_new_ret (copy), ClearPreviewStore (copy), u22 (copy), u23 (copy)
    if not u18 then
        return;
    end;

    u18 = false;
    local u115 = u19;

    if u115 then
        u19 = nil;
        u20 = u20 + 1;

        if u115.fadeTween then
            pcall(function() -- Line: 335
                -- upvalues: u115 (copy)
                u115.fadeTween:Cancel();
            end);
        end;

        local deleting = u115.deleting;

        if deleting then
            TweenService:Create(deleting, TweenInfo_new_ret3, {
                ImageTransparency = 1
            }):Play();
        end;
    end;

    u8.Interactable = false;
    local v116 = TweenService:Create(u8, TweenInfo_new_ret, {
        GroupTransparency = 1
    });
    v116.Completed:Connect(function() -- Line: 858
        -- upvalues: u18 (ref), u8 (ref), ClearPreviewStore (ref), u22 (ref), u23 (ref)
        if not u18 then
            u8.Visible = false;
            ClearPreviewStore(u22);
            ClearPreviewStore(u23);
        end;
    end);
    v116:Play();
end;

local function Toggle() -- Line: 868
    -- upvalues: u18 (ref), Close (copy), Open (copy)
    if u18 then
        Close();

        return;
    end;

    Open();
end;

local function ClearKitRig(p117: userdata) -- Line: 877
    if not p117 then
        return;
    end;

    local v118 = p117:FindFirstChildOfClass("WorldModel");

    if v118 then
        for _, child in v118:GetChildren() do
            child:Destroy();
        end;
    end;
end;

local function WireControls() -- Line: 887
    -- upvalues: UserInputService (copy), LocalPlayer (copy), u16 (ref), u18 (ref), Close (copy), Open (copy), u8 (ref), Knit (copy), EmoteData (copy), u9 (ref), BeginHold (copy), u19 (ref), u20 (ref), TweenService (copy), TweenInfo_new_ret3 (copy), u21 (copy), GetEmotes (copy), PlayEmote (copy), u11 (ref), u24 (ref), u26 (ref), BuildBrowser (copy), u25 (ref)
    UserInputService.InputBegan:Connect(function(p119, p120) -- Line: 889
        -- upvalues: LocalPlayer (ref), u16 (ref), u18 (ref), Close (ref), Open (ref)
        if p120 and (LocalPlayer:GetAttribute("OpenWindow") or not u16:CompletesAnyCombo(p119)) then
            return;
        end;

        if u16:GetActionForInput(p119) == "Emote" then
            if u18 then
                Close();

                return;
            end;

            Open();
        end;
    end);
    local Parent = u8.Parent;

    if Parent then
        Parent = Parent:FindFirstChild("MobileActions");
    end;

    if Parent then
        Parent = Parent:FindFirstChild("Emotes");
    end;

    if Parent and Parent:IsA("GuiButton") then
        local u121 = nil;

        local function isEditMode() -- Line: 917
            -- upvalues: u121 (ref), Knit (ref)
            if not u121 then
                local success, result = pcall(function() -- Line: 919
                    -- upvalues: Knit (ref)
                    return Knit.GetController("SettingsController");
                end);

                if success then
                    u121 = result;
                end;
            end;

            local v122;

            if u121 == nil then
                v122 = false;
            else
                v122 = u121:IsEditMode();
            end;

            return v122;
        end;

        Parent.Activated:Connect(function() -- Line: 927
            -- upvalues: u121 (ref), Knit (ref), u18 (ref), Close (ref), Open (ref)
            if not u121 then
                local success, result = pcall(function() -- Line: 919
                    -- upvalues: Knit (ref)
                    return Knit.GetController("SettingsController");
                end);

                if success then
                    u121 = result;
                end;
            end;

            local v123;

            if u121 == nil then
                v123 = false;
            else
                v123 = u121:IsEditMode();
            end;

            if v123 then
                return;
            end;

            if u18 then
                Close();

                return;
            end;

            Open();
        end);
    end;

    for i = 1, EmoteData.WHEEL_SLOTS do
        local v124 = u9:FindFirstChild((tostring(i)));
        local v125;

        if v124 and v124:IsA("GuiButton") then
            local Deleting = v124:FindFirstChild("Deleting");

            if Deleting and not Deleting:IsA("ImageLabel") then
                Deleting = nil;
            end;

            local function isPointer(p126) -- Line: 945
                return p126.UserInputType == Enum.UserInputType.MouseButton1 and true or p126.UserInputType == Enum.UserInputType.Touch;
            end;

            v124.InputBegan:Connect(function(p127) -- Line: 950
                -- upvalues: BeginHold (ref), i (copy), Deleting (ref)
                if p127.UserInputType == Enum.UserInputType.MouseButton1 and true or p127.UserInputType == Enum.UserInputType.Touch then
                    BeginHold(i, Deleting);
                end;
            end);
            v124.InputEnded:Connect(function(p128) -- Line: 955
                -- upvalues: u19 (ref), i (copy), u20 (ref), TweenService (ref), TweenInfo_new_ret3 (ref)
                if (p128.UserInputType == Enum.UserInputType.MouseButton1 and true or p128.UserInputType == Enum.UserInputType.Touch) and (u19 and u19.slot == i) then
                    local u129 = u19;

                    if not u129 then
                        return;
                    end;

                    u19 = nil;
                    u20 = u20 + 1;

                    if u129.fadeTween then
                        pcall(function() -- Line: 335
                            -- upvalues: u129 (copy)
                            u129.fadeTween:Cancel();
                        end);
                    end;

                    local deleting = u129.deleting;

                    if not deleting then
                        return;
                    end;

                    TweenService:Create(deleting, TweenInfo_new_ret3, {
                        ImageTransparency = 1
                    }):Play();
                end;
            end);
            v124.Activated:Connect(function() -- Line: 961
                -- upvalues: u21 (ref), i (copy), GetEmotes (ref), EmoteData (ref), PlayEmote (ref), Close (ref)
                if u21[i] then
                    u21[i] = nil;

                    return;
                end;

                local v130 = GetEmotes().Wheel[tostring(i)];

                if v130 and EmoteData.IsValid(v130) then
                    PlayEmote(v130);
                    Close();
                end;
            end);
            v125 = i;
        else
            v125 = i;
        end;
    end;

    local TextBox = u11.Search:FindFirstChild("TextBox");

    if TextBox and TextBox:IsA("TextBox") then
        TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 981
            -- upvalues: u24 (ref), TextBox (copy), u26 (ref), u18 (ref), BuildBrowser (ref)
            u24 = TextBox.Text;
            u26 = 1;

            if u18 then
                BuildBrowser();
            end;
        end);
    end;

    local ImageLabel = u11.Search:FindFirstChild("ImageLabel");

    if ImageLabel and (ImageLabel:IsA("GuiButton") and TextBox) then
        ImageLabel.Activated:Connect(function() -- Line: 990
            -- upvalues: TextBox (copy)
            TextBox.Text = "";
        end);
    end;

    local function setSort(p131) -- Line: 996
        -- upvalues: u25 (ref), u26 (ref), u18 (ref), BuildBrowser (ref)
        u25 = p131;
        u26 = 1;

        if u18 then
            BuildBrowser();
        end;
    end;

    local SortByDate = u11.Sort:FindFirstChild("SortByDate");
    local SortByName = u11.Sort:FindFirstChild("SortByName");

    if SortByDate and SortByDate:IsA("GuiButton") then
        SortByDate.Activated:Connect(function() -- Line: 1004
            -- upvalues: u25 (ref), u26 (ref), u18 (ref), BuildBrowser (ref)
            u25 = "Date";
            u26 = 1;

            if u18 then
                BuildBrowser();
            end;
        end);
    end;

    if SortByName and SortByName:IsA("GuiButton") then
        SortByName.Activated:Connect(function() -- Line: 1007
            -- upvalues: u25 (ref), u26 (ref), u18 (ref), BuildBrowser (ref)
            u25 = "Name";
            u26 = 1;

            if u18 then
                BuildBrowser();
            end;
        end);
    end;

    local Up = u11.Page:FindFirstChild("Up");
    local Down = u11.Page:FindFirstChild("Down");

    if Up and Up:IsA("GuiButton") then
        Up.Activated:Connect(function() -- Line: 1014
            -- upvalues: u26 (ref), u18 (ref), BuildBrowser (ref)
            u26 = math.max(1, u26 - 1);

            if u18 then
                BuildBrowser();
            end;
        end);
    end;

    if Down and Down:IsA("GuiButton") then
        Down.Activated:Connect(function() -- Line: 1020
            -- upvalues: u26 (ref), u18 (ref), BuildBrowser (ref)
            u26 = u26 + 1;

            if u18 then
                BuildBrowser();
            end;
        end);
    end;

    local TextBox2 = u11.Page.Frame:FindFirstChild("TextBox");

    if TextBox2 and TextBox2:IsA("TextBox") then
        TextBox2.TextEditable = false;
    end;
end;

function v7._Init(p132) -- Line: 1032
    -- upvalues: u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), Color3_fromRGB_ret2 (ref), EmoteData (copy), u14 (ref), Knit (copy), u15 (ref), u16 (ref), u17 (ref), WireControls (copy), u18 (ref), BuildWheel (copy), BuildBrowser (copy)
    u8 = p132:WaitForChild("HUD"):WaitForChild("Emote");
    u9 = u8:WaitForChild("8Wheel");
    u10 = u9:WaitForChild("Emotes");
    u11 = u9:WaitForChild("SearchBox");
    u12 = u11.Display:WaitForChild("List");
    u13 = u12:WaitForChild("Template");
    local v133 = u13:FindFirstChildOfClass("UIStroke");

    if v133 then
        Color3_fromRGB_ret2 = v133.Color;
    end;

    u13.Visible = false;
    u13.Parent = u11;

    for i = 1, EmoteData.WHEEL_SLOTS do
        local v134 = u10:FindFirstChild((tostring(i)));

        if v134 then
            v134 = v134:FindFirstChild("ViewportFrame");
        end;

        local v135;

        if v134 then
            local v136 = v134:FindFirstChildOfClass("WorldModel");

            if v136 then
                v135 = i;

                for _, child in v136:GetChildren() do
                    child:Destroy();
                end;
            else
                v135 = i;
            end;
        else
            v135 = i;
        end;
    end;

    local Viewport = u13:FindFirstChild("Viewport");

    if Viewport then
        Viewport = Viewport:FindFirstChild("ViewportFrame");
    end;

    local v137 = Viewport and Viewport:FindFirstChildOfClass("WorldModel");

    if v137 then
        for _, child in v137:GetChildren() do
            child:Destroy();
        end;
    end;

    u8.GroupTransparency = 1;
    u8.Visible = false;
    u8.Interactable = false;
    u14 = Knit.Registry:Get("PlayerData");
    u15 = Knit.GetService("EmoteService");
    u16 = Knit.GetController("InputBindingController");
    u17 = Knit.GetController("SoundController");
    WireControls();

    if u14 then
        u14:OnChange(function(p138, p139) -- Line: 1072
            -- upvalues: u18 (ref), BuildWheel (ref), BuildBrowser (ref)
            if p139[1] == "Emotes" and u18 then
                BuildWheel();
                BuildBrowser();
            end;
        end);
    end;
end;

return v7;