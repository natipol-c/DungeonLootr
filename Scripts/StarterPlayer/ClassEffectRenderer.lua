--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClassEffectRenderer
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.ClassEffectRenderer
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local u12 = {
    GetLifetime = function(p1: table, p2: userdata) -- Line: 39, Name: GetLifetime
        local v3 = 0;

        for _, descendant in p2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local v4 = (descendant:GetAttribute("EmitDelay") or 0) + (descendant:GetAttribute("EmitDuration") or 0) + descendant.Lifetime.Max;
                v3 = math.max(v3, v4);
            end;
        end;

        return math.clamp(v3 <= 0 and 1.5 or v3, 0.5, 8);
    end,

    EnableParticles = function(p5: table, p6: userdata) -- Line: 52, Name: EnableParticles
        for _, descendant in p6:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = true;
            end;
        end;
    end,

    DisableParticles = function(p7: table, p8: userdata) -- Line: 60, Name: DisableParticles
        for _, descendant in p8:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = false;
            end;
        end;
    end,

    Emit = function(p9: table, p10: userdata) -- Line: 68, Name: Emit
        for _, descendant in p10:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local v11 = p10:GetAttribute("EmitCount") or descendant:GetAttribute("EmitCount");

                if not v11 then
                    local math_ceil_ret = math.ceil(descendant.Rate * descendant.Lifetime.Max);
                    v11 = math.clamp(math_ceil_ret, 1, 200);
                end;

                descendant:Emit(v11);
            end;
        end;
    end
};

function u12.AutoEmit(p13: table, p14: userdata) -- Line: 81
    -- upvalues: u12 (copy), Debris (copy)
    local Lifetime = u12:GetLifetime(p14);
    u12:EnableParticles(p14);
    u12:Emit(p14);
    Debris:AddItem(p14, Lifetime);
end;

function u12.FireOnce(p15: table, u16: userdata, p17: boolean?) -- Line: 97
    -- upvalues: Debris (copy), u12 (copy)
    u16:SetAttribute("Bypass_FX", true);

    if u16:GetAttribute("Fire") == nil then
        u16:SetAttribute("Fire", false);
    end;

    task.spawn(function() -- Line: 102
        -- upvalues: u16 (copy)
        task.wait();

        if u16.Parent then
            u16:SetAttribute("Fire", not u16:GetAttribute("Fire"));
        end;
    end);

    if not p17 then
        Debris:AddItem(u16, u12:GetLifetime(u16));
    end;
end;

local function buildCache() -- Line: 115
    -- upvalues: u12 (copy), Debris (copy)
    return {
        Effects = u12,
        Debris = Debris,
        EffectsList = {},
        Util = {
            ScaleCFrame = function(p18) -- Line: 124, Name: ScaleCFrame
                return p18;
            end
        },
        Invis = {
            Invisible = function(p19) -- Line: 131, Name: Invisible
            end,

            Visible = function(p20) -- Line: 132, Name: Visible
            end
        }
    };
end;

local u21 = {};

local function getClassCache(p22: string) -- Line: 146
    -- upvalues: u21 (copy), ReplicatedStorage (copy), buildCache (copy)
    local v23 = u21[p22];

    if v23 then
        return v23;
    end;

    local Classes = ReplicatedStorage:FindFirstChild("Classes");

    if Classes then
        Classes = Classes:FindFirstChild(p22);
    end;

    if not Classes then
        Classes = ReplicatedStorage:FindFirstChild("Assets");

        if Classes then
            Classes = Classes:FindFirstChild("Boss_Sets");
        end;

        if Classes then
            Classes = Classes:FindFirstChild(p22);
        end;
    end;

    if Classes then
        Classes = Classes:FindFirstChild("Skill_Modules");
    end;

    if not Classes then
        return nil;
    end;

    local v24 = buildCache();

    for _, child in Classes:GetChildren() do
        if child:IsA("ModuleScript") then
            local success, result = pcall(require, child);

            if success and type(result) == "table" then
                if type(result.init) == "function" then
                    pcall(result.init, v24);
                end;

                v24.EffectsList[child.Name] = result;
            else
                warn((`[ClassEffectRenderer] failed to require {p22}/{child.Name}: {result}`));
            end;
        end;
    end;

    u21[p22] = v24;

    return v24;
end;

local u25 = nil;

local function getEffectsRoot() -- Line: 182
    -- upvalues: u25 (ref)
    if u25 and u25.Parent then
        return u25;
    end;

    local Effects = workspace:FindFirstChild("Effects");

    if Effects and Effects:IsA("Folder") then
        u25 = Effects;
    else
        u25 = Instance.new("Folder");
        u25.Name = "Effects";
        u25.Parent = workspace;
    end;

    return u25;
end;

local function ensureCharFolder(p26: userdata) -- Line: 197
    -- upvalues: u25 (ref)
    local v27;

    if u25 and u25.Parent then
        v27 = u25;
    else
        local Effects = workspace:FindFirstChild("Effects");

        if Effects and Effects:IsA("Folder") then
            u25 = Effects;
        else
            u25 = Instance.new("Folder");
            u25.Name = "Effects";
            u25.Parent = workspace;
        end;

        v27 = u25;
    end;

    local v28 = v27:FindFirstChild(p26.Name);

    if v28 and v28:IsA("Folder") then
        return v28;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = p26.Name;
    Folder.Parent = v27;
    p26.Destroying:Once(function() -- Line: 205
        -- upvalues: Folder (copy)
        if Folder then
            Folder:Destroy();
        end;
    end);

    return Folder;
end;

local u29 = nil;

local function getSettings() -- Line: 214
    -- upvalues: u29 (ref), Knit (copy)
    if not u29 then
        local success, result = pcall(function() -- Line: 216
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u29 = result;
        end;
    end;

    return u29;
end;

local function shouldRender(p30: userdata) -- Line: 224
    -- upvalues: LocalPlayer (copy), u29 (ref), Knit (copy)
    local Character = LocalPlayer.Character;
    local v31;

    if Character then
        v31 = Character:FindFirstChild("HumanoidRootPart");
    else
        v31 = Character;
    end;

    local HumanoidRootPart = p30:FindFirstChild("HumanoidRootPart");

    if not (v31 and HumanoidRootPart) then
        return false;
    end;

    if (v31.Position - HumanoidRootPart.Position).Magnitude > 75 then
        return false;
    end;

    if not u29 then
        local success, result = pcall(function() -- Line: 216
            -- upvalues: Knit (ref)
            return Knit.GetController("SettingsController");
        end);

        if success then
            u29 = result;
        end;
    end;

    local v32 = u29;

    if v32 then
        local v33 = v32:ShouldHideOtherVFX();
        local v34 = v32:ShouldHideSelfVFX();

        if v33 or v34 then
            local v35 = p30 == Character;

            if v35 and v34 then
                return false;
            end;

            if not v35 and v33 then
                return false;
            end;
        end;
    end;

    return true;
end;

return function(p36, p37) -- Line: 246
    -- upvalues: ReplicatedStorage (copy), shouldRender (copy), getClassCache (copy), ensureCharFolder (copy)
    local ClassEffect = ReplicatedStorage:WaitForChild("Player"):WaitForChild("Remotes"):WaitForChild("ClassEffect", 30);

    if ClassEffect then
        ClassEffect.OnClientEvent:Connect(function(u38, u39, u40, u41, u42, ...) -- Line: 254
            -- upvalues: shouldRender (ref), getClassCache (ref), ensureCharFolder (ref)
            if typeof(u38) ~= "Instance" or not u38:IsA("Model") then
                return;
            end;

            if typeof(u39) ~= "string" or (typeof(u40) ~= "string" or typeof(u41) ~= "string") then
                return;
            end;

            if not u38:IsDescendantOf(workspace) then
                return;
            end;

            if not shouldRender(u38) then
                return;
            end;

            local v43 = getClassCache(u39);

            if not v43 then
                return;
            end;

            local u44 = v43.EffectsList[u40];

            if not u44 or type(u44[u41]) ~= "function" then
                warn((`[ClassEffectRenderer] no method {u40}.{u41} for class {u39}`));

                return;
            end;

            ensureCharFolder(u38);
            local table_pack_ret = table.pack(...);
            task.spawn(function() -- Line: 273
                -- upvalues: u44 (copy), u41 (copy), u38 (copy), u42 (copy), table_pack_ret (copy), u39 (copy), u40 (copy)
                local success, result = pcall(u44[u41], u38, u42, table.unpack(table_pack_ret, 1, table_pack_ret.n));

                if not success then
                    warn((`[ClassEffectRenderer] {u39}.{u40}.{u41} errored: {result}`));
                end;
            end);
        end);

        return;
    end;

    warn("[ClassEffectRenderer] ClassEffect remote not found after 30s");
end;