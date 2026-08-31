--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     janitor
  Path:     game.ReplicatedStorage.Packages._Index.howmanysmall_janitor@1.18.3.janitor
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local script_FastDefer = require(script.FastDefer);
local script_Promise = require(script.Promise);
local u1 = setmetatable({}, {
    __tostring = function() -- Line: 17, Name: __tostring
        return "LinkToInstanceIndex";
    end
});
local u2 = {
    ClassName = "Janitor",
    CurrentlyCleaning = true,
    SuppressInstanceReDestroy = false,
    UnsafeThreadCleanup = false
};
u2.__index = u2;
local u3 = setmetatable({}, {
    __mode = "ks"
});
local u4 = {
    ["function"] = true,
    thread = true,
    RBXScriptConnection = "Disconnect"
};

function u2.new() -- Line: 162
    -- upvalues: u2 (copy)
    return setmetatable({
        CurrentlyCleaning = false
    }, u2);
end;

function u2.Is(p5) -- Line: 175
    -- upvalues: u2 (copy)
    local v6;

    if type(p5) == "table" then
        v6 = getmetatable(p5) == u2;
    else
        v6 = false;
    end;

    return v6;
end;

u2.instanceof = u2.Is;
local game_Destroy = game.Destroy;

local function Remove(p7, p8) -- Line: 193
    -- upvalues: u3 (copy), script_FastDefer (copy), game_Destroy (copy)
    local v9 = u3[p7];

    if v9 then
        local u10 = v9[p8];

        if not u10 then
            return p7;
        end;

        local v11 = p7[u10];

        if v11 then
            if v11 == true then
                if type(u10) == "function" then
                    u10();
                else
                    local v12;

                    if coroutine.running() == u10 then
                        v12 = nil;
                    else
                        v12 = pcall(function() -- Line: 210
                            -- upvalues: u10 (copy)
                            task.cancel(u10);
                        end);
                    end;

                    if not v12 then
                        if p7.UnsafeThreadCleanup then
                            script_FastDefer(function() -- Line: 218
                                -- upvalues: u10 (copy)
                                task.cancel(u10);
                            end);
                        else
                            task.defer(function() -- Line: 222
                                -- upvalues: u10 (copy)
                                task.cancel(u10);
                            end);
                        end;
                    end;
                end;
            elseif v11 == "Destroy" then
                if p7.SuppressInstanceReDestroy and typeof(u10) == "Instance" then
                    pcall(game_Destroy, u10);
                else
                    local Destroy = u10.Destroy;

                    if Destroy then
                        Destroy(u10);
                    end;
                end;
            elseif v11 == "Disconnect" then
                local Disconnect = u10.Disconnect;

                if Disconnect then
                    Disconnect(u10);
                end;
            else
                local v13 = u10[v11];

                if v13 then
                    v13(u10);
                end;
            end;

            p7[u10] = nil;
        end;

        v9[p8] = nil;
    end;

    return p7;
end;

local function Add(p14, p15, p16, p17) -- Line: 262
    -- upvalues: Remove (copy), u3 (copy), u4 (copy)
    if p17 then
        Remove(p14, p17);
        local v18 = u3[p14];

        if not v18 then
            v18 = {};
            u3[p14] = v18;
        end;

        v18[p17] = p15;
    end;

    local v19 = typeof(p15);
    local v20 = p16 or (u4[v19] or "Destroy");

    if v19 == "function" or v19 == "thread" then
        if v20 ~= true then
            warn(string.format("Object is a %* and as such expected `true?` for the method name and instead got %*. Traceback: %*", v19, tostring(v20), debug.traceback(nil, 2)));
        end;
    elseif not p15[v20] then
        warn(string.format("Object %* doesn\'t have method %*, are you sure you want to add it? Traceback: %*", tostring(p15), tostring(v20), debug.traceback(nil, 2)));
    end;

    p14[p15] = v20;

    return p15;
end;

u2.Add = Add;

function u2.AddObject(p21: table, p22: table, p23: any, p24: any, ...) -- Line: 415
    -- upvalues: Add (copy)
    return Add(p21, p22.new(...), p23, p24);
end;

function u2.Get(p25, p26) -- Line: 419
    -- upvalues: u3 (copy)
    local v27 = u3[p25];

    if v27 then
        return v27[p26];
    end;

    return nil;
end;

function u2.AddPromise(u28, u29, p30) -- Line: 486
    -- upvalues: script_Promise (copy), Add (copy), u3 (copy), Remove (copy)
    if not script_Promise then
        return u29;
    end;

    if not script_Promise.is(u29) then
        error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %* (%*)) Traceback: %*", typeof(u29), tostring(u29), debug.traceback(nil, 2)));
    end;

    if u29:getStatus() ~= script_Promise.Status.Started then
        return u29;
    end;

    local u31 = p30;

    if u31 == nil then
        u31 = newproxy(false);
    end;

    local u35 = Add(u28, script_Promise.new(function(p32, p33, p34) -- Line: 504
        -- upvalues: u29 (copy)
        if p34(function() -- Line: 505
            -- upvalues: u29 (ref)
            u29:cancel();
        end) then
            return;
        end;

        p32(u29);
    end), "cancel", u31);
    u35:finally(function() -- Line: 514
        -- upvalues: u28 (copy), u31 (ref), u3 (ref), u35 (copy), Remove (ref)
        local v36 = u31;
        local v37 = u3[u28];
        local v38;

        if v37 then
            v38 = v37[v36];
        else
            v38 = nil;
        end;

        if v38 == u35 then
            Remove(u28, u31);
        end;
    end);

    return u35;
end;

u2.Remove = Remove;

function u2.RemoveNoClean(p39, p40) -- Line: 585
    -- upvalues: u3 (copy)
    local v41 = u3[p39];
    local v42 = v41 and v41[p40];

    if v42 then
        p39[v42] = nil;
        v41[p40] = nil;
    end;

    return p39;
end;

function u2.RemoveList(p43, ...) -- Line: 640
    -- upvalues: u3 (copy), Remove (copy)
    if u3[p43] then
        local v44 = select("#", ...);

        if v44 == 1 then
            return Remove(p43, ...);
        end;

        if v44 == 2 then
            local v45, v46 = ...;
            Remove(p43, v45);
            Remove(p43, v46);

            return p43;
        end;

        if v44 == 3 then
            local v47, v48, v49 = ...;
            Remove(p43, v47);
            Remove(p43, v48);
            Remove(p43, v49);

            return p43;
        end;

        for i = 1, v44 do
            Remove(p43, (select(i, ...)));
            local _ = i;
        end;
    end;

    return p43;
end;

function u2.RemoveListNoClean(p50, ...) -- Line: 711
    -- upvalues: u3 (copy)
    local v51 = u3[p50];

    if v51 then
        local v52 = select("#", ...);

        if v52 == 1 then
            local v53 = ...;
            local v54 = v51[v53];

            if v54 then
                p50[v54] = nil;
                v51[v53] = nil;
            end;

            return p50;
        end;

        if v52 == 2 then
            local v55, v56 = ...;
            local v57 = v51[v55];

            if v57 then
                p50[v57] = nil;
                v51[v55] = nil;
            end;

            local v58 = v51[v56];

            if v58 then
                p50[v58] = nil;
                v51[v56] = nil;
            end;

            return p50;
        end;

        if v52 == 3 then
            local v59, v60, v61 = ...;
            local v62 = v51[v59];

            if v62 then
                p50[v62] = nil;
                v51[v59] = nil;
            end;

            local v63 = v51[v60];

            if v63 then
                p50[v63] = nil;
                v51[v60] = nil;
            end;

            local v64 = v51[v61];

            if v64 then
                p50[v64] = nil;
                v51[v61] = nil;
            end;

            return p50;
        end;

        for i = 1, v52 do
            local v65 = select(i, ...);
            local v66 = v51[v65];
            local v67;

            if v66 then
                p50[v66] = nil;
                v51[v65] = nil;
                v67 = i;
            else
                v67 = i;
            end;
        end;
    end;

    return p50;
end;

function u2.GetAll(p68) -- Line: 796
    -- upvalues: u3 (copy)
    local v69 = u3[p68];

    return not v69 and {} or table.freeze(table.clone(v69));
end;

local function Cleanup(p70) -- Line: 824
    -- upvalues: script_FastDefer (copy), game_Destroy (copy), u3 (copy)
    if not p70.CurrentlyCleaning then
        local SuppressInstanceReDestroy = p70.SuppressInstanceReDestroy;
        local UnsafeThreadCleanup = p70.UnsafeThreadCleanup;
        p70.CurrentlyCleaning = nil;
        p70.SuppressInstanceReDestroy = nil;
        p70.UnsafeThreadCleanup = nil;
        local u71, v72 = next(p70);

        while u71 and v72 do
            if v72 == true then
                if type(u71) == "function" then
                    u71();
                else
                    local v73;

                    if coroutine.running() == u71 then
                        v73 = nil;
                    else
                        v73 = pcall(function() -- Line: 841
                            -- upvalues: u71 (ref)
                            task.cancel(u71);
                        end);
                    end;

                    if not v73 then
                        local u74 = u71;

                        if UnsafeThreadCleanup then
                            script_FastDefer(function() -- Line: 849
                                -- upvalues: u74 (copy)
                                task.cancel(u74);
                            end);
                        else
                            task.defer(function() -- Line: 853
                                -- upvalues: u74 (copy)
                                task.cancel(u74);
                            end);
                        end;
                    end;
                end;
            elseif v72 == "Destroy" then
                if p70.SuppressInstanceReDestroy and typeof(u71) == "Instance" then
                    pcall(game_Destroy, u71);
                else
                    local Destroy = u71.Destroy;

                    if Destroy then
                        Destroy(u71);
                    end;
                end;
            elseif v72 == "Disconnect" then
                local Disconnect = u71.Disconnect;

                if Disconnect then
                    Disconnect(u71);
                end;
            else
                local v75 = u71[v72];

                if v75 then
                    v75(u71);
                end;
            end;

            p70[u71] = nil;
            u71, v72 = next(p70, u71);
        end;

        local v76 = u3[p70];

        if v76 then
            table.clear(v76);
            u3[p70] = nil;
        end;

        p70.CurrentlyCleaning = false;
        p70.SuppressInstanceReDestroy = SuppressInstanceReDestroy;
        p70.UnsafeThreadCleanup = UnsafeThreadCleanup;
    end;
end;

u2.Cleanup = Cleanup;

function u2.Destroy(p77) -- Line: 907
    -- upvalues: Cleanup (copy)
    Cleanup(p77);
    table.clear(p77);
    setmetatable(p77, nil);
end;

u2.__call = Cleanup;

local function LinkToInstance(u78: any, p79: userdata, p80: boolean?) -- Line: 915
    -- upvalues: u1 (copy), Add (copy), Cleanup (copy)
    local v81;

    if p80 then
        v81 = newproxy(false);
    else
        v81 = u1;
    end;

    return Add(u78, p79.Destroying:Connect(function() -- Line: 918
        -- upvalues: Cleanup (ref), u78 (copy)
        Cleanup(u78);
    end), "Disconnect", v81);
end;

u2.LinkToInstance = LinkToInstance;
u2.LegacyLinkToInstance = LinkToInstance;

function u2.LinkToInstances(p82, ...) -- Line: 981
    -- upvalues: u2 (copy), LinkToInstance (copy)
    local v83 = u2.new();

    for i = 1, select("#", ...) do
        local v84 = select(i, ...);
        local v85;

        if typeof(v84) == "Instance" then
            v83:Add(LinkToInstance(p82, v84, true), "Disconnect");
            v85 = i;
        else
            v85 = i;
        end;
    end;

    return v83;
end;

function u2.__tostring(p86) -- Line: 995
    return "Janitor";
end;

return u2;