--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BossLootChestController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.BossLootChestController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local LootChestData = require(ReplicatedStorage.GameInfo.LootChestData);
local RarityColors = require(ReplicatedStorage.SharedDictionaries.RarityColors);
local EquipmentTemplates = require(ReplicatedStorage.GameInfo.EquipmentTemplates);
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local u1 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Chests");
local u2 = LootChestData.CHEST_TIMEOUT or 60;
local Color3_fromRGB_ret = Color3.fromRGB(60, 60, 60);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);
local u3 = {
    Common = 1,
    Uncommon = 1.2,
    Rare = 1.5,
    Epic = 2,
    Legendary = 2.5,
    Mythic = 3,
    Celestial = 3.5
};
local v4 = Knit.CreateController({
    Name = "BossLootChestController"
});
v4._activeChests = {};

local function ResolveEquipmentInfo(p5) -- Line: 81
    -- upvalues: EquipmentTemplates (copy), Image_Data (copy)
    local Id = p5.Id;
    local v6;

    if Id then
        v6 = EquipmentTemplates.GetTemplate(Id);
    else
        v6 = Id;
    end;

    return {
        name = v6 and v6.DisplayName or (Id or "Equipment"),
        icon = Image_Data.Equipment and Image_Data.Equipment[Id] or (v6 and v6.ImageId or nil),
        rarity = p5.Rarity or "Common"
    };
end;

local function PopulateBillboard(p7: userdata, p8: any) -- Line: 95
    -- upvalues: RarityColors (copy)
    local Main = p7:FindFirstChild("Main");

    if not Main then
        return;
    end;

    local ItemName = Main:FindFirstChild("ItemName");
    local ItemImage = Main:FindFirstChild("ItemImage");
    local ItemAmount = Main:FindFirstChild("ItemAmount");
    local Chance = Main:FindFirstChild("Chance");
    local ViewportFrame = Main:FindFirstChild("ViewportFrame");

    if ItemName and ItemName:IsA("TextLabel") then
        ItemName.Text = p8.name;
        local v9 = p8.rarity and RarityColors[p8.rarity];

        if v9 then
            ItemName.TextColor3 = v9.TextColor3;
        end;
    end;

    if ItemAmount then
        ItemAmount.Visible = false;
    end;

    if Chance then
        Chance.Visible = false;
    end;

    if ViewportFrame then
        ViewportFrame.Visible = false;
    end;

    if ItemImage then
        ItemImage.Visible = true;

        if p8.icon then
            ItemImage.Image = p8.icon;
        end;

        ItemImage.ImageColor3 = Color3.new(0, 0, 0);
    end;
end;

local function GetLocalFolder() -- Line: 121
    local _LocalBossLootChests = workspace:FindFirstChild("_LocalBossLootChests");

    if not _LocalBossLootChests then
        _LocalBossLootChests = Instance.new("Folder");
        _LocalBossLootChests.Name = "_LocalBossLootChests";
        _LocalBossLootChests.Parent = workspace;
    end;

    return _LocalBossLootChests;
end;

local function ResolveGroundY(p10: vector) -- Line: 134
    -- upvalues: Players (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.IgnoreWater = true;
    local v11 = {};
    local _LocalBossLootChests = workspace:FindFirstChild("_LocalBossLootChests");

    if _LocalBossLootChests then
        table.insert(v11, _LocalBossLootChests);
    end;

    for _, v in Players:GetPlayers() do
        if v.Character then
            table.insert(v11, v.Character);
        end;
    end;

    local v12 = p10 + Vector3.new(0, 3, 0);

    for i = 1, 6 do
        RaycastParams_new_ret.FilterDescendantsInstances = v11;
        local v13 = workspace:Raycast(v12, Vector3.new(0, -200, 0), RaycastParams_new_ret);

        if not v13 then
            return nil;
        end;

        local v14 = v13.Instance:FindFirstAncestorWhichIsA("Model");

        if not (v14 and v14:FindFirstChildWhichIsA("Humanoid")) then
            return v13.Position.Y;
        end;

        table.insert(v11, v14);
        local _ = i;
    end;

    return nil;
end;

function v4._ClearAll(p15) -- Line: 164
    for _, v in p15._activeChests do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    table.clear(p15._activeChests);
end;

local function FadeAndDestroy(u16: userdata, p17: userdata?) -- Line: 175
    -- upvalues: TweenService (copy)
    if not (u16 and u16.Parent) then
        return;
    end;

    if p17 and p17.Parent then
        TweenService:Create(p17, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end;

    for _, descendant in u16:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Transparency < 1 then
            TweenService:Create(descendant, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;
    end;

    task.delay(0.5, function() -- Line: 193
        -- upvalues: u16 (copy)
        if u16 and u16.Parent then
            u16:Destroy();
        end;
    end);
end;

function v4._RevealChest(p18: table, u19: userdata, p20: any) -- Line: 203
    -- upvalues: SharedUtils (copy), ResolveEquipmentInfo (copy), RarityColors (copy), Color3_fromRGB_ret2 (copy), u3 (copy), Color3_fromRGB_ret (copy), TweenService (copy), PopulateBillboard (copy), FadeAndDestroy (copy)
    if not (u19 and u19.Parent) then
        return;
    end;

    local u21 = u19.PrimaryPart or u19:FindFirstChildWhichIsA("BasePart");

    if u21 then
        SharedUtils.PlaySoundAt(u21, "Boss_Chest_Reveal");
    end;

    local v22 = ResolveEquipmentInfo(p20);
    local v23 = v22.rarity and RarityColors[v22.rarity];
    local u24 = v23 and v23.TextColor3 or Color3_fromRGB_ret2;
    local v25 = u3[v22.rarity] or 1.5;
    local RarityHighlight = u19:FindFirstChild("RarityHighlight");

    if RarityHighlight then
        RarityHighlight.Enabled = false;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3_fromRGB_ret;
    Highlight.OutlineColor = Color3_fromRGB_ret;
    Highlight.FillTransparency = 0.8;
    Highlight.OutlineTransparency = 0.6;
    Highlight.Parent = u19;
    TweenService:Create(Highlight, TweenInfo.new(v25, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        FillTransparency = 0.3,
        OutlineTransparency = 0,
        FillColor = Color3_fromRGB_ret2,
        OutlineColor = u24
    }):Play();
    local u26 = nil;
    local Gui_Attachment = u19:FindFirstChild("Gui_Attachment", true);

    if Gui_Attachment then
        local v27 = Gui_Attachment:FindFirstChildOfClass("BillboardGui");

        if v27 then
            v27.Enabled = true;
            u26 = v27:FindFirstChild("Container");

            if u26 then
                u26.Visible = false;
                PopulateBillboard(u26, v22);
            end;
        end;
    end;

    task.delay(v25, function() -- Line: 250
        -- upvalues: u19 (copy), u21 (copy), SharedUtils (ref), u26 (ref), TweenService (ref), Highlight (copy), Color3_fromRGB_ret2 (ref), u24 (copy)
        if not (u19 and u19.Parent) then
            return;
        end;

        if u21 then
            SharedUtils.PlaySoundAt(u21, "Opening_Chest");
        end;

        local Chest_Effect = u19:FindFirstChild("Chest_Effect");

        if Chest_Effect then
            Chest_Effect:SetAttribute("Fire", not Chest_Effect:GetAttribute("Fire"));
        end;

        if u26 then
            u26.Visible = true;
            local Main = u26:FindFirstChild("Main");

            if Main then
                Main = Main:FindFirstChild("ItemImage");
            end;

            if Main and Main.Visible then
                TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ImageColor3 = Color3.new(1, 1, 1)
                }):Play();
            end;
        end;

        if Highlight.Parent then
            TweenService:Create(Highlight, TweenInfo.new(0.2), {
                FillTransparency = 0,
                FillColor = Color3_fromRGB_ret2
            }):Play();
            task.delay(0.3, function() -- Line: 278
                -- upvalues: Highlight (ref), TweenService (ref), u24 (ref)
                if Highlight.Parent then
                    TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        FillTransparency = 0.5,
                        FillColor = u24,
                        OutlineColor = u24
                    }):Play();
                end;
            end);
        end;
    end);
    task.delay(v25 + 4, function() -- Line: 291
        -- upvalues: FadeAndDestroy (ref), u19 (copy), Highlight (copy)
        FadeAndDestroy(u19, Highlight);
    end);
end;

local function AddRarityOutline(p28: userdata, p29: string?) -- Line: 297
    -- upvalues: RarityColors (copy)
    if p29 then
        p29 = RarityColors[p29];
    end;

    if p29 then
        p29 = p29.TextColor3;
    end;

    if not p29 then
        return;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.Name = "RarityHighlight";
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 0;
    Highlight.OutlineColor = p29;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p28;
end;

function v4._SpawnChest(u30: table, u31: any, p32: vector, p33: number) -- Line: 312
    -- upvalues: u1 (copy), LootChestData (copy), ResolveGroundY (copy), RarityColors (copy), TweenService (copy), Players (copy), u2 (copy)
    if not u1 then
        return;
    end;

    local v34 = u31.Rarity or "Common";
    local v35 = LootChestData.RARITY_TO_MODEL[v34] or "Common_Chest";
    local v36 = u1:FindFirstChild(v35);

    if not v36 then
        warn((`[BossLootChestController] Chest model "{v35}" not found for rarity {v34}`));

        return;
    end;

    local u37 = v36:Clone();
    u37.Name = "BossLootChest_" .. v34;
    u37:ScaleTo(u37:GetScale() * 2);
    local v38 = u37.PrimaryPart or u37:FindFirstChildWhichIsA("BasePart");

    for _, descendant in u37:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.Anchored = descendant == v38;
        end;
    end;

    local Owner_Attachment = u37:FindFirstChild("Owner_Attachment", true);
    local v39 = Owner_Attachment and Owner_Attachment:FindFirstChildOfClass("BillboardGui");

    if v39 then
        v39.Enabled = false;
    end;

    local Gui_Attachment = u37:FindFirstChild("Gui_Attachment", true);
    local v40 = Gui_Attachment and Gui_Attachment:FindFirstChildOfClass("BillboardGui");

    if v40 then
        v40.Enabled = true;
        local Container = v40:FindFirstChild("Container");

        if Container then
            Container.Visible = false;
        end;
    end;

    local v41 = ResolveGroundY(p32);

    if v41 then
        p32 = Vector3.new(p32.X, v41, p32.Z);
    end;

    u37:PivotTo(CFrame.new(p32 + Vector3.new(0, 8, 0)));
    local _LocalBossLootChests = workspace:FindFirstChild("_LocalBossLootChests");

    if not _LocalBossLootChests then
        _LocalBossLootChests = Instance.new("Folder");
        _LocalBossLootChests.Name = "_LocalBossLootChests";
        _LocalBossLootChests.Parent = workspace;
    end;

    u37.Parent = _LocalBossLootChests;
    local v42;

    if v34 then
        v42 = RarityColors[v34];
    end;

    if v42 then
        v42 = v42.TextColor3;
    end;

    if v42 then
        local Highlight = Instance.new("Highlight");
        Highlight.Name = "RarityHighlight";
        Highlight.FillTransparency = 1;
        Highlight.OutlineTransparency = 0;
        Highlight.OutlineColor = v42;
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.Parent = u37;
    end;

    if v38 then
        local v43 = p32 + Vector3.new(0, v38.Size.Y / 2, 0);
        local v44 = v38.CFrame - v38.CFrame.Position;
        local u45 = TweenService:Create(v38, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            CFrame = CFrame.new(v43) * v44
        });
        task.delay(p33, function() -- Line: 380
            -- upvalues: u37 (copy), u45 (copy)
            if u37.Parent then
                u45:Play();
            end;
        end);
    end;

    local u46 = u37:FindFirstChild("ChestPrompt", true) or u37:FindFirstChildWhichIsA("ProximityPrompt", true);

    if not u46 then
        u46 = Instance.new("ProximityPrompt");
        u46.Name = "ChestPrompt";
        u46.Parent = v38 or u37;
    end;

    u46.Style = Enum.ProximityPromptStyle.Default;
    u46.ActionText = "Open";
    u46.ObjectText = `{v34} Chest`;
    u46.HoldDuration = 0;
    u46.RequiresLineOfSight = false;
    u46.MaxActivationDistance = 10;
    u46.Enabled = true;
    local u47 = false;
    u46.Triggered:Connect(function(p48) -- Line: 402
        -- upvalues: Players (ref), u47 (ref), u46 (ref), u30 (copy), u37 (copy), u31 (copy)
        if p48 ~= Players.LocalPlayer then
            return;
        end;

        if u47 then
            return;
        end;

        u47 = true;
        u46.Enabled = false;
        u30:_RevealChest(u37, u31);
        local table_find_ret = table.find(u30._activeChests, u37);

        if table_find_ret then
            table.remove(u30._activeChests, table_find_ret);
        end;
    end);
    table.insert(u30._activeChests, u37);
    task.delay(u2, function() -- Line: 419
        -- upvalues: u37 (copy), u30 (copy)
        if u37 and u37.Parent then
            local table_find_ret = table.find(u30._activeChests, u37);

            if table_find_ret then
                table.remove(u30._activeChests, table_find_ret);
            end;

            u37:Destroy();
        end;
    end);
end;

function v4._DropChests(p49: table, p50: vector, p51: any) -- Line: 429
    p49:_ClearAll();
    local v52 = #p51;

    if v52 == 0 then
        return;
    end;

    for i, v in p51 do
        local v53;

        if v52 > 1 then
            local v54 = (i - 1) * (6.283185307179586 / v52);
            local v55 = math.cos(v54) * 6;
            local v56 = math.sin(v54) * 6;
            v53 = p50 + Vector3.new(v55, 0, v56);
        else
            v53 = p50;
        end;

        p49:_SpawnChest(v, v53, (i - 1) * 0.1);
    end;
end;

function v4.KnitStart(u57) -- Line: 455
    -- upvalues: Knit (copy)
    Knit.GetService("DungeonRunService").DungeonComplete:Connect(function() -- Line: 459
        -- upvalues: u57 (copy)
        u57:_ClearAll();
    end);
end;

return v4;