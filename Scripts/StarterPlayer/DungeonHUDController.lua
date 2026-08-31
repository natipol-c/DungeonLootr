--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DungeonHUDController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.DungeonHUDController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local Image_Data = require(GameInfo:WaitForChild("Image_Data"));
local EquipmentTemplates = require(GameInfo:WaitForChild("EquipmentTemplates"));
local ItemData = require(GameInfo:WaitForChild("ItemData"));
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local ColorData = require(GameInfo:WaitForChild("ColorData"));
local BossHealthBars = require(ReplicatedStorage.ClientTools.BossHealthBars);
local TweenInfo_new_ret = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 224, 130)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 154, 38)) });
local ColorSequence_new_ret2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 214, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(58, 122, 220)) });
local Color3_fromRGB_ret = Color3.fromRGB(80, 220, 100);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 200, 50);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 60, 60);
local Color3_fromRGB_ret4 = Color3.fromRGB(255, 220, 50);
local Color3_fromRGB_ret5 = Color3.fromRGB(255, 180, 0);
local TweenInfo_new_ret3 = TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v1 = Knit.CreateController({
    Name = "DungeonHUDController"
});

local function FindRoomChild(p2: number, u3: string) -- Line: 99
    local u4 = "Room_" .. tostring(p2);

    local function SearchContainer(p5: userdata) -- Line: 103
        -- upvalues: u4 (copy), u3 (copy)
        for _, descendant in p5:GetDescendants() do
            if descendant.Name == u4 and (descendant:IsA("Folder") or descendant:IsA("Model")) then
                local v6 = descendant:FindFirstChild(u3);

                if v6 then
                    return v6;
                end;

                local Spawns = descendant:FindFirstChild("Spawns");

                if Spawns then
                    local v7 = Spawns:FindFirstChild(u3);

                    if v7 then
                        return v7;
                    end;
                end;
            end;
        end;

        return nil;
    end;

    local Dungeons = workspace:FindFirstChild("Dungeons");
    local v8 = Dungeons and SearchContainer(Dungeons);

    if v8 then
        return v8;
    end;

    for _, child in workspace:GetChildren() do
        if child:IsA("Folder") and child ~= Dungeons then
            local v9 = SearchContainer(child);

            if v9 then
                return v9;
            end;
        end;
    end;

    return nil;
end;

local function FindDoorForRoom(p10: number) -- Line: 137
    -- upvalues: FindRoomChild (copy)
    local v11 = FindRoomChild(p10, "Door");

    if v11 and v11:IsA("BasePart") then
        return v11;
    end;

    return nil;
end;

local function FindExitForRoom(p12: number) -- Line: 147
    -- upvalues: FindRoomChild (copy)
    local v13 = FindRoomChild(p12, "Connectors");

    if v13 then
        local Exit = v13:FindFirstChild("Exit");

        if Exit and Exit:IsA("BasePart") then
            return Exit;
        end;

        for _, child in v13:GetChildren() do
            if child:IsA("BasePart") and child:GetAttribute("Type") == "Exit" then
                return child;
            end;
        end;
    end;

    local v14 = FindRoomChild(p12, "Door");

    if v14 and v14:IsA("BasePart") then
        return v14;
    end;

    return nil;
end;

local function FlashDoorHighlight(p15: number) -- Line: 162
    -- upvalues: FindRoomChild (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret5 (copy), TweenService (copy)
    local v16 = FindRoomChild(p15, "Door");

    if not (v16 and v16:IsA("BasePart")) then
        v16 = nil;
    end;

    if not v16 then
        return;
    end;

    local v17 = v16:FindFirstChildOfClass("MeshPart") or v16;
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3_fromRGB_ret4;
    Highlight.OutlineColor = Color3_fromRGB_ret5;
    Highlight.FillTransparency = 0.3;
    Highlight.OutlineTransparency = 0;
    Highlight.Adornee = v17;
    Highlight.Parent = v17;
    local v18 = TweenService:Create(Highlight, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        FillTransparency = 1,
        OutlineTransparency = 1
    });
    v18:Play();
    v18.Completed:Connect(function() -- Line: 190
        -- upvalues: Highlight (copy)
        if Highlight and Highlight.Parent then
            Highlight:Destroy();
        end;
    end);
end;

local LocalPlayer = Players.LocalPlayer;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = nil;
local u31 = nil;
local u32 = nil;
local u33 = nil;
local u34 = false;
local u35 = 0;
local u36 = 30;
local u37 = nil;
local u38 = nil;
local u39 = nil;
local u40 = nil;
local u41 = nil;
local u42 = nil;
local u43 = nil;
local u44 = nil;
local u45 = nil;
local u46 = false;
local u47 = false;
local u48 = false;
local u49 = nil;
local u50 = nil;
local u51 = nil;
local u52 = nil;
local u53 = nil;
local u54 = nil;
local u55 = nil;
local u56 = nil;
local u57 = nil;
local u58 = nil;
local u59 = {};
local u60 = nil;
local u61 = nil;
local u62 = nil;
local u63 = nil;
local u64 = {};
local u65 = {};
local u66 = 0;
local u67 = nil;
local u68 = nil;
local u69 = nil;
local u70 = 0;
local u71 = nil;
local u72 = nil;
local u73 = 0;
local u74 = false;
local u75 = nil;
local u76 = nil;
local u77 = false;
local u78 = false;
local u79 = false;
local u80 = false;
local u81 = nil;
local u82 = 0;
local u83 = 0;
local u84 = false;
local u85 = nil;
local u86 = nil;
local u87 = nil;
local u88 = nil;
local u89 = nil;
local u90 = false;
local u91 = false;
local u92 = false;
local u93 = false;
local u94 = 0;
local u95 = 0;
local u96 = {
    CurrentPos = 0,
    ZoneWidth = 0,
    Padding = 0,
    BarMargin = 0,
    Tween = nil,
    Zones = {},
    ByIndex = {}
};

local function PlaySound(p97: string) -- Line: 312
    -- upvalues: u86 (ref)
    if u86 then
        u86:Play(p97);
    end;
end;

local function FormatWithCommas(p98: number) -- Line: 319
    local math_floor_ret = math.floor(p98);
    local v99 = tostring(math_floor_ret);
    local v100;

    repeat
        v99, v100 = string.gsub(v99, "^(-?%d+)(%d%d%d)", "%1,%2");
    until v100 == 0;

    return v99;
end;

local function FormatTime(p101: number) -- Line: 330
    local math_floor_ret = math.floor(p101);
    local math_max_ret = math.max(math_floor_ret, 0);

    return string.format("%02d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60);
end;

local function FormatTimeMs(p102: number) -- Line: 336
    local math_max_ret = math.max(p102, 0);
    local math_floor_ret = math.floor(math_max_ret / 60);
    local v103 = math.floor(math_max_ret) % 60;
    local math_floor_ret2 = math.floor(math_max_ret % 1 * 100);

    return string.format("%02d:%02d:%02d", math_floor_ret, v103, math_floor_ret2);
end;

local function FormatHealth(p104: number) -- Line: 345
    -- upvalues: SharedUtils (copy), FormatWithCommas (copy)
    if p104 >= 1000000000 then
        return SharedUtils.FormatNumber(p104);
    end;

    return FormatWithCommas(p104);
end;

local function LerpColor(p105, p106, p107: number) -- Line: 353
    return Color3.new(p105.R + (p106.R - p105.R) * p107, p105.G + (p106.G - p105.G) * p107, p105.B + (p106.B - p105.B) * p107);
end;

local function GetTimerColor(p108: number) -- Line: 362
    -- upvalues: Color3_fromRGB_ret3 (copy), LerpColor (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
    if p108 <= 0.2 then
        return Color3_fromRGB_ret3;
    end;

    if p108 <= 0.5 then
        return LerpColor(Color3_fromRGB_ret3, Color3_fromRGB_ret2, (p108 - 0.2) / 0.3);
    end;

    return LerpColor(Color3_fromRGB_ret2, Color3_fromRGB_ret, (p108 - 0.5) / 0.5);
end;

local u109 = {
    Marker = nil,
    Highlight = nil,
    Scale = nil,
    ActiveRoom = nil,
    Running = false,
    ScaleTween = nil,
    FadeTween = nil,

    ResolveTemplate = function() -- Line: 396, Name: ResolveTemplate
        -- upvalues: ReplicatedStorage (copy)
        local Assets = ReplicatedStorage:FindFirstChild("Assets");

        if Assets then
            Assets = Assets:FindFirstChild("UI");
        end;

        if Assets then
            Assets = Assets:FindFirstChild("ContinuePath");
        end;

        if not Assets then
            return nil;
        end;

        if Assets:IsA("BillboardGui") then
            return Assets;
        end;

        return Assets:FindFirstChildWhichIsA("BillboardGui", true);
    end
};

function u109.StopPulse() -- Line: 406
    -- upvalues: u109 (copy)
    u109.Running = false;

    if u109.ScaleTween then
        u109.ScaleTween:Cancel();
        u109.ScaleTween = nil;
    end;

    if u109.FadeTween then
        u109.FadeTween:Cancel();
        u109.FadeTween = nil;
    end;
end;

function u109.Hide() -- Line: 413
    -- upvalues: u109 (copy)
    u109.StopPulse();
    u109.ActiveRoom = nil;
    local Marker = u109.Marker;

    if Marker then
        Marker.Enabled = false;
        Marker.Adornee = nil;
        Marker.Parent = nil;
    end;
end;

function u109.Reset() -- Line: 425
    -- upvalues: u109 (copy)
    u109.Hide();

    if u109.Marker then
        u109.Marker:Destroy();
    end;

    u109.Marker = nil;
    u109.Highlight = nil;
    u109.Scale = nil;
end;

function u109.ReachedNextZone(p110: number) -- Line: 434
    -- upvalues: u94 (ref), LocalPlayer (copy), FindRoomChild (copy)
    if p110 < u94 then
        return true;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v111 = FindRoomChild(p110 + 1, "Zone");

    if Character and (v111 and v111:IsA("BasePart")) then
        local v112 = v111.CFrame:PointToObjectSpace(Character.Position);
        local v113 = v111.Size * 0.5;

        if math.abs(v112.X) <= v113.X + 4 and (math.abs(v112.Y) <= v113.Y + 4 and math.abs(v112.Z) <= v113.Z + 4) then
            return true;
        end;
    end;

    return false;
end;

function u109.PulseLoop(p114: number) -- Line: 457
    -- upvalues: u109 (copy), TweenService (copy), TweenInfo_new_ret3 (copy)
    local Scale = u109.Scale;
    local Highlight = u109.Highlight;

    if not (Scale and Highlight) then
        return;
    end;

    while u109.Running and u109.ActiveRoom == p114 do
        Scale.Scale = 0;
        Highlight.BackgroundTransparency = 1;
        u109.ScaleTween = TweenService:Create(Scale, TweenInfo_new_ret3, {
            Scale = 1
        });
        u109.FadeTween = TweenService:Create(Highlight, TweenInfo_new_ret3, {
            BackgroundTransparency = 0
        });
        u109.ScaleTween:Play();
        u109.FadeTween:Play();
        u109.ScaleTween.Completed:Wait();

        if not u109.Running or u109.ActiveRoom ~= p114 then
            return;
        end;

        if u109.ReachedNextZone(p114) then
            u109.Hide();

            return;
        end;

        task.wait(0.15);
    end;
end;

function u109.ShowAtRoom(p115: number) -- Line: 491
    -- upvalues: FindExitForRoom (copy), u109 (copy)
    if not p115 then
        return;
    end;

    local v116 = FindExitForRoom(p115);

    if not v116 then
        return;
    end;

    if not u109.Marker then
        local v117 = u109.ResolveTemplate();

        if not v117 then
            return;
        end;

        local v118 = v117:Clone();
        local Highlight = v118:FindFirstChild("Highlight", true);
        local v119;

        if Highlight then
            v119 = Highlight:FindFirstChildOfClass("UIScale");
        else
            v119 = Highlight;
        end;

        if not (Highlight and (Highlight:IsA("GuiObject") and v119)) then
            v118:Destroy();

            return;
        end;

        u109.Marker = v118;
        u109.Highlight = Highlight;
        u109.Scale = v119;
    end;

    local Marker = u109.Marker;
    Marker.Adornee = v116;
    Marker.Parent = v116;
    Marker.Enabled = true;
    u109.ActiveRoom = p115;

    if u109.ReachedNextZone(p115) then
        u109.Hide();

        return;
    end;

    u109.StopPulse();
    u109.Running = true;
    task.spawn(u109.PulseLoop, p115);
end;

local function UpdateRoomProgress() -- Line: 534
    -- upvalues: u92 (ref), u93 (ref), u29 (ref), u94 (ref), u95 (ref), u31 (ref), Color3_fromRGB_ret (copy)
    if not u92 then
        return;
    end;

    if u93 then
        if u29 then
            u29.Text = "";
        end;

        return;
    end;

    if u29 then
        u29.Text = `Room {u94}/{u95}`;
    end;

    if u31 and u95 > 0 then
        local math_clamp_ret = math.clamp(u94 / u95, 0, 1);
        u31.Size = UDim2.fromScale(math_clamp_ret, 1);
        u31.BackgroundColor3 = Color3_fromRGB_ret;
    end;
end;

local function UpdateInfoFrame(p120, p121, p122, p123, p124) -- Line: 560
    -- upvalues: u20 (ref), u92 (ref), u29 (ref), u31 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), u93 (ref), u94 (ref), u95 (ref), u25 (ref), u24 (ref)
    if not u20 then
        return;
    end;

    if u92 then
        if u93 then
            if u29 then
                u29.Text = `Enemies: {p121}/{p122}`;
            end;

            if u31 and p122 > 0 then
                local math_clamp_ret = math.clamp((p122 - p121) / p122, 0, 1);
                u31.Size = UDim2.fromScale(math_clamp_ret, 1);
                local v125 = 1 - math_clamp_ret;
                local v126;

                if v125 <= 0.2 then
                    v126 = Color3_fromRGB_ret3;
                elseif v125 <= 0.5 then
                    local v127 = (v125 - 0.2) / 0.3;
                    local v128 = Color3_fromRGB_ret3;
                    local v129 = Color3_fromRGB_ret2;
                    v126 = Color3.new(v128.R + (v129.R - v128.R) * v127, v128.G + (v129.G - v128.G) * v127, v128.B + (v129.B - v128.B) * v127);
                else
                    local v130 = (v125 - 0.5) / 0.5;
                    local v131 = Color3_fromRGB_ret2;
                    local v132 = Color3_fromRGB_ret;
                    v126 = Color3.new(v131.R + (v132.R - v131.R) * v130, v131.G + (v132.G - v131.G) * v130, v131.B + (v132.B - v131.B) * v130);
                end;

                u31.BackgroundColor3 = v126;
            end;
        elseif u92 then
            if u93 then
                if u29 then
                    u29.Text = "";
                end;
            else
                if u29 then
                    u29.Text = `Room {u94}/{u95}`;
                end;

                if u31 and u95 > 0 then
                    local math_clamp_ret = math.clamp(u94 / u95, 0, 1);
                    u31.Size = UDim2.fromScale(math_clamp_ret, 1);
                    u31.BackgroundColor3 = Color3_fromRGB_ret;
                end;
            end;
        end;
    else
        if u29 then
            local math_floor_ret = math.floor(p123);
            local math_max_ret = math.max(math_floor_ret, 0);
            u29.Text = string.format("%02d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60);
        end;

        if u31 and p124 > 0 then
            local math_clamp_ret = math.clamp(p123 / p124, 0, 1);
            u31.Size = UDim2.fromScale(math_clamp_ret, 1);
            local v133;

            if math_clamp_ret <= 0.2 then
                v133 = Color3_fromRGB_ret3;
            elseif math_clamp_ret <= 0.5 then
                local v134 = (math_clamp_ret - 0.2) / 0.3;
                local v135 = Color3_fromRGB_ret3;
                local v136 = Color3_fromRGB_ret2;
                v133 = Color3.new(v135.R + (v136.R - v135.R) * v134, v135.G + (v136.G - v135.G) * v134, v135.B + (v136.B - v135.B) * v134);
            else
                local v137 = (math_clamp_ret - 0.5) / 0.5;
                local v138 = Color3_fromRGB_ret2;
                local v139 = Color3_fromRGB_ret;
                v133 = Color3.new(v138.R + (v139.R - v138.R) * v137, v138.G + (v139.G - v138.G) * v137, v138.B + (v139.B - v138.B) * v137);
            end;

            u31.BackgroundColor3 = v133;
        end;
    end;

    if u25 then
        if p120 == "Clear" then
            u24.Visible = true;
            u25.Text = tostring(p121);

            return;
        end;

        u24.Visible = false;
    end;
end;

local function UpdateObjective(p140: string) -- Line: 603
    -- upvalues: u27 (ref), u93 (ref), u92 (ref), u76 (ref), u86 (ref), TweenService (copy)
    if not u27 then
        return;
    end;

    u27.Text = ({
        Boss = "KILL BOSS",
        BossWarp = "BOSS INCOMING",
        Escape = "ESCAPE",
        Complete = "COMPLETE",
        Clear = u93 and "ELIMINATE ALL ENEMIES" or "CLEAR MOBS",
        Failed = u92 and "DEFEATED" or "TIME\'S UP"
    })[p140] or "";

    if p140 ~= u76 then
        if u86 then
            u86:Play("Ting");
        end;

        local TextSize = u27.TextSize;
        u27.TextSize = TextSize * 1.3;
        TweenService:Create(u27, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            TextSize = TextSize
        }):Play();
    end;
end;

local function UpdateBossHealth(p141: number, p142: number, p143: string, p144: string) -- Line: 640
    -- upvalues: u21 (ref), u37 (ref), u38 (ref), u39 (ref), SharedUtils (copy), FormatWithCommas (copy), u41 (ref), BossHealthBars (copy), u82 (ref), u84 (ref), u83 (ref)
    if not u21 then
        return;
    end;

    if u37 then
        u37.Text = p143 or "Boss";
    end;

    if u38 then
        u38.Text = p144 or "";
        local v145;

        if p144 == nil then
            v145 = false;
        else
            v145 = p144 ~= "";
        end;

        u38.Visible = v145;
    end;

    if u39 then
        local math_max_ret = math.max(p141, 0);
        local v146;

        if math_max_ret >= 1000000000 then
            v146 = SharedUtils.FormatNumber(math_max_ret);
        else
            v146 = FormatWithCommas(math_max_ret);
        end;

        local v147;

        if p142 >= 1000000000 then
            v147 = SharedUtils.FormatNumber(p142);
        else
            v147 = FormatWithCommas(p142);
        end;

        u39.Text = `{v146} / {v147}`;
    end;

    if u41 and p142 > 0 then
        BossHealthBars.Update(p141, p142, p143);
    end;

    u82 = os.clock();

    if not u84 then
        u83 = os.clock();
    end;

    u84 = true;
end;

local function StartTrailLogic() -- Line: 671
    -- upvalues: u42 (ref), u84 (ref), u82 (ref), u83 (ref), u85 (ref), RunService (copy), u21 (ref), u41 (ref), TweenService (copy), BossHealthBars (copy)
    if u42 then
        u42.Size = UDim2.fromScale(1, 1);
    end;

    u84 = false;
    u82 = 0;
    u83 = 0;

    if u85 then
        u85:Disconnect();
        u85 = nil;
    end;

    u85 = RunService.Heartbeat:Connect(function() -- Line: 687
        -- upvalues: u21 (ref), u42 (ref), u41 (ref), u84 (ref), u82 (ref), u83 (ref), TweenService (ref), BossHealthBars (ref)
        if not (u21 and u21.Visible) then
            return;
        end;

        if not (u42 and u41) then
            return;
        end;

        if not u84 then
            return;
        end;

        local os_clock_ret = os.clock();
        local v148 = os_clock_ret - u83;

        if os_clock_ret - u82 < 1 then
            if v148 >= 3 then
                TweenService:Create(u42, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = BossHealthBars.GetActiveSize() or u41.Size
                }):Play();
                u84 = false;
                u83 = os.clock();
            end;

            return;
        end;

        TweenService:Create(u42, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = BossHealthBars.GetActiveSize() or u41.Size
        }):Play();
        u84 = false;
    end);
end;

local function StopTrailLogic() -- Line: 720
    -- upvalues: u85 (ref), u84 (ref)
    if u85 then
        u85:Disconnect();
        u85 = nil;
    end;

    u84 = false;
end;

local function SetScale(p149: userdata, p150: number) -- Line: 732
    local v151 = p149:FindFirstChildOfClass("UIScale");

    if not v151 then
        v151 = Instance.new("UIScale");
        v151.Parent = p149;
    end;

    v151.Scale = p150;

    return v151;
end;

local function PopIn(p152: userdata) -- Line: 744
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    local v153 = p152:FindFirstChildOfClass("UIScale");

    if not v153 then
        v153 = Instance.new("UIScale");
        v153.Parent = p152;
    end;

    v153.Scale = 0;
    p152.Visible = true;
    TweenService:Create(v153, TweenInfo_new_ret, {
        Scale = 1
    }):Play();
end;

local function RevealActionButtons() -- Line: 752
    -- upvalues: u63 (ref), u64 (copy), u44 (ref), u48 (ref), u79 (ref), u62 (ref), TweenService (copy), TweenInfo_new_ret (copy)
    local v154 = u63 and u64.ButtonEnabled;
    local v155 = u44 and u48;

    if u79 then
        if v155 then
            local v156 = u44;
            local v157 = v156:FindFirstChildOfClass("UIScale");

            if not v157 then
                v157 = Instance.new("UIScale");
                v157.Parent = v156;
            end;

            v157.Scale = 1;
            u44.Visible = true;
        end;

        if v154 then
            local v158 = u63;
            local v159 = v158:FindFirstChildOfClass("UIScale");

            if not v159 then
                v159 = Instance.new("UIScale");
                v159.Parent = v158;
            end;

            v159.Scale = 1;
            u63.Visible = true;
        end;

        if u62 then
            local v160 = u62;
            local v161 = v160:FindFirstChildOfClass("UIScale");

            if not v161 then
                v161 = Instance.new("UIScale");
                v161.Parent = v160;
            end;

            v161.Scale = 1;
            u62.Visible = true;
        end;

        return;
    end;

    if v155 then
        local v162 = u44;
        local v163 = v162:FindFirstChildOfClass("UIScale");

        if not v163 then
            v163 = Instance.new("UIScale");
            v163.Parent = v162;
        end;

        v163.Scale = 0;
        v162.Visible = true;
        TweenService:Create(v163, TweenInfo_new_ret, {
            Scale = 1
        }):Play();
    end;

    if v154 then
        task.wait(0.08);
        local v164 = u63;
        local v165 = v164:FindFirstChildOfClass("UIScale");

        if not v165 then
            v165 = Instance.new("UIScale");
            v165.Parent = v164;
        end;

        v165.Scale = 0;
        v164.Visible = true;
        TweenService:Create(v165, TweenInfo_new_ret, {
            Scale = 1
        }):Play();
    end;

    task.wait(0.08);

    if u62 then
        local v166 = u62;
        local v167 = v166:FindFirstChildOfClass("UIScale");

        if not v167 then
            v167 = Instance.new("UIScale");
            v167.Parent = v166;
        end;

        v167.Scale = 0;
        v166.Visible = true;
        TweenService:Create(v167, TweenInfo_new_ret, {
            Scale = 1
        }):Play();
    end;
end;

local function ResetCompletionFrame() -- Line: 771
    -- upvalues: u22 (ref), u79 (ref), u80 (ref), u60 (ref), u65 (copy), u44 (ref), u62 (ref), u63 (ref), u43 (ref), u47 (ref), u46 (ref), u48 (ref), u49 (ref), u64 (copy)
    if not u22 then
        return;
    end;

    u22.Visible = false;
    u79 = false;
    u80 = false;

    if u60 then
        for _, child in u60:GetChildren() do
            if child.Name == "Reward_Card" then
                child:Destroy();
            end;
        end;
    end;

    for _, v in u65 do
        local v168 = v:FindFirstChildOfClass("UIScale");

        if not v168 then
            v168 = Instance.new("UIScale");
            v168.Parent = v;
        end;

        v168.Scale = 0;
    end;

    if u44 then
        local v169 = u44;
        local v170 = v169:FindFirstChildOfClass("UIScale");

        if not v170 then
            v170 = Instance.new("UIScale");
            v170.Parent = v169;
        end;

        v170.Scale = 0;
    end;

    if u62 then
        local v171 = u62;
        local v172 = v171:FindFirstChildOfClass("UIScale");

        if not v172 then
            v172 = Instance.new("UIScale");
            v172.Parent = v171;
        end;

        v172.Scale = 0;
    end;

    if u63 then
        local v173 = u63;
        local v174 = v173:FindFirstChildOfClass("UIScale");

        if not v174 then
            v174 = Instance.new("UIScale");
            v174.Parent = v173;
        end;

        v174.Scale = 0;
        u63.Visible = false;
    end;

    if u43 then
        u43.Visible = false;
    end;

    if u44 then
        u44.Active = true;
    end;

    u47 = false;
    u46 = false;
    u48 = false;
    u49 = nil;

    if u64.StatusLabel then
        u64.StatusLabel.Visible = false;
    end;
end;

local function FormatRewardAmount(p175: number) -- Line: 810
    -- upvalues: SharedUtils (copy)
    if p175 >= 1000 then
        return SharedUtils.FormatNumber((math.floor(p175)));
    end;

    local math_floor_ret = math.floor(p175);

    return tostring(math_floor_ret);
end;

local function ApplyRewardGradient(p176: userdata, p177: userdata?) -- Line: 819
    if not p177 then
        return;
    end;

    local Holder = p176:FindFirstChild("Holder");

    if not Holder then
        return;
    end;

    local v178 = Holder:FindFirstChildWhichIsA("UIGradient");

    if v178 then
        v178.Color = p177;
        v178.Enabled = true;
    end;

    local Main = Holder:FindFirstChild("Main");
    local v179 = Main and Main:FindFirstChildWhichIsA("UIGradient");

    if v179 then
        v179.Color = p177;
        v179.Enabled = true;
    end;
end;

local function SpawnRewardCard(p180: any, p181: number) -- Line: 840
    -- upvalues: u61 (ref), u60 (ref), u67 (ref), TweenInfo_new_ret2 (copy), ApplyRewardGradient (copy)
    if not (u61 and u60) then
        return nil;
    end;

    local v182 = u61:Clone();
    v182.Name = "Reward_Card";
    v182.Visible = false;
    v182.LayoutOrder = p181;
    local ItemImage = v182:FindFirstChild("ItemImage", true);

    if ItemImage then
        if p180.icon and p180.icon ~= "" then
            ItemImage.Image = p180.icon;

            if p180.whiteImage then
                ItemImage.ImageColor3 = Color3.new(1, 1, 1);
            end;

            ItemImage.Visible = true;
        else
            ItemImage.Visible = false;
        end;
    end;

    local Amount = v182:FindFirstChild("Amount", true);

    if Amount then
        if p180.amountText then
            Amount.Text = p180.amountText;
            Amount.Visible = true;
        else
            Amount.Visible = false;
        end;
    end;

    local ItemName = v182:FindFirstChild("ItemName", true);

    if ItemName then
        ItemName.Text = p180.name or "";
        ItemName.Visible = true;
    end;

    local Button = v182:FindFirstChild("Button");

    if Button and (ItemName and u67) then
        u67:BindHoverScale(Button, ItemName, {
            TweenInfo = TweenInfo_new_ret2
        });
    end;

    ApplyRewardGradient(v182, p180.seq);
    v182.Parent = u60;

    return v182;
end;

local function AnimateCoinCountUp(p183: userdata, p184: number) -- Line: 893
    -- upvalues: u79 (ref), SharedUtils (copy), u86 (ref)
    local Amount = p183:FindFirstChild("Amount", true);

    if not Amount then
        return;
    end;

    if u79 or p184 <= 0 then
        local v185;

        if p184 >= 1000 then
            v185 = SharedUtils.FormatNumber((math.floor(p184)));
        else
            local math_floor_ret = math.floor(p184);
            v185 = tostring(math_floor_ret);
        end;

        Amount.Text = v185;
        Amount.Visible = true;

        return;
    end;

    Amount.Visible = true;
    local os_clock_ret = os.clock();
    local v186 = 0;

    while not u79 do
        local v187 = (os.clock() - os_clock_ret) / 0.8;

        if v187 >= 1 then
            break;
        end;

        local v188 = p184 * v187;
        local v189;

        if v188 >= 1000 then
            v189 = SharedUtils.FormatNumber((math.floor(v188)));
        else
            local math_floor_ret = math.floor(v188);
            v189 = tostring(math_floor_ret);
        end;

        Amount.Text = v189;

        if os.clock() - v186 >= 0.05 then
            if u86 then
                u86:Play("Tick");
            end;

            v186 = os.clock();
        end;

        task.wait();
    end;

    local v190;

    if p184 >= 1000 then
        v190 = SharedUtils.FormatNumber((math.floor(p184)));
    else
        local math_floor_ret = math.floor(p184);
        v190 = tostring(math_floor_ret);
    end;

    Amount.Text = v190;
end;

local function RunCompletionSequence(p191) -- Line: 925
    -- upvalues: u22 (ref), u65 (copy), u79 (ref), TweenService (copy), TweenInfo_new_ret (copy), u60 (ref), u61 (ref), RevealActionButtons (copy), u80 (ref), SpawnRewardCard (copy), Image_Data (copy), ColorSequence_new_ret (copy), SharedUtils (copy), ColorSequence_new_ret2 (copy), ItemData (copy), RarityGradient (copy), EquipmentTemplates (copy), u86 (ref), AnimateCoinCountUp (copy)
    u22.Visible = true;

    for _, v in u65 do
        if u79 then
            break;
        end;

        local v192 = v:FindFirstChildOfClass("UIScale");

        if not v192 then
            v192 = Instance.new("UIScale");
            v192.Parent = v;
        end;

        v192.Scale = 0;
        v.Visible = true;
        TweenService:Create(v192, TweenInfo_new_ret, {
            Scale = 1
        }):Play();
        task.wait(0.08);
    end;

    if u79 then
        for _, v in u65 do
            local v193 = v:FindFirstChildOfClass("UIScale");

            if not v193 then
                v193 = Instance.new("UIScale");
                v193.Parent = v;
            end;

            v193.Scale = 1;
            v.Visible = true;
        end;
    end;

    if not (u60 and u61) then
        RevealActionButtons();
        u80 = true;

        return;
    end;

    local v194 = {};
    local v195 = p191.CashEarned or 0;

    if v195 > 0 then
        local v196 = {
            amountText = "0",
            name = "Coins"
        };
        v196.icon = Image_Data.Rewards and Image_Data.Rewards.Cash;
        v196.seq = ColorSequence_new_ret;
        local v197 = SpawnRewardCard(v196, #v194 + 1);

        if v197 then
            table.insert(v194, {
                clone = v197,
                coins = v195
            });
        end;
    end;

    local v198 = p191.StarsEarned or 0;

    if v198 > 0 then
        local v199 = {
            name = "Stars"
        };
        v199.icon = Image_Data.Rewards and Image_Data.Rewards.Stars;
        local v200;

        if v198 >= 1000 then
            v200 = SharedUtils.FormatNumber((math.floor(v198)));
        else
            local math_floor_ret = math.floor(v198);
            v200 = tostring(math_floor_ret);
        end;

        v199.amountText = v200;
        v199.seq = ColorSequence_new_ret2;
        local v201 = SpawnRewardCard(v199, #v194 + 1);

        if v201 then
            table.insert(v194, {
                clone = v201
            });
        end;
    end;

    local v202 = p191.ClassSpinsEarned or 0;

    if v202 > 0 then
        local v203 = {
            whiteImage = true
        };
        v203.icon = Image_Data.Crystals and Image_Data.Crystals.Reroll;
        v203.amountText = `x{v202}`;
        v203.name = v202 == 1 and "Class Spin" or "Class Spins";
        local v204 = SpawnRewardCard(v203, #v194 + 1);

        if v204 then
            table.insert(v194, {
                clone = v204
            });
        end;
    end;

    if p191.MaterialRewards then
        for _, v in p191.MaterialRewards do
            local Material = ItemData.GetMaterial(v.Id);
            local v205;

            if Material then
                v205 = Material.Icon;
            else
                v205 = Material;
            end;

            local v206 = {};

            if not v205 or (v205 == "" or not v205) then
                v205 = nil;
            end;

            v206.icon = v205;
            v206.amountText = `x{v.Amount}`;
            v206.name = Material and Material.Name or v.Id;
            v206.seq = RarityGradient.colorSequence(Material and Material.Rarity or "Common");
            local v207 = SpawnRewardCard(v206, #v194 + 1);

            if v207 then
                table.insert(v194, {
                    clone = v207
                });
            end;
        end;
    end;

    if p191.ItemRewards then
        for _, v in p191.ItemRewards do
            local Template = EquipmentTemplates.GetTemplate(v.ItemId);
            local v208 = Image_Data.Equipment and Image_Data.Equipment[v.ItemId] or (Template and (Template.ImageId or "") or "");
            local v209 = {};

            if v208 == "" or not v208 then
                v208 = nil;
            end;

            v209.icon = v208;
            v209.name = Template and Template.DisplayName or v.ItemId;
            v209.seq = RarityGradient.colorSequence(v.Rarity);
            v209.whiteImage = v.Identified == true;
            local v210 = SpawnRewardCard(v209, #v194 + 1);

            if v210 then
                table.insert(v194, {
                    clone = v210
                });
            end;
        end;
    end;

    for _, v in v194 do
        if u79 then
            break;
        end;

        task.wait(0.3);
        local clone = v.clone;
        local v211 = clone:FindFirstChildOfClass("UIScale");

        if not v211 then
            v211 = Instance.new("UIScale");
            v211.Parent = clone;
        end;

        v211.Scale = 0;
        clone.Visible = true;
        TweenService:Create(v211, TweenInfo_new_ret, {
            Scale = 1
        }):Play();

        if u86 then
            u86:Play("Ting");
        end;

        if v.coins then
            AnimateCoinCountUp(v.clone, v.coins);
        end;
    end;

    if u79 then
        for _, v in v194 do
            local clone = v.clone;
            local v212 = clone:FindFirstChildOfClass("UIScale");

            if not v212 then
                v212 = Instance.new("UIScale");
                v212.Parent = clone;
            end;

            v212.Scale = 1;
            v.clone.Visible = true;

            if v.coins then
                local Amount = v.clone:FindFirstChild("Amount", true);

                if Amount then
                    local coins = v.coins;
                    local v213;

                    if coins >= 1000 then
                        v213 = SharedUtils.FormatNumber((math.floor(coins)));
                    else
                        local math_floor_ret = math.floor(coins);
                        v213 = tostring(math_floor_ret);
                    end;

                    Amount.Text = v213;
                end;
            end;
        end;
    end;

    RevealActionButtons();
    u80 = true;
end;

local function StartSpeedrunTimer() -- Line: 1041
    -- upvalues: u74 (ref), u73 (ref), u71 (ref), u72 (ref), u75 (ref), RunService (copy)
    if u74 then
        return;
    end;

    u73 = os.clock();
    u74 = true;

    if u71 then
        u71.Visible = true;
    end;

    if u72 then
        u72.Text = "00:00:00";
    end;

    if u75 then
        u75:Disconnect();
        u75 = nil;
    end;

    u75 = RunService.Heartbeat:Connect(function() -- Line: 1055
        -- upvalues: u74 (ref), u72 (ref), u73 (ref)
        if not u74 then
            return;
        end;

        if u72 then
            local v214 = os.clock() - u73;
            local math_max_ret = math.max(v214, 0);
            local math_floor_ret = math.floor(math_max_ret / 60);
            local v215 = math.floor(math_max_ret) % 60;
            local math_floor_ret2 = math.floor(math_max_ret % 1 * 100);
            u72.Text = string.format("%02d:%02d:%02d", math_floor_ret, v215, math_floor_ret2);
        end;
    end);
end;

local function StopSpeedrunTimer() -- Line: 1063
    -- upvalues: u74 (ref), u75 (ref), u73 (ref)
    u74 = false;

    if u75 then
        u75:Disconnect();
        u75 = nil;
    end;

    return os.clock() - u73;
end;

local function ShowCompletion(u216) -- Line: 1074
    -- upvalues: u81 (ref), u74 (ref), u75 (ref), u73 (ref), ResetCompletionFrame (copy), u19 (ref), u20 (ref), u21 (ref), u68 (ref), u96 (copy), u85 (ref), u84 (ref), u49 (ref), u50 (ref), u48 (ref), u64 (copy), u51 (ref), u52 (ref), u53 (ref), ColorData (copy), u54 (ref), Image_Data (copy), u55 (ref), SharedUtils (copy), u56 (ref), u57 (ref), u94 (ref), u95 (ref), u58 (ref), u66 (ref), u59 (copy), u47 (ref), u46 (ref), u43 (ref), u44 (ref), u45 (ref), RunCompletionSequence (copy)
    if u81 then
        pcall(task.cancel, u81);
    end;

    u74 = false;

    if u75 then
        u75:Disconnect();
        u75 = nil;
    end;

    local _ = os.clock() - u73;
    ResetCompletionFrame();

    if u19 then
        u19.Visible = true;
    end;

    if u20 then
        u20.Visible = false;
    end;

    if u21 then
        u21.Visible = false;
    end;

    if u68 then
        u68.Visible = false;
    end;

    if u96.Frame then
        u96.Frame.Visible = false;
    end;

    if u85 then
        u85:Disconnect();
        u85 = nil;
    end;

    u84 = false;
    u49 = u216.Status;
    u50 = u216.Source;
    u48 = (u50 == nil or u50 == "BossRush") and true or u50 == "Challenge";
    u64.ButtonEnabled = u216.Source == nil;
    u64.HasConfirmed = false;

    if u216.PartyLeaderUserId then
        u64.LeaderUserId = u216.PartyLeaderUserId;
    end;

    if u51 then
        local Status = u216.Status;
        u51.Text = Status == "Failed" and "FAILED" or (Status == "Extracted" and "EXTRACTED" or "COMPLETED");
    end;

    if u52 then
        u52.Text = string.upper(u216.DungeonName or "Unknown");
    end;

    if u53 then
        local v217 = u216.Difficulty or "Easy";
        u53.Text = string.upper(v217);
        local v218 = ColorData.Difficulty and ColorData.Difficulty[v217];

        if v218 then
            u53.TextColor3 = v218;
        end;
    end;

    if u54 then
        local v219 = Image_Data.Dungeons and Image_Data.Dungeons[u216.LocationId];

        if v219 and v219 ~= "" then
            u54.Image = v219;
        else
            local Attribute = u54:GetAttribute("AuthoredDefault");

            if Attribute then
                u54.Image = Attribute;
            end;
        end;
    end;

    if u55 then
        local v220 = u216.MobsKilled or 0;
        local v221;

        if v220 >= 1000 then
            v221 = SharedUtils.FormatNumber((math.floor(v220)));
        else
            local math_floor_ret = math.floor(v220);
            v221 = tostring(math_floor_ret);
        end;

        u55.Text = v221;
    end;

    if u56 then
        local math_floor_ret = math.floor(u216.TimeElapsed or 0);
        local math_max_ret = math.max(math_floor_ret, 0);
        u56.Text = string.format("%02d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60);
    end;

    if u57 then
        local RoomsCleared = u216.RoomsCleared;

        if RoomsCleared == nil then
            local v222 = u94 > 0 and u94 or (u95 > 0 and u95 or 0);
            u57.Text = v222 > 0 and tostring(v222) or "-";
        else
            local math_floor_ret = math.floor(RoomsCleared);
            u57.Text = tostring(math_floor_ret);
        end;
    end;

    if u58 then
        local math_floor_ret = math.floor(u216.TotalDeaths or u66);
        u58.Text = tostring(math_floor_ret);
    end;

    if u59.Damage then
        local TotalDamage = u216.TotalDamage;
        local Damage = u59.Damage;
        local v223;

        if TotalDamage == nil then
            v223 = "-";
        else
            local v224;

            if TotalDamage >= 1000 then
                v224 = SharedUtils.FormatNumber((math.floor(TotalDamage)));
            else
                local math_floor_ret = math.floor(TotalDamage);
                v224 = tostring(math_floor_ret);
            end;

            v223 = v224 or "-";
        end;

        Damage.Text = v223;
    end;

    if u59.EXP then
        local TotalEXP = u216.TotalEXP;
        local EXP = u59.EXP;
        local v225;

        if TotalEXP == nil then
            v225 = "-";
        else
            local v226;

            if TotalEXP >= 1000 then
                v226 = SharedUtils.FormatNumber((math.floor(TotalEXP)));
            else
                local math_floor_ret = math.floor(TotalEXP);
                v226 = tostring(math_floor_ret);
            end;

            v225 = v226 or "-";
        end;

        EXP.Text = v225;
    end;

    u47 = false;
    u46 = false;

    if u43 then
        u43.Visible = u48;

        if u44 then
            u44.Active = true;
        end;

        if u45 then
            local v227 = u216.PlayerCount or 1;

            if v227 <= 1 then
                u45.Text = "REPLAY";
            else
                u45.Text = `REPLAY (0/{v227}) 10S`;
                u46 = true;
            end;
        end;
    end;

    u81 = task.spawn(function() -- Line: 1202
        -- upvalues: RunCompletionSequence (ref), u216 (copy)
        RunCompletionSequence(u216);
    end);
end;

local function UpdateLivesDisplay(p228: number) -- Line: 1210
    -- upvalues: u70 (ref), u69 (ref)
    u70 = p228;

    if not u69 then
        return;
    end;

    if p228 > 0 then
        u69.Text = "Lives: <font color=\"rgb(80,220,100)\">" .. tostring(p228) .. "</font>";

        return;
    end;

    u69.Text = "Lives: <font color=\"rgb(255,60,60)\">None</font>";
end;

local function UpdateDepthDisplay(p229: number?) -- Line: 1223
    -- upvalues: u32 (ref), u33 (ref)
    if not u32 then
        return;
    end;

    if p229 == nil then
        u32.Visible = false;

        return;
    end;

    u32.Visible = true;

    if u33 then
        u33.Text = "Depth: " .. tostring(p229 + 1);
    end;
end;

local TweenInfo_new_ret4 = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out);

local function CPRowWidth(p230: number) -- Line: 1249
    -- upvalues: u96 (copy)
    return p230 <= 0 and 0 or p230 * u96.ZoneWidth + (p230 - 1) * u96.Padding;
end;

local function CPMoveCurrentToPos(p231: number, p232: boolean?) -- Line: 1256
    -- upvalues: u96 (copy), TweenService (copy), TweenInfo_new_ret4 (copy)
    local Current = u96.Current;

    if not Current or (p231 < 1 or #u96.Zones < p231) then
        return;
    end;

    u96.CurrentPos = p231;
    local v233 = #u96.Zones;
    local UDim2_new_ret = UDim2.new(0.5 - (v233 <= 0 and 0 or v233 * u96.ZoneWidth + (v233 - 1) * u96.Padding) / 2 + (p231 - 1) * (u96.ZoneWidth + u96.Padding) + u96.ZoneWidth / 2, 0, u96.CurrentY.Scale, u96.CurrentY.Offset);

    if u96.Tween then
        u96.Tween:Cancel();
    end;

    if p232 then
        Current.Position = UDim2_new_ret;
    else
        u96.Tween = TweenService:Create(Current, TweenInfo_new_ret4, {
            Position = UDim2_new_ret
        });
        u96.Tween:Play();
    end;

    Current.Visible = true;
end;

local function CPSetCurrent(p234: number) -- Line: 1276
    -- upvalues: u96 (copy), CPMoveCurrentToPos (copy)
    local v235 = u96.ByIndex[p234];

    if not v235 or v235 <= u96.CurrentPos then
        return;
    end;

    CPMoveCurrentToPos(v235);
end;

local function CPShowCompleted(p236) -- Line: 1283
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    if p236.Done then
        return;
    end;

    p236.Done = true;
    local Boss = p236.Frame:FindFirstChild("Boss");
    local Treasure = p236.Frame:FindFirstChild("Treasure");
    local Completed = p236.Frame:FindFirstChild("Completed");

    if Boss then
        Boss.Visible = false;
    end;

    if Treasure then
        Treasure.Visible = false;
    end;

    if Completed then
        local v237 = Completed:FindFirstChildOfClass("UIScale");

        if not v237 then
            v237 = Instance.new("UIScale");
            v237.Parent = Completed;
        end;

        v237.Scale = 0;
        Completed.Visible = true;
        TweenService:Create(v237, TweenInfo_new_ret, {
            Scale = 1
        }):Play();
    end;
end;

local function CPMarkRoomCompleted(p238: number) -- Line: 1297
    -- upvalues: u96 (copy), CPShowCompleted (copy)
    local v239 = u96.ByIndex[p238];

    if v239 then
        v239 = u96.Zones[v239];
    end;

    if not v239 or v239.IsBoss then
        return;
    end;

    CPShowCompleted(v239);
end;

local function CPCompleteBoss() -- Line: 1305
    -- upvalues: u96 (copy), CPShowCompleted (copy)
    for _, v in u96.Zones do
        if v.IsBoss then
            CPShowCompleted(v);

            return;
        end;
    end;
end;

local function CPFocusBoss() -- Line: 1315
    -- upvalues: u96 (copy), CPMoveCurrentToPos (copy)
    for i, v in u96.Zones do
        if v.IsBoss then
            if u96.CurrentPos < i then
                CPMoveCurrentToPos(i);

                return;
            end;

            break;
        end;
    end;
end;

local function CPReset() -- Line: 1325
    -- upvalues: u109 (copy), u96 (copy)
    u109.Reset();
    table.clear(u96.Zones);
    table.clear(u96.ByIndex);
    u96.CurrentPos = 0;

    if u96.Tween then
        u96.Tween:Cancel();
        u96.Tween = nil;
    end;

    if u96.List then
        for _, child in u96.List:GetChildren() do
            if child.Name == "ZoneSlot" then
                child:Destroy();
            end;
        end;
    end;

    if u96.Current then
        u96.Current.Visible = false;
    end;

    if u96.Frame then
        u96.Frame.Visible = false;
    end;
end;

local function CPBuild(p240: any, p241: number?) -- Line: 1346
    -- upvalues: u96 (copy), CPReset (copy), CPMoveCurrentToPos (copy)
    if not (u96.Frame and (u96.List and u96.Template)) then
        return;
    end;

    CPReset();

    if not p240 or #p240 == 0 then
        return;
    end;

    for i, v in p240 do
        local v242 = u96.Template:Clone();
        v242.Name = "ZoneSlot";
        v242.LayoutOrder = i;
        local v243 = v.Completed == true;
        local Boss = v242:FindFirstChild("Boss");
        local Treasure = v242:FindFirstChild("Treasure");
        local Completed = v242:FindFirstChild("Completed");

        if Boss then
            local v244;

            if v.IsBoss == true then
                v244 = not v243;
            else
                v244 = false;
            end;

            Boss.Visible = v244;
        end;

        if Treasure then
            local v245;

            if v.HasTreasure == true then
                v245 = not v.IsBoss and not v243;
            else
                v245 = false;
            end;

            Treasure.Visible = v245;
        end;

        if Completed then
            Completed.Visible = v243;
        end;

        v242.Visible = true;
        v242.Parent = u96.List;
        table.insert(u96.Zones, {
            Index = v.Index,
            IsBoss = v.IsBoss == true,
            Frame = v242,
            Done = v243
        });
        u96.ByIndex[v.Index] = i;
    end;

    if u96.Bar then
        local v246 = #u96.Zones;
        u96.Bar.Size = UDim2.new((v246 <= 0 and 0 or v246 * u96.ZoneWidth + (v246 - 1) * u96.Padding) + u96.BarMargin, 0, u96.BarDesign.Y.Scale, u96.BarDesign.Y.Offset);
    end;

    CPMoveCurrentToPos(p241 and u96.ByIndex[p241] or 1, true);
    u96.Frame.Visible = true;
end;

local function OnPhaseChange(p247: string, p248: any) -- Line: 1389
    -- upvalues: u76 (ref), u77 (ref), u19 (ref), u20 (ref), u21 (ref), u22 (ref), u96 (copy), StartSpeedrunTimer (copy), u23 (ref), u68 (ref), u69 (ref), u70 (ref), UpdateObjective (copy), u37 (ref), u39 (ref), SharedUtils (copy), FormatWithCommas (copy), BossHealthBars (copy), u41 (ref), u42 (ref), StartTrailLogic (copy), CPFocusBoss (copy), u85 (ref), u84 (ref), CPShowCompleted (copy), u24 (ref), u27 (ref), u34 (ref), u36 (ref), u35 (ref), u29 (ref), u31 (ref), Color3_fromRGB_ret (copy), u86 (ref), LocalPlayer (copy), u92 (ref), u93 (ref), u94 (ref), u95 (ref), FlashDoorHighlight (copy), u109 (copy), u74 (ref), u75 (ref), u73 (ref)
    u76 = p247;
    local v249 = p248 or {};

    if p247 == "Escape" or p247 == "Complete" then
        u77 = true;
    elseif p247 == "Clear" or (p247 == "Boss" or (p247 == "BossWarp" or (p247 == "RushRoom" or (p247 == "SurviveRoom" or p247 == "MightRoom")))) then
        u77 = false;
    end;

    if p247 == "Clear" then
        if u19 then
            u19.Visible = true;
        end;

        if u20 then
            u20.Visible = true;
        end;

        if u21 then
            u21.Visible = false;
        end;

        if u22 then
            u22.Visible = false;
        end;

        if u96.Frame and #u96.Zones > 0 then
            u96.Frame.Visible = true;
        end;

        StartSpeedrunTimer();

        if u23 then
            u23.Text = v249.DungeonName or "";
        end;

        u68 = (not u68 and u20 and true or false) and u20:FindFirstChild("Lives_Frame");

        if u68 then
            u69 = u68:FindFirstChild("Lives_Text");
        end;

        if v249.Lives ~= nil then
            local Lives = v249.Lives;
            u70 = Lives;

            if u69 then
                if Lives > 0 then
                    u69.Text = "Lives: <font color=\"rgb(80,220,100)\">" .. tostring(Lives) .. "</font>";
                else
                    u69.Text = "Lives: <font color=\"rgb(255,60,60)\">None</font>";
                end;
            end;
        end;

        if u68 then
            u68.Visible = true;
        end;

        UpdateObjective("Clear");

        return;
    end;

    if p247 == "Boss" then
        if u19 then
            u19.Visible = true;
        end;

        if u20 then
            u20.Visible = true;
        end;

        if u21 then
            u21.Visible = true;
        end;

        if u37 then
            u37.Text = v249.BossName or "Boss";
        end;

        if u39 and v249.BossMaxHP then
            local BossMaxHP = v249.BossMaxHP;
            local v250;

            if BossMaxHP >= 1000000000 then
                v250 = SharedUtils.FormatNumber(BossMaxHP);
            else
                v250 = FormatWithCommas(BossMaxHP);
            end;

            u39.Text = `{v250} / {v250}`;
        end;

        BossHealthBars.Prime(v249.BossName, v249.BossMaxHP);

        if u41 then
            u41.Size = UDim2.fromScale(1, 1);
        end;

        if u42 then
            u42.Size = UDim2.fromScale(1, 1);
        end;

        StartTrailLogic();
        UpdateObjective("Boss");
        CPFocusBoss();

        return;
    end;

    if p247 == "Escape" then
        UpdateObjective("Escape");

        if u21 then
            u21.Visible = false;
        end;

        if u85 then
            u85:Disconnect();
            u85 = nil;
        end;

        u84 = false;

        for _, v in u96.Zones do
            if v.IsBoss then
                CPShowCompleted(v);

                return;
            end;
        end;

        return;
    end;

    if p247 == "BossWarp" then
        if u19 then
            u19.Visible = true;
        end;

        UpdateObjective("BossWarp");

        if u24 then
            u24.Visible = false;
        end;

        if u27 then
            u27.TextColor3 = Color3.fromRGB(255, 100, 50);
            task.delay(1.5, function() -- Line: 1480
                -- upvalues: u76 (ref), u27 (ref)
                if u76 == "BossWarp" or u76 == "Boss" then
                    u27.TextColor3 = Color3.fromRGB(255, 255, 255);
                end;
            end);
        end;
    elseif p247 == "RushRoom" then
        u34 = true;
        u36 = v249.TimeLimit or 30;
        u35 = u36;

        if u19 then
            u19.Visible = true;
        end;

        if u20 then
            u20.Visible = true;
        end;

        if u21 then
            u21.Visible = false;
        end;

        if u24 then
            u24.Visible = true;
        end;

        if u23 and v249.DungeonName then
            u23.Text = v249.DungeonName;
        end;

        if u27 then
            u27.Text = "RUSH INBOUND";
            u27.TextColor3 = Color3.fromRGB(255, 80, 80);
            task.delay(2, function() -- Line: 1507
                -- upvalues: u34 (ref), u27 (ref)
                if u34 and u27 then
                    u27.Text = "SURVIVE THE RUSH";
                    u27.TextColor3 = Color3.fromRGB(255, 255, 255);
                end;
            end);
        end;

        if u29 then
            local math_floor_ret = math.floor(u35);
            local math_max_ret = math.max(math_floor_ret, 0);
            u29.Text = string.format("%02d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60);
        end;

        if u31 then
            u31.Size = UDim2.fromScale(1, 1);
            u31.BackgroundColor3 = Color3_fromRGB_ret;
        end;

        if u86 then
            u86:Play("Ting");
        end;
    elseif p247 == "RushFailed" then
        u34 = false;

        if u27 then
            u27.Text = "TIME\'S UP";
            u27.TextColor3 = Color3.fromRGB(255, 80, 80);
            task.delay(2, function() -- Line: 1532
                -- upvalues: u27 (ref)
                if u27 then
                    u27.TextColor3 = Color3.fromRGB(255, 255, 255);
                end;
            end);
        end;
    elseif p247 == "MightRoom" then
        if u19 then
            u19.Visible = true;
        end;

        if u20 then
            u20.Visible = true;
        end;

        if u21 then
            u21.Visible = false;
        end;

        if u24 then
            u24.Visible = true;
        end;

        if u23 and v249.DungeonName then
            u23.Text = v249.DungeonName;
        end;

        if u27 then
            u27.Text = "MIGHT CHALLENGE";
            u27.TextColor3 = Color3.fromRGB(255, 80, 80);
            task.delay(2, function() -- Line: 1555
                -- upvalues: u76 (ref), u27 (ref)
                if u76 == "MightRoom" and u27 then
                    u27.Text = "DEFEAT THE CHAMPIONS";
                    u27.TextColor3 = Color3.fromRGB(255, 255, 255);
                end;
            end);
        end;

        if u86 then
            u86:Play("Ting");
        end;
    elseif p247 == "RoomCleared" then
        u34 = false;
        local v251 = LocalPlayer:GetAttribute("InEndless") == true;

        if u27 then
            if v251 then
                u27.Text = "WAVE " .. (v249.Wave or (v249.WavesCleared or 0)) .. " CLEARED";
            else
                u27.Text = "ROOM CLEARED";
            end;
        end;

        if u86 then
            u86:Play("Ting");
        end;

        if not v251 then
            if u92 then
                if u93 then
                    if u29 then
                        u29.Text = "";
                    end;
                else
                    if u29 then
                        u29.Text = `Room {u94}/{u95}`;
                    end;

                    if u31 and u95 > 0 then
                        local math_clamp_ret = math.clamp(u94 / u95, 0, 1);
                        u31.Size = UDim2.fromScale(math_clamp_ret, 1);
                        u31.BackgroundColor3 = Color3_fromRGB_ret;
                    end;
                end;
            end;

            if v249.RoomIndex then
                task.spawn(FlashDoorHighlight, v249.RoomIndex);
                local v252 = u96.ByIndex[v249.RoomIndex];

                if v252 then
                    v252 = u96.Zones[v252];
                end;

                if v252 and not v252.IsBoss then
                    CPShowCompleted(v252);
                end;
            end;
        end;

        if v249.RoomIndex then
            u109.ShowAtRoom(v249.RoomIndex);
        end;
    elseif p247 == "Complete" or p247 == "Failed" then
        UpdateObjective(p247);

        if u85 then
            u85:Disconnect();
            u85 = nil;
        end;

        u84 = false;
        u74 = false;

        if u75 then
            u75:Disconnect();
            u75 = nil;
        end;

        local _ = os.clock() - u73;

        if p247 == "Complete" then
            for _, v in u96.Zones do
                if v.IsBoss then
                    CPShowCompleted(v);
                    break;
                end;
            end;
        end;

        u109.Reset();
        u92 = false;
        u93 = false;
        u34 = false;
        u94 = 0;
        u95 = 0;
    end;
end;

local function UpdateDungeonVisibility() -- Line: 1614
    -- upvalues: LocalPlayer (copy), u78 (ref), u66 (ref), u19 (ref), u22 (ref), u85 (ref), u84 (ref), ResetCompletionFrame (copy), CPReset (copy), u20 (ref), u21 (ref)
    local v253 = LocalPlayer:GetAttribute("InDungeon") == true;

    if v253 and not u78 then
        u78 = true;
        u66 = 0;

        if u19 then
            u19.Visible = true;
        end;
    elseif not v253 and u78 then
        u78 = false;
        task.delay(8, function() -- Line: 1631
            -- upvalues: u78 (ref), u22 (ref), u85 (ref), u84 (ref), ResetCompletionFrame (ref), CPReset (ref), u20 (ref), u21 (ref), u19 (ref)
            if not u78 then
                if u22 and u22.Visible then
                    return;
                end;

                if u85 then
                    u85:Disconnect();
                    u85 = nil;
                end;

                u84 = false;
                ResetCompletionFrame();
                CPReset();

                if u20 then
                    u20.Visible = false;
                end;

                if u21 then
                    u21.Visible = false;
                end;

                if u19 then
                    u19.Visible = false;
                end;
            end;
        end);
    end;
end;

local function SetPodQueueVisible(p254: boolean, p255: boolean?) -- Line: 1654
    -- upvalues: u90 (ref), u91 (ref), u87 (ref), u20 (ref), u21 (ref), u68 (ref), u96 (copy), u19 (ref), u88 (ref), u78 (ref), u22 (ref)
    u90 = p254;
    u91 = p255 or false;

    if not u87 then
        return;
    end;

    if p254 then
        if u20 then
            u20.Visible = false;
        end;

        if u21 then
            u21.Visible = false;
        end;

        if u68 then
            u68.Visible = false;
        end;

        if u96.Frame then
            u96.Frame.Visible = false;
        end;

        if u19 then
            u19.Visible = true;
        end;

        u87.Visible = true;
        u87.Active = true;

        if u88 then
            u88.Visible = u91;
            u88.Active = u91;
        end;
    else
        u87.Visible = false;

        if u88 then
            u88.Visible = false;
        end;

        if not u78 and (u19 and not (u22 and u22.Visible)) then
            u19.Visible = false;
        end;
    end;
end;

local function OnCloseButtonPressed() -- Line: 1688
    -- upvalues: u80 (ref), u79 (ref), u49 (ref), u50 (ref), Knit (copy), ResetCompletionFrame (copy), u19 (ref)
    if u80 then
        if (u49 == "Extracted" or (u49 == "Failed" or u49 == "Cleared" and u50 == "BossRush")) and true or (u50 == "Challenge" and true or u50 == "Raids") then
            pcall(function() -- Line: 1707
                -- upvalues: u50 (ref), Knit (ref)
                if u50 == "BossRush" then
                    Knit.GetService("BossRushService"):RequestReturn();

                    return;
                end;

                if u50 == "Challenge" then
                    Knit.GetService("ChallengeRunService"):RequestReturn();

                    return;
                end;

                if u50 == "Raids" then
                    Knit.GetService("RaidRunService"):RequestReturn();

                    return;
                end;

                Knit.GetService("DungeonRunService"):RequestReturn();
            end);
            ResetCompletionFrame();

            if u19 then
                u19.Visible = false;

                return;
            end;
        else
            ResetCompletionFrame();
        end;

        return;
    end;

    u79 = true;
end;

local function OnReplayButtonPressed() -- Line: 1736
    -- upvalues: u47 (ref), u44 (ref), u50 (ref), Knit (copy)
    if u47 then
        return;
    end;

    u47 = true;

    if u44 then
        u44.Active = false;
    end;

    pcall(function() -- Line: 1745
        -- upvalues: u50 (ref), Knit (ref)
        if u50 == "BossRush" then
            Knit.GetService("BossRushService"):RequestReplay();

            return;
        end;

        if u50 == "Challenge" then
            Knit.GetService("ChallengeRunService"):RequestReplay();

            return;
        end;

        Knit.GetService("DungeonRunService"):RequestReplay();
    end);
end;

local function OpenNextDungeonSelect() -- Line: 1769
    -- upvalues: Knit (copy), u22 (ref), u19 (ref)
    local success, result = pcall(function() -- Line: 1770
        -- upvalues: Knit (ref)
        return Knit.GetController("DungeonSelectController");
    end);

    if not (success and result) then
        return;
    end;

    if u22 then
        u22.Visible = false;
    end;

    result:Open({
        InDungeon = true,

        OnClose = function() -- Line: 1775, Name: OnClose
            -- upvalues: u22 (ref), u19 (ref)
            if u22 and (not u19 or u19.Visible) then
                u22.Visible = true;
            end;
        end
    });
end;

local function OnDungeonButtonPressed() -- Line: 1785
    -- upvalues: u64 (copy), LocalPlayer (copy), OpenNextDungeonSelect (copy), Knit (copy)
    local Pending = u64.Pending;

    if not Pending or Pending.Type ~= "ChangeDungeon" then
        if u64.LeaderUserId ~= LocalPlayer.UserId then
            return;
        end;

        OpenNextDungeonSelect();

        return;
    end;

    if Pending.InitiatorUserId == LocalPlayer.UserId then
        OpenNextDungeonSelect();

        return;
    end;

    if u64.HasConfirmed then
        return;
    end;

    u64.HasConfirmed = true;
    pcall(function() -- Line: 1796
        -- upvalues: Knit (ref)
        Knit.GetService("DungeonRunService"):ConfirmDungeonChange();
    end);
end;

local function OnPartyActionUpdate(p256) -- Line: 1808
    -- upvalues: u64 (copy)
    u64.Pending = p256;
    local StatusLabel = u64.StatusLabel;

    if not p256 then
        u64.HasConfirmed = false;

        if StatusLabel then
            StatusLabel.Visible = false;
        end;

        return;
    end;

    if not StatusLabel then
        return;
    end;

    local v257 = tostring(p256.InitiatorName or "Party"):gsub("<", "&lt;");

    if p256.Type == "Replay" then
        StatusLabel.Text = `{v257} wants to Replay: {p256.VoteCount}/{p256.Total}`;
    else
        if p256.Type ~= "ChangeDungeon" then
            return;
        end;

        local v258 = tostring(p256.TargetName or "?"):gsub("<", "&lt;");

        if p256.Countdown then
            StatusLabel.Text = `Moving to {v258} in {p256.Countdown}...`;
        else
            StatusLabel.Text = `{v257} wants to move to {v258}: {p256.VoteCount}/{p256.Total}`;
        end;
    end;

    StatusLabel.Visible = true;
end;

local function ForceResetDungeonHUD() -- Line: 1836
    -- upvalues: u78 (ref), u93 (ref), u79 (ref), u80 (ref), u70 (ref), u69 (ref), u74 (ref), u75 (ref), u73 (ref), u85 (ref), u84 (ref), ResetCompletionFrame (copy), CPReset (copy), u20 (ref), u21 (ref), u22 (ref), u68 (ref), u32 (ref), u19 (ref)
    u78 = false;
    u93 = false;
    u79 = false;
    u80 = false;
    u70 = 0;

    if u69 then
        u69.Text = "";
    end;

    u74 = false;

    if u75 then
        u75:Disconnect();
        u75 = nil;
    end;

    local _ = os.clock() - u73;

    if u85 then
        u85:Disconnect();
        u85 = nil;
    end;

    u84 = false;
    ResetCompletionFrame();
    CPReset();

    if u20 then
        u20.Visible = false;
    end;

    if u21 then
        u21.Visible = false;
    end;

    if u22 then
        u22.Visible = false;
    end;

    if u68 then
        u68.Visible = false;
    end;

    if u32 then
        u32.Visible = false;
    end;

    if u19 then
        u19.Visible = false;
    end;
end;

local function HookCharacterDeath(p259) -- Line: 1866
    -- upvalues: u78 (ref), LocalPlayer (copy), u66 (ref), ForceResetDungeonHUD (copy)
    if not p259 then
        return;
    end;

    local Humanoid = p259:WaitForChild("Humanoid", 5);

    if Humanoid then
        Humanoid.Died:Connect(function() -- Line: 1870
            -- upvalues: u78 (ref), LocalPlayer (ref), u66 (ref), ForceResetDungeonHUD (ref)
            if u78 and not LocalPlayer:GetAttribute("InBossRush") then
                u66 = u66 + 1;
            end;

            task.delay(0.3, function() -- Line: 1878
                -- upvalues: u78 (ref), LocalPlayer (ref), ForceResetDungeonHUD (ref)
                if not u78 then
                    return;
                end;

                if LocalPlayer:GetAttribute("DungeonRespawning") then
                    return;
                end;

                if LocalPlayer:GetAttribute("InBossRush") then
                    return;
                end;

                if LocalPlayer:GetAttribute("InChallenge") then
                    return;
                end;

                if LocalPlayer:GetAttribute("IsSpectating") then
                    return;
                end;

                ForceResetDungeonHUD();
            end);
        end);
    end;
end;

if LocalPlayer.Character then
    task.spawn(HookCharacterDeath, LocalPlayer.Character);
end;

LocalPlayer.CharacterAdded:Connect(HookCharacterDeath);

local function OnDungeonAlert(p260: string, ...) -- Line: 1920
    -- upvalues: Knit (copy)
    local Controller = Knit.GetController("NotificationController");

    if not Controller then
        return;
    end;

    local v261 = { ... };

    if p260 == "TimeWarning" then
        local v262 = v261[1];

        if Controller.PRESETS and Controller.PRESETS.DUNGEON_TIME_WARNING then
            Controller.PRESETS.DUNGEON_TIME_WARNING(v262);

            return;
        end;

        Controller:Show("Custom", `⏰ {v262} seconds remaining!`, 3, Color3.fromRGB(255, 200, 50), Color3.fromRGB(80, 60, 10), "Error");
    end;
end;

function v1.KnitInit(p263) -- Line: 1945
    -- upvalues: Knit (copy), u19 (ref), u87 (ref), u88 (ref), u20 (ref), u23 (ref), u24 (ref), u25 (ref), u26 (ref), u27 (ref), u28 (ref), u29 (ref), u30 (ref), u31 (ref), u68 (ref), u69 (ref), u32 (ref), u33 (ref), u71 (ref), u72 (ref), u21 (ref), u37 (ref), u38 (ref), u39 (ref), u40 (ref), u41 (ref), u42 (ref), BossHealthBars (copy), u22 (ref), u51 (ref), u52 (ref), u53 (ref), u54 (ref), u65 (copy), u55 (ref), u56 (ref), u57 (ref), u58 (ref), u59 (copy), u64 (copy), u60 (ref), u61 (ref), u44 (ref), u62 (ref), u63 (ref), u43 (ref), u45 (ref), u96 (copy)
    u19 = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Dungeon_Container");

    if not u19 then
        warn("[DungeonHUDController] Dungeon_Container not found in Main.HUD");

        return;
    end;

    u87 = u19:FindFirstChild("Leave");

    if u87 then
        u87.Visible = false;
    end;

    u88 = u19:FindFirstChild("Start");

    if not u88 and u87 then
        u88 = u87:Clone();
        u88.Name = "Start";
        u88.LayoutOrder = u87.LayoutOrder - 1;
        local Position = u87.Position;
        u88.Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale - (u87.Size.Y.Scale + 0.02), Position.Y.Offset);
        local Text = u88:FindFirstChild("Text");

        if Text and Text:IsA("TextLabel") then
            Text.Text = "START";
        end;

        u88.Parent = u19;
    end;

    if u88 then
        u88.Visible = false;
    end;

    u20 = u19:FindFirstChild("Info");

    if u20 then
        u23 = u20:FindFirstChild("Dungeon_Name");
        u24 = u20:FindFirstChild("Mob_Counter");

        if u24 then
            u25 = u24:FindFirstChild("Progress_Text");
        end;

        u26 = u20:FindFirstChild("Objective_Frame");

        if u26 then
            u27 = u26:FindFirstChild("Objective_Text");
        end;

        u28 = u20:FindFirstChild("Time_Left");

        if u28 then
            u29 = u28:FindFirstChild("Time_Text");
            u30 = u28:FindFirstChild("Progress_Bar");

            if u30 then
                u31 = u30:FindFirstChild("Progress_Color");
            end;
        end;

        u68 = u20:FindFirstChild("Lives_Frame");

        if u68 then
            u69 = u68:FindFirstChild("Lives_Text");
        end;

        u32 = u20:FindFirstChild("Depth");

        if u32 then
            u33 = u32:FindFirstChild("TextLabel");
            u32.Visible = false;
        end;

        u71 = u20:FindFirstChild("Timer");

        if u71 then
            u72 = u71:FindFirstChild("Time_Text");
        end;
    end;

    u21 = u19:FindFirstChild("Boss_Info");

    if u21 then
        u37 = u21:FindFirstChild("Boss_Name");
        u38 = u21:FindFirstChild("Boss_Type");
        u39 = u21:FindFirstChild("Health_Amount");
        u40 = u21:FindFirstChild("Health_Bar");

        if u40 then
            u41 = u40:FindFirstChild("Health_Color");
            u42 = u40:FindFirstChild("Trail");
        end;

        BossHealthBars.SetRefs(u40, u21:FindFirstChild("Health_Count"));
    end;

    u22 = u19:FindFirstChild("Completion_Info");

    if u22 then
        local Header = u22:FindFirstChild("Header");

        if Header then
            Header = Header:FindFirstChild("Title");
        end;

        u51 = Header;
        local Content = u22:FindFirstChild("Content");

        if Content then
            local Level = Content:FindFirstChild("Level");

            if Level then
                u52 = Level:FindFirstChild("Title");
                local Difficulty = Level:FindFirstChild("Difficulty");

                if Difficulty then
                    Difficulty = Difficulty:FindFirstChild("Dificulty");
                end;

                u53 = Difficulty;
                local Background = Level:FindFirstChild("Background");

                if Background then
                    Background = Background:FindFirstChild("DungeonImage");
                end;

                u54 = Background;

                if u54 then
                    u54:SetAttribute("AuthoredDefault", u54.Image);
                end;
            end;

            local Stats = Content:FindFirstChild("Stats");

            if Stats then
                table.clear(u65);

                local function statCard(p264) -- Line: 2070
                    -- upvalues: Stats (copy), u65 (ref)
                    local v265 = Stats:FindFirstChild(p264);

                    if v265 then
                        table.insert(u65, v265);
                    end;

                    if v265 then
                        v265 = v265:FindFirstChild("StatValue");
                    end;

                    return v265;
                end;

                local Stat_MobsKilled = Stats:FindFirstChild("Stat_MobsKilled");

                if Stat_MobsKilled then
                    table.insert(u65, Stat_MobsKilled);
                end;

                if Stat_MobsKilled then
                    Stat_MobsKilled = Stat_MobsKilled:FindFirstChild("StatValue");
                end;

                u55 = Stat_MobsKilled;
                local Stat_TotalTime = Stats:FindFirstChild("Stat_TotalTime");

                if Stat_TotalTime then
                    table.insert(u65, Stat_TotalTime);
                end;

                if Stat_TotalTime then
                    Stat_TotalTime = Stat_TotalTime:FindFirstChild("StatValue");
                end;

                u56 = Stat_TotalTime;
                local Stat_RoomCleared = Stats:FindFirstChild("Stat_RoomCleared");

                if Stat_RoomCleared then
                    table.insert(u65, Stat_RoomCleared);
                end;

                if Stat_RoomCleared then
                    Stat_RoomCleared = Stat_RoomCleared:FindFirstChild("StatValue");
                end;

                u57 = Stat_RoomCleared;
                local Stat_TotalDeath = Stats:FindFirstChild("Stat_TotalDeath");

                if Stat_TotalDeath then
                    table.insert(u65, Stat_TotalDeath);
                end;

                if Stat_TotalDeath then
                    Stat_TotalDeath = Stat_TotalDeath:FindFirstChild("StatValue");
                end;

                u58 = Stat_TotalDeath;
                local Stat_TotalDamage = Stats:FindFirstChild("Stat_TotalDamage");

                if Stat_TotalDamage then
                    table.insert(u65, Stat_TotalDamage);
                end;

                if Stat_TotalDamage then
                    Stat_TotalDamage = Stat_TotalDamage:FindFirstChild("StatValue");
                end;

                u59.Damage = Stat_TotalDamage;
                local Stat_TotalEXP = Stats:FindFirstChild("Stat_TotalEXP");

                if Stat_TotalEXP then
                    table.insert(u65, Stat_TotalEXP);
                end;

                if Stat_TotalEXP then
                    Stat_TotalEXP = Stat_TotalEXP:FindFirstChild("StatValue");
                end;

                u59.EXP = Stat_TotalEXP;
            end;

            u64.StatusLabel = Content:FindFirstChild("StatusText");

            if u64.StatusLabel then
                u64.StatusLabel.Visible = false;
            end;

            local Rewards = Content:FindFirstChild("Rewards");

            if Rewards then
                Rewards = Rewards:FindFirstChild("RewardList");
            end;

            u60 = Rewards;
            u61 = u60 and u60:FindFirstChild("Template");

            if u61 then
                u61.Visible = false;
            end;

            local ActionButtons = Content:FindFirstChild("ActionButtons");

            if ActionButtons then
                u44 = ActionButtons:FindFirstChild("ReplayButton");
                u62 = ActionButtons:FindFirstChild("ReturnButton");
                u63 = ActionButtons:FindFirstChild("DungeonButton");
                u43 = u44;
                u45 = nil;
            end;
        end;
    end;

    u96.Frame = u19:FindFirstChild("Completion_Progress");

    if u96.Frame then
        u96.Bar = u96.Frame:FindFirstChild("Bar");
        u96.List = u96.Frame:FindFirstChild("List");
        u96.Current = u96.Frame:FindFirstChild("Current");
        local v266 = u96.List and u96.List:FindFirstChild("Zone");
        u96.Template = v266;
        local v267 = u96.List and u96.List:FindFirstChildOfClass("UIListLayout");
        u96.ZoneWidth = u96.Template and u96.Template.Size.X.Scale or 0;
        u96.Padding = v267 and v267.Padding.Scale or 0;
        u96.CurrentY = u96.Current and u96.Current.Position.Y or UDim.new(0.5, 0);

        if u96.Template then
            u96.Template.Visible = false;
        end;

        if u96.Current then
            u96.Current.Visible = false;
        end;

        if u96.Bar then
            u96.BarDesign = u96.Bar.Size;
            u96.BarMargin = math.max(u96.BarDesign.X.Scale - (7 * u96.ZoneWidth + 6 * u96.Padding), 0);
            u96.Bar.AnchorPoint = Vector2.new(0.5, u96.Bar.AnchorPoint.Y);
            u96.Bar.Position = UDim2.new(0.5, 0, u96.Bar.Position.Y.Scale, u96.Bar.Position.Y.Offset);
        end;

        u96.Frame.Visible = false;
    end;

    if u19 then
        u19.Visible = false;
    end;

    if u20 then
        u20.Visible = false;
    end;

    if u21 then
        u21.Visible = false;
    end;

    if u22 then
        u22.Visible = false;
    end;
end;

local u268 = {
    Combat = "Clear",
    BossPhase = "Boss",
    BossWarp = "BossWarp",
    BossDefeated = "Escape",
    RoomCleared = "RoomCleared",
    RushRoom = "RushRoom",
    RushFailed = "RushFailed",
    MightRoom = "MightRoom",
    Complete = "Complete",
    Failed = "Failed"
};

function v1.HasEarnedRewards(p269) -- Line: 2163
    -- upvalues: u77 (ref)
    return u77;
end;

function v1.KnitStart(p270) -- Line: 2167
    -- upvalues: u86 (ref), Knit (copy), u67 (ref), u89 (ref), SetPodQueueVisible (copy), u87 (ref), u90 (ref), u88 (ref), u91 (ref), u92 (ref), UpdateInfoFrame (copy), OnPhaseChange (copy), UpdateBossHealth (copy), ShowCompletion (copy), OnDungeonAlert (copy), u70 (ref), u69 (ref), u94 (ref), u95 (ref), u268 (copy), u96 (copy), CPMoveCurrentToPos (copy), CPBuild (copy), u93 (ref), u32 (ref), u33 (ref), u77 (ref), u35 (ref), u36 (ref), u34 (ref), u29 (ref), u31 (ref), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), u43 (ref), u46 (ref), u45 (ref), ResetCompletionFrame (copy), CPReset (copy), u19 (ref), OnPartyActionUpdate (copy), u64 (copy), u62 (ref), OnCloseButtonPressed (copy), u63 (ref), OnDungeonButtonPressed (copy), u44 (ref), OnReplayButtonPressed (copy), LocalPlayer (copy), UpdateDungeonVisibility (copy)
    pcall(function() -- Line: 2169
        -- upvalues: u86 (ref), Knit (ref)
        u86 = Knit.GetController("SoundController");
    end);
    pcall(function() -- Line: 2174
        -- upvalues: u67 (ref), Knit (ref)
        u67 = Knit.GetController("UIAnimationController");
    end);
    pcall(function() -- Line: 2179
        -- upvalues: u89 (ref), Knit (ref)
        u89 = Knit.GetService("DungeonQueueService");
    end);

    if u89 then
        u89.PodQueueUpdate:Connect(function(p271, p272) -- Line: 2185
            -- upvalues: SetPodQueueVisible (ref)
            SetPodQueueVisible(p271, p272);
        end);
    end;

    if u87 then
        u87.Activated:Connect(function() -- Line: 2190
            -- upvalues: u90 (ref), u89 (ref), u87 (ref)
            if not (u90 and u89) then
                return;
            end;

            u87.Active = false;
            task.spawn(function() -- Line: 2196
                -- upvalues: u89 (ref), u87 (ref), u90 (ref)
                u89:RequestLeaveQueue():await();

                if u87 and u90 then
                    u87.Active = true;
                end;
            end);
        end);
    end;

    if u88 then
        u88.Activated:Connect(function() -- Line: 2204
            -- upvalues: u90 (ref), u91 (ref), u89 (ref), u88 (ref)
            if not (u90 and (u91 and u89)) then
                return;
            end;

            u88.Active = false;
            task.spawn(function() -- Line: 2210
                -- upvalues: u89 (ref), u88 (ref), u90 (ref)
                u89:RequestStartNow():await();

                if u88 and u90 then
                    u88.Active = true;
                end;
            end);
        end);
    end;

    local Service = Knit.GetService("DungeonService");
    Service.StateUpdate:Connect(function(p273, p274, p275, p276, p277) -- Line: 2223
        -- upvalues: u92 (ref), UpdateInfoFrame (ref)
        u92 = false;
        UpdateInfoFrame(p273, p274, p275, p276, p277);
    end);
    Service.PhaseChange:Connect(function(p278, p279) -- Line: 2229
        -- upvalues: u92 (ref), OnPhaseChange (ref)
        u92 = false;
        OnPhaseChange(p278, p279);
    end);
    Service.BossHealthUpdate:Connect(function(p280, p281, p282, p283) -- Line: 2235
        -- upvalues: UpdateBossHealth (ref)
        UpdateBossHealth(p280, p281, p282, p283);
    end);
    Service.DungeonComplete:Connect(function(p284) -- Line: 2240
        -- upvalues: ShowCompletion (ref)
        ShowCompletion(p284);
    end);
    Service.DungeonAlert:Connect(function(p285, ...) -- Line: 2245
        -- upvalues: OnDungeonAlert (ref)
        OnDungeonAlert(p285, ...);
    end);
    Service.LivesUpdate:Connect(function(p286) -- Line: 2250
        -- upvalues: u70 (ref), u69 (ref)
        u70 = p286;

        if not u69 then
            return;
        end;

        if p286 > 0 then
            u69.Text = "Lives: <font color=\"rgb(80,220,100)\">" .. tostring(p286) .. "</font>";

            return;
        end;

        u69.Text = "Lives: <font color=\"rgb(255,60,60)\">None</font>";
    end);
    local Service2 = Knit.GetService("DungeonRunService");
    Service2.StateUpdate:Connect(function(p287, p288, p289, p290, p291) -- Line: 2259
        -- upvalues: u92 (ref), u94 (ref), u95 (ref), u268 (ref), UpdateInfoFrame (ref), u96 (ref), CPMoveCurrentToPos (ref)
        u92 = true;
        u94 = p290 or 0;
        u95 = p291 or 0;
        UpdateInfoFrame(u268[p287] or p287, p288, p289, 0, 0);
        local v292 = u94 > 0 and u96.ByIndex[u94];

        if v292 then
            if v292 <= u96.CurrentPos then
                return;
            end;

            CPMoveCurrentToPos(v292);
        end;
    end);
    Service2.RoomLayoutUpdate:Connect(function(p293, p294) -- Line: 2276
        -- upvalues: CPBuild (ref)
        CPBuild(p293, p294);
    end);
    Service2.ZoneEntered:Connect(function(p295) -- Line: 2279
        -- upvalues: u96 (ref), CPMoveCurrentToPos (ref)
        local v296 = u96.ByIndex[p295];

        if v296 then
            if v296 <= u96.CurrentPos then
                return;
            end;

            CPMoveCurrentToPos(v296);
        end;
    end);
    task.spawn(function() -- Line: 2288
        -- upvalues: Service2 (copy)
        pcall(function() -- Line: 2289
            -- upvalues: Service2 (ref)
            Service2:RequestZoneLayout():await();
        end);
    end);
    Service2.PhaseChange:Connect(function(p297, p298) -- Line: 2295
        -- upvalues: u92 (ref), u93 (ref), u95 (ref), u94 (ref), u32 (ref), u33 (ref), u268 (ref), OnPhaseChange (ref)
        u92 = true;
        local v299 = p298 or {};

        if v299.IsOpenWorld ~= nil then
            u93 = v299.IsOpenWorld;
        end;

        if v299.TotalRooms then
            u95 = v299.TotalRooms;
        end;

        if v299.RoomIndex then
            u94 = v299.RoomIndex;
        end;

        if v299.IsEndless and v299.ExtensionIndex ~= nil then
            local ExtensionIndex = v299.ExtensionIndex;

            if u32 then
                if ExtensionIndex == nil then
                    u32.Visible = false;
                else
                    u32.Visible = true;

                    if u33 then
                        u33.Text = "Depth: " .. tostring(ExtensionIndex + 1);
                    end;
                end;
            end;
        end;

        OnPhaseChange(u268[p297] or p297, v299);
    end);
    Service2.SpecialBossSummonPrompt:Connect(function(p300) -- Line: 2323
        -- upvalues: Knit (ref), Service2 (copy)
        local u301 = p300 or {};
        task.spawn(function() -- Line: 2325
            -- upvalues: Knit (ref), u301 (ref), Service2 (ref)
            local Controller = Knit.GetController("WarningController");

            if u301.CanAfford then
                Service2:ConfirmSpecialBossSummon(Controller:Prompt({
                    ConfirmText = "Summon",
                    DenyText = "Cancel",
                    Message = `Consume <b>{u301.Amount}x {u301.KeyName}</b> to summon <b>{u301.BossName}</b>?`
                }) == true):catch(function() -- Line: 2343
                end);

                return;
            end;

            Controller:Prompt({
                ConfirmText = "OK",
                DenyText = "Close",
                Message = `You need <b>{u301.Amount or 0}x {u301.KeyName or "Key"}</b> to summon <b>{u301.BossName or "the Special Boss"}</b>.\nYou have {u301.HaveCount or 0}.`
            });
            Service2:ConfirmSpecialBossSummon(false):catch(function() -- Line: 2334
            end);
        end);
    end);
    Service2.BossHealthUpdate:Connect(function(p302, p303, p304) -- Line: 2348
        -- upvalues: UpdateBossHealth (ref)
        UpdateBossHealth(p302, p303, p304, nil);
    end);
    Service2.DungeonComplete:Connect(function(p305) -- Line: 2353
        -- upvalues: u92 (ref), u93 (ref), u94 (ref), u95 (ref), u77 (ref), ShowCompletion (ref)
        u92 = false;
        u93 = false;
        u94 = 0;
        u95 = 0;

        if p305 and p305.IsVictory then
            u77 = true;
        end;

        ShowCompletion(p305);
    end);
    Service2.LivesUpdate:Connect(function(p306) -- Line: 2367
        -- upvalues: u70 (ref), u69 (ref)
        u70 = p306;

        if not u69 then
            return;
        end;

        if p306 > 0 then
            u69.Text = "Lives: <font color=\"rgb(80,220,100)\">" .. tostring(p306) .. "</font>";

            return;
        end;

        u69.Text = "Lives: <font color=\"rgb(255,60,60)\">None</font>";
    end);
    Service2.RushTimerUpdate:Connect(function(p307, p308) -- Line: 2372
        -- upvalues: u35 (ref), u36 (ref), u34 (ref), u29 (ref), u31 (ref), Color3_fromRGB_ret3 (ref), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret (ref)
        u35 = p307;
        u36 = p308 or 30;

        if u34 then
            if u29 then
                local math_floor_ret = math.floor(p307);
                local math_max_ret = math.max(math_floor_ret, 0);
                u29.Text = string.format("%02d:%02d", math.floor(math_max_ret / 60), math_max_ret % 60);
            end;

            if u31 and u36 > 0 then
                local math_clamp_ret = math.clamp(p307 / u36, 0, 1);
                u31.Size = UDim2.fromScale(math_clamp_ret, 1);
                local v309;

                if math_clamp_ret <= 0.2 then
                    v309 = Color3_fromRGB_ret3;
                elseif math_clamp_ret <= 0.5 then
                    local v310 = (math_clamp_ret - 0.2) / 0.3;
                    local v311 = Color3_fromRGB_ret3;
                    local v312 = Color3_fromRGB_ret2;
                    v309 = Color3.new(v311.R + (v312.R - v311.R) * v310, v311.G + (v312.G - v311.G) * v310, v311.B + (v312.B - v311.B) * v310);
                else
                    local v313 = (math_clamp_ret - 0.5) / 0.5;
                    local v314 = Color3_fromRGB_ret2;
                    local v315 = Color3_fromRGB_ret;
                    v309 = Color3.new(v314.R + (v315.R - v314.R) * v313, v314.G + (v315.G - v314.G) * v313, v314.B + (v315.B - v314.B) * v313);
                end;

                u31.BackgroundColor3 = v309;
            end;
        end;
    end);

    local function HandleReplayVoteUpdate(p316, p317, p318) -- Line: 2389
        -- upvalues: u43 (ref), u46 (ref), u45 (ref)
        if p316 == -1 then
            if u43 then
                u43.Visible = false;
            end;

            u46 = false;

            return;
        end;

        if not (u43 and u45) then
            return;
        end;

        if p317 <= 1 then
            return;
        end;

        if p318 > 0 then
            u45.Text = `REPLAY ({p316}/{p317}) {p318}S`;

            return;
        end;

        local v319 = u45.Text:match("%d+S$") or "";

        if v319 == "" then
            u45.Text = `REPLAY ({p316}/{p317})`;

            return;
        end;

        u45.Text = `REPLAY ({p316}/{p317}) {v319}`;
    end;

    local function HandleReplayStarting() -- Line: 2419
        -- upvalues: ResetCompletionFrame (ref), CPReset (ref), u19 (ref)
        ResetCompletionFrame();
        CPReset();

        if u19 then
            u19.Visible = false;
        end;
    end;

    Service2.ReplayVoteUpdate:Connect(HandleReplayVoteUpdate);
    Service2.ReplayStarting:Connect(HandleReplayStarting);
    Service2.PartyActionUpdate:Connect(OnPartyActionUpdate);
    Service2.SessionMemberUpdate:Connect(function(p320, p321) -- Line: 2431
        -- upvalues: u64 (ref)
        if p321 then
            u64.LeaderUserId = p321;
        end;
    end);
    local success, result = pcall(function() -- Line: 2444
        -- upvalues: Knit (ref)
        return Knit.GetService("BossRushService");
    end);

    if success and result then
        result.DungeonComplete:Connect(function(p322) -- Line: 2449
            -- upvalues: u92 (ref), u93 (ref), u94 (ref), u95 (ref), ShowCompletion (ref)
            u92 = false;
            u93 = false;
            u94 = 0;
            u95 = 0;
            ShowCompletion(p322);
        end);
        result.ReplayVoteUpdate:Connect(HandleReplayVoteUpdate);
        result.ReplayStarting:Connect(HandleReplayStarting);
    end;

    local success2, result2 = pcall(function() -- Line: 2468
        -- upvalues: Knit (ref)
        return Knit.GetService("ChallengeRunService");
    end);

    if success2 and result2 then
        result2.DungeonComplete:Connect(function(p323) -- Line: 2472
            -- upvalues: u92 (ref), u93 (ref), u94 (ref), u95 (ref), ShowCompletion (ref)
            u92 = false;
            u93 = false;
            u94 = 0;
            u95 = 0;
            ShowCompletion(p323);
        end);
        result2.ReplayVoteUpdate:Connect(HandleReplayVoteUpdate);
        result2.ReplayStarting:Connect(HandleReplayStarting);
    end;

    local success3, result3 = pcall(function() -- Line: 2486
        -- upvalues: Knit (ref)
        return Knit.GetService("RaidRunService");
    end);

    if success3 and result3 then
        result3.DungeonComplete:Connect(function(p324) -- Line: 2490
            -- upvalues: u92 (ref), u93 (ref), u94 (ref), u95 (ref), ShowCompletion (ref)
            u92 = false;
            u93 = false;
            u94 = 0;
            u95 = 0;
            ShowCompletion(p324);
        end);
    end;

    if u62 then
        u62.Activated:Connect(OnCloseButtonPressed);
    end;

    if u63 then
        u63.Activated:Connect(OnDungeonButtonPressed);
    end;

    if u44 then
        u44.Activated:Connect(OnReplayButtonPressed);
    end;

    LocalPlayer:GetAttributeChangedSignal("InDungeon"):Connect(UpdateDungeonVisibility);
    LocalPlayer:GetAttributeChangedSignal("InEndless"):Connect(UpdateDungeonVisibility);
    UpdateDungeonVisibility();
end;

return v1;