--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     flipbook
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.common.flipbook
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u5 = {
    serialize = function(p1: table) -- Line: 6, Name: serialize
        local buffer_create_ret = buffer.create(#p1 * 8);

        for i, v in p1 do
            buffer.writef64(buffer_create_ret, (i - 1) * 8, v);
        end;

        return buffer_create_ret;
    end,

    deserialize = function(p2) -- Line: 16, Name: deserialize
        if typeof(p2) == "string" then
            p2 = buffer.fromstring(p2) or p2;
        end;

        local v3 = {};

        for i = 0, buffer.len(p2) / 8 - 1 do
            local buffer_readf64_ret = buffer.readf64(p2, i * 8);
            table.insert(v3, buffer_readf64_ret);
            local _ = i;
        end;

        return v3;
    end,

    isLocalFlipbook = function(p4: userdata) -- Line: 29, Name: isLocalFlipbook
        -- upvalues: RunService (copy), CollectionService (copy)
        if not RunService:IsStudio() then
            return false;
        end;

        for _, v in CollectionService:GetTags(p4) do
            if v:match("^_local_flipbook_") then
                return true;
            end;
        end;

        return false;
    end
};

function u5.getTexturePrefix(p6: userdata) -- Line: 43
    -- upvalues: u5 (copy)
    return u5.isLocalFlipbook(p6) and "rbxtemp://" or "rbxassetid://";
end;

function u5.getFlipbookData(p7: userdata) -- Line: 47
    -- upvalues: u5 (copy)
    if not p7:GetAttribute("FlipbookEnabled") then
        return nil;
    end;

    local Attribute = p7:GetAttribute("FlipbookTextures");

    if not Attribute then
        return nil;
    end;

    local v8 = u5.deserialize(Attribute);

    if #v8 == 0 then
        return nil;
    end;

    return v8;
end;

function u5.getChangeDuration(p9: table) -- Line: 81
    local duration = p9.duration;

    if p9.ref:GetAttribute("SyncDuration") then
        duration = p9.effectDuration;
    end;

    return duration;
end;

function u5.createUpdateCallback(u10: table) -- Line: 91
    -- upvalues: u5 (copy)
    local TexturePrefix = u5.getTexturePrefix(u10.ref);

    return function(p11, p12) -- Line: 94
        -- upvalues: u10 (copy), TexturePrefix (copy)
        local math_round_ret = math.round(#u10.frames * p11);
        local math_max_ret = math.max(math_round_ret, 1);
        u10.setTexture((`{TexturePrefix}{u10.frames[math_max_ret]}`));

        return p12 * u10.getSpeed();
    end;
end;

return u5;