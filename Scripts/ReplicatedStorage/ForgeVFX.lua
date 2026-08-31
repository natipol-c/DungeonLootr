--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ForgeVFX
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require("@self/mod/logger");
local u2 = require("@self/mod/utility");
local u3 = require("@self/mod/attributes");
local u4 = require("@self/effects/sound");
local u5 = require("@self/effects/bezier");
local u6 = require("@self/effects/lightning");
local u7 = require("@self/effects/camera_shake");
local u8 = require("@self/effects/shockwave_ring");
local u9 = require("@self/effects/shockwave_line");
local u10 = require("@self/effects/shockwave_debris");
local u11 = require("@self/services/caches");
local u12 = require("@self/services/effects");
local u13 = require("@self/services/texture_loader");
local u14 = require("@self/services/enabled_effects");
local PLUGIN_CONTEXT = u2.PLUGIN_CONTEXT;
local SERVER_CONTEXT = u2.SERVER_CONTEXT;
local u15 = {
    scope = {},
    setup = false
};

function u15.init(p16: table?) -- Line: 117
    -- upvalues: u15 (copy), SERVER_CONTEXT (copy), u2 (copy), u1 (copy), RunService (copy), PLUGIN_CONTEXT (copy), u11 (copy), u12 (copy), u13 (copy), u14 (copy), u4 (copy), u7 (copy), u5 (copy), u6 (copy), u8 (copy), u9 (copy), u10 (copy)
    if u15.setup then
        return;
    end;

    if SERVER_CONTEXT then
        task.spawn(function() -- Line: 123
            -- upvalues: u2 (ref), u1 (ref)
            local v17 = 0;

            while true do
                v17 = v17 + 1;
                local success, result = pcall(u2.setCollisionGroups, u2.COLLISION_GROUPS);

                if not success then
                    task.wait(v17);
                end;

                if success or v17 >= 5 then
                    if not success then
                        u1.warn((`couldn't register necessary collision groups after {v17} tries with the last error being: {result}`));
                    end;

                    return;
                end;
            end;
        end);
    end;

    u15.setup = true;

    if RunService:IsServer() and not PLUGIN_CONTEXT then
        return;
    end;

    u15.caches = u11.init(u15.scope);
    shared.vfx = u15;
    u12.init(u15);
    u13.init(u15.scope);
    u14.init(u15.scope, u15.caches.shared_part, u12);
    u4.init();
    u7.init();
    u5.init(u15.caches.shared_part);
    u6.init(u15.caches.shared_part);
    u8.init(u15.caches.shared_part);
    u9.init(u15.caches.shared_part);
    u10.init(u15.caches.shared_part);
end;

function u15.deinit() -- Line: 177
    -- upvalues: u15 (copy), RunService (copy), PLUGIN_CONTEXT (copy), u2 (copy), u12 (copy), u4 (copy), u5 (copy), u6 (copy), u7 (copy), u8 (copy), u9 (copy), u10 (copy), CollectionService (copy)
    if not u15.setup then
        return;
    end;

    u15.setup = false;
    shared.vfx = nil;

    if RunService:IsServer() and not PLUGIN_CONTEXT then
        return;
    end;

    u2.cleanupScope(u15.scope);
    u12.deinit();
    u4.deinit();
    u5.deinit();
    u6.deinit();
    u7.deinit();
    u8.deinit();
    u9.deinit();
    u10.deinit();

    for _, v in CollectionService:GetTagged(u2.CLEANUP_TAG) do
        v:Destroy();
    end;
end;

local function fullEmit(p18: number, p19: number, ...) -- Line: 209
    -- upvalues: u15 (copy), u1 (copy), u12 (copy)
    if not u15.setup then
        u1.error("not initialized");
    end;

    return u12.emit(p19, ...);
end;

function u15.emit(p20, ...) -- Line: 217
    -- upvalues: fullEmit (copy)
    if typeof(p20) == "number" then
        return fullEmit(p20, 0, ...);
    end;

    return fullEmit(1, 0, p20, ...);
end;

function u15.emitWithDepth(p21: number, ...) -- Line: 225
    -- upvalues: fullEmit (copy)
    return fullEmit(1, p21, ...);
end;

function u15.cacheAttributes(p22: userdata, p23: boolean) -- Line: 229
    -- upvalues: u2 (copy), u1 (copy), ReplicatedStorage (copy), u3 (copy)
    if u2.SERVER_CONTEXT then
        u1.error("attributes can only be cached in a client-side context");
    end;

    if not p22:IsDescendantOf(ReplicatedStorage) then
        u1.error("attributes can only be cached for VFX inside ReplicatedStorage");
    end;

    u3.cache(p22);

    if p23 then
        return;
    end;

    for _, descendant in p22:GetDescendants() do
        u3.cache(descendant);
    end;
end;

function u15.restoreAttributes(p24: userdata, p25: boolean?) -- Line: 249
    -- upvalues: u2 (copy), u1 (copy), u3 (copy)
    if u2.SERVER_CONTEXT then
        u1.error("attributes can only be restored in a client-side context");
    end;

    u3.restore(p24);

    if p25 then
        return;
    end;

    for _, descendant in p24:GetDescendants() do
        u3.restore(descendant);
    end;
end;

local function setEnabled(p26: userdata, p27: boolean) -- Line: 265
    -- upvalues: u3 (copy)
    if p26:IsA("ParticleEmitter") then
        p26.Enabled = p27;

        return;
    end;

    if p26:IsA("Beam") then
        p26.Enabled = p27;

        return;
    end;

    if u3.isCached(p26) then
        u3.trigger(p26, "Enabled", p27);

        return;
    end;

    p26:SetAttribute("Enabled", p27);
end;

function u15.enable(p28: userdata) -- Line: 281
    -- upvalues: setEnabled (copy)
    setEnabled(p28, true);

    for _, descendant in p28:GetDescendants() do
        setEnabled(descendant, true);
    end;
end;

function u15.disable(p29: userdata) -- Line: 289
    -- upvalues: setEnabled (copy)
    setEnabled(p29, false);

    for _, descendant in p29:GetDescendants() do
        setEnabled(descendant, false);
    end;
end;

u15.retime = require("@self/mod/retime").batch;
u15.resize = require("@self/mod/resize").batch;
u15.recolor = require("@self/mod/recolor");

return u15;