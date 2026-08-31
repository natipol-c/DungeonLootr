--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Particles
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.Particles
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local Range = require(script.Parent.Range);
local u1 = {};

local function parseDuration(p2) -- Line: 6
    -- upvalues: Range (copy)
    if p2 == nil then
        return nil;
    end;

    if typeof(p2) == "number" then
        return p2;
    end;

    local v3 = {};

    for i in tostring(p2):gmatch("[^,]+") do
        local v4 = tonumber(i:match("^%s*(.-)%s*$"));

        if v4 then
            table.insert(v3, v4);
        end;
    end;

    if #v3 == 0 then
        return nil;
    end;

    if #v3 == 1 then
        return v3[1];
    end;

    local math_min_ret = math.min(v3[1], v3[2]);
    local math_max_ret = math.max(v3[1], v3[2]);

    return Range.RandomValueFromRange(NumberRange.new(math_min_ret, math_max_ret));
end;

function u1.Emit(p5: userdata) -- Line: 18
    for _, descendant in p5:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            task.delay(descendant:GetAttribute("EmitDelay") or 0.001, function() -- Line: 21
                -- upvalues: descendant (copy)
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end);
        end;
    end;
end;

function u1.EnableEmit(u6) -- Line: 28
    -- upvalues: parseDuration (copy)
    task.spawn(function() -- Line: 29
        -- upvalues: u6 (copy), parseDuration (ref)
        for _, descendant in u6:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                if descendant:GetAttribute("EmitCount") then
                    task.delay(descendant:GetAttribute("EmitDelay") or 0.001, function() -- Line: 33
                        -- upvalues: descendant (copy)
                        descendant:Emit(descendant:GetAttribute("EmitCount"));
                    end);
                end;

                if descendant:GetAttribute("EmitDuration") then
                    task.delay(descendant:GetAttribute("EmitDelay") or 0.001, function() -- Line: 38
                        -- upvalues: descendant (copy)
                        descendant.Enabled = true;
                        task.wait(descendant:GetAttribute("EmitDuration"));
                        descendant.Enabled = false;
                    end);
                end;
            end;

            if descendant:IsA("Trail") then
                local u7 = parseDuration(descendant:GetAttribute("EmitDuration"));

                if u7 and u7 > 0 then
                    task.delay(descendant:GetAttribute("EmitDelay") or 0.001, function() -- Line: 48
                        -- upvalues: descendant (copy), u7 (copy)
                        descendant.Enabled = true;
                        task.wait(u7);
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;
    end);
end;

function u1.EmitTrail(u8: userdata) -- Line: 59
    -- upvalues: parseDuration (copy)
    local u9 = parseDuration(u8:GetAttribute("EmitDuration"));

    if u9 and u9 > 0 then
        task.delay(u8:GetAttribute("EmitDelay") or 0.001, function() -- Line: 62
            -- upvalues: u8 (copy), u9 (copy)
            u8.Enabled = true;
            task.wait(u9);
            u8.Enabled = false;
        end);
    end;
end;

function u1.EnableEmitSingle(u10: userdata) -- Line: 70
    -- upvalues: parseDuration (copy)
    task.spawn(function() -- Line: 71
        -- upvalues: u10 (copy), parseDuration (ref)
        if u10:IsA("Trail") then
            local u11 = parseDuration(u10:GetAttribute("EmitDuration"));

            if u11 and u11 > 0 then
                task.delay(u10:GetAttribute("EmitDelay") or 0.001, function() -- Line: 75
                    -- upvalues: u10 (ref), u11 (copy)
                    u10.Enabled = true;
                    task.wait(u11);
                    u10.Enabled = false;
                end);
            end;
        end;

        if u10:IsA("ParticleEmitter") then
            if u10:GetAttribute("EmitCount") then
                task.delay(u10:GetAttribute("EmitDelay") or 0.001, function() -- Line: 84
                    -- upvalues: u10 (ref)
                    u10:Emit(u10:GetAttribute("EmitCount"));
                end);
            end;

            if u10:GetAttribute("EmitDuration") then
                task.delay(u10:GetAttribute("EmitDelay") or 0.001, function() -- Line: 89
                    -- upvalues: u10 (ref)
                    u10.Enabled = true;
                    task.wait(u10:GetAttribute("EmitDuration"));
                    u10.Enabled = false;
                end);
            end;
        end;
    end);
end;

function u1.EnableEmitChildrenAndRepeatForAttachments(u12) -- Line: 99
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 100
        -- upvalues: u12 (copy), u1 (ref)
        for _, child in u12:GetChildren() do
            u1.EnableEmitSingle(child);

            if child:IsA("Attachment") then
                u1.EnableEmitChildrenAndRepeatForAttachments(child);
            end;
        end;
    end);
end;

return u1;