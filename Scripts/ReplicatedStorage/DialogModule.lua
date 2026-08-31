--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DialogModule
  Path:     game.ReplicatedStorage.DialogModule
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:20 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local CollectionService = game:GetService("CollectionService");
local tick = script.sounds.tick;
local tick2 = script.sounds.tick2;
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");

local function getDialogResponsesUI() -- Line: 16
    -- upvalues: PlayerGui (copy)
    local dialogResponses = PlayerGui:WaitForChild("dialog"):WaitForChild("dialogResponses");

    if not dialogResponses:FindFirstChild("1") then
        local template = dialogResponses:WaitForChild("template", 10);

        if template then
            for i = 1, 9 do
                local v2 = template:Clone();
                v2.Parent = dialogResponses;
                v2.Name = i;
                local _ = i;
            end;

            template:Destroy();
        end;
    end;

    return dialogResponses;
end;

getDialogResponsesUI();

function u1.new(p3, p4, p5, p6) -- Line: 36
    -- upvalues: u1 (copy), getDialogResponsesUI (copy), TweenService (copy), RunService (copy)
    local u7 = setmetatable({}, u1);
    u7.npcName = p3;
    u7.npc = p4;
    u7.dialogs = {};
    u7.responses = {};
    u7.dialogOption = 1;
    u7.npcGui = u7.npc:WaitForChild("Head"):WaitForChild("gui");
    u7.active = false;
    u7.talking = false;
    u7.prompt = p5;
    getDialogResponsesUI();
    local BindableEvent = Instance.new("BindableEvent");
    u7.responded = BindableEvent.Event;
    u7.fireResponded = BindableEvent;
    u7.animNameText = TweenService:Create(u7.npcGui.name, TweenInfo.new(0.3), {
        TextTransparency = 1
    });
    u7.animNameStroke = TweenService:Create(u7.npcGui.name.UIStroke, TweenInfo.new(0.3), {
        Transparency = 1
    });
    u7.animArrowText = TweenService:Create(u7.npcGui.arrow, TweenInfo.new(0.3), {
        TextTransparency = 1
    });
    u7.animArrowStroke = TweenService:Create(u7.npcGui.arrow.UIStroke, TweenInfo.new(0.3), {
        Transparency = 1
    });
    u7.animDialogText = TweenService:Create(u7.npcGui.dialog, TweenInfo.new(0.3), {
        TextTransparency = 1
    });
    u7.animDialogStroke = TweenService:Create(u7.npcGui.dialog.UIStroke, TweenInfo.new(0.3), {
        Transparency = 1
    });

    if p6 ~= nil then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = p6;
        p4:WaitForChild("Humanoid"):LoadAnimation(Animation):Play();
    end;

    local u8 = 0;
    local v10 = RunService.Heartbeat:Connect(function() -- Line: 73
        -- upvalues: u8 (ref), u7 (copy)
        u8 = u8 + 1;

        if u7.talking then
            u7.npcGui.StudsOffset = Vector3.new(0, 1.6, 0);

            return;
        end;

        local npcGui = u7.npcGui;
        local v9 = math.sin(u8 / 25) / 6 + 1.55;
        npcGui.StudsOffset = Vector3.new(0, v9, 0);
    end);
    p5.PromptShown:Connect(function() -- Line: 81
        -- upvalues: u7 (copy)
        u7.npcGui.AlwaysOnTop = true;
    end);
    p5.PromptHidden:Connect(function() -- Line: 84
        -- upvalues: u7 (copy)
        if u7.talking then
            return;
        end;

        u7.npcGui.AlwaysOnTop = false;
    end);
    u7.connections = { v10 };

    return u7;
end;

function u1.addDialog(p11, p12, p13) -- Line: 94
    table.insert(p11.dialogs, {
        text = p12,
        responses = p13
    });
end;

function u1.sortDialogs(p14, p15) -- Line: 99
    table.sort(p14.dialogs, p15 or function(p16, p17) -- Line: 100
        return p16.text < p17.text;
    end);
end;

function u1.triggerDialog(u18, u19, p20) -- Line: 104
    -- upvalues: TweenService (copy), tick (copy), getDialogResponsesUI (copy), tick2 (copy), UserInputService (copy)
    u18:showGui();

    if #u18.dialogs == 0 then
        warn("No dialogs available for NPC: " .. u18.npcName);

        return;
    end;

    local u21 = p20 or u18.dialogOption;
    local u22 = u18.dialogs[u21];
    TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FieldOfView = 65
    }):Play();
    task.spawn(function() -- Line: 117
        -- upvalues: u18 (copy), u22 (copy), tick (ref), getDialogResponsesUI (ref), TweenService (ref), tick2 (ref), u21 (copy), UserInputService (ref), u19 (copy)
        u18.talking = true;
        local dialog = u18.npcGui.dialog;
        dialog.Visible = true;
        dialog.Text = "";
        local v23 = "";
        local v24 = 0;
        local v25 = false;

        for _, v in string.split(u22.text, "") do
            v23 = v23 .. v;
            v25 = v == "<" and true or v25;

            if v == ">" then
                v24 = v24 + 1;
                v25 = false;
            else
                v24 = v24 == 2 and 0 or v24;

                if not v25 then
                    dialog.Text = v23 .. (v24 == 1 and "</font>" or "");
                    tick:Play();
                    task.wait(0.02);
                end;
            end;
        end;

        dialog.Text = u22.text;
        u18.talking = false;
        local u26 = {
            Enum.KeyCode.One,
            Enum.KeyCode.Two,
            Enum.KeyCode.Three,
            Enum.KeyCode.Four,
            Enum.KeyCode.Five,
            Enum.KeyCode.Six,
            Enum.KeyCode.Seven,
            Enum.KeyCode.Eight,
            Enum.KeyCode.Nine
        };
        local v27 = getDialogResponsesUI();
        local u28 = nil;

        for i, v in ipairs(u22.responses) do
            local u29 = v27[i];
            u29.text.Text = "<font color=\'rgb(255,220,127)\'>" .. i .. ".)</font> [\'\'" .. v .. "\'\']";
            local _ = i .. ".) [\'\'" .. v:gsub("%b<>", "") .. "\'\']";
            u29.Size = UDim2.fromScale(u29.Size.X.Scale, 0.4);
            u29.text.Position = UDim2.new(0.02, 0, 0.5, 0);
            u29.Visible = true;
            TweenService:Create(u29, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(u29.Size.X.Scale, 0, 0.35, 0)
            }):Play();
            local u30 = u29.MouseEnter:Connect(function() -- Line: 167
                -- upvalues: TweenService (ref), u29 (copy), tick2 (ref)
                TweenService:Create(u29, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.new(u29.Size.X.Scale + u29.Size.X.Scale * 0.05, 0, 0.4, 0)
                }):Play();
                TweenService:Create(u29.text, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.06, 0, 0.5, 0)
                }):Play();
                tick2:Play();
            end);
            local u31 = u29.MouseLeave:Connect(function() -- Line: 173
                -- upvalues: TweenService (ref), u29 (copy)
                TweenService:Create(u29, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.new(u29.Size.X.Scale, 0, 0.35, 0)
                }):Play();
                TweenService:Create(u29.text, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.02, 0, 0.5, 0)
                }):Play();
            end);
            local u32 = u29.MouseButton1Down:Connect(function() -- Line: 178
                -- upvalues: u18 (ref), u28 (ref), i (copy), u21 (ref), tick (ref)
                if not u18.active then
                    return;
                end;

                u18.active = false;
                u28 = i;
                u18.fireResponded:Fire(i, u21);
                tick:Play();
            end);
            local u35 = UserInputService.InputBegan:Connect(function(p33, p34) -- Line: 186
                -- upvalues: u26 (copy), i (copy), u18 (ref), u28 (ref), u21 (ref), tick (ref)
                if p34 then
                    return;
                end;

                if p33.UserInputType == Enum.UserInputType.Keyboard then
                    local table_find_ret = table.find(u26, p33.KeyCode);

                    if table_find_ret ~= nil and table_find_ret == i then
                        if not u18.active then
                            return;
                        end;

                        u18.active = false;
                        u28 = i;
                        u18.fireResponded:Fire(i, u21);
                        tick:Play();
                    end;
                end;
            end);
            coroutine.wrap(function() -- Line: 200
                -- upvalues: u28 (ref), u30 (copy), u31 (copy), u32 (copy), u35 (copy), u29 (copy)
                repeat
                    task.wait();
                until u28 ~= nil;

                u30:Disconnect();
                u31:Disconnect();
                u32:Disconnect();
                u35:Disconnect();
                u29.Visible = false;
            end)();
            tick2:Play();
            task.wait(0.2);
        end;

        u18.active = true;

        while u18.active do
            if (u19.Character.PrimaryPart.Position - u18.npc.Torso.Position).Magnitude > 10 then
                u18:hideGui();
                break;
            end;

            task.wait();
        end;
    end);
end;

function u1.showGui(u36) -- Line: 230
    turnProximityPromptsOn(false);
    u36.animNameText:Play();
    u36.animNameStroke:Play();
    u36.animArrowText:Play();
    u36.animArrowStroke:Play();
    u36.animDialogText:Cancel();
    u36.animDialogStroke:Cancel();
    u36.npcGui.dialog.TextTransparency = 0;
    u36.npcGui.dialog.UIStroke.Transparency = 0;
    coroutine.wrap(function() -- Line: 245
        -- upvalues: u36 (copy)
        task.wait(0.3);

        if u36.npcGui.name.TextTransparency ~= 1 then
            return;
        end;

        u36.npcGui.name.Visible = false;
        u36.npcGui.arrow.Visible = false;
    end)();
end;

function u1.hideGui(u37, u38, p39) -- Line: 254
    -- upvalues: TweenService (copy), getDialogResponsesUI (copy), tick (copy)
    u37.active = false;
    u37.talking = true;
    local v40 = p39 or false;
    turnProximityPromptsOn(not v40);
    u37.talking = false;

    if v40 then
        TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 65
        }):Play();
    else
        TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 70
        }):Play();
    end;

    for _, child in getDialogResponsesUI():GetChildren() do
        if child:IsA("GuiButton") then
            child.Visible = false;
        end;
    end;

    local dialog = u37.npcGui.dialog;

    if u38 then
        dialog.TextTransparency = 0;
        dialog.UIStroke.Transparency = 0;
        u37.npcGui.name.TextTransparency = 1;
        u37.npcGui.name.UIStroke.Transparency = 1;
        u37.npcGui.arrow.TextTransparency = 1;
        u37.npcGui.arrow.UIStroke.Transparency = 1;
        dialog.Text = "";
        dialog.Visible = true;
        local v41 = "";
        local v42 = 0;
        local v43 = false;

        for _, v in string.split(u38, "") do
            if dialog.Text ~= v41 and v43 == 0 then
                warn("other dialog happening");
                break;
            end;

            v41 = v41 .. v;
            v43 = v == "<" and true or v43;

            if v == ">" then
                v42 = v42 + 1;
                v43 = false;
            else
                v42 = v42 == 2 and 0 or v42;

                if not v43 then
                    dialog.Text = v41 .. (v42 == 1 and "</font>" or "");
                    tick:Play();
                    task.wait(0.02);
                end;
            end;
        end;

        dialog.Text = u38;

        if v40 then
            return;
        end;
    end;

    task.spawn(function() -- Line: 304
        -- upvalues: u38 (copy), dialog (copy), u37 (copy)
        if u38 then
            wait(2);

            if dialog.Text ~= u38 then
                return;
            end;
        end;

        if u37.npcGui.name.TextTransparency ~= 1 then
            u37.animNameText:Cancel();
            u37.animNameStroke:Cancel();
            u37.animArrowText:Cancel();
            u37.animArrowStroke:Cancel();
        end;

        u37.npcGui.name.TextTransparency = 0;
        u37.npcGui.name.UIStroke.Transparency = 0;
        u37.npcGui.arrow.TextTransparency = 0;
        u37.npcGui.arrow.UIStroke.Transparency = 0;
        u37.npcGui.name.Visible = true;
        u37.npcGui.arrow.Visible = true;
        u37.animDialogText:Play();
        u37.animDialogStroke:Play();
        turnProximityPromptsOn(true);
    end);
end;

function u1.nextOption(p44) -- Line: 330
    p44.dialogOption = p44.dialogOption + 1;

    if #p44.dialogs < p44.dialogOption then
        warn("No next dialog option for, " .. p44.npcName);
        p44.dialogOption = p44.dialogOption - 1;
    end;

    return p44.dialogOption;
end;

function turnProximityPromptsOn(p45)
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTagged("NPCprompt") do
        if v:IsA("ProximityPrompt") then
            v.Enabled = p45;
        end;
    end;
end;

return u1;