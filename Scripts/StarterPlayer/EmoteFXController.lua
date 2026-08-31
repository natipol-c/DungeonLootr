--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EmoteFXController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.EmoteFXController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
local SoundService = game:GetService("SoundService");
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"));
local EmoteData = require(ReplicatedStorage:WaitForChild("GameInfo"):WaitForChild("EmoteData"));
local LocalPlayer = Players.LocalPlayer;
local v1 = Knit.CreateController({
    Name = "EmoteFXController"
});
local u2 = {};
local u3 = nil;
local u4 = nil;

local function ShouldShowAura(p5: userdata) -- Line: 66
    -- upvalues: u3 (ref), LocalPlayer (copy)
    if not u3 then
        return true;
    end;

    if p5 == LocalPlayer then
        return not u3:ShouldHideSelfVFX();
    end;

    return not u3:ShouldHideOtherVFX();
end;

local function ShouldPlaySound(p6: userdata) -- Line: 74
    -- upvalues: LocalPlayer (copy), u3 (ref)
    return p6 == LocalPlayer and true or (not u3 and true or not u3:ShouldDisableEmoteSounds());
end;

local function Cleanup(p7: userdata) -- Line: 82
    -- upvalues: u2 (copy), Debris (copy)
    local v8 = u2[p7];

    if not v8 then
        return;
    end;

    u2[p7] = nil;

    if v8.timeout and v8.timeout ~= coroutine.running() then
        pcall(task.cancel, v8.timeout);
    end;

    for _, v in v8.conns do
        pcall(function() -- Line: 92
            -- upvalues: v (copy)
            v:Disconnect();
        end);
    end;

    if v8.sound then
        local sound = v8.sound;
        pcall(function() -- Line: 97
            -- upvalues: sound (copy)
            sound:Stop();
        end);
        pcall(function() -- Line: 98
            -- upvalues: sound (copy)
            sound:Destroy();
        end);
    end;

    if v8.aura then
        local aura = v8.aura;

        for _, descendant in aura:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = false;
            end;
        end;

        Debris:AddItem(aura, 2);
    end;
end;

local function BuildAura(p9: userdata, p10: userdata, p11: userdata, p12: userdata) -- Line: 118
    local v13 = p12:Clone();
    local BoundingBox, v14 = p10:GetBoundingBox();
    local CFrame_new_ret = CFrame.new(p11.Position.X, BoundingBox.Position.Y - v14.Y / 2, p11.Position.Z);
    local v15 = nil;

    if v13:IsA("BasePart") then
        v13.Anchored = false;
        v13.CFrame = CFrame_new_ret;
        v15 = v13;
    elseif v13:IsA("Model") then
        v13:PivotTo(CFrame_new_ret);
        v15 = v13.PrimaryPart;
    end;

    if v15 then
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = v15;
        WeldConstraint.Part1 = p11;
        WeldConstraint.Parent = v15;
    end;

    v13:SetAttribute("OwnerUserId", p9.UserId);
    v13.Parent = p10;

    for _, descendant in v13:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant.Enabled = true;
        end;
    end;

    return v13;
end;

local function BuildSound(p16: userdata, p17: userdata) -- Line: 158
    -- upvalues: u4 (ref)
    local v18 = p17:Clone();

    if u4 then
        v18.SoundGroup = u4;
    end;

    v18.Parent = p16;
    v18:Play();

    return v18;
end;

local function OnStart(u19: userdata, p20: string) -- Line: 170
    -- upvalues: Cleanup (copy), EmoteData (copy), u2 (copy), u3 (ref), LocalPlayer (copy), BuildAura (copy), BuildSound (copy)
    Cleanup(u19);

    if not EmoteData.IsValid(p20) then
        return;
    end;

    local Character = u19.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
        return;
    end;

    local v21 = {
        conns = {}
    };
    u2[u19] = v21;
    local Aura = EmoteData.GetAura(p20);

    if Aura then
        local v22;

        if u3 then
            if u19 == LocalPlayer then
                v22 = not u3:ShouldHideSelfVFX();
            else
                v22 = not u3:ShouldHideOtherVFX();
            end;
        else
            v22 = true;
        end;

        if v22 then
            local success, result = pcall(BuildAura, u19, Character, HumanoidRootPart, Aura);

            if success then
                v21.aura = result;
            end;
        end;
    end;

    local Sound = EmoteData.GetSound(p20);

    if Sound and (u19 == LocalPlayer or not (u3 and u3:ShouldDisableEmoteSounds())) then
        local success, result = pcall(BuildSound, HumanoidRootPart, Sound);

        if success and result then
            v21.sound = result;
            local v24 = result.Ended:Connect(function() -- Line: 200
                -- upvalues: result (copy), u2 (ref), u19 (copy)
                pcall(function() -- Line: 201
                    -- upvalues: result (ref)
                    result:Destroy();
                end);
                local v23 = u2[u19];

                if v23 and v23.sound == result then
                    v23.sound = nil;
                end;
            end);
            table.insert(v21.conns, v24);
        end;
    end;

    if not (v21.aura or v21.sound) then
        u2[u19] = nil;

        return;
    end;

    local v27 = Character.AncestryChanged:Connect(function(p25, p26) -- Line: 219
        -- upvalues: Cleanup (ref), u19 (copy)
        if not p26 then
            Cleanup(u19);
        end;
    end);
    table.insert(v21.conns, v27);
    v21.timeout = task.delay(300, function() -- Line: 227
        -- upvalues: Cleanup (ref), u19 (copy)
        Cleanup(u19);
    end);
end;

local function EnsureEmoteSoundGroup() -- Line: 236
    -- upvalues: SoundService (copy)
    local Emote = SoundService:FindFirstChild("Emote");

    if Emote and Emote:IsA("SoundGroup") then
        return Emote;
    end;

    local SoundGroup = Instance.new("SoundGroup");
    SoundGroup.Name = "Emote";
    SoundGroup.Volume = 0.5;
    SoundGroup.Parent = SoundService;

    return SoundGroup;
end;

local function ApplyEmoteVolume(p28: number?) -- Line: 249
    -- upvalues: u4 (ref)
    if not u4 then
        return;
    end;

    local v29 = tonumber(p28) or 50;
    u4.Volume = math.clamp(v29, 0, 100) / 100;
end;

function v1.KnitStart(p30) -- Line: 256
    -- upvalues: u3 (ref), Knit (copy), u4 (ref), SoundService (copy), OnStart (copy), Cleanup (copy), Players (copy)
    u3 = Knit.GetController("SettingsController");
    local Emote = SoundService:FindFirstChild("Emote");

    if not (Emote and Emote:IsA("SoundGroup")) then
        Emote = Instance.new("SoundGroup");
        Emote.Name = "Emote";
        Emote.Volume = 0.5;
        Emote.Parent = SoundService;
    end;

    u4 = Emote;
    local Service = Knit.GetService("SettingsService");
    local v31, v32 = Service:GetSettings():await();
    local v33 = v31 and (v32 and type(v32.EmoteVolume) == "number") and (v32.EmoteVolume or 50) or 50;

    if u4 then
        local v34 = tonumber(v33) or 50;
        u4.Volume = math.clamp(v34, 0, 100) / 100;
    end;

    Service.SettingChanged:Connect(function(p35, p36) -- Line: 265
        -- upvalues: u4 (ref)
        if p35 == "EmoteVolume" then
            if not u4 then
                return;
            end;

            local v37 = tonumber(p36) or 50;
            u4.Volume = math.clamp(v37, 0, 100) / 100;
        end;
    end);
    Knit.GetService("EmoteService").EmotePerformed:Connect(function(p38, p39, p40) -- Line: 272
        -- upvalues: OnStart (ref), Cleanup (ref)
        if typeof(p38) ~= "Instance" or not p38:IsA("Player") then
            return;
        end;

        if p40 then
            OnStart(p38, p39);

            return;
        end;

        Cleanup(p38);
    end);
    Players.PlayerRemoving:Connect(function(p41) -- Line: 283
        -- upvalues: Cleanup (ref)
        Cleanup(p41);
    end);
end;

return v1;