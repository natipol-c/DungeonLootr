--[[
  Type:     ModuleScript
  Method:   cached
  Name:     varSetServer
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.varSetServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

local DataStoreService = game:GetService("DataStoreService");
local u1 = {};
local u2 = nil;
local u3 = nil;
task.spawn(function() -- Line: 5
    -- upvalues: u2 (ref), u3 (ref), DataStoreService (copy), u1 (copy)
    local success, result = pcall(function() -- Line: 6
        -- upvalues: DataStoreService (ref)
        local DataStore = DataStoreService:GetDataStore("_package/eryn.io/Cmdr");
        DataStore:GetAsync("test_key");

        return DataStore;
    end);
    u2 = success;
    u3 = result;

    while #u1 > 0 do
        coroutine.resume(table.remove(u1, 1));
    end;
end);

return function(p4, p5, p6) -- Line: 17
    -- upvalues: u2 (ref), u1 (copy), u3 (ref)
    if u2 == nil then
        table.insert(u1, coroutine.running());
        coroutine.yield();
    end;

    local v7 = true;
    local v8;

    if p5:sub(1, 1) == "$" then
        p5 = p5:sub(2);
        v8 = true;
    else
        v8 = false;
    end;

    if p5:sub(1, 1) == "." then
        p5 = p5:sub(2);
        v7 = false;
    end;

    if v7 and not u2 then
        return "# You must publish this place to the web to use saved keys.";
    end;

    local v9 = "var_" .. (v8 and "global" or tostring(p4.Executor.UserId));

    if v7 then
        u3:SetAsync(v9 .. "_" .. p5, p6);

        return type(p6) == "table" and (table.concat(p6, ",") or "") or p6;
    end;

    p4:GetStore(v9)[p5] = p6;

    return type(p6) == "table" and (table.concat(p6, ",") or "") or p6;
end;