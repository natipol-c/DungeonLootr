--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ForgeVFXUtil
  Path:     game.ReplicatedStorage.Modules.ForgeVFXUtil
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ForgeVFX = require(ReplicatedStorage.ExternalModules.ForgeVFX);
local u1 = RunService:IsServer();
local u2;

if u1 then
    u2 = nil;
else
    u2 = Players.LocalPlayer;
end;

local u3 = {};
local u4 = nil;
local u5 = {};

function u3.Init() -- Line: 64
    -- upvalues: ForgeVFX (copy)
    ForgeVFX.init();
end;

function u3.GetTemplate(p6: string) -- Line: 69
    -- upvalues: u5 (copy), u4 (ref), ReplicatedStorage (copy)
    local v7 = u5[p6];

    if v7 then
        return v7;
    end;

    if not u4 then
        local Assets = ReplicatedStorage:FindFirstChild("Assets");

        if Assets then
            Assets = Assets:FindFirstChild("ForgeFX");
        end;

        u4 = Assets;
    end;

    if not u4 then
        warn("[ForgeVFXUtil] ReplicatedStorage.Assets.ForgeFX not found — create the container in Studio and place effect packs inside");

        return nil;
    end;

    local v8 = u4:FindFirstChild(p6);

    if v8 then
        u5[p6] = v8;

        return v8;
    end;

    warn((`[ForgeVFXUtil] no effect named "{p6}" under Assets.ForgeFX`));

    return nil;
end;

function u3.GetForge() -- Line: 96
    -- upvalues: ForgeVFX (copy)
    if not ForgeVFX.setup then
        ForgeVFX.init();
    end;

    return ForgeVFX;
end;

local function withinDistance(p9, p10: number) -- Line: 103
    -- upvalues: u2 (copy)
    if not p9 or p10 == (1 / 0) then
        return true;
    end;

    local v11 = u2 and u2.Character;

    if v11 then
        v11 = v11:FindFirstChild("HumanoidRootPart");
    end;

    return not v11 and true or (p9.Position - v11.Position).Magnitude <= p10;
end;

local u12 = nil;

local function getDefaultParent() -- Line: 122
    -- upvalues: u12 (ref)
    if u12 and u12.Parent then
        return u12;
    end;

    local ForgeVFX_Active = workspace:FindFirstChild("ForgeVFX_Active");

    if ForgeVFX_Active and ForgeVFX_Active:IsA("Folder") then
        u12 = ForgeVFX_Active;
    else
        local Folder = Instance.new("Folder");
        Folder.Name = "ForgeVFX_Active";
        Folder.Parent = workspace;
        u12 = Folder;
    end;

    return u12;
end;

function u3.GetDefaultParent() -- Line: 141
    -- upvalues: getDefaultParent (copy)
    return getDefaultParent();
end;

function u3.IsScreenOwner(p13: userdata?) -- Line: 154
    -- upvalues: u1 (copy), Players (copy), u2 (copy)
    if u1 then
        return false;
    end;

    local v14;

    if p13 then
        v14 = Players:GetPlayerFromCharacter(p13);
    else
        v14 = p13;
    end;

    local v15 = v14 and v14.UserId;

    if v15 then
        p13 = v15;
    elseif p13 then
        p13 = p13:GetAttribute("ForgeVFX_ScreenOwner");
    end;

    if not p13 then
        return true;
    end;

    local v16;

    if u2 == nil then
        v16 = false;
    else
        v16 = u2.UserId == p13;
    end;

    return v16;
end;

local function prepareClone(p17, p18) -- Line: 166
    -- upvalues: u1 (copy), u3 (copy), u2 (copy), ForgeVFX (copy), RunService (copy), getDefaultParent (copy)
    if u1 then
        warn("[ForgeVFXUtil] emitting is client-only — call from a client script or a Skill_Modules choreographer, never from Skills/");

        return nil;
    end;

    local v19;

    if typeof(p17) == "string" then
        v19 = u3.GetTemplate(p17);
    else
        v19 = p17;
    end;

    if typeof(v19) ~= "Instance" then
        if typeof(p17) ~= "string" then
            warn((`[ForgeVFXUtil] invalid template argument ({typeof(p17)})`));
        end;

        return nil;
    end;

    local AttachTo = p18.AttachTo;
    local u20 = p18.Offset or CFrame.identity;
    local CFrame2 = p18.CFrame;

    if not CFrame2 and AttachTo then
        CFrame2 = AttachTo.CFrame * u20;
    end;

    if not CFrame2 and v19:IsA("PVInstance") then
        CFrame2 = v19:GetPivot();
    end;

    local v21 = p18.MaxDistance or 250;
    local v22;

    if CFrame2 and v21 ~= (1 / 0) then
        local v23 = u2 and u2.Character;

        if v23 then
            v23 = v23:FindFirstChild("HumanoidRootPart");
        end;

        v22 = not v23 and true or (CFrame2.Position - v23.Position).Magnitude <= v21;
    else
        v22 = true;
    end;

    if not v22 then
        return nil;
    end;

    if not ForgeVFX.setup then
        ForgeVFX.init();
    end;

    local u24 = v19:Clone();

    if p18.StripCameraShake then
        for _, descendant in u24:GetDescendants() do
            if descendant:IsA("RayValue") and descendant:HasTag("CameraShake") then
                descendant:Destroy();
            end;
        end;
    end;

    local function fixPart(p25: userdata) -- Line: 221
        p25.CanCollide = false;
        p25.Anchored = true;
    end;

    if u24:IsA("BasePart") then
        u24.CanCollide = false;
        u24.Anchored = true;
    end;

    for _, descendant in u24:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.Anchored = true;
        end;
    end;

    if (p18.Scale ~= nil and p18.Scale ~= 1 or p18.TimeScale ~= nil and p18.TimeScale ~= 1) and true or p18.Color ~= nil then
        if u24:GetAttribute("U") == nil then
            if p18.Scale and p18.Scale ~= 1 then
                ForgeVFX.resize(p18.Scale, u24);
            end;

            if p18.TimeScale and p18.TimeScale ~= 1 then
                ForgeVFX.retime(p18.TimeScale, u24);
            end;

            if p18.Color then
                ForgeVFX.recolor(p18.Color, p18.ColorMode or "multiply", u24);
            end;
        else
            warn((`[ForgeVFXUtil] {v19:GetFullName()} is attribute-cached — Scale/TimeScale/Color skipped (see VFX_REFERENCE.md §10)`));
        end;
    end;

    if CFrame2 and u24:IsA("PVInstance") then
        u24:PivotTo(CFrame2);
    end;

    local u26 = nil;

    local function stopFollow() -- Line: 260
        -- upvalues: u26 (ref)
        if u26 then
            u26:Disconnect();
            u26 = nil;
        end;
    end;

    if AttachTo and u24:IsA("PVInstance") then
        u26 = RunService.RenderStepped:Connect(function() -- Line: 268
            -- upvalues: AttachTo (copy), u24 (copy), u20 (copy)
            if AttachTo.Parent then
                u24:PivotTo(AttachTo.CFrame * u20);
            end;
        end);
        u24.Destroying:Once(stopFollow);
    end;

    u24.Parent = p18.Parent or getDefaultParent();

    return u24, stopFollow;
end;

function u3.Emit(p27, p28) -- Line: 319
    -- upvalues: prepareClone (copy), ForgeVFX (copy)
    local u29 = p28 or {};
    local u30, u31 = prepareClone(p27, u29);

    if not u30 then
        return nil;
    end;

    local u32 = ForgeVFX.emit(u30);
    local u33 = false;
    u32.Finished:finally(function() -- Line: 330, Name: cleanup
        -- upvalues: u33 (ref), u31 (copy), u30 (copy), u29 (ref)
        if u33 then
            return;
        end;

        u33 = true;
        u31();
        u30:Destroy();

        if u29.OnFinished then
            task.spawn(u29.OnFinished);
        end;
    end);

    return {
        Instance = u30,
        Finished = u32.Finished,
        StopFollow = u31,

        Clear = function() -- Line: 348, Name: Clear
            -- upvalues: u32 (copy), u33 (ref), u31 (copy), u30 (copy), u29 (ref)
            u32.Clear();

            if u33 then
                return;
            end;

            u33 = true;
            u31();
            u30:Destroy();

            if u29.OnFinished then
                task.spawn(u29.OnFinished);
            end;
        end
    };
end;

function u3.Attach(p34, p35) -- Line: 372
    -- upvalues: prepareClone (copy), ForgeVFX (copy)
    local u36, u37 = prepareClone(p34, p35 or {});

    if not u36 then
        return nil;
    end;

    ForgeVFX.enable(u36);
    local u38 = false;

    return {
        Instance = u36,

        Stop = function(p39) -- Line: 385
            -- upvalues: u38 (ref), ForgeVFX (ref), u36 (copy), u37 (copy)
            if u38 then
                return;
            end;

            u38 = true;
            local v40 = typeof(p39) ~= "number" and 2 or p39;
            ForgeVFX.disable(u36);
            task.delay(v40, function() -- Line: 394
                -- upvalues: u37 (ref), u36 (ref)
                u37();
                u36:Destroy();
            end);
        end
    };
end;

return u3;