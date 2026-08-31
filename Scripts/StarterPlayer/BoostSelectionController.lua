--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BoostSelectionController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.BoostSelectionController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Debris = game:GetService("Debris");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local Back = Enum.EasingStyle.Back;
local v1 = Knit.CreateController({
    Name = "BoostSelectionController"
});

local function PlayNamedSFX(p2: string) -- Line: 59
    -- upvalues: SoundService (copy)
    local v3 = SoundService:FindFirstChild(p2, true);

    if v3 and v3:IsA("Sound") then
        v3:Play();
    end;
end;

local function PlayChestLand() -- Line: 67
    -- upvalues: SoundService (copy), Debris (copy)
    local Chest_Land = SoundService:FindFirstChild("Chest_Land", true);

    if not (Chest_Land and Chest_Land:IsA("Sound")) then
        return;
    end;

    local v4 = Chest_Land:Clone();
    v4.PlaybackSpeed = 1 + (math.random() * 2 - 1) * 0.02;
    v4.Parent = SoundService;
    v4:Play();
    Debris:AddItem(v4, 5);
end;

function v1._Resolve(u5) -- Line: 80
    -- upvalues: LocalPlayer (copy)
    if u5._frame then
        return true;
    end;

    local Boost_Selection = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Boost_Selection");

    if not Boost_Selection then
        warn("[BoostSelectionController] Main.HUD.Boost_Selection missing");

        return false;
    end;

    u5._frame = Boost_Selection;
    u5._textLabel = Boost_Selection:FindFirstChild("TextLabel");
    u5._cards = {};

    for i = 1, 3 do
        local v6 = Boost_Selection:FindFirstChild("Boost_" .. i);
        local v7;

        if v6 then
            local Card = v6:FindFirstChild("Card");
            local Icon = v6:FindFirstChild("Icon");
            local ItemTemplate = v6:FindFirstChild("ItemTemplate");

            if ItemTemplate then
                ItemTemplate.Visible = false;
            end;

            local Glow = v6:FindFirstChild("Glow");
            local v8;

            if Glow then
                v8 = Glow:FindFirstChildOfClass("UIScale");
            else
                v8 = Glow;
            end;

            if Glow and not v8 then
                v8 = Instance.new("UIScale");
                v8.Scale = 0;
                v8.Parent = Glow;
            end;

            local _cards = u5._cards;
            local v9 = {
                Index = i,
                Button = v6,
                Card = Card
            };

            if Card then
                Card = Card:FindFirstChildOfClass("UIScale");
            end;

            v9.CardScale = Card;
            v9.Icon = Icon;
            v9.Title = v6:FindFirstChild("Title");
            v9.Description = v6:FindFirstChild("Description");
            v9.ButtonScale = v6:FindFirstChildOfClass("UIScale");
            v9.Glow = Glow;
            v9.GlowScale = v8;
            v9.StartPos = v6:GetAttribute("Start_Position");
            v9.EndPos = v6:GetAttribute("End_Position");
            _cards[i] = v9;
            v6.MouseButton1Click:Connect(function() -- Line: 132
                -- upvalues: u5 (copy), i (copy)
                u5:_OnCardClicked(i);
            end);
            v7 = i;
        else
            v7 = i;
        end;
    end;

    return true;
end;

function v1._Reset(p10) -- Line: 143
    p10._active = false;
    p10._ready = false;
    p10._selecting = false;
    p10._candidates = nil;

    if not p10._frame then
        return;
    end;

    p10._frame.Visible = false;
    p10._frame.GroupTransparency = 1;

    for _, v in p10._cards do
        if v.ButtonScale then
            v.ButtonScale.Scale = 1;
        end;

        if v.Button then
            v.Button.ImageTransparency = 0;
        end;

        if v.Card then
            v.Card.ImageTransparency = 0;
        end;

        if v.Icon then
            v.Icon.ImageTransparency = 0;
        end;

        if v.StartPos then
            v.Button.Position = v.StartPos;
        end;

        p10:_StopGlow(v);

        if v.GlowScale then
            v.GlowScale.Scale = 0;
        end;

        if v.Glow then
            v.Glow.Rotation = 0;
        end;
    end;
end;

function v1._Show(u11, p12) -- Line: 168
    -- upvalues: TweenService (copy), Back (copy), PlayChestLand (copy)
    if not u11:_Resolve() then
        return;
    end;

    if type(p12) ~= "table" or #p12 == 0 then
        return;
    end;

    u11:_Reset();
    u11._candidates = p12;
    u11._active = true;

    if u11._textLabel then
        u11._textLabel.Text = "SELECT A BLESSING:";
    end;

    for i, v in u11._cards do
        local v13 = p12[i];

        if v13 then
            if v.Icon and v13.Icon then
                v.Icon.Image = v13.Icon;
            end;

            if v.Title then
                v.Title.Text = v13.Title or "";
            end;

            if v.Description then
                v.Description.Text = v13.Description or "";
            end;
        end;
    end;

    u11._frame.Visible = true;
    u11._frame.GroupTransparency = 1;
    TweenService:Create(u11._frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();

    for i = 1, #u11._cards do
        local u14 = u11._cards[i];
        local v15;

        if u14.StartPos and u14.EndPos then
            u14.Button.Position = u14.StartPos;
            task.delay((i - 1) * 0.18, function() -- Line: 208
                -- upvalues: u11 (copy), u14 (copy), TweenService (ref), Back (ref), PlayChestLand (ref)
                if not (u11._active and u14.Button.Parent) then
                    return;
                end;

                local v16 = TweenService:Create(u14.Button, TweenInfo.new(0.55, Back, Enum.EasingDirection.Out), {
                    Position = u14.EndPos
                });
                v16.Completed:Connect(function() -- Line: 215
                    -- upvalues: PlayChestLand (ref)
                    PlayChestLand();
                end);
                v16:Play();
            end);
            v15 = i;
        else
            v15 = i;
        end;
    end;

    task.delay((#u11._cards - 1) * 0.18 + 0.55, function() -- Line: 225
        -- upvalues: u11 (copy)
        if u11._active then
            u11._ready = true;
        end;
    end);
end;

function v1._OnCardClicked(u17: table, u18: number) -- Line: 232
    -- upvalues: TweenService (copy), SoundService (copy), Knit (copy)
    if not u17._active or (not u17._ready or u17._selecting) then
        return;
    end;

    if not (u17._candidates and u17._candidates[u18]) then
        return;
    end;

    u17._selecting = true;
    u17._ready = false;
    local v19 = u17._cards[u18];

    if v19 then
        if v19.ButtonScale then
            TweenService:Create(v19.ButtonScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1.15
            }):Play();
        end;

        u17:_StartGlow(v19);
        local RelicInteract = SoundService:FindFirstChild("RelicInteract", true);

        if RelicInteract and RelicInteract:IsA("Sound") then
            RelicInteract:Play();
        end;
    end;

    for i, v in u17._cards do
        if i ~= u18 then
            for _, v2 in { v.Button, v.Card, v.Icon } do
                if v2 then
                    TweenService:Create(v2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ImageTransparency = 0.6
                    }):Play();
                end;
            end;
        end;
    end;

    task.spawn(function() -- Line: 264
        -- upvalues: u17 (copy), TweenService (ref), Knit (ref), u18 (copy)
        task.wait(0.45);

        if u17._frame then
            TweenService:Create(u17._frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                GroupTransparency = 1
            }):Play();
        end;

        for _, v in u17._cards do
            u17:_StopGlow(v);
        end;

        task.wait(0.35);

        if u17._frame then
            u17._frame.Visible = false;
        end;

        local v20, v21, v22 = Knit.GetService("DungeonBuffService"):SelectBuff(u18):await();

        if not (v20 and v21) then
            warn("[BoostSelectionController] SelectBuff failed:", v22 or (v20 and "unknown" or "promise rejected"));
        end;

        u17:_Reset();
    end);
end;

function v1._StartGlow(p23, u24) -- Line: 293
    -- upvalues: TweenService (copy)
    local GlowScale = u24.GlowScale;
    local Glow = u24.Glow;

    if not (GlowScale and Glow) then
        return;
    end;

    if u24.GlowScaleTween then
        u24.GlowScaleTween:Cancel();
    end;

    GlowScale.Scale = 0;
    local u25 = TweenService:Create(GlowScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    });
    u24.GlowScaleTween = u25;
    u25.Completed:Connect(function(p26) -- Line: 307
        -- upvalues: u24 (copy), u25 (copy), Glow (copy), TweenService (ref)
        if p26 ~= Enum.PlaybackState.Completed then
            return;
        end;

        if u24.GlowScaleTween ~= u25 then
            return;
        end;

        if u24.GlowSpinTween then
            u24.GlowSpinTween:Cancel();
        end;

        Glow.Rotation = 0;
        u24.GlowSpinTween = TweenService:Create(Glow, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
            Rotation = 360
        });
        u24.GlowSpinTween:Play();
    end);
    u25:Play();
end;

function v1._StopGlow(p27, p28) -- Line: 323
    if p28.GlowScaleTween then
        p28.GlowScaleTween:Cancel();
        p28.GlowScaleTween = nil;
    end;

    if p28.GlowSpinTween then
        p28.GlowSpinTween:Cancel();
        p28.GlowSpinTween = nil;
    end;
end;

function v1.KnitStart(u29) -- Line: 336
    -- upvalues: Knit (copy)
    if u29:_Resolve() then
        u29:_Reset();
    end;

    Knit.GetService("DungeonBuffService").BuffSelection:Connect(function(p30) -- Line: 343
        -- upvalues: u29 (copy)
        u29:_Show(p30);
    end);
    local success, result = pcall(function() -- Line: 348
        -- upvalues: Knit (ref)
        return Knit.GetService("DungeonRunService");
    end);

    if success and (result and result.DungeonComplete) then
        result.DungeonComplete:Connect(function() -- Line: 352
            -- upvalues: u29 (copy)
            if u29._frame and u29._frame.Visible then
                u29:_Reset();
            end;
        end);
    end;
end;

return v1;