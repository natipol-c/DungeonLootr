--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DialogueController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.DialogueController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local DialogModule = require(ReplicatedStorage.DialogModule);
local LocalPlayer = Players.LocalPlayer;
local DialogueData = ReplicatedStorage:WaitForChild("DialogueData");
local v1 = Knit.CreateController({
    Name = "DialogueController",
    _dialogueService = nil,
    _npcInstances = {}
});
local u2 = {};

local function PlayVoiceLine(u3: userdata, p4: string) -- Line: 76
    -- upvalues: u2 (copy)
    local v5 = u2[u3];

    if v5 then
        v5:Stop();
        v5:Destroy();
        u2[u3] = nil;
    end;

    if not p4 then
        return;
    end;

    local Head = u3:FindFirstChild("Head");

    if not Head then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = p4;
    Sound.Volume = 1;
    Sound.RollOffMaxDistance = 50;
    Sound.Parent = Head;
    Sound:Play();
    u2[u3] = Sound;
    Sound.Ended:Once(function() -- Line: 100
        -- upvalues: u2 (ref), u3 (copy), Sound (copy)
        if u2[u3] == Sound then
            u2[u3] = nil;
        end;

        Sound:Destroy();
    end);
end;

local function StopVoiceLine(p6: userdata) -- Line: 108
    -- upvalues: u2 (copy)
    local v7 = u2[p6];

    if v7 then
        v7:Stop();
        v7:Destroy();
        u2[p6] = nil;
    end;
end;

local u8 = {};

local function ClearGuidePointer() -- Line: 125
    -- upvalues: u8 (copy)
    for _, v in ipairs(u8) do
        if typeof(v) == "Instance" then
            v:Destroy();
        end;
    end;

    table.clear(u8);
end;

local function GuideArrowTo(p9: userdata?, p10: vector?) -- Line: 141
    -- upvalues: ClearGuidePointer (copy), LocalPlayer (copy), u8 (copy), ReplicatedStorage (copy)
    ClearGuidePointer();

    if not p9 then
        return;
    end;

    local v11 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();

    if not v11.PrimaryPart then
        v11:WaitForChild("HumanoidRootPart", 15);
    end;

    if not (v11 and v11.PrimaryPart) then
        return;
    end;

    local v12 = v11.PrimaryPart:FindFirstChild("GuideArrowAttachment") or Instance.new("Attachment");
    v12.Orientation = Vector3.new(0, 0, 90);
    v12.Name = "GuideArrowAttachment";
    v12.Parent = v11.PrimaryPart;
    local Attachment = Instance.new("Attachment");
    Attachment.Position = p10 or Vector3.new(0, 0, 0);
    Attachment.Orientation = Vector3.new(0, 0, 90);
    Attachment.Name = "GuideArrowAttachment";
    Attachment.Parent = p9;
    table.insert(u8, Attachment);
    local v13 = ReplicatedStorage.Assets.VFX.OnboardingBeam:Clone();
    v13.Attachment0 = v12;
    v13.Attachment1 = Attachment;
    v13.Parent = v11.PrimaryPart;
    table.insert(u8, v13);
    task.delay(5, function() -- Line: 176
        -- upvalues: ClearGuidePointer (ref)
        ClearGuidePointer();
    end);
end;

local function GuideArrowToPosition(p14: vector, p15: vector?) -- Line: 184
    -- upvalues: GuideArrowTo (copy), u8 (copy)
    local Part = Instance.new("Part");
    Part.Name = "GuidePointerTarget";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Position = p14;
    Part.Parent = workspace;
    GuideArrowTo(Part, p15);
    table.insert(u8, Part);
end;

function v1.ShowGuidePointer(p16: table, p17: any, p18: vector?) -- Line: 200
    -- upvalues: GuideArrowTo (copy), u8 (copy)
    if typeof(p17) ~= "Vector3" then
        if typeof(p17) == "Instance" then
            GuideArrowTo(p17, p18);
        end;

        return;
    end;

    local Part = Instance.new("Part");
    Part.Name = "GuidePointerTarget";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Position = p17;
    Part.Parent = workspace;
    GuideArrowTo(Part, p18);
    table.insert(u8, Part);
end;

function v1.HideGuidePointer(p19) -- Line: 208
    -- upvalues: ClearGuidePointer (copy)
    ClearGuidePointer();
end;

local u20 = Enum.RenderPriority.Character.Value + 1;
local u21 = CFrame.new(0, 1, 0) * CFrame.Angles(0, 3.141592653589793, 0);
local CFrame_Angles_ret = CFrame.Angles(-1.5707963267948966, 0, 0);

local function SetupHeadTracking(p22: userdata, p23: userdata) -- Line: 232
    -- upvalues: RunService (copy), u20 (copy), LocalPlayer (copy), u21 (copy), CFrame_Angles_ret (copy)
    local Torso = p22:FindFirstChild("Torso");

    if not Torso then
        return function() -- Line: 234
        end;
    end;

    local Neck = Torso:FindFirstChild("Neck");

    if not Neck then
        return function() -- Line: 237
        end;
    end;

    local C0 = Neck.C0;
    local u24 = false;
    local u25 = 0;
    local u26 = 0;
    local u27 = true;
    local u28 = "HeadTrack_" .. p22:GetFullName();
    local u29 = {};
    table.insert(u29, p23.PromptShown:Connect(function() -- Line: 249
        -- upvalues: u24 (ref), u27 (ref)
        u24 = true;
        u27 = false;
    end));
    table.insert(u29, p23.PromptHidden:Connect(function() -- Line: 255
        -- upvalues: u24 (ref)
        u24 = false;
    end));
    local u30 = p22:FindFirstChild("Head") and p22.Head:FindFirstChild("gui") and p22.Head.gui:FindFirstChild("dialog");

    if u30 then
        local PropertyChangedSignal = u30:GetPropertyChangedSignal("Visible");
        table.insert(u29, PropertyChangedSignal:Connect(function() -- Line: 265
            -- upvalues: u30 (copy), u24 (ref), u27 (ref)
            if u30.Visible then
                u24 = true;
                u27 = false;
            end;
        end));
    end;

    RunService:BindToRenderStep(u28, u20, function() -- Line: 274
        -- upvalues: u27 (ref), u24 (ref), LocalPlayer (ref), Torso (copy), u25 (ref), u26 (ref), Neck (copy), C0 (copy), u21 (ref), CFrame_Angles_ret (ref)
        if u27 then
            return;
        end;

        local v31 = 0;
        local v32 = 0;

        if u24 then
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if Character and Torso.Parent then
                local Unit = (Character.Position - Torso.Position).Unit;

                if Torso.CFrame.LookVector:Dot(Unit) > 0 then
                    local v33 = Torso.CFrame:VectorToObjectSpace(Unit);
                    v31 = math.clamp(-v33.X, -0.85, 0.85);
                    v32 = math.clamp(-v33.Y, -0.85, 0.85);
                end;
            end;
        end;

        u25 = u25 + (v31 - u25) * 0.08;
        u26 = u26 + (v32 - u26) * 0.08;

        if u24 or (math.abs(u25) >= 0.001 or math.abs(u26) >= 0.001) then
            Neck.C0 = u21 * CFrame.Angles(0, u25, 0) * CFrame.Angles(u26, 0, 0) * CFrame_Angles_ret;

            return;
        end;

        u25 = 0;
        u26 = 0;
        u27 = true;
        Neck.C0 = C0;
    end);

    return function() -- Line: 321
        -- upvalues: u29 (copy), RunService (ref), u28 (copy), Neck (copy), C0 (copy)
        for _, v in u29 do
            v:Disconnect();
        end;

        table.clear(u29);
        pcall(function() -- Line: 327
            -- upvalues: RunService (ref), u28 (ref)
            RunService:UnbindFromRenderStep(u28);
        end);

        if Neck and Neck.Parent then
            Neck.C0 = C0;
        end;
    end;
end;

function v1._SetupNPC(u34: table, u35: userdata) -- Line: 340
    -- upvalues: DialogueData (copy), CollectionService (copy), DialogModule (copy), LocalPlayer (copy), PlayVoiceLine (copy), u2 (copy), SetupHeadTracking (copy)
    local DialogueId = u35:FindFirstChild("DialogueId");

    if not (DialogueId and DialogueId:IsA("StringValue")) then
        warn("[DialogueController] NPC missing DialogueId StringValue:", u35:GetFullName());

        return;
    end;

    local Value = DialogueId.Value;
    local v36 = DialogueData:FindFirstChild(Value);

    if not v36 then
        warn("[DialogueController] No DialogueData module found for:", Value);

        return;
    end;

    local success, result = pcall(require, v36);

    if not success then
        warn("[DialogueController] Failed to load DialogueData for:", Value, result);

        return;
    end;

    local v37 = u35:FindFirstChildWhichIsA("ProximityPrompt");

    if not v37 then
        warn("[DialogueController] NPC missing ProximityPrompt:", u35:GetFullName());

        return;
    end;

    CollectionService:AddTag(v37, "NPCprompt");
    local u38 = DialogModule.new(result.npcName or Value, u35, v37, result.animation);

    for _, v in ipairs(result.dialogs) do
        u38:addDialog(v.text, v.responses);
    end;

    local u39 = {
        player = LocalPlayer,
        npc = u35,
        dialogObject = u38,
        controller = u34,
        dialogueId = Value
    };
    local v42 = v37.Triggered:Connect(function(p40) -- Line: 396
        -- upvalues: LocalPlayer (ref), result (copy), u39 (copy), PlayVoiceLine (ref), u35 (copy), u38 (copy)
        if p40 ~= LocalPlayer then
            return;
        end;

        local v41 = result.getStartDialog and (result.getStartDialog(u39) or 1) or 1;

        if result.voiceLines and result.voiceLines[v41] then
            PlayVoiceLine(u35, result.voiceLines[v41]);
        end;

        u38:triggerDialog(p40, v41);
    end);
    local v57 = u38.responded:Connect(function(p43, p44) -- Line: 414
        -- upvalues: result (copy), u38 (copy), u39 (copy), u35 (copy), u2 (ref), PlayVoiceLine (ref), LocalPlayer (ref), u34 (copy), Value (copy)
        if not result.onResponse then
            u38:hideGui();

            return;
        end;

        local v45 = { result.onResponse(u39, p43, p44) };
        local v46 = v45[1];

        if v46 == "hide" then
            local v47 = v45[2];
            local v48 = u35;
            local v49 = u2[v48];

            if v49 then
                v49:Stop();
                v49:Destroy();
                u2[v48] = nil;
            end;

            u38:hideGui(v47);

            return;
        end;

        if v46 == "goto" then
            local v50 = v45[2];
            local v51 = v45[3];

            if v51 then
                u38:hideGui(v51, true);
            end;

            if result.voiceLines and result.voiceLines[v50] then
                PlayVoiceLine(u35, result.voiceLines[v50]);
            end;

            u38:triggerDialog(LocalPlayer, v50);

            return;
        end;

        if v46 ~= "server" then
            local _ = v46 == nil;

            return;
        end;

        local v52 = v45[2];
        local v53 = v45[3];
        local v54 = v45[4];

        if u34._dialogueService then
            u34._dialogueService.DialogueAction:Fire(Value, v52, v53);
        else
            warn("[DialogueController] DialogueService not ready — server action dropped:", v52);
        end;

        local v55 = u35;
        local v56 = u2[v55];

        if v56 then
            v56:Stop();
            v56:Destroy();
            u2[v55] = nil;
        end;

        if v54 then
            u38:hideGui(v54);

            return;
        end;

        u38:hideGui();
    end);
    local v58;

    if result.headTracking == false then
        v58 = nil;
    else
        v58 = SetupHeadTracking(u35, v37);
    end;

    u34._npcInstances[u35] = {
        dialogObject = u38,
        dataModule = result,
        context = u39,
        connections = { v42, v57 },
        headTrackCleanup = v58
    };
end;

function v1._CleanupNPC(p59: table, p60: userdata) -- Line: 481
    -- upvalues: u2 (copy)
    local v61 = p59._npcInstances[p60];

    if not v61 then
        return;
    end;

    local v62 = u2[p60];

    if v62 then
        v62:Stop();
        v62:Destroy();
        u2[p60] = nil;
    end;

    for _, v in v61.connections do
        v:Disconnect();
    end;

    if v61.headTrackCleanup then
        v61.headTrackCleanup();
    end;

    p59._npcInstances[p60] = nil;
end;

function v1.GetDialogObject(p63: table, p64: userdata) -- Line: 499
    local v65 = p63._npcInstances[p64];

    if v65 then
        v65 = v65.dialogObject;
    end;

    return v65;
end;

function v1.KnitInit(u66) -- Line: 506
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTagged("DialogueNPC") do
        task.spawn(function() -- Line: 509
            -- upvalues: u66 (copy), v (copy)
            u66:_SetupNPC(v);
        end);
    end;

    CollectionService:GetInstanceAddedSignal("DialogueNPC"):Connect(function(p67) -- Line: 515
        -- upvalues: u66 (copy)
        u66:_SetupNPC(p67);
    end);
    CollectionService:GetInstanceRemovedSignal("DialogueNPC"):Connect(function(p68) -- Line: 520
        -- upvalues: u66 (copy)
        u66:_CleanupNPC(p68);
    end);
end;

function v1.KnitStart(u69) -- Line: 525
    -- upvalues: Knit (copy)
    local Service = Knit.GetService("DialogueService");
    u69._dialogueService = Service;
    Service.DialogueResult:Connect(function(p70, p71, p72) -- Line: 531
        -- upvalues: u69 (copy)
        if p71 == "GuidePointer" then
            if p72.part then
                u69:ShowGuidePointer(p72.part);
            elseif p72.position then
                u69:ShowGuidePointer(p72.position);
            end;
        end;

        for _, v in u69._npcInstances do
            if v.dataModule.onServerResult then
                v.dataModule.onServerResult(v.context, p70, p71, p72);
            end;
        end;
    end);
end;

return v1;