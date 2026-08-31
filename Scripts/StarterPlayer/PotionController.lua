--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PotionController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.PotionController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local PotionData = require(ReplicatedStorage.GameInfo.PotionData);
local Registry = require(script.Parent.Parent.Controllers.Registry);
local Knit = require(ReplicatedStorage.Packages.Knit);
local CooldownOverlay = require(script.Parent.Parent.ClientUtils.CooldownOverlay);
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local Color3_fromRGB_ret = Color3.fromRGB(255, 80, 80);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);
local u4 = nil;

local function GetIBC() -- Line: 55
    -- upvalues: u4 (ref), Knit (copy)
    if u4 then
        return u4;
    end;

    local success, result = pcall(function() -- Line: 57
        -- upvalues: Knit (ref)
        return Knit.GetController("InputBindingController");
    end);

    if success then
        u4 = result;
    end;

    return u4;
end;

local v5 = {};

local function GetPotions() -- Line: 72
    -- upvalues: u2 (ref)
    return u2 and (u2.Data.Potions or {}) or {};
end;

local function GetPotionCount(p6: string) -- Line: 77
    -- upvalues: u2 (ref)
    return (u2 and (u2.Data.Potions or {}) or {})[p6] or 0;
end;

local function FormatAmount(p7: number) -- Line: 82
    return "x" .. tostring(p7);
end;

local u34 = (function(p8: number, p9: string, p10: string) -- Line: 90, Name: CreateSlot
    -- upvalues: u2 (ref), CooldownOverlay (copy), PotionData (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), u3 (ref), Knit (copy), u4 (ref), UserInputService (copy)
    return {
        frame = nil,
        amountLabel = nil,
        imageLabel = nil,
        keyLabel = nil,
        cooldownOverlay = nil,
        cooldownLabel = nil,
        cooldownThread = nil,
        isOnCooldown = false,
        isUsing = false,
        slotIndex = p8,
        equippedField = p9,
        actionName = p10,

        GetEquippedId = function(p11) -- Line: 106, Name: GetEquippedId
            -- upvalues: u2 (ref)
            return u2 and (u2.Data[p11.equippedField] or "") or "";
        end,

        InitCooldown = function(p12) -- Line: 111, Name: InitCooldown
            -- upvalues: CooldownOverlay (ref)
            if p12.cooldownOverlay then
                return;
            end;

            p12.cooldownOverlay = p12.frame:FindFirstChild("Cooldown");

            if p12.cooldownOverlay then
                p12.cooldownLabel = p12.cooldownOverlay:FindFirstChild("TextLabel");
                CooldownOverlay.Reset(p12.cooldownOverlay, p12.cooldownLabel);
            end;
        end,

        StartCooldownVisual = function(u13: table, u14: number) -- Line: 121, Name: StartCooldownVisual
            -- upvalues: CooldownOverlay (ref)
            u13:InitCooldown();

            if not (u13.cooldownOverlay and u13.cooldownLabel) then
                return;
            end;

            if u13.cooldownThread then
                task.cancel(u13.cooldownThread);
                u13.cooldownThread = nil;
            end;

            u13.isOnCooldown = true;
            CooldownOverlay.Show(u13.cooldownOverlay, u13.cooldownLabel);
            u13.cooldownThread = task.spawn(function() -- Line: 133
                -- upvalues: u14 (copy), u13 (copy), CooldownOverlay (ref)
                local v15 = u14;

                while v15 > 0 do
                    u13.cooldownLabel.Text = math.ceil(v15) .. "s";
                    task.wait(0.1);
                    v15 = v15 - 0.1;
                end;

                CooldownOverlay.Hide(u13.cooldownOverlay, u13.cooldownLabel);
                u13.isOnCooldown = false;
                u13.cooldownThread = nil;
            end);
        end,

        Refresh = function(u16) -- Line: 147, Name: Refresh
            -- upvalues: PotionData (ref), Color3_fromRGB_ret (ref), u2 (ref), Color3_fromRGB_ret2 (ref)
            if not u16.imageLabel then
                return;
            end;

            local function setAmount(p17: string, p18) -- Line: 152
                -- upvalues: u16 (copy)
                if u16.amountLabel then
                    u16.amountLabel.Text = p17;
                    u16.amountLabel.TextColor3 = p18;
                end;
            end;

            local EquippedId = u16:GetEquippedId();
            local v19;

            if EquippedId == "" then
                v19 = nil;
            else
                v19 = PotionData.GetPotion(EquippedId) or nil;
            end;

            if not v19 then
                local v20 = Color3_fromRGB_ret;

                if u16.amountLabel then
                    u16.amountLabel.Text = "x0";
                    u16.amountLabel.TextColor3 = v20;
                end;

                u16.imageLabel.ImageTransparency = 0.5;
                u16.imageLabel.Image = "";

                return;
            end;

            local v21 = (u2 and (u2.Data.Potions or {}) or {})[EquippedId] or 0;
            local v22 = "x" .. tostring(v21);
            local v23 = v21 > 0 and Color3_fromRGB_ret2 or Color3_fromRGB_ret;

            if u16.amountLabel then
                u16.amountLabel.Text = v22;
                u16.amountLabel.TextColor3 = v23;
            end;

            u16.imageLabel.Image = v19.Icon;
            u16.imageLabel.ImageTransparency = v21 > 0 and 0 or 0.5;
        end,

        Use = function(u24) -- Line: 175, Name: Use
            -- upvalues: u2 (ref), u3 (ref), Knit (ref)
            if u24.isUsing then
                return;
            end;

            if u24.isOnCooldown then
                return;
            end;

            local EquippedId = u24:GetEquippedId();

            if EquippedId == "" then
                return;
            end;

            if ((u2 and (u2.Data.Potions or {}) or {})[EquippedId] or 0) < 1 then
                return;
            end;

            u24.isUsing = true;
            local v25, v26, v27, v28 = u3:UsePotion(u24.slotIndex):await();

            if v25 and v26 then
                Knit.GetController("SoundController"):Play("PotionUse");
            elseif v27 == "POTION_ON_COOLDOWN" and v28 then
                u24:StartCooldownVisual(v28.Remaining or 1);
            end;

            task.delay(0.1, function() -- Line: 197
                -- upvalues: u24 (copy)
                u24:Refresh();
            end);
            u24.isUsing = false;
        end,

        RefreshKey = function(p29) -- Line: 207, Name: RefreshKey
            -- upvalues: u4 (ref), Knit (ref), UserInputService (ref)
            if not p29.keyLabel then
                return;
            end;

            local v30;

            if u4 then
                v30 = u4;
            else
                local success, result = pcall(function() -- Line: 57
                    -- upvalues: Knit (ref)
                    return Knit.GetController("InputBindingController");
                end);

                if success then
                    u4 = result;
                end;

                v30 = u4;
            end;

            if not v30 then
                p29.keyLabel.Text = "";

                return;
            end;

            local LastInputType = UserInputService:GetLastInputType();
            local Key = v30:GetKey(p29.actionName, ((LastInputType == Enum.UserInputType.Gamepad1 or (LastInputType == Enum.UserInputType.Gamepad2 or LastInputType == Enum.UserInputType.Gamepad3)) and true or LastInputType == Enum.UserInputType.Gamepad4) and "Gamepad" or "Keyboard");
            p29.keyLabel.Text = v30:PrettyKey(Key);
        end,

        Wire = function(u31, p32, p33) -- Line: 227, Name: Wire
            u31.frame = p32:WaitForChild(p33);
            u31.amountLabel = u31.frame:FindFirstChild("Amount");
            u31.imageLabel = u31.frame:FindFirstChild("ItemImage");
            u31.keyLabel = u31.frame:FindFirstChild("Input");
            u31.button = u31.frame;
            u31:InitCooldown();
            u31:RefreshKey();
            u31:Refresh();

            if u31.button then
                u31.button.Activated:Connect(function() -- Line: 244
                    -- upvalues: u31 (copy)
                    u31:Use();
                end);
            end;
        end
    };
end)(1, "EquippedPotion", "Potion_Health");

local function OnInputBegan(p35: userdata, p36: boolean) -- Line: 261
    -- upvalues: u4 (ref), Knit (copy), LocalPlayer (copy), u34 (copy)
    local v37;

    if u4 then
        v37 = u4;
    else
        local success, result = pcall(function() -- Line: 57
            -- upvalues: Knit (ref)
            return Knit.GetController("InputBindingController");
        end);

        if success then
            u4 = result;
        end;

        v37 = u4;
    end;

    if not v37 then
        return;
    end;

    if p36 and (LocalPlayer:GetAttribute("OpenWindow") or not v37:CompletesAnyCombo(p35)) then
        return;
    end;

    if v37:GetActionForInput(p35) == "Potion_Health" then
        u34:Use();
    end;
end;

local function OnPotionUsedSignal(p38: string, p39: userdata) -- Line: 283
    -- upvalues: PotionData (copy), u34 (copy), LocalPlayer (copy)
    local Potion = PotionData.GetPotion(p38);

    if p38 == u34:GetEquippedId() and (p39 and p39.Cooldown) then
        u34:StartCooldownVisual(p39.Cooldown);
    end;

    if Potion then
        local Character = LocalPlayer.Character;
        local v40 = Character and Character:FindFirstChild("HumanoidRootPart");

        if v40 then
            local PotionHealFX = v40:FindFirstChild("PotionHealFX");

            if PotionHealFX and PotionHealFX:IsA("Attachment") then
                for _, child in PotionHealFX:GetChildren() do
                    if child:IsA("ParticleEmitter") then
                        child:Emit(child:GetAttribute("BurstCount") or 10);
                    end;
                end;
            end;
        end;
    end;

    u34:Refresh();
end;

local function OnHoTEndedSignal(p41: string) -- Line: 316
end;

local function OnDataChanged(p42, p43) -- Line: 324
    -- upvalues: u34 (copy)
    if p43[1] == "Potions" or p43[1] == "EquippedPotion" then
        u34:Refresh();
    end;
end;

function v5._Init(p44) -- Line: 334
    -- upvalues: u1 (ref), u2 (ref), Registry (copy), u3 (ref), Knit (copy), u34 (copy), UserInputService (copy), OnInputBegan (copy), OnPotionUsedSignal (copy), OnHoTEndedSignal (copy), OnDataChanged (copy), u4 (ref)
    u1 = p44;
    u2 = Registry:Get("PlayerData");
    u3 = Knit.GetService("PotionService");
    local Bottom = u1.HUD.Actions:FindFirstChild("Bottom");

    if Bottom then
        Bottom = Bottom:FindFirstChild("Actions");
    end;

    if not Bottom then
        warn("[PotionController] HUD.Actions.Bottom.Actions not found — potions unavailable");

        return;
    end;

    u34:Wire(Bottom, "Health");
    UserInputService.InputBegan:Connect(OnInputBegan);
    u3.PotionUsed:Connect(OnPotionUsedSignal);
    u3.HoTEnded:Connect(OnHoTEndedSignal);
    u2:OnChange(OnDataChanged);
    local v45;

    if u4 then
        v45 = u4;
    else
        local success, result = pcall(function() -- Line: 57
            -- upvalues: Knit (ref)
            return Knit.GetController("InputBindingController");
        end);

        if success then
            u4 = result;
        end;

        v45 = u4;
    end;

    if v45 then
        v45:OnBindingsChanged(function(p46) -- Line: 364
            -- upvalues: u34 (ref)
            if p46 == "Potion_Health" then
                u34:RefreshKey();
            end;
        end);
    end;

    UserInputService.LastInputTypeChanged:Connect(function() -- Line: 371
        -- upvalues: u34 (ref)
        u34:RefreshKey();
    end);
    local EquippedId = u34:GetEquippedId();

    if EquippedId ~= "" then
        task.spawn(function() -- Line: 378
            -- upvalues: u3 (ref), EquippedId (copy), u34 (ref)
            local v47, v48 = u3:GetCooldownRemaining(EquippedId):await();

            if v47 and (v48 and v48 > 0) then
                u34:StartCooldownVisual(v48);
            end;
        end);
    end;

    print("[PotionController] Initialized");
end;

return v5;