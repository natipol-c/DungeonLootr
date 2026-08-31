--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ObjectCache
  Path:     game.ReplicatedStorage.Modules.ObjectCache
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local CFrame_new_ret = CFrame.new(16777216, 16777216, 16777216);
local table_create_ret = table.create(10000);
local table_create_ret2 = table.create(10000);
local u1 = false;
local coroutine_create_ret = coroutine.create(function() -- Line: 25, Name: UpdateMovement
    -- upvalues: table_create_ret (copy), table_create_ret2 (copy), u1 (ref)
    while true do
        workspace:BulkMoveTo(table_create_ret, table_create_ret2, Enum.BulkMoveMode.FireCFrameChanged);
        table.clear(table_create_ret);
        table.clear(table_create_ret2);
        u1 = false;
        coroutine.yield();
    end;
end);
local u2 = {};
u2.__index = u2;

function u2._GetNew(p3: table, p4: number, p5: boolean) -- Line: 41
    -- upvalues: CFrame_new_ret (copy)
    if p5 then
        warn((`ObjectCache: Cache retrieval exceeded preallocated amount! expanding by {p4}...`));
    end;

    local _FreeObjects = p3._FreeObjects;
    local v6 = #p3._FreeObjects;
    local CacheHolder = p3.CacheHolder;
    local _IsTemplateModel = p3._IsTemplateModel;
    local _Template = p3._Template;
    local table_create_ret3 = table.create(p4);
    local table_create_ret4 = table.create(p4);
    local table_create_ret5 = table.create(p4);

    for i = v6 + 1, v6 + p4 do
        local v7 = _Template:Clone();
        local v8;

        if _IsTemplateModel then
            v8 = v7.PrimaryPart;
        else
            v8 = v7;
        end;

        _FreeObjects[i] = v8;
        local v9 = i - v6;
        table_create_ret3[v9] = v8;
        table_create_ret4[v9] = CFrame_new_ret;
        table_create_ret5[v9] = v7;
        local _ = i;
    end;

    workspace:BulkMoveTo(table_create_ret3, table_create_ret4, Enum.BulkMoveMode.FireCFrameChanged);

    for _, v in table_create_ret5 do
        v.Parent = CacheHolder;
    end;

    return table.remove(_FreeObjects);
end;

function u2.GetPart(p10: table, p11) -- Line: 77
    -- upvalues: table_create_ret (copy), table_create_ret2 (copy), u1 (ref), coroutine_create_ret (copy)
    local v12 = table.remove(p10._FreeObjects) or p10:_GetNew(p10._ExpandAmount, true);
    p10._Objects[v12] = nil;

    if p11 then
        table.insert(table_create_ret, v12);
        table.insert(table_create_ret2, p11);

        if not u1 then
            u1 = true;
            task.defer(coroutine_create_ret);
        end;
    end;

    return v12;
end;

function u2.ReturnPart(p13: table, p14: userdata) -- Line: 93
    -- upvalues: table_create_ret (copy), table_create_ret2 (copy), CFrame_new_ret (copy), u1 (ref), coroutine_create_ret (copy)
    if p13._Objects[p14] then
        return;
    end;

    p13._Objects[p14] = true;
    table.insert(p13._FreeObjects, p14);
    table.insert(table_create_ret, p14);
    table.insert(table_create_ret2, CFrame_new_ret);

    if not u1 then
        u1 = true;
        task.defer(coroutine_create_ret);
    end;
end;

function u2.Update(p15) -- Line: 110
    -- upvalues: coroutine_create_ret (copy)
    task.spawn(coroutine_create_ret);
end;

function u2.ExpandCache(p16: table, p17: number) -- Line: 114
    local v18 = typeof(p17) ~= "number" and true or p17 >= 0;
    local v19 = `Invalid argument #1 to 'ObjectCache:ExpandCache' (positive number expected, got {typeof(p17)})`;
    assert(v18, v19);
    p16:_GetNew(p17, false);
end;

function u2.SetExpandAmount(p20: table, p21: number) -- Line: 118
    local v22 = typeof(p21) ~= "number" and true or p21 > 0;
    local v23 = `Invalid argument #1 to 'ObjectCache:SetExpandAmount' (positive number expected, got {typeof(p21)})`;
    assert(v22, v23);
    p20._ExpandAmount = p21;
end;

function u2.IsInUse(p24: table, p25: userdata) -- Line: 123
    return p24._Objects[p25] == nil;
end;

function u2.Destroy(p26) -- Line: 127
    p26.CacheHolder:Destroy();
end;

local function GetCacheContainer() -- Line: 131
    local Folder = Instance.new("Folder");
    Folder.Name = "ObjectCache";

    return Folder;
end;

return {
    new = function(p27: userdata, p28: number?, p29: userdata?) -- Line: 139, Name: new
        -- upvalues: CFrame_new_ret (copy), u2 (copy)
        local v30 = typeof(p27);
        local v31 = `Invalid argument #1 to 'ObjectCache.new' (BasePart expected, got {v30})`;
        assert(v30 == "Instance", v31);
        local v32 = p27:IsA("BasePart") or p27:IsA("Model");
        local v33 = `Invalid argument #1 to 'ObjectCache.new' (BasePart or Model expected, got {p27.ClassName})`;
        assert(v32, v33);
        assert(p27.Archivable, "ObjectCache: Cannot use template object provided, as it has Archivable set to false.");

        if p27:IsA("Model") then
            assert(p27.PrimaryPart ~= nil, "Invalid Template provided to \'ObjectCache.new\': Model has no PrimaryPart set!");
        end;

        local v34 = typeof(p28);
        local v35 = `Invalid argument #2 to 'ObjectCache.new' (number expected, got {v34})`;
        assert(p28 == nil and true or v34 == "number", v35);
        local v36 = `Invalid argument #2 to 'ObjectCache.new' (positive number expected, got {p28})`;
        assert(p28 == nil and true or p28 >= 0, v36);
        local v37 = typeof(p29);
        local v38 = `Invalid argument #3 to 'ObjectCache.new' (Instance expected, got {v37})`;
        assert(p29 == nil and true or v37 == "Instance", v38);
        local v39 = p28 or 10;
        local Folder = Instance.new("Folder");
        Folder.Name = "ObjectCache";
        local table_create_ret3 = table.create(v39);
        local table_create_ret4 = table.create(v39);
        local v40 = p27:IsA("Model");
        local v41 = {};

        for i = 1, v39 do
            local v42 = p27:Clone();
            local v43;

            if v40 then
                v43 = v42.PrimaryPart;
            else
                v43 = v42;
            end;

            table_create_ret3[i] = v42;
            table_create_ret4[i] = v43;
            v43.CFrame = CFrame_new_ret;
            v42.Parent = Folder;
            local _ = i;
        end;

        Folder.Parent = p29 or workspace;

        return setmetatable({
            _ExpandAmount = 50,
            CacheHolder = Folder,
            _Template = p27,
            _FreeObjects = table_create_ret4,
            _Objects = v41,
            _IsTemplateModel = v40,
            _PreallocatedAmount = v39
        }, u2);
    end
};