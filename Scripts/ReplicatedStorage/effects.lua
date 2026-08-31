--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     effects
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.services.effects
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

require("../types");
local u1 = require("../mod/logger");
local u2 = require("../mod/utility");
local u3 = require("../emitters");
local u4 = require("../pkg/Promise");
local table_concat_ret = table.concat({
    "Beam",
    "Trail",
    "Sound",
    "ParticleEmitter",
    `.{u2.BEZIER_TAG}`,
    `.{u2.LIGHTNING_TAG}`,
    "Model",
    "RayValue",
    "BasePart[$Enabled=true]",
    "#Rings > Part",
    "#Lines > Part",
    "#Debris > Part"
}, ",");
local u5 = {};
local u6 = nil;

local function u7() -- Line: 39
end;

local u8 = {
    Finished = u4.resolve(),
    Clear = u7
};

function u5.init(p9) -- Line: 46
    -- upvalues: u6 (ref)
    u6 = p9;
end;

function u5.deinit() -- Line: 50
    -- upvalues: u6 (ref)
    u6 = nil;
end;

local function emitWithContext(p10: number, u11: table?, ...) -- Line: 54
    -- upvalues: u6 (ref), u1 (copy), u8 (copy), table_concat_ret (copy), u2 (copy), u5 (copy), u3 (copy), u4 (copy), u7 (copy)
    if not (u6 and u6.setup) then
        u1.error("effects service not initialized");

        return u8;
    end;

    local u12 = {};
    local u13 = {};

    local function queryAndEmitDescendants(p14: userdata, p15: number) -- Line: 68
        -- upvalues: table_concat_ret (ref), u2 (ref), u5 (ref), u3 (ref), u12 (copy), u13 (copy), u6 (ref), u11 (copy)
        local v16 = p14:QueryDescendants(table_concat_ret);
        local v17 = #v16;

        if v17 == 0 then
            return {};
        end;

        local table_create_ret = table.create(v17);
        local v18 = {};
        local v19 = {};
        v18[p14] = false;
        v19[p14] = p15;

        for _, v in v16 do
            local Parent = v.Parent;
            local u20 = v;
            local v21 = {};

            while v19[Parent] == nil do
                table.insert(v21, Parent);
                Parent = Parent.Parent;
            end;

            local v22 = v18[Parent];
            local v23 = v19[Parent];

            for i = #v21, 1, -1 do
                local v24 = v21[i];
                v23 = v23 + 1;
                v19[v24] = v23;
                v22 = v22 or (u2.shouldSkipNested(v24) or v24:HasTag(u2.EMIT_EXCLUDE_TAG));
                v18[v24] = v22;
                local _ = i;
            end;

            if not v22 then
                table.insert(table_create_ret, u2.createEmitPromise(u5, u20, v19[u20.Parent], function(p25) -- Line: 112
                    -- upvalues: u3 (ref), u20 (copy), u12 (ref), u13 (ref), u6 (ref)
                    u3.dispatch(u20, p25, u12, u13, u6.caches.shared_part, 1);
                end, u11));
            end;
        end;

        return table_create_ret;
    end;

    local v26 = {};

    for _, v in { ... } do
        if v:IsA("BasePart") and (v:GetAttribute("Enabled") and not u2.findFirstClassWithTag(v, "Attachment", u2.SHOCKWAVE_TAG)) then
            if not u2.lock(v) then
                local v27 = v:FindFirstAncestorOfClass("Model");

                if not v27 or u2.isSpinModelStatic(v27) then
                    local coroutine_running_ret = coroutine.running();
                    local u28 = {
                        depth = p10,
                        effects = u5,
                        _context = u11
                    };

                    if u3.screen(v, u28) then
                        local v29 = queryAndEmitDescendants(v, p10 + 1);

                        if #v29 > 0 then
                            local v30 = u4.all(v29);
                            table.insert(v26, v30:finally(function() -- Line: 154
                                -- upvalues: u2 (ref), v (copy), coroutine_running_ret (copy), u28 (copy)
                                u2.unlock(v, coroutine_running_ret);
                                u2.cleanupScope(u28);
                            end));
                        else
                            u2.unlock(v, coroutine_running_ret);
                            u2.cleanupScope(u28);
                        end;
                    end;
                end;
            end;
        else
            table.insert(v26, u2.createEmitPromise(u5, v, p10, function(p31) -- Line: 168
                -- upvalues: u3 (ref), v (copy), u12 (copy), u13 (copy), u6 (ref)
                u3.dispatch(v, p31, u12, u13, u6.caches.shared_part, 1);
            end, u11));

            if not u2.shouldSkipNested(v) then
                for _, v2 in queryAndEmitDescendants(v, p10 + 1) do
                    table.insert(v26, v2);
                end;
            end;
        end;
    end;

    local u32 = {
        Finished = u4.all(v26)
    };
    u32.Clear = u11 and function() -- Line: 187
        -- upvalues: u11 (copy), u32 (copy)
        for _, v in u11._promises do
            v:cancel();
        end;

        u32.Finished:cancel();
    end or u7;

    return u32;
end;

function u5.emit(p33: number, ...) -- Line: 198
    -- upvalues: emitWithContext (copy)
    return emitWithContext(p33, {
        _promises = {}
    }, ...);
end;

function u5.prepareEmitFolder(p34: userdata, p35: string, p36: any) -- Line: 203
    local v37 = p34:FindFirstChild(p35);

    if not (v37 and v37:IsA("Folder")) then
        return nil;
    end;

    v37.Parent = nil;
    table.insert(p36, v37);

    return v37;
end;

function u5.prepareEmitOnFinish(p38: userdata, p39: any) -- Line: 215
    -- upvalues: u5 (copy)
    return u5.prepareEmitFolder(p38, "EmitOnFinish", p39);
end;

function u5.emitNested(p40: userdata, p41: number, p42: any) -- Line: 219
    -- upvalues: u6 (ref), u8 (copy), emitWithContext (copy)
    if not (u6 and u6.setup) then
        return u8;
    end;

    local Children = p40:GetChildren();

    if #Children == 0 then
        return u8;
    end;

    local v43;

    if p42 then
        v43 = p42._context;
    else
        v43 = nil;
    end;

    return emitWithContext(p41, v43, table.unpack(Children));
end;

function u5.emitFromFolder(p44: userdata?, p45: userdata, p46: number, p47: any) -- Line: 234
    -- upvalues: u8 (copy), emitWithContext (copy)
    if not p44 then
        return u8;
    end;

    local Children = p44:GetChildren();

    if #Children == 0 then
        return u8;
    end;

    for _, v in Children do
        v.Parent = p45;
    end;

    local v48;

    if p47 then
        v48 = p47._context;
    else
        v48 = nil;
    end;

    return emitWithContext(p46, v48, table.unpack(Children));
end;

function u5.emitOnFinish(p49: userdata?, p50: userdata, p51: number, p52: any) -- Line: 258
    -- upvalues: u5 (copy)
    return u5.emitFromFolder(p49, p50, p51, p52);
end;

return u5;