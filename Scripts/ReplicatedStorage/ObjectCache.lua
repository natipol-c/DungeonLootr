--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ObjectCache
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.obj.ObjectCache
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("../mod/utility");
local u2 = {};
u2.__index = u2;

local function reconcile(p3, p4) -- Line: 39
    for i, v in p4 do
        if p3[i] == nil then
            p3[i] = v;
        end;
    end;

    return p3;
end;

local table_create_ret = table.create(10000);
local table_create_ret2 = table.create(10000);
local u5 = false;
local coroutine_create_ret = coroutine.create(function() -- Line: 54
    -- upvalues: table_create_ret (copy), table_create_ret2 (copy), u5 (ref)
    while true do
        workspace:BulkMoveTo(table_create_ret, table_create_ret2, Enum.BulkMoveMode.FireCFrameChanged);
        table.clear(table_create_ret);
        table.clear(table_create_ret2);
        u5 = false;
        coroutine.yield();
    end;
end);

function u2.new(p6: userdata, p7: userdata?, p8: table?) -- Line: 67
    -- upvalues: u2 (copy)
    local u9 = setmetatable({}, u2);
    u9.ref = p6;
    u9.parent = p7;
    u9.amount = 0;
    u9.restore_amount = 0;
    local v10 = p8 or {};

    for i, v in {
        size = 100,
        excess_lifetime = 30
    } do
        if v10[i] == nil then
            v10[i] = v;
        end;
    end;

    u9.params = v10;
    u9.scope = { p6, p7 };
    u9.unused = table.create(u9.params.size);
    u9.item_map = {};
    u9.part_mode = p6:IsA("BasePart");

    for i = 1, u9.params.size do
        u9:_add();
        local _ = i;
    end;

    table.insert(u9.scope, task.spawn(function() -- Line: 93
        -- upvalues: u9 (copy)
        while true do
            repeat
                if not task.wait(15) then
                    return;
                end;

                if u9.restore_amount > 0 then
                    for i = 1, u9.restore_amount do
                        u9:_add();
                        local v11 = u9;
                        v11.restore_amount = v11.restore_amount - 1;
                        local _ = i;
                    end;
                end;
            until u9.amount > u9.params.size;

            local v12 = 0;

            for i = 1, #u9.unused do
                if u9.amount <= u9.params.size then
                    break;
                end;

                local v13 = i - v12;
                local v14 = u9.unused[v13];
                local v15;

                if v14.dependents == 0 and os.clock() - v14.added <= u9.params.excess_lifetime then
                    v14:destroy();
                    table.remove(u9.unused, v13);
                    u9.item_map[v14.key] = nil;
                    local v16 = u9;
                    v16.amount = v16.amount - 1;
                    v12 = v12 + 1;
                    v15 = i;
                else
                    v15 = i;
                end;
            end;
        end;
    end));

    return u9;
end;

function u2._add(u17: any, p18: any, p19: boolean?) -- Line: 137
    local u20 = u17.ref:Clone();
    u20.Archivable = false;
    u20.Parent = u17.parent;
    local u21 = {
        dependents = 1,
        key = p18,
        value = u20,
        added = os.clock()
    };
    local u22 = false;

    function u21.destroy(p23) -- Line: 152
        -- upvalues: u22 (ref), u20 (copy)
        u22 = true;
        u20:Destroy();
    end;

    u17.amount = u17.amount + 1;
    u20.Destroying:Connect(function() -- Line: 159
        -- upvalues: u22 (ref), u17 (copy), u21 (copy)
        if u22 then
            return;
        end;

        local table_find_ret = table.find(u17.unused, u21);

        if table_find_ret then
            table.remove(u17.unused, table_find_ret);
        end;

        if u21.key then
            u17.item_map[u21.key] = nil;
        end;

        local v24 = u17;
        v24.amount = v24.amount - 1;
        local v25 = u17;
        v25.restore_amount = v25.restore_amount + 1;
    end);

    if p18 then
        u17.item_map[p18] = u21;
    end;

    if not p19 then
        table.insert(u17.unused, u21);
    end;

    return u21;
end;

function u2.has(p26, p27) -- Line: 189
    return p26.item_map[p27] and true or false;
end;

function u2.peek(p28, p29) -- Line: 193
    return p28.item_map[p29];
end;

function u2.get(p30, p31) -- Line: 197
    -- upvalues: table_create_ret (copy), table_create_ret2 (copy), u5 (ref), coroutine_create_ret (copy)
    if p30:has(p31) then
        local v32 = p30:peek(p31);

        if v32 then
            v32.dependents = v32.dependents + 1;
        end;

        return v32.value;
    end;

    local table_remove_ret = table.remove(p30.unused);

    if table_remove_ret then
        table_remove_ret.key = p31;
        table_remove_ret.added = os.clock();
        p30.item_map[p31] = table_remove_ret;
    else
        table_remove_ret = p30:_add(p31, true);
    end;

    if p30.part_mode then
        return setmetatable({
            _getReal = function() -- Line: 249, Name: _getReal
                -- upvalues: table_remove_ret (ref)
                return table_remove_ret.value;
            end
        }, {
            __newindex = function(p33, p34, p35) -- Line: 222, Name: __newindex
                -- upvalues: table_create_ret (ref), table_remove_ret (ref), table_create_ret2 (ref), u5 (ref), coroutine_create_ret (ref)
                if p34 == "CFrame" then
                    table.insert(table_create_ret, table_remove_ret.value);
                    table.insert(table_create_ret2, p35);

                    if not u5 then
                        u5 = true;
                        task.defer(coroutine_create_ret);
                    end;
                else
                    table_remove_ret.value[p34] = p35;
                end;
            end,

            __index = function(p36, p37) -- Line: 236, Name: __index
                -- upvalues: table_remove_ret (ref)
                local u38 = table_remove_ret.value[p37];

                return typeof(u38) == "function" and function(p39, ...) -- Line: 240
                    -- upvalues: u38 (copy), table_remove_ret (ref)
                    return u38(table_remove_ret.value, ...);
                end or u38;
            end
        });
    end;

    return table_remove_ret.value;
end;

function u2.free(p40, p41) -- Line: 258
    local v42 = p40.item_map[p41];

    if not v42 then
        return;
    end;

    v42.dependents = math.max(v42.dependents - 1, 0);

    if v42.dependents == 0 then
        v42.added = os.clock();

        if p40.params.on_free then
            p40.params.on_free(v42);
        end;

        table.insert(p40.unused, v42);
    end;
end;

function u2.destroy(p43) -- Line: 278
    -- upvalues: u1 (copy)
    u1.cleanupScope(p43.scope);

    for _, v in p43.item_map do
        v.value:Destroy();
    end;

    table.clear(p43.unused);
    table.clear(p43.item_map);
end;

return u2;