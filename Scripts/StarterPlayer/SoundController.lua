--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SoundController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.SoundController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local SoundService = game:GetService("SoundService");
local Knit = require(game.ReplicatedStorage.Packages.Knit);
local v1 = Knit.CreateController({
    Name = "SoundController"
});
local u2 = {};

for _, descendant in SoundService:GetDescendants() do
    if descendant:IsA("Sound") then
        u2[descendant.Name] = descendant;
    end;
end;

function v1.Play(p3, p4, p5) -- Line: 23
    -- upvalues: u2 (copy), SoundService (copy)
    if u2[p4] then
        u2[p4]:Play();

        return;
    end;

    if not p5 then
        warn("Sound not found: " .. p4);

        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.Name = p4;
    Sound.SoundId = p5;
    Sound.Parent = SoundService;
    u2[p4] = Sound;
    Sound:Play();
end;

function v1.KnitStart(u6) -- Line: 41
    -- upvalues: Knit (copy), SoundService (copy)
    Knit.GetService("SoundService").PlaySoundToPlayer:Connect(function(p7, p8) -- Line: 44
        -- upvalues: u6 (copy)
        u6:Play(p7, p8);
    end);
    local Service = Knit.GetService("SettingsService");

    local function applySFXVolume(p9) -- Line: 51
        -- upvalues: SoundService (ref)
        local SFX = SoundService:FindFirstChild("SFX");

        if SFX and SFX:IsA("SoundGroup") then
            SFX.Volume = math.clamp(p9, 0, 100) / 100;
        end;
    end;

    local v10, v11 = Service:GetSettings():await();
    local v12 = v10 and (v11 and type(v11.SFXVolume) == "number") and (v11.SFXVolume or 50) or 50;
    local SFX = SoundService:FindFirstChild("SFX");

    if SFX and SFX:IsA("SoundGroup") then
        SFX.Volume = math.clamp(v12, 0, 100) / 100;
    end;

    Service.SettingChanged:Connect(function(p13, p14) -- Line: 61
        -- upvalues: SoundService (ref)
        if p13 == "SFXVolume" then
            local SFX2 = SoundService:FindFirstChild("SFX");

            if SFX2 and SFX2:IsA("SoundGroup") then
                SFX2.Volume = math.clamp(p14, 0, 100) / 100;
            end;
        end;
    end);
end;

return v1;