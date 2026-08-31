--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     sound
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.sound
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../pkg/Promise");
local Random_new_ret = Random.new();
local v5 = {};
local u6 = nil;

local function selectRandomSound(p7: userdata) -- Line: 17
    -- upvalues: u1 (copy), CollectionService (copy), Random_new_ret (copy)
    local v8 = u1.get(p7, "SoundPoolTag", "");

    if v8 == "" then
        return p7;
    end;

    local v9 = {};
    local v10 = {};
    local v11 = 0;

    for _, v in CollectionService:GetTagged(v8) do
        if v:IsA("Sound") then
            table.insert(v9, v);
            local v12 = u1.get(v, "SoundPoolWeight", 1);
            table.insert(v10, v12);
            v11 = v11 + v12;
        end;
    end;

    if #v9 == 0 then
        return p7;
    end;

    if v11 > 0 then
        local v13 = Random_new_ret:NextNumber() * v11;
        local v14 = 0;

        for i, v in v10 do
            v14 = v14 + v;

            if v13 <= v14 then
                return v9[i];
            end;
        end;
    end;

    return v9[Random_new_ret:NextInteger(1, #v9)];
end;

local function createSoundClone(p15: userdata, p16: userdata, p17: any) -- Line: 64
    -- upvalues: u3 (copy), u6 (ref)
    local v18 = p16:Clone();

    for _, v in v18:GetTags() do
        v18:RemoveTag(v);
    end;

    local v19 = p15:FindFirstAncestorWhichIsA("BasePart");
    local v20 = nil;

    if u3.PLUGIN_CONTEXT then
        if v19 then
            v20 = Instance.new("Part");
            v20.Name = "SoundEmitter";
            v20.Anchored = true;
            v20.CanCollide = false;
            v20.CanQuery = false;
            v20.CanTouch = false;
            v20.Transparency = 1;
            v20.Size = Vector3.new(1, 1, 1);
            v20.CFrame = v19.CFrame;
            v20.Parent = u6;
            v18.Parent = v20;
            table.insert(p17, v20);
        else
            v18.Parent = u6;
            table.insert(p17, v18);
        end;
    else
        if v19 then
            v18.Parent = v19;
        else
            v18.Parent = workspace.Terrain;
        end;

        table.insert(p17, v18);
    end;

    return v18, v20;
end;

local function playSingleSound(p21: userdata, p22: userdata, u23: userdata, u24: userdata?, p25: any, p26: number) -- Line: 109
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), RunService (copy)
    local PlaybackSpeed = u23.PlaybackSpeed;
    local u27 = u1.get(p22, "Volume_End", u23.Volume);
    local u28 = u1.get(p22, "Volume_Start", u23.Volume);
    u23.Volume = u28;

    if u28 == u27 then
        u23.Volume = u28;
    else
        local v29 = u1.get(p22, "Volume_Duration", u23.TimeLength);
        local fromParams = u2.fromParams;
        local v30 = u1.get(p22, "Volume_Curve", u3.default_bezier);
        table.insert(p25, fromParams(v30, v29, function(p31, p32) -- Line: 129
            -- upvalues: u23 (copy), u3 (ref), u28 (copy), u27 (copy), PlaybackSpeed (ref)
            u23.Volume = u3.lerp(u28, u27, p31);

            return p32 * PlaybackSpeed;
        end));
    end;

    local u33 = u1.get(p22, "Speed_End", u23.PlaybackSpeed);
    local u34 = u1.get(p22, "Speed_Start", u23.PlaybackSpeed);
    local u35 = u34;
    local u36 = nil;

    if u34 == u33 then
        u23.PlaybackSpeed = u34;
    else
        local v37 = u1.get(p22, "Speed_Duration", u23.TimeLength);
        u36 = u2.fromParams(u1.get(p22, "Speed_Curve", u3.default_bezier), v37, function(p38, p39) -- Line: 151
            -- upvalues: u35 (ref), u3 (ref), u34 (copy), u33 (copy), u23 (copy)
            u35 = u3.lerp(u34, u33, p38);
            u23.PlaybackSpeed = u35;

            return p39;
        end);
        table.insert(p25, u36);
    end;

    local u40 = u1.get(p22, "RollOff_End", u23.RollOffMinDistance);
    local u41 = u1.get(p22, "RollOff_Start", u23.RollOffMinDistance);

    if u41 ~= u40 then
        local v42 = u1.get(p22, "RollOff_Duration", u23.TimeLength);
        local fromParams = u2.fromParams;
        local v43 = u1.get(p22, "RollOff_Curve", u3.default_bezier);
        table.insert(p25, fromParams(v43, v42, function(p44, p45) -- Line: 174
            -- upvalues: u23 (copy), u3 (ref), u41 (copy), u40 (copy), u35 (ref)
            u23.RollOffMinDistance = u3.lerp(u41, u40, p44);

            return p45 * u35;
        end, u36));
    end;

    if u23.PlayOnRemove and not u3.PLUGIN_CONTEXT then
        u23:Destroy();
    else
        u23:Play();
    end;

    local u46 = u24 and p21:FindFirstAncestorWhichIsA("BasePart");

    if u46 then
        table.insert(p25, RunService.Heartbeat:Connect(function() -- Line: 195
            -- upvalues: u24 (copy), u46 (copy)
            if u24.Parent then
                u24.CFrame = u46.CFrame;
            end;
        end));
    end;

    if p26 > 0 then
        task.wait(p26);
        u23:Stop();
    else
        u2.timer(u23.TimeLength, function(p47, p48) -- Line: 208
            -- upvalues: u23 (copy), u36 (ref)
            if u23.PlaybackSpeed > 0 or p48 > 0 and (u36 and u36.Connected) then
                return p47 * u23.PlaybackSpeed;
            end;

            return nil;
        end, u36, p25);
    end;

    return u36;
end;

function v5.init() -- Line: 218
    -- upvalues: u3 (copy), u6 (ref)
    if not u3.PLUGIN_CONTEXT then
        return;
    end;

    local v49 = script:FindFirstAncestorOfClass("Plugin");

    if not v49 then
        return;
    end;

    u6 = v49:CreateDockWidgetPluginGui("VFXForgeSoundPlayer", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, true, 200, 100, 100, 50));

    if u6 then
        u6.Name = "VFXForgeSoundPlayer";
    end;
end;

function v5.deinit() -- Line: 239
    -- upvalues: u6 (ref)
    if u6 then
        u6:Destroy();
        u6 = nil;
    end;
end;

function v5.emit(u50: userdata, u51: any) -- Line: 246
    -- upvalues: u1 (copy), selectRandomSound (copy), u4 (copy), createSoundClone (copy), playSingleSound (copy), Random_new_ret (copy)
    if u50.Playing then
        u50:Stop();
    end;

    local v52 = u1.get(u50, "SoundPoolIsSource", false);
    local v53 = u1.get(u50, "SoundPoolInheritAttributes", false);

    if v53 then
        if not v52 then
            u50 = selectRandomSound(u50) or u50;
        end;
    end;

    local v54 = u1.get(u50, "EmitDelay", 0);
    local u55 = u1.get(u50, "EmitDuration", 0);
    local v56 = u1.get(u50, "EmitCount", 1);
    local Range = u1.getRange(u50, "EmitInterval", NumberRange.new(0, 0));
    local v57 = u1.get(u50, "RepeatCount", 1);
    local Range2 = u1.getRange(u50, "RepeatInterval", NumberRange.new(0, 0));
    task.wait(v54);
    local v58 = {};

    for i = 1, v56 do
        local u59 = v53 and u50;

        if not u59 then
            if v52 then
                u59 = u50;
            else
                u59 = selectRandomSound(u50) or u50;
            end;
        end;

        local v60;

        if u59 then
            local u61;

            if v53 and u59 ~= u50 then
                u61 = u59;
            else
                u61 = u50;
            end;

            v60 = i;

            for i2 = 1, v57 do
                table.insert(v58, u4.new(function(p62) -- Line: 283
                    -- upvalues: createSoundClone (ref), u50 (ref), u59 (copy), u51 (copy), playSingleSound (ref), u61 (copy), u55 (copy)
                    local v63, v64 = createSoundClone(u50, u59, u51);
                    playSingleSound(u50, u61, v63, v64, u51, u55);

                    if v64 then
                        v64:Destroy();
                    else
                        v63:Destroy();
                    end;

                    p62();
                end));
                local v65;

                if i2 < v57 and Range2.Max > 0 then
                    task.wait(Random_new_ret:NextNumber(Range2.Min, Range2.Max));
                    v65 = i2;
                else
                    v65 = i2;
                end;
            end;

            if v60 < v56 and Range.Max > 0 then
                task.wait(Random_new_ret:NextNumber(Range.Min, Range.Max));
            end;
        else
            v60 = i;
        end;
    end;

    u4.all(v58):await();
end;

return v5;