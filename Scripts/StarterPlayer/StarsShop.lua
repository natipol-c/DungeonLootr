--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     StarsShop
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.StarsShop
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local GameInfo = ReplicatedStorage:WaitForChild("GameInfo");
local CosmeticData = require(GameInfo:WaitForChild("CosmeticData"));
local EmoteData = require(GameInfo:WaitForChild("EmoteData"));
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local RevealCascade = require(script.Parent.Parent.ClientUtils.RevealCascade);
local Cosmetic_Manager = require(ReplicatedStorage.Globals.Modules.Cosmetic_Manager);
local RarityGradient = require(ReplicatedStorage.Modules.RarityGradient);
local LocalPlayer = Players.LocalPlayer;
local Color3_new_ret = Color3.new(1, 1, 1);
local CFrame_new_ret = CFrame.new(Vector3.new(0, 0.5, -12), Vector3.new(0, 0.5, 0));
local CFrame_new_ret2 = CFrame.new(0, 0.5, 0);
local TweenInfo_new_ret = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local TweenInfo_new_ret3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
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
local u13 = {};
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
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
local u29 = "Emotes";
local u30 = {
    Emotes = 1,
    Cosmetics = 1
};
local u31 = false;
local u32 = 0;
local u33 = {};
local u34 = {};
local u35 = false;
local u36 = {};
local u37 = {};
local u38 = {};
local u39 = {};
local u40 = 0;
local u41 = nil;

local function FormatTime(p42: number) -- Line: 142
    local math_floor_ret = math.floor(p42);
    local math_max_ret = math.max(0, math_floor_ret);
    local math_floor_ret2 = math.floor(math_max_ret / 3600);
    local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);

    return string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret % 60);
end;

local function FormatCommas(p43: number) -- Line: 151
    local math_floor_ret = math.floor(p43);
    local v44 = tostring(math_floor_ret);
    local v45;

    repeat
        v44, v45 = v44:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
    until v45 == 0;

    return v44;
end;

local function TabItems(p46: string) -- Line: 162
    -- upvalues: u28 (ref)
    return u28 and (p46 == "Emotes" and u28.Emotes or (u28.Cosmetics or {})) or {};
end;

local function SelectedItem() -- Line: 168
    -- upvalues: TabItems (copy), u29 (ref), u30 (copy)
    return TabItems(u29)[u30[u29]];
end;

local function CycleIndex(p47: number) -- Line: 174
    -- upvalues: TabItems (copy), u29 (ref)
    local v48 = #TabItems(u29);

    return v48 == 0 and 1 or (p47 - 1) % v48 + 1;
end;

local function ItemDisplayName(p49: number) -- Line: 181
    -- upvalues: TabItems (copy), u29 (ref)
    local v50 = TabItems(u29);
    local v51 = #TabItems(u29);
    local v52 = v50[v51 == 0 and 1 or (p49 - 1) % v51 + 1];

    return v52 and v52.DisplayName or "";
end;

local function CloneCharacter() -- Line: 189
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    local v53 = {};

    for _, descendant in Character:GetDescendants() do
        if not descendant.Archivable then
            descendant.Archivable = true;
            table.insert(v53, descendant);
        end;
    end;

    local Archivable = Character.Archivable;
    Character.Archivable = true;
    local v54 = Character:Clone();
    Character.Archivable = Archivable;

    for _, v in v53 do
        v.Archivable = false;
    end;

    for _, descendant in v54:GetDescendants() do
        if descendant:IsA("BaseScript") or (descendant:IsA("Tool") or (descendant:IsA("ForceField") or (descendant:IsA("BillboardGui") or descendant.Name == "Holder"))) then
            descendant:Destroy();
        end;
    end;

    return v54;
end;

local function WeldAccessories(p55: userdata) -- Line: 219
    for _, child in p55:GetChildren() do
        if child:IsA("Accessory") then
            local Handle = child:FindFirstChild("Handle");

            if Handle then
                local v56 = Handle:FindFirstChildOfClass("Attachment");

                if v56 then
                    for _, child2 in p55:GetChildren() do
                        if child2:IsA("BasePart") then
                            local v57 = child2:FindFirstChild(v56.Name);

                            if v57 and v57:IsA("Attachment") then
                                Handle.CFrame = child2.CFrame * v57.CFrame * v56.CFrame:Inverse();
                                local Weld = Instance.new("Weld");
                                Weld.Part0 = child2;
                                Weld.Part1 = Handle;
                                Weld.C0 = v57.CFrame;
                                Weld.C1 = v56.CFrame;
                                Weld.Parent = Handle;
                                break;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

local function ApplyCosmeticSetToClone(p58: userdata, p59: string) -- Line: 245
    -- upvalues: Cosmetic_Manager (copy), CosmeticData (copy), WeldAccessories (copy)
    Cosmetic_Manager.ClearAll(p58);
    local v60 = {};

    for _, v in CosmeticData.Slots do
        if Cosmetic_Manager.SetHasSlot(p59, v) then
            v60[v] = p59;
        else
            v60[v] = "";
        end;
    end;

    Cosmetic_Manager.ApplyAll(p58, v60);
    WeldAccessories(p58);
end;

local function PlayCloneAnimation(p61: userdata, p62: string?) -- Line: 262
    -- upvalues: EmoteData (copy), LocalPlayer (copy), Class_Data (copy), ReplicatedStorage (copy)
    local v63 = p61:FindFirstChildOfClass("Humanoid");

    if not v63 then
        return nil;
    end;

    local u64 = v63:FindFirstChildOfClass("Animator");

    if not u64 then
        u64 = Instance.new("Animator");
        u64.Parent = v63;
    end;

    local u65;

    if p62 then
        u65 = EmoteData.GetAnimation(p62);
    else
        local v66 = Class_Data[LocalPlayer:GetAttribute("Stat_ActiveClass") or ""];
        local v67 = v66 and v66.AnimationOverrides and v66.AnimationOverrides.idle;

        if v67 then
            u65 = Instance.new("Animation");
            u65.AnimationId = v67;
        else
            u65 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Idle_Animations");

            if u65 then
                u65 = u65:FindFirstChild("Hitman_Idle");
            end;
        end;
    end;

    if not u65 then
        return nil;
    end;

    local success, result = pcall(function() -- Line: 289
        -- upvalues: u64 (ref), u65 (ref)
        return u64:LoadAnimation(u65);
    end);

    if not (success and result) then
        return nil;
    end;

    result.Priority = Enum.AnimationPriority.Action4;
    result.Looped = true;
    result:Play();

    return result;
end;

local function MountCloneInViewport(p68: userdata) -- Line: 303
    -- upvalues: CloneCharacter (copy), CFrame_new_ret2 (copy), CFrame_new_ret (copy)
    local v69 = CloneCharacter();

    if not v69 then
        return nil;
    end;

    local WorldModel = Instance.new("WorldModel");
    WorldModel.Name = "CharacterWorld";
    WorldModel.Parent = p68;
    local HumanoidRootPart = v69:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        v69.PrimaryPart = HumanoidRootPart;
    end;

    v69:PivotTo(CFrame_new_ret2);
    v69.Parent = WorldModel;
    local v70 = p68:FindFirstChildOfClass("Camera");

    if not v70 then
        v70 = Instance.new("Camera");
        v70.Parent = p68;
    end;

    v70.FieldOfView = 30;
    v70.CFrame = CFrame_new_ret;
    p68.CurrentCamera = v70;

    return v69;
end;

local function OffsetPosition(p71, p72: number) -- Line: 337
    return UDim2.new(p71.X.Scale + p72, p71.X.Offset, p71.Y.Scale, p71.Y.Offset);
end;

local function ClearCarouselViewport(p73: number) -- Line: 342
    -- upvalues: u37 (copy), u13 (copy)
    local u74 = u37[p73];

    if u74 then
        if u74.track then
            pcall(function() -- Line: 346
                -- upvalues: u74 (copy)
                u74.track:Stop();
            end);
        end;

        u37[p73] = nil;
    end;

    local v75 = u13[p73];

    if v75 then
        for _, child in v75:GetChildren() do
            if not child:IsA("UIGradient") then
                child:Destroy();
            end;
        end;
    end;
end;

local function RenderItemIntoViewport(p76: number, p77: number) -- Line: 362
    -- upvalues: u13 (copy), TabItems (copy), u29 (ref), ClearCarouselViewport (copy), u37 (copy), MountCloneInViewport (copy), PlayCloneAnimation (copy), ApplyCosmeticSetToClone (copy)
    local v78 = u13[p76];

    if not v78 then
        return;
    end;

    local v79 = TabItems(u29);
    local v80 = #TabItems(u29);
    local v81 = v79[v80 == 0 and 1 or (p77 - 1) % v80 + 1];

    if not v81 then
        ClearCarouselViewport(p76);

        return;
    end;

    local v82 = u29 .. "/" .. v81.Id;
    local v83 = u37[p76];

    if v83 and v83.key == v82 then
        return;
    end;

    ClearCarouselViewport(p76);
    local v84 = MountCloneInViewport(v78);

    if not v84 then
        return;
    end;

    local v85;

    if u29 == "Emotes" then
        v85 = PlayCloneAnimation(v84, v81.Id);
    else
        ApplyCosmeticSetToClone(v84, v81.Id);
        v85 = PlayCloneAnimation(v84, nil);
    end;

    u37[p76] = {
        key = v82,
        clone = v84,
        track = v85
    };
end;

local function UpdateCarouselLabels() -- Line: 393
    -- upvalues: u30 (copy), u29 (ref), u16 (ref), TabItems (copy), u17 (ref), u18 (ref)
    local v86 = u30[u29];

    if u16 then
        local v87 = TabItems(u29);
        local v88 = #TabItems(u29);
        local v89 = v87[v88 == 0 and 1 or (v86 - 1) % v88 + 1];
        u16.Text = v89 and v89.DisplayName or "";
    end;

    if u17 then
        local v90 = TabItems(u29);
        local v91 = #TabItems(u29);
        local v92 = v90[v91 == 0 and 1 or (v86 + 1 - 1) % v91 + 1];
        u17.Text = v92 and v92.DisplayName or "";
    end;

    if u18 then
        local v93 = TabItems(u29);
        local v94 = #TabItems(u29);
        local v95 = v93[v94 == 0 and 1 or (v86 - 1 - 1) % v94 + 1];
        u18.Text = v95 and v95.DisplayName or "";
    end;
end;

local function CancelCarouselTweens() -- Line: 402
    -- upvalues: u36 (copy), u35 (ref)
    for _, v in u36 do
        pcall(function() -- Line: 404
            -- upvalues: v (copy)
            v:Cancel();
        end);
    end;

    table.clear(u36);
    u35 = false;
end;

local function SnapToIndex(p96: number) -- Line: 411
    -- upvalues: CancelCarouselTweens (copy), u30 (copy), u29 (ref), TabItems (copy), u34 (ref), RenderItemIntoViewport (copy), u13 (copy), u33 (ref), u16 (ref), u17 (ref), u18 (ref)
    CancelCarouselTweens();
    local v97 = #TabItems(u29);
    u30[u29] = v97 == 0 and 1 or (p96 - 1) % v97 + 1;
    local v98 = u30[u29];
    local v99 = #TabItems(u29);
    u34 = {
        Main = 1,
        Next = 2,
        Previous = 3
    };
    RenderItemIntoViewport(1, v98);

    if u13[1] then
        u13[1].Position = u33.Main;
    end;

    if u13[2] then
        if v99 >= 2 then
            u13[2].Visible = true;
            RenderItemIntoViewport(2, v98 + 1);
            u13[2].Position = u33.Next;
        else
            u13[2].Visible = false;
        end;
    end;

    if u13[3] then
        if v99 >= 3 then
            u13[3].Visible = true;
            RenderItemIntoViewport(3, v98 - 1);
            u13[3].Position = u33.Previous;
        else
            u13[3].Visible = false;
        end;
    end;

    local v100 = u30[u29];

    if u16 then
        local v101 = TabItems(u29);
        local v102 = #TabItems(u29);
        local v103 = v101[v102 == 0 and 1 or (v100 - 1) % v102 + 1];
        u16.Text = v103 and v103.DisplayName or "";
    end;

    if u17 then
        local v104 = TabItems(u29);
        local v105 = #TabItems(u29);
        local v106 = v104[v105 == 0 and 1 or (v100 + 1 - 1) % v105 + 1];
        u17.Text = v106 and v106.DisplayName or "";
    end;

    if u18 then
        local v107 = TabItems(u29);
        local v108 = #TabItems(u29);
        local v109 = v107[v108 == 0 and 1 or (v100 - 1 - 1) % v108 + 1];
        u18.Text = v109 and v109.DisplayName or "";
    end;
end;

local function AnimateStep(p110: number) -- Line: 446
    -- upvalues: TabItems (copy), u29 (ref), SnapToIndex (copy), u30 (copy), u35 (ref), u34 (ref), TweenService (copy), u13 (copy), TweenInfo_new_ret (copy), u36 (copy), u33 (ref), RenderItemIntoViewport (copy), u16 (ref), u17 (ref), u18 (ref)
    if #TabItems(u29) < 3 then
        SnapToIndex(u30[u29] + p110);

        return;
    end;

    u35 = true;
    local v111 = u30[u29] + p110;
    local v112 = #TabItems(u29);
    u30[u29] = v112 == 0 and 1 or (v111 - 1) % v112 + 1;
    local v113 = u30[u29];
    local Main = u34.Main;
    local Next = u34.Next;
    local Previous = u34.Previous;

    local function slide(p114: number, p115) -- Line: 460
        -- upvalues: TweenService (ref), u13 (ref), TweenInfo_new_ret (ref), u36 (ref)
        local v116 = TweenService:Create(u13[p114], TweenInfo_new_ret, {
            Position = p115
        });
        table.insert(u36, v116);
        v116:Play();
    end;

    if p110 == 1 then
        local v117 = TweenService:Create(u13[Next], TweenInfo_new_ret, {
            Position = u33.Main
        });
        table.insert(u36, v117);
        v117:Play();
        local v118 = TweenService:Create(u13[Main], TweenInfo_new_ret, {
            Position = u33.Previous
        });
        table.insert(u36, v118);
        v118:Play();
        RenderItemIntoViewport(Previous, v113 + 1);
        local Next2 = u33.Next;
        u13[Previous].Position = UDim2.new(Next2.X.Scale + 0.2, Next2.X.Offset, Next2.Y.Scale, Next2.Y.Offset);
        local v119 = TweenService:Create(u13[Previous], TweenInfo_new_ret, {
            Position = u33.Next
        });
        table.insert(u36, v119);
        v119:Play();
        u34 = {
            Main = Next,
            Previous = Main,
            Next = Previous
        };
    else
        local v120 = TweenService:Create(u13[Previous], TweenInfo_new_ret, {
            Position = u33.Main
        });
        table.insert(u36, v120);
        v120:Play();
        local v121 = TweenService:Create(u13[Main], TweenInfo_new_ret, {
            Position = u33.Next
        });
        table.insert(u36, v121);
        v121:Play();
        RenderItemIntoViewport(Next, v113 - 1);
        local Previous2 = u33.Previous;
        u13[Next].Position = UDim2.new(Previous2.X.Scale + -0.2, Previous2.X.Offset, Previous2.Y.Scale, Previous2.Y.Offset);
        local v122 = TweenService:Create(u13[Next], TweenInfo_new_ret, {
            Position = u33.Previous
        });
        table.insert(u36, v122);
        v122:Play();
        u34 = {
            Main = Previous,
            Next = Main,
            Previous = Next
        };
    end;

    local v123 = u30[u29];

    if u16 then
        local v124 = TabItems(u29);
        local v125 = #TabItems(u29);
        local v126 = v124[v125 == 0 and 1 or (v123 - 1) % v125 + 1];
        u16.Text = v126 and v126.DisplayName or "";
    end;

    if u17 then
        local v127 = TabItems(u29);
        local v128 = #TabItems(u29);
        local v129 = v127[v128 == 0 and 1 or (v123 + 1 - 1) % v128 + 1];
        u17.Text = v129 and v129.DisplayName or "";
    end;

    if u18 then
        local v130 = TabItems(u29);
        local v131 = #TabItems(u29);
        local v132 = v130[v131 == 0 and 1 or (v123 - 1 - 1) % v131 + 1];
        u18.Text = v132 and v132.DisplayName or "";
    end;

    task.delay(TweenInfo_new_ret.Time, function() -- Line: 491
        -- upvalues: u35 (ref)
        u35 = false;
    end);
end;

local u133 = nil;

local function SetEmoteTileSelected(p134: number, p135: boolean) -- Line: 502
    -- upvalues: u38 (copy), TweenService (copy), TweenInfo_new_ret2 (copy), TweenInfo_new_ret3 (copy)
    local v136 = u38[p134];

    if not (v136 and v136.selectedScale) then
        return;
    end;

    TweenService:Create(v136.selectedScale, p135 and TweenInfo_new_ret2 or TweenInfo_new_ret3, {
        Scale = p135 and 1 or 0
    }):Play();
end;

local function SetCosmeticRowSelected(p137: number, p138: boolean) -- Line: 513
    -- upvalues: u39 (copy)
    local v139 = u39[p137];

    if not v139 then
        return;
    end;

    local Active = v139:FindFirstChild("Active");
    local InActive = v139:FindFirstChild("InActive");

    if Active then
        Active.Visible = p138;
    end;

    if InActive then
        InActive.Visible = not p138;
    end;
end;

local function ApplyListSelection(p140: number?, p141: number) -- Line: 523
    -- upvalues: u29 (ref), u38 (copy), TweenService (copy), TweenInfo_new_ret3 (copy), TweenInfo_new_ret2 (copy), u39 (copy)
    if u29 == "Emotes" then
        if p140 and p140 ~= p141 then
            local v142 = u38[p140];

            if v142 and v142.selectedScale then
                TweenService:Create(v142.selectedScale, TweenInfo_new_ret3, {
                    Scale = 0
                }):Play();
            end;
        end;

        local v143 = u38[p141];

        if v143 then
            if not v143.selectedScale then
                return;
            end;

            TweenService:Create(v143.selectedScale, TweenInfo_new_ret2 or TweenInfo_new_ret3, {
                Scale = 1
            }):Play();
        end;
    else
        local v144 = p140 and p140 ~= p141 and u39[p140];

        if v144 then
            local Active = v144:FindFirstChild("Active");
            local InActive = v144:FindFirstChild("InActive");

            if Active then
                Active.Visible = false;
            end;

            if InActive then
                InActive.Visible = true;
            end;
        end;

        local v145 = u39[p141];

        if not v145 then
            return;
        end;

        local Active = v145:FindFirstChild("Active");
        local InActive = v145:FindFirstChild("InActive");

        if Active then
            Active.Visible = true;
        end;

        if InActive then
            InActive.Visible = false;
        end;
    end;
end;

local function SelectIndex(p146: number, p147: boolean) -- Line: 535
    -- upvalues: TabItems (copy), u29 (ref), u30 (copy), u38 (copy), TweenService (copy), TweenInfo_new_ret2 (copy), TweenInfo_new_ret3 (copy), u39 (copy), u133 (ref), u35 (ref), AnimateStep (copy), SnapToIndex (copy), ApplyListSelection (copy)
    local v148 = TabItems(u29);

    if #v148 == 0 then
        return;
    end;

    local v149 = #TabItems(u29);
    local v150 = v149 == 0 and 1 or (p146 - 1) % v149 + 1;
    local v151 = u30[u29];

    if v150 == v151 then
        if u29 == "Emotes" then
            local v152 = u38[v150];

            if v152 and v152.selectedScale then
                TweenService:Create(v152.selectedScale, TweenInfo_new_ret2 or TweenInfo_new_ret3, {
                    Scale = 1
                }):Play();
            end;
        else
            local v153 = u39[v150];

            if v153 then
                local Active = v153:FindFirstChild("Active");
                local InActive = v153:FindFirstChild("InActive");

                if Active then
                    Active.Visible = true;
                end;

                if InActive then
                    InActive.Visible = false;
                end;
            end;
        end;

        u133();

        return;
    end;

    if p147 and (not u35 and #v148 >= 3) then
        local v154 = #TabItems(u29);

        if v150 == (v154 == 0 and 1 or (v151 + 1 - 1) % v154 + 1) then
            AnimateStep(1);
        else
            local v155 = #TabItems(u29);

            if v150 == (v155 == 0 and 1 or (v151 - 1 - 1) % v155 + 1) then
                AnimateStep(-1);
            else
                SnapToIndex(v150);
            end;
        end;
    else
        SnapToIndex(v150);
    end;

    ApplyListSelection(v151, u30[u29]);
    u133();
end;

u133 = function() -- Line: 568
    -- upvalues: TabItems (copy), u29 (ref), u30 (copy), u19 (ref), u21 (ref), u20 (ref), FormatCommas (copy), u22 (ref)
    local v156 = TabItems(u29)[u30[u29]];

    if v156 and not v156.Owned then
        if u19 then
            u19.Visible = true;

            if u20 then
                u20.Text = FormatCommas(v156.StarsCost or 0);
            end;
        end;

        if u21 then
            local v157;

            if v156.RobuxPrice == nil then
                v157 = false;
            else
                v157 = v156.RobuxPrice > 0;
            end;

            u21.Visible = v157;

            if v157 and u22 then
                u22.Text = FormatCommas(v156.RobuxPrice);
            end;
        end;

        return;
    end;

    if u19 then
        u19.Visible = false;
    end;

    if u21 then
        u21.Visible = false;
    end;
end;

local function SyncEmoteTileAnimations() -- Line: 599
    -- upvalues: u24 (ref), u38 (copy)
    if not u24 then
        return;
    end;

    local AbsolutePosition = u24.AbsolutePosition;
    local AbsoluteWindowSize = u24.AbsoluteWindowSize;

    if AbsoluteWindowSize.X <= 0 and AbsoluteWindowSize.Y <= 0 then
        return;
    end;

    for _, v in u38 do
        local track = v.track;

        if track then
            local AbsolutePosition2 = v.frame.AbsolutePosition;
            local AbsoluteSize = v.frame.AbsoluteSize;

            if AbsoluteSize.X > 0 and AbsoluteSize.Y > 0 then
                local v158;

                if AbsolutePosition2.X + AbsoluteSize.X > AbsolutePosition.X and (AbsolutePosition2.X < AbsolutePosition.X + AbsoluteWindowSize.X and AbsolutePosition2.Y + AbsoluteSize.Y > AbsolutePosition.Y) then
                    v158 = AbsolutePosition2.Y < AbsolutePosition.Y + AbsoluteWindowSize.Y;
                else
                    v158 = false;
                end;

                if v158 and not track.IsPlaying then
                    track:Play();
                elseif not v158 and track.IsPlaying then
                    track:Stop();
                end;
            end;
        end;
    end;
end;

local function ClearEmoteTiles() -- Line: 627
    -- upvalues: u38 (copy)
    for _, v in u38 do
        if v.track then
            pcall(function() -- Line: 630
                -- upvalues: v (copy)
                v.track:Stop();
            end);
        end;

        if v.frame and v.frame.Parent then
            v.frame:Destroy();
        end;
    end;

    table.clear(u38);
end;

local function BuildEmoteTiles() -- Line: 640
    -- upvalues: ClearEmoteTiles (copy), u25 (ref), u28 (ref), u32 (ref), Color3_new_ret (copy), RarityGradient (copy), MountCloneInViewport (copy), PlayCloneAnimation (copy), SelectIndex (copy), u24 (ref), u38 (copy), RevealCascade (copy), u6 (ref), SyncEmoteTileAnimations (copy)
    ClearEmoteTiles();

    if not (u25 and u28) then
        return;
    end;

    local u159 = u32;
    local v160 = {};

    for i, v in u28.Emotes do
        local v161 = u25:Clone();
        v161.Name = v.Id;
        v161.LayoutOrder = i;
        v161.Visible = true;
        local Item_Name = v161:FindFirstChild("Item_Name");

        if Item_Name then
            Item_Name.Text = v.DisplayName;
            Item_Name.TextColor3 = Color3_new_ret;
            RarityGradient.set(Item_Name, v.Rarity);
        end;

        local Owned = v161:FindFirstChild("Owned");

        if Owned then
            Owned.Visible = v.Owned == true;
        end;

        local Selected = v161:FindFirstChild("Selected");
        local v162;

        if Selected then
            v162 = Selected:FindFirstChildWhichIsA("UIScale");
        else
            v162 = Selected;
        end;

        if v162 then
            v162.Scale = 0;
        end;

        if Selected then
            Selected = Selected:FindFirstChild("Item_Name");
        end;

        if Selected then
            Selected.Text = v.DisplayName;
        end;

        local v163 = {
            track = nil,
            frame = v161,
            selectedScale = v162
        };
        local ViewportFrame = v161:FindFirstChild("ViewportFrame");
        local v164 = ViewportFrame and MountCloneInViewport(ViewportFrame);

        if v164 then
            v163.track = PlayCloneAnimation(v164, v.Id);
        end;

        local Selection_Button = v161:FindFirstChild("Selection_Button");

        if Selection_Button and Selection_Button:IsA("GuiButton") then
            Selection_Button.MouseButton1Click:Connect(function() -- Line: 683
                -- upvalues: SelectIndex (ref), i (copy)
                SelectIndex(i, true);
            end);
        end;

        v161.Parent = u24;
        u38[i] = v163;
        table.insert(v160, v161);
    end;

    RevealCascade.play(v160, {
        isCurrent = function() -- Line: 694, Name: isCurrent
            -- upvalues: u6 (ref), u32 (ref), u159 (copy)
            return u6.Visible and u32 == u159;
        end
    });
    task.delay(#v160 * 0.06 + 0.35, function() -- Line: 703
        -- upvalues: u32 (ref), u159 (copy), u6 (ref), SyncEmoteTileAnimations (ref)
        if u32 == u159 and u6.Visible then
            SyncEmoteTileAnimations();
        end;
    end);
end;

local function ClearCosmeticRows() -- Line: 712
    -- upvalues: u39 (copy)
    for _, v in u39 do
        if v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u39);
end;

local function BuildCosmeticRows() -- Line: 720
    -- upvalues: u39 (copy), u27 (ref), u28 (ref), u32 (ref), Color3_new_ret (copy), RarityGradient (copy), SelectIndex (copy), u26 (ref), RevealCascade (copy), u6 (ref)
    for _, v in u39 do
        if v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u39);

    if not (u27 and u28) then
        return;
    end;

    local u165 = u32;
    local v166 = {};

    for i, v in u28.Cosmetics do
        local v167 = u27:Clone();
        v167.Name = v.Id;
        v167.LayoutOrder = i;
        v167.Visible = true;
        local u168 = i;
        local v169 = v;

        for _, v2 in { "Active", "InActive" } do
            local v170 = v167:FindFirstChild(v2);

            if v170 then
                v170 = v170:FindFirstChild("TitleName");
            end;

            if v170 then
                v170.Text = v169.DisplayName .. (v169.Owned and " (Owned)" or "");
                v170.TextColor3 = Color3_new_ret;
                RarityGradient.set(v170, v169.Rarity);
            end;
        end;

        local v171 = u39[u168];

        if v171 then
            local Active = v171:FindFirstChild("Active");
            local InActive = v171:FindFirstChild("InActive");

            if Active then
                Active.Visible = false;
            end;

            if InActive then
                InActive.Visible = true;
            end;
        end;

        v167.MouseButton1Click:Connect(function() -- Line: 747
            -- upvalues: SelectIndex (ref), u168 (copy)
            SelectIndex(u168, true);
        end);
        v167.Parent = u26;
        u39[u168] = v167;
        table.insert(v166, v167);
    end;

    RevealCascade.play(v166, {
        isCurrent = function() -- Line: 757, Name: isCurrent
            -- upvalues: u6 (ref), u32 (ref), u165 (copy)
            return u6.Visible and u32 == u165;
        end
    });
end;

local function PaintTabButtons() -- Line: 766
    -- upvalues: u8 (ref), u9 (ref), u29 (ref)
    local v172 = u8 and u8:FindFirstChild("Text");
    local v173 = u9 and u9:FindFirstChild("Text");

    if v172 then
        v172.TextTransparency = u29 == "Emotes" and 0 or 0.45;
    end;

    if v173 then
        v173.TextTransparency = u29 == "Cosmetics" and 0 or 0.45;
    end;
end;

local function SwitchTab(p174: string) -- Line: 779
    -- upvalues: u29 (ref), u8 (ref), u9 (ref), u23 (ref), u26 (ref), SnapToIndex (copy), u30 (copy), u38 (copy), TweenService (copy), TweenInfo_new_ret2 (copy), TweenInfo_new_ret3 (copy), u39 (copy), u133 (ref)
    u29 = p174;
    local v175 = u8 and u8:FindFirstChild("Text");
    local v176 = u9 and u9:FindFirstChild("Text");

    if v175 then
        v175.TextTransparency = u29 == "Emotes" and 0 or 0.45;
    end;

    if v176 then
        v176.TextTransparency = u29 == "Cosmetics" and 0 or 0.45;
    end;

    if u23 then
        u23.Visible = p174 == "Emotes";
    end;

    if u26 then
        u26.Visible = p174 == "Cosmetics";
    end;

    SnapToIndex(u30[p174]);
    local v177 = u30[p174];

    if u29 == "Emotes" then
        local v178 = u38[v177];

        if v178 and v178.selectedScale then
            TweenService:Create(v178.selectedScale, TweenInfo_new_ret2 or TweenInfo_new_ret3, {
                Scale = 1
            }):Play();
        end;
    else
        local v179 = u39[v177];

        if v179 then
            local Active = v179:FindFirstChild("Active");
            local InActive = v179:FindFirstChild("InActive");

            if Active then
                Active.Visible = true;
            end;

            if InActive then
                InActive.Visible = false;
            end;
        end;
    end;

    u133();
end;

local u180 = nil;

local function UpdateTimerDisplay() -- Line: 796
    -- upvalues: u7 (ref), u40 (ref)
    if not u7 then
        return;
    end;

    local math_floor_ret = math.floor(u40);
    local math_max_ret = math.max(0, math_floor_ret);
    local math_floor_ret2 = math.floor(math_max_ret / 3600);
    local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
    u7.Text = "STOCK ROTATION IN: " .. string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret % 60);
end;

local function StartTimerCountdown() -- Line: 801
    -- upvalues: u41 (ref), u7 (ref), u40 (ref), RunService (copy), u6 (ref), u180 (ref)
    if u41 then
        u41:Disconnect();
        u41 = nil;
    end;

    if u7 then
        local math_floor_ret = math.floor(u40);
        local math_max_ret = math.max(0, math_floor_ret);
        local math_floor_ret2 = math.floor(math_max_ret / 3600);
        local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
        u7.Text = "STOCK ROTATION IN: " .. string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret % 60);
    end;

    u41 = RunService.Heartbeat:Connect(function(p181) -- Line: 809
        -- upvalues: u40 (ref), u7 (ref), u41 (ref), u6 (ref), u180 (ref)
        u40 = u40 - p181;

        if u40 <= 0 then
            u40 = 0;

            if u7 then
                local math_floor_ret = math.floor(u40);
                local math_max_ret = math.max(0, math_floor_ret);
                local math_floor_ret2 = math.floor(math_max_ret / 3600);
                local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
                u7.Text = "STOCK ROTATION IN: " .. string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret % 60);
            end;

            if u41 then
                u41:Disconnect();
                u41 = nil;
            end;

            if u6.Visible then
                u180();
            end;
        else
            if not u7 then
                return;
            end;

            local math_floor_ret = math.floor(u40);
            local math_max_ret = math.max(0, math_floor_ret);
            local math_floor_ret2 = math.floor(math_max_ret / 3600);
            local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
            u7.Text = "STOCK ROTATION IN: " .. string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret % 60);
        end;
    end);
end;

local function RefreshOwnedVisuals() -- Line: 833
    -- upvalues: u28 (ref), u3 (ref), u39 (copy), u38 (copy), u133 (ref)
    if not (u28 and u3) then
        return;
    end;

    local Data = u3.Data;
    local v182 = Data.OwnedCosmetics or {};

    for i, v in u28.Cosmetics do
        local v183 = table.find(v182, v.Id) ~= nil;

        if v183 ~= v.Owned then
            v.Owned = v183;
            local v184 = u39[i];

            if v184 then
                local v185 = v;

                for _, v2 in { "Active", "InActive" } do
                    local v186 = v184:FindFirstChild(v2);

                    if v186 then
                        v186 = v186:FindFirstChild("TitleName");
                    end;

                    if v186 then
                        v186.Text = v185.DisplayName .. (v183 and " (Owned)" or "");
                    end;
                end;
            end;
        end;
    end;

    local v187 = Data.Emotes and Data.Emotes.Owned or {};

    for i, v in u28.Emotes do
        local v188 = v187[v.Id] ~= nil;

        if v188 ~= v.Owned then
            v.Owned = v188;
            local v189 = u38[i];

            if v189 then
                v189 = v189.frame:FindFirstChild("Owned");
            end;

            if v189 then
                v189.Visible = v188;
            end;
        end;
    end;

    u133();
end;

local function TeardownPreviews() -- Line: 873
    -- upvalues: u32 (ref), u13 (copy), ClearCarouselViewport (copy), ClearEmoteTiles (copy), u39 (copy), u41 (ref)
    u32 = u32 + 1;

    for i in u13 do
        ClearCarouselViewport(i);
    end;

    ClearEmoteTiles();

    for _, v in u39 do
        if v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(u39);

    if u41 then
        u41:Disconnect();
        u41 = nil;
    end;
end;

u180 = function() -- Line: 889
    -- upvalues: u4 (ref), u32 (ref), u28 (ref), u40 (ref), TabItems (copy), u30 (copy), u13 (copy), ClearCarouselViewport (copy), BuildEmoteTiles (copy), BuildCosmeticRows (copy), u29 (ref), u8 (ref), u9 (ref), u23 (ref), u26 (ref), SnapToIndex (copy), u38 (copy), TweenService (copy), TweenInfo_new_ret2 (copy), TweenInfo_new_ret3 (copy), u39 (copy), u133 (ref), u41 (ref), u7 (ref), RunService (copy), u6 (ref), u180 (ref)
    if not u4 then
        return;
    end;

    local v190, v191 = u4:GetShopListing():await();

    if not (v190 and v191) then
        warn("[StarsShop] Failed to load shop listing");

        return;
    end;

    u32 = u32 + 1;
    u28 = v191;
    u40 = v191.ResetIn or 0;

    for _, v in { "Emotes", "Cosmetics" } do
        local v192 = #TabItems(v);

        if u30[v] > math.max(1, v192) then
            u30[v] = 1;
        end;
    end;

    for i in u13 do
        ClearCarouselViewport(i);
    end;

    BuildEmoteTiles();
    BuildCosmeticRows();
    local v193 = u29;
    u29 = v193;
    local v194 = u8 and u8:FindFirstChild("Text");
    local v195 = u9 and u9:FindFirstChild("Text");

    if v194 then
        v194.TextTransparency = u29 == "Emotes" and 0 or 0.45;
    end;

    if v195 then
        v195.TextTransparency = u29 == "Cosmetics" and 0 or 0.45;
    end;

    if u23 then
        u23.Visible = v193 == "Emotes";
    end;

    if u26 then
        u26.Visible = v193 == "Cosmetics";
    end;

    SnapToIndex(u30[v193]);
    local v196 = u30[v193];

    if u29 == "Emotes" then
        local v197 = u38[v196];

        if v197 and v197.selectedScale then
            TweenService:Create(v197.selectedScale, TweenInfo_new_ret2 or TweenInfo_new_ret3, {
                Scale = 1
            }):Play();
        end;
    else
        local v198 = u39[v196];

        if v198 then
            local Active = v198:FindFirstChild("Active");
            local InActive = v198:FindFirstChild("InActive");

            if Active then
                Active.Visible = true;
            end;

            if InActive then
                InActive.Visible = false;
            end;
        end;
    end;

    u133();

    if u41 then
        u41:Disconnect();
        u41 = nil;
    end;

    if u7 then
        local math_floor_ret = math.floor(u40);
        local math_max_ret = math.max(0, math_floor_ret);
        local math_floor_ret2 = math.floor(math_max_ret / 3600);
        local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
        u7.Text = "STOCK ROTATION IN: " .. string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret % 60);
    end;

    u41 = RunService.Heartbeat:Connect(function(p199) -- Line: 809
        -- upvalues: u40 (ref), u7 (ref), u41 (ref), u6 (ref), u180 (ref)
        u40 = u40 - p199;

        if u40 <= 0 then
            u40 = 0;

            if u7 then
                local math_floor_ret = math.floor(u40);
                local math_max_ret = math.max(0, math_floor_ret);
                local math_floor_ret2 = math.floor(math_max_ret / 3600);
                local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
                u7.Text = "STOCK ROTATION IN: " .. string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret % 60);
            end;

            if u41 then
                u41:Disconnect();
                u41 = nil;
            end;

            if u6.Visible then
                u180();
            end;
        else
            if not u7 then
                return;
            end;

            local math_floor_ret = math.floor(u40);
            local math_max_ret = math.max(0, math_floor_ret);
            local math_floor_ret2 = math.floor(math_max_ret / 3600);
            local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
            u7.Text = "STOCK ROTATION IN: " .. string.format("%02d:%02d:%02d", math_floor_ret2, math_floor_ret3, math_max_ret % 60);
        end;
    end);
end;

local function OnStarsClicked() -- Line: 923
    -- upvalues: u31 (ref), TabItems (copy), u29 (ref), u30 (copy), u4 (ref), RefreshOwnedVisuals (copy)
    if u31 then
        return;
    end;

    local v200 = TabItems(u29)[u30[u29]];

    if not v200 or v200.Owned then
        return;
    end;

    u31 = true;
    local v201, v202, v203;

    if u29 == "Emotes" then
        v201, v202, v203 = u4:PurchaseEmote(v200.Id):await();
    else
        v201, v202, v203 = u4:PurchaseCosmetic(v200.Id):await();
    end;

    if v201 and v202 then
        v200.Owned = true;
        RefreshOwnedVisuals();
    else
        warn("[StarsShop] Purchase failed:", v203 or "Unknown");
    end;

    u31 = false;
end;

local function OnRobuxClicked() -- Line: 947
    -- upvalues: u31 (ref), TabItems (copy), u29 (ref), u30 (copy), u4 (ref)
    if u31 then
        return;
    end;

    local v204 = TabItems(u29)[u30[u29]];

    if not v204 or v204.Owned then
        return;
    end;

    local v205, v206, v207 = u4:RequestRobuxPurchase(u29 == "Emotes" and "Emote" or "Cosmetic", v204.Id):await();

    if not (v205 and v206) then
        warn("[StarsShop] Robux purchase request failed:", v207 or "Unknown");
    end;
end;

function v1._Init(p208) -- Line: 963
    -- upvalues: u2 (ref), u3 (ref), Registry (copy), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u13 (copy), u33 (ref), u19 (ref), u20 (ref), u21 (ref), u22 (ref), u23 (ref), u24 (ref), u25 (ref), u26 (ref), u27 (ref), u4 (ref), Knit (copy), u5 (ref), u35 (ref), SelectIndex (copy), u30 (copy), u29 (ref), SnapToIndex (copy), u38 (copy), TweenService (copy), TweenInfo_new_ret2 (copy), TweenInfo_new_ret3 (copy), u39 (copy), u133 (ref), OnStarsClicked (copy), OnRobuxClicked (copy), SyncEmoteTileAnimations (copy), u180 (ref), TeardownPreviews (copy), RefreshOwnedVisuals (copy)
    u2 = p208;
    u3 = Registry:Get("PlayerData");
    u6 = u2.Frames:FindFirstChild("Stars_Shop");

    if not u6 then
        warn("[StarsShop] Stars_Shop frame not found");

        return;
    end;

    u7 = u6:FindFirstChild("RotationTimer");
    u8 = u6:FindFirstChild("Emotes");
    u9 = u6:FindFirstChild("Cosmetics");
    u10 = u6:FindFirstChild("Content");

    if not u10 then
        warn("[StarsShop] Stars_Shop.Content not found");

        return;
    end;

    u11 = u10:FindFirstChild("PlayerViewer");

    if u11 then
        u12 = u11:FindFirstChild("CanvasGroup");
        u14 = u11:FindFirstChild("CycleForward");
        u15 = u11:FindFirstChild("CycleBack");
        local Display = u11:FindFirstChild("Display");

        if Display then
            Display = Display:FindFirstChild("SelectionName");
        end;

        u16 = Display;
        local v209 = u14 and u14:FindFirstChild("NextName");
        u17 = v209;
        local v210 = u15 and u15:FindFirstChild("PreviousName");
        u18 = v210;

        if u12 then
            u13[1] = u12:FindFirstChild("Viewport_" .. 1);
            u13[2] = u12:FindFirstChild("Viewport_" .. 2);
            u13[3] = u12:FindFirstChild("Viewport_" .. 3);
            u33 = {
                Main = u12:GetAttribute("Main_Position"),
                Next = u12:GetAttribute("Next_Position"),
                Previous = u12:GetAttribute("Previous_Position")
            };

            if not (u33.Main and (u33.Next and u33.Previous)) then
                warn("[StarsShop] CanvasGroup missing Main/Next/Previous_Position attributes");
            end;
        end;
    end;

    local Buttons = u10:FindFirstChild("Buttons");

    if Buttons then
        u19 = Buttons:FindFirstChild("Stars");
        local v211 = u19 and u19:FindFirstChild("Amount");
        u20 = v211;
        u21 = Buttons:FindFirstChild("Robux");
        local v212 = u21 and u21:FindFirstChild("Amount");
        u22 = v212;
    end;

    u23 = u10:FindFirstChild("EmotesContainer");
    local v213 = u23 and u23:FindFirstChild("Selection");
    u24 = v213;
    u25 = u24 and u24:FindFirstChild("TemplateFrame");

    if u25 then
        u25.Visible = false;
    end;

    u26 = u10:FindFirstChild("CosmeticsList");
    u27 = u26 and u26:FindFirstChild("Template");

    if u27 then
        u27.Visible = false;
    end;

    u4 = Knit.GetService("StarsShopService");
    u5 = Knit.GetService("EmoteService");

    if u14 then
        u14.MouseButton1Click:Connect(function() -- Line: 1037
            -- upvalues: u35 (ref), SelectIndex (ref), u30 (ref), u29 (ref)
            if u35 then
                return;
            end;

            SelectIndex(u30[u29] + 1, true);
        end);
    end;

    if u15 then
        u15.MouseButton1Click:Connect(function() -- Line: 1043
            -- upvalues: u35 (ref), SelectIndex (ref), u30 (ref), u29 (ref)
            if u35 then
                return;
            end;

            SelectIndex(u30[u29] - 1, true);
        end);
    end;

    if u8 then
        u8.MouseButton1Click:Connect(function() -- Line: 1050
            -- upvalues: u29 (ref), u8 (ref), u9 (ref), u23 (ref), u26 (ref), SnapToIndex (ref), u30 (ref), u38 (ref), TweenService (ref), TweenInfo_new_ret2 (ref), TweenInfo_new_ret3 (ref), u39 (ref), u133 (ref)
            if u29 ~= "Emotes" then
                u29 = "Emotes";
                local v214 = u8 and u8:FindFirstChild("Text");
                local v215 = u9 and u9:FindFirstChild("Text");

                if v214 then
                    v214.TextTransparency = u29 == "Emotes" and 0 or 0.45;
                end;

                if v215 then
                    v215.TextTransparency = u29 == "Cosmetics" and 0 or 0.45;
                end;

                if u23 then
                    u23.Visible = true;
                end;

                if u26 then
                    u26.Visible = false;
                end;

                SnapToIndex(u30.Emotes);
                local Emotes = u30.Emotes;

                if u29 == "Emotes" then
                    local v216 = u38[Emotes];

                    if v216 and v216.selectedScale then
                        TweenService:Create(v216.selectedScale, TweenInfo_new_ret2 or TweenInfo_new_ret3, {
                            Scale = 1
                        }):Play();
                    end;
                else
                    local v217 = u39[Emotes];

                    if v217 then
                        local Active = v217:FindFirstChild("Active");
                        local InActive = v217:FindFirstChild("InActive");

                        if Active then
                            Active.Visible = true;
                        end;

                        if InActive then
                            InActive.Visible = false;
                        end;
                    end;
                end;

                u133();
            end;
        end);
    end;

    if u9 then
        u9.MouseButton1Click:Connect(function() -- Line: 1055
            -- upvalues: u29 (ref), u8 (ref), u9 (ref), u23 (ref), u26 (ref), SnapToIndex (ref), u30 (ref), u38 (ref), TweenService (ref), TweenInfo_new_ret2 (ref), TweenInfo_new_ret3 (ref), u39 (ref), u133 (ref)
            if u29 ~= "Cosmetics" then
                u29 = "Cosmetics";
                local v218 = u8 and u8:FindFirstChild("Text");
                local v219 = u9 and u9:FindFirstChild("Text");

                if v218 then
                    v218.TextTransparency = u29 == "Emotes" and 0 or 0.45;
                end;

                if v219 then
                    v219.TextTransparency = u29 == "Cosmetics" and 0 or 0.45;
                end;

                if u23 then
                    u23.Visible = false;
                end;

                if u26 then
                    u26.Visible = true;
                end;

                SnapToIndex(u30.Cosmetics);
                local Cosmetics = u30.Cosmetics;

                if u29 == "Emotes" then
                    local v220 = u38[Cosmetics];

                    if v220 and v220.selectedScale then
                        TweenService:Create(v220.selectedScale, TweenInfo_new_ret2 or TweenInfo_new_ret3, {
                            Scale = 1
                        }):Play();
                    end;
                else
                    local v221 = u39[Cosmetics];

                    if v221 then
                        local Active = v221:FindFirstChild("Active");
                        local InActive = v221:FindFirstChild("InActive");

                        if Active then
                            Active.Visible = true;
                        end;

                        if InActive then
                            InActive.Visible = false;
                        end;
                    end;
                end;

                u133();
            end;
        end);
    end;

    if u19 then
        u19.MouseButton1Click:Connect(OnStarsClicked);
    end;

    if u21 then
        u21.MouseButton1Click:Connect(OnRobuxClicked);
    end;

    if u24 then
        u24:GetPropertyChangedSignal("CanvasPosition"):Connect(SyncEmoteTileAnimations);
    end;

    u6:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1073
        -- upvalues: u6 (ref), u180 (ref), TeardownPreviews (ref)
        if u6.Visible then
            u180();

            return;
        end;

        TeardownPreviews();
    end);
    u3:OnChange(function(p222, p223) -- Line: 1084
        -- upvalues: u6 (ref), RefreshOwnedVisuals (ref)
        if not u6.Visible then
            return;
        end;

        if p223[1] == "OwnedCosmetics" or p223[1] == "Emotes" then
            RefreshOwnedVisuals();
        end;
    end);
    u5.EmoteUnlocked:Connect(function() -- Line: 1092
        -- upvalues: u6 (ref), RefreshOwnedVisuals (ref)
        if u6.Visible then
            RefreshOwnedVisuals();
        end;
    end);

    if u6.Visible then
        u180();
    end;
end;

return v1;