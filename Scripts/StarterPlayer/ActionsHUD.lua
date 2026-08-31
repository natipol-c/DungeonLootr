--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ActionsHUD
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.ActionsHUD
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:13 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local Class_Data = require(ReplicatedStorage.Classes.Class_Data);
local Image_Data = require(ReplicatedStorage.GameInfo.Image_Data);
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"));
local CooldownOverlay = require(script.Parent.Parent.ClientUtils.CooldownOverlay);
local Skill = ReplicatedStorage:WaitForChild("Player").Remotes.Inputs.Skill;
local u1 = nil;

local function GetIBC() -- Line: 43
    -- upvalues: u1 (ref), Knit (copy)
    if u1 then
        return u1;
    end;

    local success, result = pcall(function() -- Line: 45
        -- upvalues: Knit (ref)
        return Knit.GetController("InputBindingController");
    end);

    if success then
        u1 = result;
    end;

    return u1;
end;

local v2 = {};
local u3 = { 1, 2, 3, 4 };
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = nil;
local u8 = nil;

local function clearConnections() -- Line: 70
    -- upvalues: u7 (ref), u8 (ref), u6 (copy), u5 (copy)
    if u7 then
        u7:Disconnect();
        u7 = nil;
    end;

    if u8 then
        u8();
        u8 = nil;
    end;

    for _, v in u6 do
        v:Disconnect();
    end;

    table.clear(u6);
    table.clear(u5);
end;

local function refreshKeyLabel(p9) -- Line: 89
    -- upvalues: u4 (copy), u1 (ref), Knit (copy), UserInputService (copy)
    local v10 = u4[p9];

    if not (v10 and v10.keyLabel) then
        return;
    end;

    local v11;

    if u1 then
        v11 = u1;
    else
        local success, result = pcall(function() -- Line: 45
            -- upvalues: Knit (ref)
            return Knit.GetController("InputBindingController");
        end);

        if success then
            u1 = result;
        end;

        v11 = u1;
    end;

    if not v11 then
        v10.keyLabel.Text = "";

        return;
    end;

    local LastInputType = UserInputService:GetLastInputType();
    local Key = v11:GetKey("Skill" .. p9, ((LastInputType == Enum.UserInputType.Gamepad1 or (LastInputType == Enum.UserInputType.Gamepad2 or LastInputType == Enum.UserInputType.Gamepad3)) and true or LastInputType == Enum.UserInputType.Gamepad4) and "Gamepad" or "Keyboard");
    v10.keyLabel.Text = v11:PrettyKey(Key);
end;

local function refreshAllKeyLabels() -- Line: 111
    -- upvalues: u3 (copy), refreshKeyLabel (copy)
    for _, v in u3 do
        refreshKeyLabel(v);
    end;
end;

local function refreshSkillNames() -- Line: 120
    -- upvalues: LocalPlayer (copy), Class_Data (copy), u3 (copy), u4 (copy), Image_Data (copy)
    local Attribute = LocalPlayer:GetAttribute("Active_Class");

    if not Attribute then
        return;
    end;

    local v12 = Class_Data.Get(Attribute);

    if not v12 then
        return;
    end;

    for _, v in u3 do
        local v13 = u4[v];

        if v13 then
            local SkillImage = Image_Data.GetSkillImage(Attribute, v);

            if v13.skillImage then
                v13.skillImage.Image = SkillImage or "";
                v13.skillImage.Visible = SkillImage ~= nil;
            end;

            if v13.skillName then
                v13.skillName.Text = v12.Skills and (v12.Skills[v] or "") or "";
                v13.skillName.Visible = SkillImage == nil;
            end;
        end;
    end;
end;

local function refreshCharges() -- Line: 148
    -- upvalues: u3 (copy), u4 (copy), LocalPlayer (copy)
    for _, v in u3 do
        local v14 = u4[v];

        if v14 and v14.charge then
            local Attribute = LocalPlayer:GetAttribute("Skill" .. v .. "_Charges");
            local Attribute2 = LocalPlayer:GetAttribute("Skill" .. v .. "_MaxCharges");

            if Attribute and (Attribute2 and Attribute2 > 1) then
                v14.charge.Text = "x" .. Attribute;
            else
                v14.charge.Text = "";
            end;
        end;
    end;
end;

local function startCooldown(p15, p16) -- Line: 164
    -- upvalues: u4 (copy), u5 (copy), CooldownOverlay (copy)
    local v17 = u4[p15];

    if not v17 then
        return;
    end;

    u5[p15] = {
        startTime = tick(),
        duration = p16
    };

    if v17.cooldownTime then
        v17.cooldownTime.Text = math.ceil(p16) .. "s";
    end;

    CooldownOverlay.Show(v17.cooldownFrame, v17.cooldownTime);
end;

local function endCooldown(p18) -- Line: 177
    -- upvalues: u4 (copy), u5 (copy), CooldownOverlay (copy)
    local v19 = u4[p18];

    if not v19 then
        return;
    end;

    u5[p18] = nil;
    CooldownOverlay.Hide(v19.cooldownFrame, v19.cooldownTime);
end;

function v2._Init(p20) -- Line: 188
    -- upvalues: clearConnections (copy), u4 (copy), u3 (copy), CooldownOverlay (copy), refreshSkillNames (copy), refreshCharges (copy), refreshKeyLabel (copy), u6 (copy), LocalPlayer (copy), u1 (ref), Knit (copy), u8 (ref), UserInputService (copy), refreshAllKeyLabels (copy), startCooldown (copy), u5 (copy), u7 (ref), RunService (copy), Skill (copy)
    clearConnections();
    table.clear(u4);
    local HUD = p20:FindFirstChild("HUD");

    if not HUD then
        return;
    end;

    local Actions = HUD:FindFirstChild("Actions");

    if not Actions then
        return;
    end;

    local Bottom = Actions:FindFirstChild("Bottom");

    if Bottom then
        Bottom = Bottom:FindFirstChild("Actions");
    end;

    if not Bottom then
        return;
    end;

    for _, v in u3 do
        local v21 = Bottom:FindFirstChild((tostring(v)));

        if v21 then
            local Cooldown = v21:FindFirstChild("Cooldown");
            local v22;

            if Cooldown then
                v22 = Cooldown:FindFirstChild("TextLabel");
            else
                v22 = Cooldown;
            end;

            u4[v] = {
                frame = v21,
                cooldownFrame = Cooldown,
                cooldownTime = v22,
                skillName = v21:FindFirstChild("SkillName"),
                skillImage = v21:FindFirstChild("SkillImage"),
                keyLabel = v21:FindFirstChild("Input"),
                charge = v21:FindFirstChild("Charge"),
                button = v21
            };
            CooldownOverlay.Reset(Cooldown, v22);
        end;
    end;

    refreshSkillNames();
    refreshCharges();

    for _, v in u3 do
        refreshKeyLabel(v);
    end;

    u6.ClassChange = LocalPlayer:GetAttributeChangedSignal("Active_Class"):Connect(function() -- Line: 234
        -- upvalues: refreshSkillNames (ref), refreshCharges (ref)
        refreshSkillNames();
        refreshCharges();
    end);
    local v23;

    if u1 then
        v23 = u1;
    else
        local success, result = pcall(function() -- Line: 45
            -- upvalues: Knit (ref)
            return Knit.GetController("InputBindingController");
        end);

        if success then
            u1 = result;
        end;

        v23 = u1;
    end;

    if v23 then
        u8 = v23:OnBindingsChanged(function(p24) -- Line: 243
            -- upvalues: refreshKeyLabel (ref)
            local v25 = p24:match("^Skill(%d)$");

            if v25 then
                refreshKeyLabel((tonumber(v25)));
            end;
        end);
    end;

    u6.InputType = UserInputService.LastInputTypeChanged:Connect(refreshAllKeyLabels);

    for _, v in u3 do
        local v26 = "Skill" .. v;
        local u27 = v26 .. "_OnCooldown";
        local u28 = v26 .. "_CooldownDuration";
        local u29 = v26 .. "_CooldownRemaining";

        local function beginFromAttrs() -- Line: 266
            -- upvalues: LocalPlayer (ref), u29 (copy), u28 (copy), startCooldown (ref), v (copy)
            startCooldown(v, LocalPlayer:GetAttribute(u29) or LocalPlayer:GetAttribute(u28) or 5);
        end;

        u6["CD_" .. v] = LocalPlayer:GetAttributeChangedSignal(u27):Connect(function() -- Line: 272
            -- upvalues: LocalPlayer (ref), u27 (copy), u29 (copy), u28 (copy), startCooldown (ref), v (copy), u4 (ref), u5 (ref), CooldownOverlay (ref)
            if LocalPlayer:GetAttribute(u27) then
                startCooldown(v, LocalPlayer:GetAttribute(u29) or LocalPlayer:GetAttribute(u28) or 5);

                return;
            end;

            local v30 = v;
            local v31 = u4[v30];

            if not v31 then
                return;
            end;

            u5[v30] = nil;
            CooldownOverlay.Hide(v31.cooldownFrame, v31.cooldownTime);
        end);
        u6["CDRem_" .. v] = LocalPlayer:GetAttributeChangedSignal(u29):Connect(function() -- Line: 282
            -- upvalues: LocalPlayer (ref), u27 (copy), u29 (copy), u28 (copy), startCooldown (ref), v (copy)
            if LocalPlayer:GetAttribute(u27) and (LocalPlayer:GetAttribute(u29) or 0) > 0 then
                startCooldown(v, LocalPlayer:GetAttribute(u29) or LocalPlayer:GetAttribute(u28) or 5);
            end;
        end);
        u6["Charge_" .. v] = LocalPlayer:GetAttributeChangedSignal(v26 .. "_Charges"):Connect(refreshCharges);

        if LocalPlayer:GetAttribute(u27) then
            startCooldown(v, LocalPlayer:GetAttribute(u29) or (LocalPlayer:GetAttribute(u28) or 5));
        end;
    end;

    u7 = RunService.Heartbeat:Connect(function() -- Line: 298
        -- upvalues: u5 (ref), u4 (ref)
        for i, v in u5 do
            local v32 = u4[i];

            if v32 and v32.cooldownTime then
                local v33 = v.duration - (tick() - v.startTime);
                local math_max_ret = math.max(0, v33);

                if math_max_ret > 0 then
                    v32.cooldownTime.Text = math.ceil(math_max_ret) .. "s";
                end;
            end;
        end;
    end);

    for _, v in u3 do
        local v34 = u4[v];

        if v34 and v34.button then
            local u35 = "Skill" .. v;
            u6["Btn_" .. v] = v34.button.Activated:Connect(function() -- Line: 315
                -- upvalues: LocalPlayer (ref), u35 (copy), Skill (ref), v (copy)
                if LocalPlayer:GetAttribute("Dead") then
                    return;
                end;

                if not LocalPlayer:GetAttribute("Weapon_Equipped") then
                    return;
                end;

                local Attribute = LocalPlayer:GetAttribute(u35 .. "_Charges");
                local Attribute2 = LocalPlayer:GetAttribute(u35 .. "_MaxCharges");

                if Attribute and (Attribute2 and Attribute2 > 1) then
                    if Attribute <= 0 then
                        return;
                    end;
                elseif LocalPlayer:GetAttribute(u35 .. "_OnCooldown") then
                    return;
                end;

                Skill:FireServer(v, "tap");
            end);
        end;
    end;
end;

return v2;