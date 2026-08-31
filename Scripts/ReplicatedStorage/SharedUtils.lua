--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SharedUtils
  Path:     game.ReplicatedStorage.Modules.SharedUtils
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local EnemyResolver = require(ReplicatedStorage.GameInfo.EnemyResolver);
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
require(ReplicatedStorage.GameInfo.MutationData);
local RarityData = require(ReplicatedStorage.GameInfo.RarityData);
local MonetizationList = require(ReplicatedStorage.GameInfo.MonetizationList);
local Models = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Models");
local Items = Models:FindFirstChild("Items");
local Models2 = ServerStorage:FindFirstChild("Models");

if Models2 then
    Models2 = Models2:FindFirstChild("Enemies");
end;

local u1 = Models2 or Models:WaitForChild("Enemies", 5);
local u2 = {};

for _, child in Items:GetChildren() do
    for _, descendant in child:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "NPC";
        end;
    end;
end;

if u1 then
    for _, child in u1:GetChildren() do
        for _, descendant in child:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CollisionGroup = "NPC";
            end;
        end;
    end;
end;

function u2.GetGridData(p3) -- Line: 54
    return {
        Rows = 7,
        Cols = 10
    };
end;

function u2.GetItemStats(p4) -- Line: 61
    -- upvalues: RarityData (copy)
    local Rarity = p4.Rarity;

    return {
        Income = (RarityData.BaseIncome[Rarity] or 1) * (p4.Info.Income or 1),
        Price = (RarityData.BasePrice[Rarity] or 0) * (p4.Info.Price or 1)
    };
end;

function u2.GetStarsMultiplier(p5: userdata) -- Line: 72
    -- upvalues: MonetizationList (copy)
    return MonetizationList["2xStars"].DoesPlayerOwn(p5) and 2 or 1;
end;

function u2.GetCrystalsMultiplier(p6: userdata) -- Line: 76
    -- upvalues: MonetizationList (copy)
    return MonetizationList["2xCrystals"].DoesPlayerOwn(p6) and 2 or 1;
end;

local u7 = {
    BASE_HP = 200,
    HP_PER_VIT = 15,
    INNATE_BASE_DAMAGE = 30,
    DAMAGE_PER_PRIMARY_STAT = 1.5,
    PRIMARY_STAT = {
        Physical = "STR",
        Magic = "INT",
        Ranged = "DEX"
    }
};

function u2.GetClassCombatPreview(p8) -- Line: 104
    -- upvalues: u7 (copy)
    local v9 = p8 and (p8.BaseStats or {}) or {};

    return {
        Health = u7.BASE_HP + (v9.VIT or 0) * u7.HP_PER_VIT,
        Attack = u7.INNATE_BASE_DAMAGE + math.floor((v9[u7.PRIMARY_STAT[p8 and p8.DamageType or "Physical"] or "STR"] or 0) * u7.DAMAGE_PER_PRIMARY_STAT)
    };
end;

local u10 = nil;

local function getSFXSoundGroup() -- Line: 148
    -- upvalues: u10 (ref)
    if u10 and u10.Parent then
        return u10;
    end;

    local SFX = game:GetService("SoundService"):FindFirstChild("SFX");

    if SFX and SFX:IsA("SoundGroup") then
        u10 = SFX;
    end;

    return u10;
end;

local u11 = setmetatable({}, {
    __mode = "k"
});

local function clearPoolTimer(p12: userdata) -- Line: 158
    -- upvalues: u11 (copy)
    local v13 = u11[p12];

    if v13 then
        pcall(task.cancel, v13);
        u11[p12] = nil;
    end;
end;

function u2.PlayPooledSound(p14: userdata, p15: userdata, p16: number?, p17: string, p18: number?) -- Line: 163
    -- upvalues: u11 (copy), u10 (ref)
    if not (p14 and p15) then
        return;
    end;

    local u19 = p17 .. "Idle";
    local SoundId = p15.SoundId;
    local v20 = 0;
    local u21 = nil;

    for _, child in p14:GetChildren() do
        if child:IsA("Sound") and (child:GetAttribute(p17) and child.SoundId == SoundId) then
            v20 = v20 + 1;

            if not u21 and (child:GetAttribute(u19) and not child.IsPlaying) then
                u21 = child;
            end;
        end;
    end;

    local u22;

    if u21 then
        u22 = true;
        local v23 = u11[u21];

        if v23 then
            pcall(task.cancel, v23);
            u11[u21] = nil;
        end;

        u21:SetAttribute(u19, false);
        u21.TimePosition = 0;
    else
        u21 = p15:Clone();
        u22 = v20 < 4;

        if u22 then
            u21:SetAttribute(p17, true);
            u21:SetAttribute(u19, false);
        end;
    end;

    if p18 then
        u21.PlaybackSpeed = p15.PlaybackSpeed + (math.random() * 2 - 1) * p18;
    end;

    u21.Volume = p16 or (p15.Volume or 1);
    local v24;

    if u10 and u10.Parent then
        v24 = u10;
    else
        local SFX = game:GetService("SoundService"):FindFirstChild("SFX");

        if SFX and SFX:IsA("SoundGroup") then
            u10 = SFX;
        end;

        v24 = u10;
    end;

    if v24 then
        u21.SoundGroup = v24;
    end;

    u21.Parent = p14;
    u21.Ended:Once(function() -- Line: 210
        -- upvalues: u21 (ref), u11 (ref), u22 (ref), u19 (copy)
        local v25 = u21;
        local v26 = u11[v25];

        if v26 then
            pcall(task.cancel, v26);
            u11[v25] = nil;
        end;

        if not u22 then
            u21:Destroy();

            return;
        end;

        u21:SetAttribute(u19, true);
        u11[u21] = task.delay(2, function() -- Line: 214
            -- upvalues: u11 (ref), u21 (ref)
            u11[u21] = nil;
            u21:Destroy();
        end);
    end);
    u11[u21] = task.delay(10, function() -- Line: 225
        -- upvalues: u11 (ref), u21 (ref)
        u11[u21] = nil;
        u21:Destroy();
    end);
    u21:Play();
end;

local function ResolveSFX(p27: string) -- Line: 236
    local SFX = game.SoundService.SFX;

    return SFX:FindFirstChild(p27) or SFX:FindFirstChild(p27, true);
end;

function u2.PlaySoundAt(p28: userdata, p29: any, p30: number?, p31: number?) -- Line: 248
    -- upvalues: RunService (copy), ReplicatedStorage (copy), u2 (copy)
    if not p28 then
        return;
    end;

    if not RunService:IsServer() then
        if typeof(p29) == "string" then
            local SFX = game.SoundService.SFX;
            local v32 = SFX:FindFirstChild(p29) or SFX:FindFirstChild(p29, true);

            if not v32 then
                warn("PlaySoundAt: Sound not found - " .. p29);

                return;
            end;

            p29 = v32;
        elseif typeof(p29) ~= "Instance" or not p29:IsA("Sound") then
            warn("PlaySoundAt: Invalid sound argument - expected string or Sound, got " .. typeof(p29));

            return;
        end;

        u2.PlayPooledSound(p28, p29, p30, "_PooledSFX", p31);

        return;
    end;

    if typeof(p29) == "string" then
        local SFX = game.SoundService.SFX;

        if not (SFX:FindFirstChild(p29) or SFX:FindFirstChild(p29, true)) then
            warn("PlaySoundAt: Sound not found - " .. p29);

            return;
        end;
    end;

    local Remotes = ReplicatedStorage.Player:FindFirstChild("Remotes");

    if Remotes then
        Remotes = Remotes:FindFirstChild("SFX_Single");
    end;

    if Remotes then
        Remotes:FireAllClients(p28, p29, p30, p31);
    end;
end;

function u2.FireHRPEffect(p33: userdata?, p34: string) -- Line: 289
    if not p33 then
        return;
    end;

    local v35 = p33:FindFirstChild(p34);

    if v35 then
        v35:SetAttribute("Fire", not v35:GetAttribute("Fire"));
    end;
end;

local u36 = {
    None = 0,
    Hit = 1,
    Combo = 2,
    Unblockable = 3,
    Straggler = 4
};
local u37 = {
    Hit = {
        FillTransparency = 0.5,
        OutlineTransparency = 1,
        FillColor = Color3.fromRGB(255, 0, 0),
        OutlineColor = Color3.fromRGB(255, 255, 255)
    },
    Combo = {
        FillTransparency = 0.2,
        OutlineTransparency = 0,
        FillColor = Color3.fromRGB(255, 255, 0),
        OutlineColor = Color3.fromRGB(0, 255, 255)
    },
    Unblockable = {
        FillTransparency = 0.2,
        OutlineTransparency = 0,
        FillColor = Color3.fromRGB(255, 0, 127),
        OutlineColor = Color3.fromRGB(255, 255, 0)
    },
    Straggler = {
        FillTransparency = 0.3,
        OutlineTransparency = 0,
        FillColor = Color3.fromRGB(255, 140, 0),
        OutlineColor = Color3.fromRGB(255, 255, 255)
    }
};

function u2.InitHighlight(p38: userdata) -- Line: 334
    local EntityHighlight = p38:FindFirstChild("EntityHighlight");

    if EntityHighlight then
        EntityHighlight:Destroy();
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.Name = "EntityHighlight";
    Highlight.Adornee = p38;
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 1;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p38;
    p38:SetAttribute("HighlightState", "None");
    p38:SetAttribute("HighlightPriority", 0);
end;

local function applyState(p39: userdata, p40: string) -- Line: 351
    -- upvalues: u36 (copy), u37 (copy), TweenService (copy)
    local EntityHighlight = p39:FindFirstChild("EntityHighlight");

    if not EntityHighlight then
        return false;
    end;

    local v41 = p39:GetAttribute("HighlightPriority") or 0;
    local v42 = u36[p40] or 0;

    if v42 < v41 then
        return false;
    end;

    local v43 = u37[p40];

    if not v43 then
        return false;
    end;

    p39:SetAttribute("HighlightState", p40);
    p39:SetAttribute("HighlightPriority", v42);
    EntityHighlight.FillColor = v43.FillColor;
    EntityHighlight.OutlineColor = v43.OutlineColor;
    EntityHighlight.FillTransparency = 1;
    EntityHighlight.OutlineTransparency = 1;
    TweenService:Create(EntityHighlight, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = v43.FillTransparency,
        OutlineTransparency = v43.OutlineTransparency
    }):Play();

    return true;
end;

local function dismissState(p44: userdata, p45: string, p46: number?) -- Line: 383
    -- upvalues: TweenService (copy)
    local EntityHighlight = p44:FindFirstChild("EntityHighlight");

    if not EntityHighlight then
        return;
    end;

    if p44:GetAttribute("HighlightState") ~= p45 then
        return;
    end;

    p44:SetAttribute("HighlightState", "None");
    p44:SetAttribute("HighlightPriority", 0);
    TweenService:Create(EntityHighlight, TweenInfo.new(p46 or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
end;

function u2.ClearHighlight(p47: userdata, p48: number?) -- Line: 401
    -- upvalues: TweenService (copy)
    local v49;

    if p47 then
        v49 = p47:FindFirstChild("EntityHighlight");
    else
        v49 = p47;
    end;

    if not v49 then
        return;
    end;

    p47:SetAttribute("HighlightState", "None");
    p47:SetAttribute("HighlightPriority", 0);
    p47:SetAttribute("Combo", false);
    p47:SetAttribute("Unblockable", false);
    TweenService:Create(v49, TweenInfo.new(p48 or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
end;

function u2.ComboEffect(u50: userdata) -- Line: 419
    -- upvalues: applyState (copy), dismissState (copy)
    if u50 then
        u50:SetAttribute("Combo", true);
        local u51 = applyState(u50, "Combo");

        return function() -- Line: 425
            -- upvalues: u50 (copy), u51 (copy), dismissState (ref)
            u50:SetAttribute("Combo", false);

            if u51 then
                dismissState(u50, "Combo");
            end;
        end;
    end;
end;

function u2.UnblockableEffect(u52: userdata) -- Line: 433
    -- upvalues: applyState (copy), dismissState (copy)
    if u52 then
        u52:SetAttribute("Unblockable", true);
        local u53 = applyState(u52, "Unblockable");

        return function() -- Line: 439
            -- upvalues: u52 (copy), u53 (copy), dismissState (ref)
            u52:SetAttribute("Unblockable", false);

            if u53 then
                dismissState(u52, "Unblockable");
            end;
        end;
    end;
end;

function u2.StragglerEffect(u54: userdata) -- Line: 449
    -- upvalues: applyState (copy), dismissState (copy)
    if not u54 then
        return function() -- Line: 450
        end;
    end;

    local u55 = applyState(u54, "Straggler");
    local v56 = u55 and u54:FindFirstChild("EntityHighlight");

    if v56 then
        v56.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    end;

    return function() -- Line: 462
        -- upvalues: u55 (copy), dismissState (ref), u54 (copy)
        if u55 then
            dismissState(u54, "Straggler");
            local EntityHighlight = u54:FindFirstChild("EntityHighlight");

            if EntityHighlight then
                EntityHighlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            end;
        end;
    end;
end;

function u2.hitEffect(u57: userdata) -- Line: 474
    -- upvalues: applyState (copy), ReplicatedStorage (copy), dismissState (copy)
    if not u57 then
        return;
    end;

    if not applyState(u57, "Hit") then
        return;
    end;

    local v58 = ReplicatedStorage.Assets.VFX.hitEffect:Clone();
    v58.Parent = u57.PrimaryPart or u57;
    v58:Emit(1);
    game.Debris:AddItem(v58, 1);
    task.delay(0.2, function() -- Line: 487
        -- upvalues: dismissState (ref), u57 (copy)
        dismissState(u57, "Hit", 0.1);
    end);
end;

function u2.ShowStatusDamage(p59: userdata, p60: number, p61, p62: string?) -- Line: 493
    -- upvalues: ReplicatedStorage (copy), u2 (copy), TweenService (copy)
    local u63 = ReplicatedStorage.Assets.UI.Damage:Clone();
    local CanvasGroup = u63.CanvasGroup;
    local dmgLabel = CanvasGroup.dmgLabel;
    dmgLabel.Text = (p62 or "-") .. u2.FormatNumber(p60);

    for _, child in dmgLabel:GetChildren() do
        if child:IsA("UIGradient") then
            child.Enabled = false;
        end;
    end;

    dmgLabel.TextColor3 = p61;
    u63.Parent = p59;
    CanvasGroup.GroupTransparency = 1;
    local Size = CanvasGroup.Size;
    local UDim2_fromScale_ret = UDim2.fromScale(Size.X.Scale * math.random(1.1, 1.3), Size.Y.Scale * math.random(1.1, 1.3));
    local math_random_ret = math.random(-5, 5);
    local math_random_ret2 = math.random(-5, 5);
    dmgLabel.Position = dmgLabel.Position + UDim2.fromOffset(math_random_ret, math_random_ret2);
    CanvasGroup.Size = UDim2.fromScale(0, 0);
    TweenService:Create(CanvasGroup, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0,
        Size = UDim2_fromScale_ret,
        Rotation = math.random(-35, 35)
    }):Play();
    task.delay(1, function() -- Line: 528
        -- upvalues: TweenService (ref), CanvasGroup (copy), u63 (copy)
        TweenService:Create(CanvasGroup, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            GroupTransparency = 1,
            Size = UDim2.fromScale(0, 0)
        }):Play();
        game.Debris:AddItem(u63, 0.5);
    end);
end;

function u2.ShowText(p64: userdata, p65: string, p66) -- Line: 538
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    local u67 = ReplicatedStorage.Assets.UI.TextPopup:Clone();
    u67.CanvasGroup.textLabel.Text = p65;
    u67.CanvasGroup.textLabel.TextColor3 = p66 or Color3.new(1, 1, 1);
    u67.Parent = p64;
    local CanvasGroup = u67.CanvasGroup;
    CanvasGroup.GroupTransparency = 1;
    CanvasGroup.Size = UDim2.fromScale(0, 0);
    TweenService:Create(CanvasGroup, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        GroupTransparency = 0,
        Size = u67.CanvasGroup:GetAttribute("DefaultSize") or UDim2.fromScale(1, 1)
    }):Play();
    task.delay(1.5, function() -- Line: 553
        -- upvalues: TweenService (ref), CanvasGroup (copy), u67 (copy)
        TweenService:Create(CanvasGroup, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            GroupTransparency = 1,
            Size = UDim2.fromScale(0, 0)
        }):Play();
        game.Debris:AddItem(u67, 0.5);
    end);
end;

function u2.iFrameEffect(p68: userdata, p69: number?) -- Line: 564
    -- upvalues: TweenService (copy)
    if p68 then
        local v70 = p69 or 0.4;
        local iFrameHighlight = p68:FindFirstChild("iFrameHighlight");

        if iFrameHighlight then
            iFrameHighlight:Destroy();
        end;

        local Highlight = Instance.new("Highlight");
        Highlight.Name = "iFrameHighlight";
        Highlight.Adornee = p68;
        Highlight.FillColor = Color3.fromRGB(100, 200, 255);
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.FillTransparency = 0.3;
        Highlight.OutlineTransparency = 0;
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.Parent = p68;
        local u71 = v70 * 0.8;
        task.delay(v70 * 0.2, function() -- Line: 592
            -- upvalues: Highlight (copy), TweenService (ref), u71 (copy)
            if Highlight and Highlight.Parent then
                local v72 = TweenService:Create(Highlight, TweenInfo.new(u71, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                });
                v72:Play();
                v72.Completed:Once(function() -- Line: 603
                    -- upvalues: Highlight (ref)
                    if Highlight and Highlight.Parent then
                        Highlight:Destroy();
                    end;
                end);
            end;
        end);
        game.Debris:AddItem(Highlight, v70 + 0.5);

        return Highlight;
    end;

    warn("iFrameEffect: model not passed");
end;

function u2.PlayerSkill_Effect(p73: userdata) -- Line: 619
    if p73 then
    end;
end;

local u74 = {};

function u2.CheckParry(p75: userdata, p76: userdata?) -- Line: 665
    -- upvalues: u74 (copy), u2 (copy)
    if not p75 then
        return false;
    end;

    if not p75:GetAttribute("Parry") then
        return false;
    end;

    local HumanoidRootPart = p75:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        local v77 = tick();
        local v78 = u74[p75];

        if not v78 or v77 - v78 > 0.2 then
            u74[p75] = v77;
            u2.ShowTextPopup(HumanoidRootPart, "PARRY!", Color3.fromRGB(255, 215, 0));
            local v79 = "Parry" .. math.random(1, 2);
            u2.PlaySoundAt(HumanoidRootPart, v79, 0.8);

            if HumanoidRootPart:FindFirstChild("ParryFX") then
                HumanoidRootPart.ParryFX:SetAttribute("Fire", not HumanoidRootPart.ParryFX:GetAttribute("Fire"));
            end;
        end;
    end;

    return true;
end;

function u2.parryEffect(p80: userdata, p81: number?) -- Line: 695
    -- upvalues: TweenService (copy)
    if not p80 then
        warn("model not passed for parry effect");

        return;
    end;

    local ParryEffect = p80:FindFirstChild("ParryEffect");

    if ParryEffect then
        ParryEffect:Destroy();
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.Name = "ParryEffect";
    Highlight.Adornee = p80;
    Highlight.FillColor = Color3.fromRGB(255, 215, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 150);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 0.3;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p80;
    task.delay(p81 or 0.25, function() -- Line: 721
        -- upvalues: Highlight (copy), TweenService (ref)
        if Highlight and Highlight.Parent then
            local v82 = TweenService:Create(Highlight, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                FillTransparency = 1,
                OutlineTransparency = 1
            });
            v82:Play();
            v82.Completed:Once(function() -- Line: 733
                -- upvalues: Highlight (ref)
                if Highlight and Highlight.Parent then
                    Highlight:Destroy();
                end;
            end);
        end;
    end);
end;

function u2.counterEffect(p83: userdata, p84: number?) -- Line: 744
    -- upvalues: TweenService (copy)
    if not p83 then
        warn("model not passed for counter effect");

        return;
    end;

    local CounterEffect = p83:FindFirstChild("CounterEffect");

    if CounterEffect then
        CounterEffect:Destroy();
    end;

    local ParryEffect = p83:FindFirstChild("ParryEffect");

    if ParryEffect then
        ParryEffect:Destroy();
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.Name = "CounterEffect";
    Highlight.Adornee = p83;
    Highlight.FillColor = Color3.fromRGB(255, 215, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 150);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 0.5;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p83;
    task.delay(p84 or 0.5, function() -- Line: 770
        -- upvalues: Highlight (copy), TweenService (ref)
        if Highlight and Highlight.Parent then
            local v85 = TweenService:Create(Highlight, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                FillTransparency = 1,
                OutlineTransparency = 1
            });
            v85:Play();
            v85.Completed:Once(function() -- Line: 781
                -- upvalues: Highlight (ref)
                if Highlight and Highlight.Parent then
                    Highlight:Destroy();
                end;
            end);
        end;
    end);
end;

local u86 = {};

function u2.ShowTextPopup(p87: userdata, p88: string, p89) -- Line: 793
    -- upvalues: u86 (copy), TweenService (copy)
    local v90 = tostring(p87) .. "_" .. p88;
    local v91 = tick();
    local v92 = u86[v90];

    if v92 and v91 - v92 < 0.2 then
        return;
    end;

    u86[v90] = v91;
    local v93 = p89 or Color3.fromRGB(255, 215, 0);
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "TextPopup";
    BillboardGui.Size = UDim2.new(3, 0, 1.125, 0);
    BillboardGui.StudsOffset = Vector3.new(0, 3, 0);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.Parent = p87;
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "CanvasGroup";
    CanvasGroup.Size = UDim2.new(1, 0, 1, 0);
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.GroupTransparency = 1;
    CanvasGroup.Parent = BillboardGui;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "PopupLabel";
    TextLabel.Size = UDim2.new(1, 0, 1, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = p88;
    TextLabel.TextColor3 = v93;
    TextLabel.TextStrokeColor3 = v93:Lerp(Color3.new(0, 0, 0), 0.7);
    TextLabel.TextStrokeTransparency = 0;
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.TextScaled = true;
    TextLabel.Parent = CanvasGroup;
    local Size = CanvasGroup.Size;
    CanvasGroup.Size = UDim2.fromScale(0, 0);
    TweenService:Create(CanvasGroup, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        GroupTransparency = 0,
        Rotation = 0,
        Size = Size
    }):Play();
    task.delay(0.6, function() -- Line: 843
        -- upvalues: TweenService (ref), BillboardGui (copy), CanvasGroup (copy)
        TweenService:Create(BillboardGui, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            StudsOffset = BillboardGui.StudsOffset + Vector3.new(0, 1.5, 0)
        }):Play();
        TweenService:Create(CanvasGroup, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            GroupTransparency = 1,
            Size = UDim2.fromScale(0.5, 0.5)
        }):Play();
    end);
    game.Debris:AddItem(BillboardGui, 1.2);
end;

local u94 = nil;

local function _getDamageRemote() -- Line: 870
    -- upvalues: ReplicatedStorage (copy)
    local Player = ReplicatedStorage:FindFirstChild("Player");

    if Player then
        Player = Player:FindFirstChild("Remotes");
    end;

    if Player then
        Player = Player:FindFirstChild("DamageDisplay");
    end;

    return Player;
end;

local function _emitDamageNumber(p95: userdata, p96: number, p97: boolean) -- Line: 881
    -- upvalues: RunService (copy), ReplicatedStorage (copy), u94 (ref), u2 (copy)
    local v98 = p95.Position + Vector3.new(0, p95.Size.Y * 0.5 + 2, 0);

    if RunService:IsServer() then
        local Player = ReplicatedStorage:FindFirstChild("Player");

        if Player then
            Player = Player:FindFirstChild("Remotes");
        end;

        if Player then
            Player = Player:FindFirstChild("DamageDisplay");
        end;

        if Player then
            Player:FireAllClients(v98, p96, p97, p95);
        end;
    else
        u94 = u94 or require(ReplicatedStorage.Modules.DamageDisplay);
        local v99 = p97 and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(255, 50, 50);
        u94.DisplayDamage(v98, (p97 and "CRIT -" or "-") .. u2.FormatNumber(p96), v99, {
            IsCrit = p97
        });
    end;
end;

u2.CLIENTSIDE_HIT_FX = true;
local u100 = nil;

function u2.DisableEmittersAndTrails(p101: userdata?) -- Line: 911
    if not p101 then
        return;
    end;

    for _, descendant in p101:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;
end;

function u2.TriggerHitFX(p102: userdata?, p103: string) -- Line: 920
    -- upvalues: u2 (copy), RunService (copy), u100 (ref), ReplicatedStorage (copy)
    if not p102 then
        return;
    end;

    if u2.CLIENTSIDE_HIT_FX and RunService:IsServer() then
        u100 = u100 or require(ReplicatedStorage.Globals.Modules.FX_Broadcaster);
        u100.Fire(p102, "Asset", p103, p103);

        return;
    end;

    local HumanoidRootPart = p102:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        HumanoidRootPart = HumanoidRootPart:FindFirstChild(p103);
    end;

    if HumanoidRootPart then
        HumanoidRootPart:SetAttribute("Fire", not HumanoidRootPart:GetAttribute("Fire"));
    end;
end;

function u2.ShowDamage(p104: userdata, p105: number) -- Line: 937
    -- upvalues: u2 (copy), _emitDamageNumber (copy)
    if not p104 then
        return;
    end;

    u2.TriggerHitFX(p104:FindFirstAncestorWhichIsA("Model"), "NormalHit");
    _emitDamageNumber(p104, p105, false);
end;

function u2.ShowCritDamage(p106: userdata, p107: number) -- Line: 947
    -- upvalues: u2 (copy), _emitDamageNumber (copy)
    if not p106 then
        return;
    end;

    u2.TriggerHitFX(p106:FindFirstAncestorWhichIsA("Model"), "NormalHit");
    _emitDamageNumber(p106, p107, true);
end;

local u108 = {
    _Head = { "Head" },
    _Torso = { "Torso", "UpperTorso", "HumanoidRootPart" },
    _Right_Arm = { "Right Arm", "RightUpperArm", "RightHand" },
    _Left_Arm = { "Left Arm", "LeftUpperArm", "LeftHand" },
    _Right_Leg = { "Right Leg", "RightUpperLeg", "RightFoot" },
    _Left_Leg = { "Left Leg", "LeftUpperLeg", "LeftFoot" },
    _HumanoidRootPart = { "HumanoidRootPart" }
};
local u109 = { "ParticleEmitter", "Beam", "Trail" };

local function DisableFX(p110: userdata) -- Line: 973
    -- upvalues: u109 (copy)
    for _, v in ipairs(u109) do
        local v111 = v;

        for _, descendant in p110:GetDescendants() do
            if descendant:IsA(v111) then
                descendant.Enabled = false;
            end;
        end;
    end;
end;

function u2.ApplyMutation(p112: userdata, p113: string) -- Line: 983
    -- upvalues: ReplicatedStorage (copy), u108 (copy), DisableFX (copy)
    if not p113 then
        return;
    end;

    local v114 = ReplicatedStorage.Assets.Mutations:FindFirstChild(p113);

    if v114 then
        local Folder = Instance.new("Folder");
        Folder.Name = "MutationEffects";
        Folder.Parent = p112;
        local u115 = {};

        for i, v in pairs(u108) do
            local v116 = v114:FindFirstChild(i);

            if v116 then
                local v117 = i;
                local v118 = nil;

                for _, v2 in ipairs(v) do
                    v118 = p112:FindFirstChild(v2, true);

                    if v118 and v118:IsA("BasePart") then
                        break;
                    end;
                end;

                if v118 then
                    local v119 = v116:Clone();

                    if not v119:HasTag("ParticleObject") then
                        v119:AddTag("ParticleObject");
                        v119:SetAttribute("Bypass_FX", true);
                    end;

                    v119.Name = v117 .. "_Effect";
                    DisableFX(v119);

                    if v119:IsA("Model") then
                        local v120 = v119.PrimaryPart or v119:FindFirstChildWhichIsA("BasePart");

                        if v120 then
                            v119:PivotTo(v118.CFrame);
                            local WeldConstraint = Instance.new("WeldConstraint");
                            WeldConstraint.Part0 = v118;
                            WeldConstraint.Part1 = v120;
                            WeldConstraint.Parent = v120;

                            for _, descendant in v119:GetDescendants() do
                                if descendant:IsA("BasePart") then
                                    descendant.CanCollide = false;
                                    descendant.Massless = true;
                                end;
                            end;
                        end;
                    elseif v119:IsA("BasePart") then
                        v119.CFrame = v118.CFrame;
                        v119.CanCollide = false;
                        v119.Massless = true;
                        local WeldConstraint = Instance.new("WeldConstraint");
                        WeldConstraint.Part0 = v118;
                        WeldConstraint.Part1 = v119;
                        WeldConstraint.Parent = v119;
                    end;

                    v119.Parent = Folder;
                    table.insert(u115, v119);
                else
                    warn((`Could not find target part for {v117} on {p112.Name}`));
                end;
            end;
        end;

        p112:SetAttribute("Mutation", p113);
        task.delay(0.5, function() -- Line: 1060
            -- upvalues: u115 (copy)
            for _, v in ipairs(u115) do
                if v and v.Parent then
                    v:SetAttribute("FX_Activate", true);
                end;
            end;
        end);

        return Folder;
    end;

    warn("Mutation prefab not found:", p113);
end;

function u2.AttachAnimateScript(p121: userdata, p122: any) -- Line: 1085
    -- upvalues: ReplicatedStorage (copy)
    local Animate = p121:FindFirstChild("Animate");

    if Animate then
        Animate:Destroy();
    end;

    local v123 = ReplicatedStorage.Assets.Scripts.Animate:Clone();

    if p122.WalkAnim then
        local walk = v123:FindFirstChild("walk");

        if walk and walk:FindFirstChild("WalkAnim") then
            walk.WalkAnim.AnimationId = p122.WalkAnim;
        end;

        local run = v123:FindFirstChild("run");

        if run and run:FindFirstChild("RunAnim") then
            run.RunAnim.AnimationId = p122.WalkAnim;
        end;
    end;

    if p122.IdleAnim then
        local idle = v123:FindFirstChild("idle");

        if idle then
            local Animation1 = idle:FindFirstChild("Animation1");

            for _, child in idle:GetChildren() do
                if child:IsA("Animation") then
                    if Animation1 == nil then
                        Animation1 = child;
                    end;

                    if child ~= Animation1 then
                        child:Destroy();
                    end;
                end;
            end;

            if Animation1 then
                Animation1.AnimationId = p122.IdleAnim;
            end;
        end;
    end;

    v123.Parent = p121;
    v123.Enabled = true;

    return v123;
end;

function u2.CreateItem(p124: any, p125: boolean?, p126: boolean?, p127: boolean?, p128: string?) -- Line: 1119
    -- upvalues: EnemyResolver (copy), u1 (copy), Items (copy), ReplicatedStorage (copy), RarityColors (copy), u2 (copy)
    local v129 = EnemyResolver(p124);

    if not v129 then
        return;
    end;

    local v130 = u1 and u1:FindFirstChild(p124) or Items and Items:FindFirstChild(p124);

    if v130 then
        local v131 = v130:Clone();
        v131:SetAttribute("ItemId", p124);
        local v132 = v131.PrimaryPart:FindFirstChild("BillboardAttachment") or v131.PrimaryPart;
        local v133;

        if p126 then
            v133 = nil;
        else
            v133 = not p125 and ReplicatedStorage.Assets.UI.ItemBillboard:Clone() or ReplicatedStorage.Assets.UI.ItemBillboardWithHealth:Clone();
            v133.Frame.ItemName.Text = v129.Name or "Unknown Item";
            local v134 = RarityColors[v129.Rarity];

            if v134 then
                v133.Frame.Rarity.Text = v129.Rarity or "Unknown Rarity";
                v133.Frame.Rarity.TextColor3 = v134.TextColor3;
            else
                v133.Frame.Rarity.Visible = false;
            end;

            v133.Frame.Income.Text = u2.FormatCashString(v129.Info.Income or 0) .. "/s";
            v133.Frame.Price.Text = u2.FormatCashString(v129.Info.Price, true);
            v133.Frame.Unstealable.Visible = p127 == true;
            v133.Parent = v132;
        end;

        u2.AttachAnimateScript(v131, v129);

        if p128 then
            u2.ApplyMutation(v131, p128);
        end;

        return v131, v133;
    end;
end;

function u2.SpawnEnemy(p135: string) -- Line: 1172
    -- upvalues: EnemyResolver (copy), u1 (copy), ReplicatedStorage (copy), u2 (copy)
    local v136 = EnemyResolver(p135);

    if not v136 then
        warn("[SpawnEnemy] No data for:", p135);

        return nil, nil;
    end;

    local v137 = u1 and u1:FindFirstChild(p135);

    if not v137 then
        warn((`[SpawnEnemy] No model for "{p135}" in the Enemies library (server: ServerStorage.Models.Enemies / client: RS.Assets.Models.Enemies boss subset)`));

        return nil, nil;
    end;

    local v138 = v137:Clone();
    v138:SetAttribute("ItemId", p135);
    local v139 = v138.PrimaryPart:FindFirstChild("BillboardAttachment") or v138.PrimaryPart;
    local v140 = ReplicatedStorage.Assets.UI.ItemBillboardWithHealth:Clone();
    local Frame = v140:FindFirstChild("Frame");

    if Frame then
        local ItemName = Frame:FindFirstChild("ItemName");

        if ItemName then
            ItemName.Text = v136.Name or p135;
        end;

        for _, v in { "Rarity", "Income", "Price", "Unstealable", "Duration" } do
            local v141 = Frame:FindFirstChild(v);

            if v141 then
                v141.Visible = false;
            end;
        end;
    end;

    v140.Parent = v139;
    u2.AttachAnimateScript(v138, v136);

    return v138, v140;
end;

function u2.SetEnemyLevel(p142: userdata, p143: number) -- Line: 1213
    if not p142 then
        return;
    end;

    local Level = p142:FindFirstChild("Level");

    if not Level then
        Level = Instance.new("TextLabel");
        Level.Name = "Level";
        Level.BackgroundTransparency = 1;
        Level.Size = UDim2.new(1, 0, 0.18, 0);
        Level.Position = UDim2.new(0, 0, -0.2, 0);
        Level.AnchorPoint = Vector2.new(0, 0);
        Level.Font = Enum.Font.GothamBold;
        Level.TextScaled = true;
        Level.TextColor3 = Color3.fromRGB(255, 255, 255);
        Level.TextStrokeTransparency = 0.3;
        Level.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
        Level.ZIndex = 2;
        Level.Parent = p142;
    end;

    Level.Text = `Lv. {p143}`;
end;

local u144 = {};

function u2.SetTheftStatus(p145: userdata, p146: boolean, p147: string?) -- Line: 1238
    -- upvalues: u144 (copy), u2 (copy), ReplicatedStorage (copy)
    local Character = p145.Character;

    if not Character then
        warn((`Player {p145.Name} does not have a character.`));

        return;
    end;

    u144[p145.UserId] = u144[p145.UserId] or {};
    p145:SetAttribute("IsTheft", p146);

    if not p146 then
        Character.Humanoid.WalkSpeed = ReplicatedStorage.Configuration.DEFAULT_WALK_SPEED.Value;
        u144[p145.UserId].Character:Destroy();
        u144[p145.UserId].Weld:Destroy();

        return;
    end;

    local v148 = u2.CreateItem(p147);
    u144[p145.UserId].Character = v148;
    v148.PrimaryPart.Anchored = false;
    v148:PivotTo(Character.PrimaryPart:GetPivot() * CFrame.new(0, 3, 0));
    v148.Parent = workspace;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = Character.PrimaryPart;
    WeldConstraint.Part1 = v148.PrimaryPart;
    WeldConstraint.Parent = Character.PrimaryPart;
    WeldConstraint.Name = "TheftCharacterWeld";
    u144[p145.UserId].Weld = WeldConstraint;
    Character.Humanoid.WalkSpeed = 10;
end;

function u2.GetRichCharacterName(p149: string) -- Line: 1270
    -- upvalues: EnemyResolver (copy), RarityColors (copy)
    local v150 = EnemyResolver(p149);

    if not v150 then
        return p149;
    end;

    local Name = v150.Name;
    local TextColor3 = RarityColors[v150.Rarity].TextColor3;
    local v151 = TextColor3:Lerp(Color3.new(), 0.95);

    return `<font color="#{TextColor3:ToHex()}"><stroke thickness="5.4" color="#{v151:ToHex()}">{Name}</stroke></font>`;
end;

function u2.GetRandomPositionInsidePart(p152: userdata) -- Line: 1282
    if not p152 then
        return nil;
    end;

    local v153 = p152.Size / 2;
    local Position = p152.Position;
    local math_random_ret = math.random(-v153.X, v153.X);
    local math_random_ret2 = math.random(-v153.Y, v153.Y);

    return Position + Vector3.new(math_random_ret, math_random_ret2, math.random(-v153.Z, v153.Z));
end;

function u2.CheckDistance(p154: vector, p155: vector, p156: number) -- Line: 1294
    return (p154 - p155).Magnitude <= p156;
end;

function u2.MoveToFinished(p157: userdata) -- Line: 1299
    local u158 = false;
    local BindableEvent = Instance.new("BindableEvent");
    local u159 = nil;
    u159 = p157.MoveToFinished:Connect(function(p160) -- Line: 1304
        -- upvalues: u158 (ref), BindableEvent (copy), u159 (ref)
        if not u158 then
            u158 = true;
            BindableEvent:Fire(p160);
        end;

        if u159 then
            u159:Disconnect();
        end;
    end);
    task.delay(3, function() -- Line: 1314
        -- upvalues: u158 (ref), BindableEvent (copy)
        if not u158 then
            u158 = true;
            BindableEvent:Fire(false);
        end;
    end);
    local v161 = BindableEvent.Event:Wait();

    if u159 then
        u159:Disconnect();
    end;

    BindableEvent:Destroy();

    return v161;
end;

function u2.FormatNumber(p162: number) -- Line: 1329
    local math_floor_ret = math.floor(p162);
    local math_abs_ret = math.abs(math_floor_ret);

    for _, v in ipairs({ {
            value = 1e42,
            suffix = "tdD"
        }, {
            value = 1e39,
            suffix = "DD"
        }, {
            value = 1e36,
            suffix = "Ud"
        }, {
            value = 1e33,
            suffix = "de"
        }, {
            value = 1e30,
            suffix = "N"
        }, {
            value = 1e27,
            suffix = "O"
        }, {
            value = 1e24,
            suffix = "Sp"
        }, {
            value = 1e21,
            suffix = "SX"
        }, {
            value = 1e18,
            suffix = "Qn"
        }, {
            value = 1000000000000000,
            suffix = "qd"
        }, {
            value = 1000000000000,
            suffix = "T"
        }, {
            value = 1000000000,
            suffix = "B"
        }, {
            value = 1000000,
            suffix = "M"
        }, {
            value = 1000,
            suffix = "K"
        } }) do
        if v.value <= math_abs_ret then
            return string.format("%.2f", math_floor_ret / v.value):gsub("%.?0+$", "") .. v.suffix;
        end;
    end;

    return tostring(math_floor_ret);
end;

function u2.FormatWithCommas(p163: number) -- Line: 1364
    local math_floor_ret = math.floor(p163 + 0.5);
    local v164 = tostring(math_floor_ret);
    local v165;

    repeat
        v164, v165 = v164:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v165 == 0;

    return v164;
end;

function u2.AbbreviateNumber(p166: number) -- Line: 1378
    if p166 >= 1000000 then
        return string.format("%.1fM", p166 / 1000000);
    end;

    if p166 >= 1000 then
        return string.format("%.1fK", p166 / 1000);
    end;

    return tostring(p166);
end;

function u2.AbbreviateStat10k(p167: number) -- Line: 1390
    local math_floor_ret = math.floor(p167);

    if math_floor_ret < 10000 then
        return tostring(math_floor_ret);
    end;

    local v168, v169;

    if math_floor_ret >= 1000000 then
        v168 = 1000000;
        v169 = "M";
    else
        v168 = 1000;
        v169 = "k";
    end;

    local v170 = math_floor_ret / v168;

    if v170 == math.floor(v170) then
        return string.format("%d%s", v170, v169);
    end;

    return string.format("%.1f%s", v170, v169);
end;

function u2.FormatToHHMMSS(p171: number) -- Line: 1406
    local math_floor_ret = math.floor(p171 / 3600);
    local math_floor_ret2 = math.floor(p171 % 3600 / 60);

    return string.format("%02d:%02d:%02d", math_floor_ret, math_floor_ret2, p171 % 60);
end;

function u2.FormatCashString(p172: number, p173: boolean) -- Line: 1413
    -- upvalues: u2 (copy)
    local v174 = u2.FormatNumber(p172);

    return p173 and v174 == "0" and "FREE" or `${v174}`;
end;

local u175 = {
    [48] = true,
    [60] = true,
    [75] = true,
    [100] = true,
    [150] = true,
    [180] = true,
    [352] = true,
    [420] = true
};

function u2.GetHeadshotThumbnail(p176: number, p177: number?) -- Line: 1428
    -- upvalues: u175 (copy)
    local v178 = not (p177 and (u175[p177] and p177)) and 150 or p177;

    return `rbxthumb://type=AvatarHeadShot&id={p176}&w={v178}&h={v178}`;
end;

function u2._ResolveViewportAnimator(p179: userdata) -- Line: 1437
    local v180 = p179:FindFirstChildOfClass("Humanoid");

    if v180 then
        local v181 = v180:FindFirstChildOfClass("Animator");

        if not v181 then
            v181 = Instance.new("Animator");
            v181.Parent = v180;
        end;

        return v181;
    end;

    local v182 = p179:FindFirstChildOfClass("AnimationController");

    if not v182 then
        return nil;
    end;

    local v183 = v182:FindFirstChildOfClass("Animator");

    if not v183 then
        v183 = Instance.new("Animator");
        v183.Parent = v182;
    end;

    return v183;
end;

function u2.LoadItemViewport(p184: userdata, p185: string) -- Line: 1459
    -- upvalues: u2 (copy), EnemyResolver (copy)
    p184:ClearAllChildren();
    local u186 = u2.CreateItem(p185, false, true);

    if not u186 then
        return;
    end;

    local u187 = EnemyResolver(p185);

    if not u187 then
        return;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "CharacterWorld";
    WorldModel.Parent = p184;
    local Vector3_new_ret = Vector3.new(0, 2 + (u187.ViewportOffset and (u187.ViewportOffset.Y or 0) or 0), 3);
    u186:PivotTo(CFrame.new(Vector3_new_ret));
    u186.Parent = WorldModel;
    local Camera = Instance.new("Camera");
    Camera.CFrame = CFrame.new(0, 1.5, u187.ViewportDistance or -2.5) * CFrame.Angles(0, 3.141592653589793, 0);
    Camera.Parent = p184;
    p184.CurrentCamera = Camera;
    pcall(u2.SnapViewportAccessories, u186);

    if u187.IdleAnim and u187.IdleAnim ~= "" then
        pcall(function() -- Line: 1488
            -- upvalues: u2 (ref), u186 (copy), u187 (copy)
            local v188 = u2._ResolveViewportAnimator(u186);

            if not v188 then
                return;
            end;

            local Animation = Instance.new("Animation");
            Animation.AnimationId = u187.IdleAnim;
            local v189 = v188:LoadAnimation(Animation);
            v189.Looped = true;
            v189.Priority = Enum.AnimationPriority.Idle;
            v189:Play(0);
        end);
    end;

    task.spawn(function() -- Line: 1500
        -- upvalues: WorldModel (copy), u186 (copy), Camera (copy), Vector3_new_ret (copy)
        while WorldModel.Parent and u186.Parent do
            local v190 = Camera.CFrame.Position - Vector3.new(0, 0, 0);
            local Unit = Vector3.new(v190.X, 0, v190.Z).Unit;
            u186:PivotTo(CFrame.new(Vector3_new_ret, Vector3_new_ret + Unit) * CFrame.Angles(0, -0.4363323129985824, 0));
            task.wait(0.1);
        end;
    end);
end;

function u2.SnapViewportAccessories(p191: userdata) -- Line: 1522
    local v192 = {};

    for _, descendant in p191:GetDescendants() do
        if descendant:IsA("Attachment") then
            local Parent = descendant.Parent;

            if Parent and (Parent:IsA("BasePart") and (not Parent:FindFirstAncestorWhichIsA("Accessory") and v192[descendant.Name] == nil)) then
                v192[descendant.Name] = descendant;
            end;
        end;
    end;

    for _, child in p191:GetChildren() do
        if child:IsA("Accessory") then
            local Handle = child:FindFirstChild("Handle");

            if Handle then
                for _, child2 in Handle:GetChildren() do
                    if child2:IsA("Attachment") then
                        local v193 = v192[child2.Name];

                        if v193 then
                            local Parent = v193.Parent;
                            Handle.CFrame = Parent.CFrame * v193.CFrame * child2.CFrame:Inverse();
                            local Weld = Instance.new("Weld");
                            Weld.Part0 = Parent;
                            Weld.Part1 = Handle;
                            Weld.C0 = v193.CFrame;
                            Weld.C1 = child2.CFrame;
                            Weld.Parent = Handle;
                            break;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

local RaycastParams_new_ret = RaycastParams.new();

function u2.GetSurfaceFromVector3(p194: vector, p195: number, p196: any, p197: any) -- Line: 1568
    -- upvalues: RaycastParams_new_ret (copy)
    if p197 == "Include" then
        RaycastParams_new_ret.IncludeInstances = p196 or {};
        RaycastParams_new_ret.ExcludeInstances = {};
    else
        RaycastParams_new_ret.ExcludeInstances = p196 or {};
        RaycastParams_new_ret.IncludeInstances = nil;
    end;

    local v198 = workspace:Raycast(p194, Vector3.new(0, -1, 0) * (p195 or 50), RaycastParams_new_ret);

    if v198 then
        p194 = v198.Position or p194;
    end;

    return p194, v198 and v198.Normal or Vector3.new(0, 1, 0);
end;

game.Players.PlayerRemoving:Connect(function(p199) -- Line: 1585
    -- upvalues: u144 (copy), u86 (copy), u74 (copy)
    u144[p199.UserId] = nil;

    if p199.Character then
        local HumanoidRootPart = p199.Character:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            for i, _ in pairs(u86) do
                if string.find(i, (tostring(HumanoidRootPart))) then
                    u86[i] = nil;
                end;
            end;
        end;

        u74[p199.Character] = nil;
    end;
end);

function u2.BroadcastCombatSound(p200: string, p201: userdata, p202: number?) -- Line: 1607
    -- upvalues: ReplicatedStorage (copy)
    local Remotes = ReplicatedStorage.Player:FindFirstChild("Remotes");

    if Remotes then
        Remotes = Remotes:FindFirstChild("SFX");
    end;

    if Remotes then
        Remotes:FireAllClients(p200, p201, p202);
    end;
end;

local function findFXPrefab(p203: userdata) -- Line: 1623
    for _, child in p203:GetChildren() do
        if child:HasTag("Weapon_Prefab") then
            return child;
        end;
    end;

    for _, child in p203:GetChildren() do
        if child.Name ~= "Animations" and (child.Name ~= "Skill_Animations" and (child:IsA("BasePart") or child:IsA("Model"))) then
            return child;
        end;
    end;

    return nil;
end;

function u2.AttachFXPrefab(p204: userdata, p205: any) -- Line: 1637
    -- upvalues: findFXPrefab (copy)
    local v206 = p205.logLabel or "AttachFXPrefab";

    if not p205.container then
        warn((`[{v206}] No prefab container`));

        return nil;
    end;

    local v207 = findFXPrefab(p205.container);

    if not v207 then
        warn((`[{v206}] No prefab found in "{p205.container.Name}"`));

        return nil;
    end;

    local v208 = v207:Clone();
    local FX = v208:FindFirstChild("FX");

    if not FX then
        warn((`[{v206}] Prefab "{v207.Name}" has no FX folder`));
        v208:Destroy();

        return nil;
    end;

    local v209;

    if v208:IsA("BasePart") then
        v209 = v208;
    elseif v208:IsA("Model") and v208.PrimaryPart then
        v209 = v208.PrimaryPart;
    else
        v209 = v208:FindFirstChildWhichIsA("BasePart");
    end;

    if not v209 then
        warn((`[{v206}] Could not determine root part for FX prefab "{v207.Name}"`));
        v208:Destroy();

        return nil;
    end;

    v208.Parent = p204;

    if v208:IsA("BasePart") then
        local Weld = Instance.new("Weld");
        Weld.Name = p205.weldName;
        Weld.Part0 = p204;
        Weld.Part1 = v208;
        Weld.Parent = v208;
        v208.CFrame = p204.CFrame;
        v208.Transparency = 1;
        v208.CanCollide = false;
        v208.CanQuery = false;
    else
        local Weld = Instance.new("Weld");
        Weld.Name = p205.weldName;
        Weld.Part0 = p204;
        Weld.Part1 = v209;
        Weld.Parent = v209;
        v209.CFrame = p204.CFrame;

        for _, descendant in v208:GetDescendants() do
            if descendant:IsA("BasePart") and not descendant:IsDescendantOf(FX) then
                if p205.stripMode == "destroy" then
                    if descendant ~= v209 then
                        descendant:Destroy();
                    end;
                else
                    descendant.Transparency = 1;
                    descendant.CanCollide = false;
                    descendant.CanQuery = false;
                end;
            end;
        end;
    end;

    for _, child in v208:GetChildren() do
        if child ~= FX and (not child:IsA("Weld") and (not child:IsA("Motor6D") and child ~= v209)) then
            child:Destroy();
        end;
    end;

    local v210 = {};

    for _, child in FX:GetChildren() do
        v210[child.Name] = child;
    end;

    return v208, v210;
end;

function u2.WaitForEventOrStop(p211: userdata, p212: userdata?, p213: number) -- Line: 1734
    local coroutine_running_ret = coroutine.running();
    local u214 = false;
    local u215 = {};
    local u216 = nil;

    local function finish() -- Line: 1740
        -- upvalues: u214 (ref), u215 (copy), u216 (ref), coroutine_running_ret (copy)
        if u214 then
            return;
        end;

        u214 = true;

        for _, v in u215 do
            v:Disconnect();
        end;

        if u216 and coroutine.running() ~= u216 then
            task.cancel(u216);
        end;

        if coroutine.status(coroutine_running_ret) == "suspended" then
            task.spawn(coroutine_running_ret);
        end;
    end;

    table.insert(u215, p211.Event:Once(finish));

    if p212 then
        table.insert(u215, p212.Stopped:Once(finish));
    end;

    u216 = task.delay(p213, finish);
    coroutine.yield();
end;

u2.FREEZE_TIME_ATTR = "CC_FreezeTime";

function u2.IsTimeFrozen() -- Line: 1773
    -- upvalues: u2 (copy)
    return workspace:GetAttribute(u2.FREEZE_TIME_ATTR) == true;
end;

function u2.CheckRateLimit(p217: table, p218: number, p219: number) -- Line: 1787
    local v220 = tick();
    local v221 = p217[p218];

    if v221 and v220 - v221 < p219 then
        return false;
    end;

    p217[p218] = v220;

    return true;
end;

function u2.FindByGUID(p222: table?, p223: string) -- Line: 1800
    if not p222 then
        return nil, nil;
    end;

    for i, v in p222 do
        if type(v) == "table" and v.GUID == p223 then
            return i, v;
        end;
    end;

    return nil, nil;
end;

return u2;