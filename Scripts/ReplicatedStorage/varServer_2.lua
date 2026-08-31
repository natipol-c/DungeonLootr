--[[
  Type:     ModuleScript
  Method:   cached
  Name:     varServer
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.varServer
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

return function(p4, p5) -- Line: 17
    -- upvalues: u2 (ref), u1 (copy), u3 (ref)
    if u2 == nil then
        table.insert(u1, coroutine.running());
        coroutine.yield();
    end;

    local v6 = true;
    local v7;

    if p5:sub(1, 1) == "$" then
        p5 = p5:sub(2);
        v7 = true;
    else
        v7 = false;
    end;

    if p5:sub(1, 1) == "." then
        p5 = p5:sub(2);
        v6 = false;
    end;

    if v6 and not u2 then
        return "# You must publish this place to the web to use saved keys.";
    end;

    local v8 = "var_" .. (v7 and "global" or tostring(p4.Executor.UserId));

    if v6 then
        local v9 = u3:GetAsync(v8 .. "_" .. p5) or "";

        return type(v9) == "table" and (table.concat(v9, ",") or "") or v9;
    end;

    local v10 = p4:GetStore(v8)[p5] or "";

    return type(v10) == "table" and (table.concat(v10, ",") or "") or v10;
end;