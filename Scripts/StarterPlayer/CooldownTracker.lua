--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CooldownTracker
  Path:     game.StarterPlayer.StarterPlayerScripts.CooldownTracker_Init.CooldownTracker
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local Linear = Enum.EasingStyle.Linear;
local u1 = {
    Dodge = {
        activeAttr = "Dodge_Cooldown_Active",
        durationAttr = "Dodge_Cooldown_Duration",
        displayName = "Dodge"
    },
    Parry = {
        activeAttr = "Parry_Cooldown_Active",
        durationAttr = "Parry_Cooldown_Duration",
        displayName = "Parry"
    }
};
local u2 = { 1, 2, 3, 4 };
local v3 = {};
local u4 = nil;
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};

local function clearConnections() -- Line: 77
    -- upvalues: u5 (copy), u6 (copy), u7 (copy), u8 (copy)
    for _, v in u5 do
        v:Disconnect();
    end;

    table.clear(u5);

    for _, v in u6 do
        v:Cancel();
    end;

    table.clear(u6);

    for _, v in u7 do
        v:Cancel();
    end;

    table.clear(u7);

    for _, v in u8 do
        task.cancel(v);
    end;

    table.clear(u8);
end;

local function getCanvas(p9) -- Line: 99
    -- upvalues: u4 (ref)
    if u4 then
        return u4:FindFirstChild(p9 .. "_Canvas");
    end;

    return nil;
end;

local function getBarColor(p10) -- Line: 104
    -- upvalues: u4 (ref)
    local v11;

    if u4 then
        v11 = u4:FindFirstChild(p10 .. "_Canvas");
    else
        v11 = nil;
    end;

    if not v11 then
        return nil;
    end;

    local v12 = v11:FindFirstChild(p10 .. "_CD");

    if v12 then
        return v12:FindFirstChild("Bar_Color");
    end;

    return nil;
end;

local function getTimeLabel(p13) -- Line: 112
    -- upvalues: u4 (ref)
    local v14;

    if u4 then
        v14 = u4:FindFirstChild(p13 .. "_Canvas");
    else
        v14 = nil;
    end;

    if not v14 then
        return nil;
    end;

    local v15 = v14:FindFirstChild(p13 .. "_CD");

    if v15 then
        return v15:FindFirstChild("Time_Left");
    end;

    return nil;
end;

local function fadeCanvas(p16, p17, p18) -- Line: 121
    -- upvalues: u4 (ref), u7 (copy), TweenService (copy)
    local v19;

    if u4 then
        v19 = u4:FindFirstChild(p16 .. "_Canvas");
    else
        v19 = nil;
    end;

    if not v19 then
        return;
    end;

    if u7[p16] then
        u7[p16]:Cancel();
    end;

    local v20 = TweenService:Create(v19, TweenInfo.new(p18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        GroupTransparency = p17
    });
    u7[p16] = v20;
    v20:Play();
end;

local function startCooldownUI(p21, u22) -- Line: 141
    -- upvalues: u1 (copy), u4 (ref), u8 (copy), u6 (copy), fadeCanvas (copy), TweenService (copy), Linear (copy), u5 (copy), RunService (copy)
    local u23 = u1[p21];

    if not u23 then
        return;
    end;

    local v24;

    if u4 then
        v24 = u4:FindFirstChild(p21 .. "_Canvas");
    else
        v24 = nil;
    end;

    local v25;

    if v24 then
        local v26 = v24:FindFirstChild(p21 .. "_CD");

        if v26 then
            v25 = v26:FindFirstChild("Bar_Color");
        else
            v25 = nil;
        end;
    else
        v25 = nil;
    end;

    local v27;

    if u4 then
        v27 = u4:FindFirstChild(p21 .. "_Canvas");
    else
        v27 = nil;
    end;

    local u28;

    if v27 then
        local v29 = v27:FindFirstChild(p21 .. "_CD");

        if v29 then
            u28 = v29:FindFirstChild("Time_Left");
        else
            u28 = nil;
        end;
    else
        u28 = nil;
    end;

    if not (v25 and u28) then
        return;
    end;

    local v30;

    if u4 then
        v30 = u4:FindFirstChild(p21 .. "_Canvas");
    else
        v30 = nil;
    end;

    local v31 = v30 and v30:FindFirstChild("Highlight_Frame");

    if v31 then
        v31.Visible = false;
    end;

    if u8[p21] then
        task.cancel(u8[p21]);
        u8[p21] = nil;
    end;

    if u6[p21] then
        u6[p21]:Cancel();
    end;

    v25.Size = UDim2.new(0, 0, 1, 0);
    fadeCanvas(p21, 0, 0.15);
    local v32 = TweenService:Create(v25, TweenInfo.new(u22, Linear), {
        Size = UDim2.new(1, 0, 1, 0)
    });
    u6[p21] = v32;
    v32:Play();
    local u33 = tick();
    local v34 = p21 .. "_heartbeat";

    if u5[v34] then
        u5[v34]:Disconnect();
    end;

    u5[v34] = RunService.Heartbeat:Connect(function() -- Line: 192
        -- upvalues: u33 (copy), u22 (copy), u28 (copy), u23 (copy)
        local v35 = u22 - (tick() - u33);
        local math_max_ret = math.max(0, v35);

        if math_max_ret > 0 then
            if math_max_ret >= 1 then
                u28.Text = string.format("%s: %.1fs", u23.displayName, math_max_ret);

                return;
            end;

            u28.Text = string.format("%s: %.1fs", u23.displayName, math_max_ret);
        end;
    end);
end;

local function endCooldownUI(u36) -- Line: 207
    -- upvalues: u1 (copy), u4 (ref), u5 (copy), u6 (copy), TweenService (copy), u8 (copy), LocalPlayer (copy), fadeCanvas (copy)
    local u37 = u1[u36];

    if not u37 then
        return;
    end;

    local v38;

    if u4 then
        v38 = u4:FindFirstChild(u36 .. "_Canvas");
    else
        v38 = nil;
    end;

    local v39;

    if v38 then
        local v40 = v38:FindFirstChild(u36 .. "_CD");

        if v40 then
            v39 = v40:FindFirstChild("Time_Left");
        else
            v39 = nil;
        end;
    else
        v39 = nil;
    end;

    local v41;

    if u4 then
        v41 = u4:FindFirstChild(u36 .. "_Canvas");
    else
        v41 = nil;
    end;

    local v42;

    if v41 then
        local v43 = v41:FindFirstChild(u36 .. "_CD");

        if v43 then
            v42 = v43:FindFirstChild("Bar_Color");
        else
            v42 = nil;
        end;
    else
        v42 = nil;
    end;

    local v44;

    if u4 then
        v44 = u4:FindFirstChild(u36 .. "_Canvas");
    else
        v44 = nil;
    end;

    local v45 = u36 .. "_heartbeat";

    if u5[v45] then
        u5[v45]:Disconnect();
        u5[v45] = nil;
    end;

    if v42 then
        if u6[u36] then
            u6[u36]:Cancel();
        end;

        v42.Size = UDim2.new(1, 0, 1, 0);
    end;

    if v39 then
        v39.Text = u37.displayName .. " Ready!";
    end;

    if v44 then
        local Highlight_Frame = v44:FindFirstChild("Highlight_Frame");
        local u46 = Highlight_Frame and Highlight_Frame:FindFirstChildWhichIsA("UIGradient");

        if u46 then
            Highlight_Frame.BackgroundTransparency = 0;
            Highlight_Frame.Visible = true;
            u46.Enabled = true;
            u46.Offset = Vector2.new(-1, 0);
            local v47 = u36 .. "_shine";

            if u6[v47] then
                u6[v47]:Cancel();
            end;

            local v48 = TweenService:Create(u46, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Offset = Vector2.new(1, 0)
            });
            u6[v47] = v48;
            v48:Play();
            v48.Completed:Once(function() -- Line: 261
                -- upvalues: u46 (copy), Highlight_Frame (copy)
                u46.Enabled = false;
                Highlight_Frame.BackgroundTransparency = 1;
            end);
        end;
    end;

    if u8[u36] then
        task.cancel(u8[u36]);
    end;

    u8[u36] = task.delay(1.2, function() -- Line: 275
        -- upvalues: u8 (ref), u36 (copy), LocalPlayer (ref), u37 (copy), fadeCanvas (ref)
        u8[u36] = nil;

        if not LocalPlayer:GetAttribute(u37.activeAttr) then
            fadeCanvas(u36, 1, 0.4);
        end;
    end);
end;

local function setupForCharacter(p49) -- Line: 285
    -- upvalues: clearConnections (copy), u4 (ref), ReplicatedStorage (copy), LocalPlayer (copy), u1 (copy), u5 (copy), startCooldownUI (copy), endCooldownUI (copy), u2 (copy), fadeCanvas (copy)
    clearConnections();

    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    local HumanoidRootPart = p49:WaitForChild("HumanoidRootPart", 10);

    if not HumanoidRootPart then
        return;
    end;

    local Skill_Gui = ReplicatedStorage.Assets.UI:FindFirstChild("Skill_Gui");

    if not Skill_Gui then
        warn("[CooldownTracker] Skill_Gui template not found in ReplicatedStorage.Assets.UI");

        return;
    end;

    u4 = Skill_Gui:Clone();
    u4.Adornee = HumanoidRootPart;
    u4.Parent = LocalPlayer.PlayerGui;

    for i, _ in u1 do
        local v50;

        if u4 then
            v50 = u4:FindFirstChild(i .. "_Canvas");
        else
            v50 = nil;
        end;

        if v50 then
            v50.GroupTransparency = 1;
        end;
    end;

    for i, v in u1 do
        u5[i .. "_attr"] = LocalPlayer:GetAttributeChangedSignal(v.activeAttr):Connect(function() -- Line: 319
            -- upvalues: LocalPlayer (ref), v (copy), startCooldownUI (ref), i (copy), endCooldownUI (ref)
            local Attribute = LocalPlayer:GetAttribute(v.activeAttr);
            local v51 = LocalPlayer:GetAttribute(v.durationAttr) or 1;

            if Attribute then
                startCooldownUI(i, v51);

                return;
            end;

            endCooldownUI(i);
        end);

        if LocalPlayer:GetAttribute(v.activeAttr) then
            startCooldownUI(i, LocalPlayer:GetAttribute(v.durationAttr) or 1);
        end;
    end;

    for _, v in u2 do
        local v52 = "Skill" .. v;
        local u53 = v52 .. "_OnCooldown";
        local u54 = v52 .. "_CooldownDuration";
        u5["Skill_slot" .. v .. "_attr"] = LocalPlayer:GetAttributeChangedSignal(u53):Connect(function() -- Line: 346
            -- upvalues: LocalPlayer (ref), u53 (copy), u54 (copy), startCooldownUI (ref), u2 (ref), endCooldownUI (ref)
            local Attribute = LocalPlayer:GetAttribute(u53);
            local v55 = LocalPlayer:GetAttribute(u54) or 1;

            if Attribute then
                startCooldownUI("Skill", v55);

                return;
            end;

            local v56 = false;

            for _, v2 in u2 do
                if LocalPlayer:GetAttribute("Skill" .. v2 .. "_OnCooldown") then
                    v56 = true;
                    break;
                end;
            end;

            if not v56 then
                endCooldownUI("Skill");
            end;
        end);

        if LocalPlayer:GetAttribute(u53) then
            startCooldownUI("Skill", LocalPlayer:GetAttribute(u54) or 1);
        end;
    end;

    local Block_Canvas = u4:FindFirstChild("Block_Canvas");

    if Block_Canvas then
        Block_Canvas.GroupTransparency = 1;

        local function getBlockBar() -- Line: 386
            -- upvalues: Block_Canvas (copy)
            local Block_Background = Block_Canvas:FindFirstChild("Block_Background");

            if Block_Background then
                return Block_Background:FindFirstChild("Bar_Color"), Block_Background:FindFirstChild("Health");
            end;

            return nil, nil;
        end;

        local function updateBlockHealthUI() -- Line: 392
            -- upvalues: Block_Canvas (copy), LocalPlayer (ref)
            local Block_Background = Block_Canvas:FindFirstChild("Block_Background");
            local v57, v58;

            if Block_Background then
                v57 = Block_Background:FindFirstChild("Bar_Color");
                v58 = Block_Background:FindFirstChild("Health");
            else
                v57 = nil;
                v58 = nil;
            end;

            if not (v57 and v58) then
                return;
            end;

            local v59 = LocalPlayer:GetAttribute("Block_Health") or 0;
            local v60 = LocalPlayer:GetAttribute("Block_MaxHealth") or 1;
            local v61 = v59 / math.max(v60, 1);
            local math_clamp_ret = math.clamp(v61, 0, 1);
            v57.Size = UDim2.new(math_clamp_ret, 0, 1, 0);
            v58.Text = string.format("%d / %d", v59, v60);
        end;

        local function onBlockActiveChanged() -- Line: 404
            -- upvalues: LocalPlayer (ref), fadeCanvas (ref), updateBlockHealthUI (copy)
            if not LocalPlayer:GetAttribute("Block_Active") then
                fadeCanvas("Block", 1, 0.4);

                return;
            end;

            fadeCanvas("Block", 0, 0.15);
            updateBlockHealthUI();
        end;

        u5.Block_Active_attr = LocalPlayer:GetAttributeChangedSignal("Block_Active"):Connect(onBlockActiveChanged);
        u5.Block_Health_attr = LocalPlayer:GetAttributeChangedSignal("Block_Health"):Connect(updateBlockHealthUI);

        if LocalPlayer:GetAttribute("Block_Active") then
            if LocalPlayer:GetAttribute("Block_Active") then
                fadeCanvas("Block", 0, 0.15);
                updateBlockHealthUI();

                return;
            end;

            fadeCanvas("Block", 1, 0.4);
        end;
    end;
end;

function v3.Init() -- Line: 430
    -- upvalues: LocalPlayer (copy), setupForCharacter (copy)
    if LocalPlayer.Character then
        task.spawn(setupForCharacter, LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(function(p62) -- Line: 435
        -- upvalues: setupForCharacter (ref)
        setupForCharacter(p62);
    end);
end;

return v3;