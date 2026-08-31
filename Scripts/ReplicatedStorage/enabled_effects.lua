--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     enabled_effects
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.services.enabled_effects
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
require("../types");
local u2 = require("../mod/utility");
local u3 = require("../emitters");

return {
    init = function(p4, u5, u6) -- Line: 11, Name: init
        -- upvalues: u2 (copy), u3 (copy), u1 (copy), RunService (copy), CollectionService (copy)
        local u7 = {};
        local u8 = {};

        local function removeEnabledEffect(p9: userdata) -- Line: 15
            -- upvalues: u7 (copy), u2 (ref)
            local v10 = u7[p9];

            if v10 then
                u2.cleanupScope(v10);
            end;

            u7[p9] = nil;
        end;

        local function removeEnabledEffectFull(p11: userdata) -- Line: 25
            -- upvalues: u7 (copy), u2 (ref), u8 (copy)
            local v12 = u7[p11];

            if v12 then
                u2.cleanupScope(v12);
            end;

            u7[p11] = nil;
            local v13 = u8[p11];

            if v13 then
                v13:Disconnect();
                u8[p11] = nil;
            end;
        end;

        local function addEnabledEffect(u14: userdata) -- Line: 36
            -- upvalues: u3 (ref), u7 (copy), u8 (copy), addEnabledEffect (copy), u2 (ref), u1 (ref), RunService (ref), u6 (copy), u5 (copy)
            local u15 = nil;

            for _, v in u3.enabled_registry do
                if v.check(u14) then
                    u15 = v;
                    break;
                end;
            end;

            if not u15 then
                return;
            end;

            local u16 = {};
            local v17 = {};
            table.insert(v17, u16);
            u7[u14] = v17;

            if not u8[u14] then
                u8[u14] = u14.AncestryChanged:Connect(function() -- Line: 59
                    -- upvalues: u14 (copy), u7 (ref), addEnabledEffect (ref), u2 (ref)
                    if u14:IsDescendantOf(workspace) or u14.Parent and u14.Parent:HasTag("AllowEmitting") then
                        if not u7[u14] then
                            addEnabledEffect(u14);
                        end;
                    else
                        local v18 = u14;
                        local v19 = u7[v18];

                        if v19 then
                            u2.cleanupScope(v19);
                        end;

                        u7[v18] = nil;
                    end;
                end);
            end;

            local function onEnabled(p20: boolean?) -- Line: 70
                -- upvalues: u1 (ref), u14 (copy), u2 (ref), u16 (copy), RunService (ref), u6 (ref), u15 (ref), u5 (ref)
                if p20 == nil then
                    p20 = u1.get(u14, "Enabled", true);
                end;

                local v21 = u2.isForceEmitting(u14) or u14:IsDescendantOf(workspace) or u14.Parent and u14.Parent:HasTag("AllowEmitting");

                if p20 and not v21 then
                    return;
                end;

                if not p20 then
                    u2.cleanupScope(u16);

                    return;
                end;

                u2.cleanupScope(u16);
                local u22 = 0;
                local u23 = {
                    _promises = {},
                    _scopes = {}
                };
                u2.setEnabledCancelToken(u14, u23);
                table.insert(u16, RunService.RenderStepped:Connect(function() -- Line: 93
                    -- upvalues: u1 (ref), u14 (ref), u22 (ref), u6 (ref), u23 (copy), u15 (ref), u5 (ref), u2 (ref)
                    local v24 = u1.get(u14, "Rate", 5);
                    local State = u1.getState(u14, "SpeedOverride", 1);

                    if State == 0 then
                        return;
                    end;

                    if os.clock() - u22 <= 1 / v24 / State then
                        return;
                    end;

                    u22 = os.clock();
                    local v25 = {
                        depth = 0,
                        effects = u6,
                        _context = u23
                    };
                    table.insert(u23._scopes, v25);
                    u15.emit(u14, v25, u5);
                    local table_find_ret = table.find(u23._scopes, v25);

                    if table_find_ret then
                        table.remove(u23._scopes, table_find_ret);
                    end;

                    u2.cleanupScope(v25);
                end));
            end;

            table.insert(v17, u1.hook(u14, "Enabled", onEnabled));
            onEnabled();
        end;

        for _, v in CollectionService:GetTagged(u2.ENABLED_VFX_TAG) do
            addEnabledEffect(v);
        end;

        CollectionService:GetInstanceAddedSignal(u2.ENABLED_VFX_TAG):Connect(addEnabledEffect);
        CollectionService:GetInstanceRemovedSignal(u2.ENABLED_VFX_TAG):Connect(removeEnabledEffectFull);
        table.insert(p4, function() -- Line: 141
            -- upvalues: u7 (copy), u2 (ref), u8 (copy)
            for _, v in u7 do
                u2.cleanupScope(v);
            end;

            for _, v in u8 do
                v:Disconnect();
            end;

            table.clear(u8);
        end);
    end
};