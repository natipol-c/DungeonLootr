--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flipbook
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.Flipbook
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local ContentProvider = game:GetService("ContentProvider");
local Range = require(script.Parent.Range);
local v11 = {
    GetSortedTextures = function(p1: userdata) -- Line: 15, Name: GetSortedTextures
        -- upvalues: ContentProvider (copy)
        local v2 = {};

        for _, child in pairs(p1:GetChildren()) do
            if child.Texture then
                table.insert(v2, child);
            end;
        end;

        if #v2 == 0 then
            return {};
        end;

        table.sort(v2, function(p3, p4) -- Line: 24
            return (tonumber(p3.Name) or 0) < (tonumber(p4.Name) or 0);
        end);
        local u5 = {};

        for _, v in ipairs(v2) do
            table.insert(u5, v.Texture);
        end;

        if #u5 > 0 then
            task.spawn(function() -- Line: 35
                -- upvalues: ContentProvider (ref), u5 (copy)
                ContentProvider:PreloadAsync(u5);
            end);
        end;

        return u5;
    end,

    GetSortedBeamTextures = function(p6: userdata) -- Line: 44, Name: GetSortedBeamTextures
        -- upvalues: ContentProvider (copy)
        local v7 = {};

        for _, child in pairs(p6:GetChildren()) do
            if child:IsA("Decal") then
                table.insert(v7, child);
            end;
        end;

        if #v7 == 0 then
            return {};
        end;

        table.sort(v7, function(p8, p9) -- Line: 53
            return (tonumber(p8.Name) or 0) < (tonumber(p9.Name) or 0);
        end);
        local u10 = {};

        for _, v in ipairs(v7) do
            table.insert(u10, v.Texture);
        end;

        if #u10 > 0 then
            task.spawn(function() -- Line: 64
                -- upvalues: ContentProvider (ref), u10 (copy)
                ContentProvider:PreloadAsync(u10);
            end);
        end;

        return u10;
    end
};

local function _loop(p12, u13, u14, u15) -- Line: 73
    -- upvalues: Range (copy)
    if #u13 == 0 then
        return;
    end;

    local u16 = 1 / Range.RandomValueFromRange(p12.FlipbookFramerate);
    local u17 = p12.FlipbookStartRandom and (math.random(1, #u13) or 1) or 1;
    local os_clock_ret = os.clock();
    task.spawn(function() -- Line: 81
        -- upvalues: os_clock_ret (copy), u15 (copy), u14 (copy), u13 (copy), u17 (ref), u16 (copy)
        while os.clock() - os_clock_ret < u15 do
            u14.Texture = u13[u17];
            u17 = u17 + 1;

            if u17 > #u13 then
                u17 = 1;
            end;

            task.wait(u16);
        end;
    end);
end;

local function _oneShot(p18, u19, u20, p21) -- Line: 92
    if #u19 == 0 then
        return;
    end;

    local u22 = p21 / #u19;
    local u23 = p18.FlipbookStartRandom and (math.random(1, #u19) or 1) or 1;
    task.spawn(function() -- Line: 98
        -- upvalues: u19 (copy), u23 (ref), u20 (copy), u22 (copy)
        for i = 1, #u19 do
            if u23 > #u19 then
                break;
            end;

            u20.Texture = u19[u23];
            u23 = u23 + 1;
            task.wait(u22);
            local _ = i;
        end;
    end);
end;

function v11.Flip(p24: any, p25: table, p26: any, p27: any) -- Line: 108
    -- upvalues: _loop (copy), _oneShot (copy)
    if not (p24 and p24.FlipbookMode) then
        return;
    end;

    if p24.FlipbookMode == Enum.ParticleFlipbookMode.Loop then
        _loop(p24, p25, p26, p27);

        return;
    end;

    if p24.FlipbookMode == Enum.ParticleFlipbookMode.OneShot then
        _oneShot(p24, p25, p26, p27);
    end;
end;

function v11.FlipBeam(p28: any, p29: table, p30: any, p31: any) -- Line: 118
    -- upvalues: _loop (copy), _oneShot (copy)
    if not (p28 and (p29 and p28.FlipbookMode)) then
        return;
    end;

    local FlipbookMode = p28.FlipbookMode;

    if FlipbookMode == Enum.ParticleFlipbookMode.Loop then
        _loop(p28, p29, p30, p31);

        return;
    end;

    if FlipbookMode == Enum.ParticleFlipbookMode.OneShot then
        _oneShot(p28, p29, p30, p31);
    end;
end;

v11.Loop = _loop;
v11.OneShot = _oneShot;
v11.BeamLoop = _loop;
v11.BeamOneShot = _oneShot;

return v11;