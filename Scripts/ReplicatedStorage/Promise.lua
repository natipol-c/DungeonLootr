--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Promise
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.pkg.Promise
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    __mode = "k"
};

local function isCallable(p2) -- Line: 34
    if type(p2) == "function" then
        return true;
    end;

    local v3 = type(p2) == "table" and getmetatable(p2);

    if v3 then
        local v4 = rawget(v3, "__call");

        if type(v4) == "function" then
            return true;
        end;
    end;

    return false;
end;

local function makeEnum(u5, p6) -- Line: 52
    local v7 = {};

    for _, v in ipairs(p6) do
        v7[v] = v;
    end;

    return setmetatable(v7, {
        __index = function(p8, p9) -- Line: 60, Name: __index
            -- upvalues: u5 (copy)
            error(string.format("%s is not in %s!", p9, u5), 2);
        end,

        __newindex = function() -- Line: 63, Name: __newindex
            -- upvalues: u5 (copy)
            error(string.format("Creating new members in %s is not allowed!", u5), 2);
        end
    });
end;

local u10 = {
    Kind = makeEnum("Promise.Error.Kind", { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" })
};
u10.__index = u10;

function u10.new(p11, p12) -- Line: 88
    -- upvalues: u10 (ref)
    local v13 = p11 or {};
    local v14 = {
        error = tostring(v13.error) or "[This error has no error text.]",
        trace = v13.trace,
        context = v13.context,
        kind = v13.kind,
        parent = p12,
        createdTick = os.clock(),
        createdTrace = debug.traceback()
    };

    return setmetatable(v14, u10);
end;

function u10.is(p15) -- Line: 101
    if type(p15) == "table" then
        local v16 = getmetatable(p15);

        if type(v16) == "table" then
            local v17;

            if rawget(p15, "error") == nil then
                v17 = false;
            else
                local v18 = rawget(v16, "extend");
                v17 = type(v18) == "function";
            end;

            return v17;
        end;
    end;

    return false;
end;

function u10.isKind(p19, p20) -- Line: 113
    -- upvalues: u10 (ref)
    assert(p20 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil");
    local v21 = u10.is(p19) and p19.kind == p20;

    return v21;
end;

function u10.extend(p22, p23) -- Line: 119
    -- upvalues: u10 (ref)
    local v24 = p23 or {};
    v24.kind = v24.kind or p22.kind;

    return u10.new(v24, p22);
end;

function u10.getErrorChain(p25) -- Line: 127
    local v26 = { p25 };

    while v26[#v26].parent do
        table.insert(v26, v26[#v26].parent);
    end;

    return v26;
end;

function u10.__tostring(p27) -- Line: 137
    local v28 = { string.format("-- Promise.Error(%s) --", p27.kind or "?") };

    for _, v in ipairs(p27:getErrorChain()) do
        table.insert(v28, table.concat({ v.trace or v.error, v.context }, "\n"));
    end;

    return table.concat(v28, "\n");
end;

local function pack(...) -- Line: 161
    return select("#", ...), { ... };
end;

local function packResult(p29, ...) -- Line: 168
    return p29, select("#", ...), { ... };
end;

local function makeErrorHandler(u30) -- Line: 172
    -- upvalues: u10 (ref)
    assert(u30 ~= nil, "traceback is nil");

    return function(p31) -- Line: 175
        -- upvalues: u10 (ref), u30 (copy)
        if type(p31) == "table" then
            return p31;
        end;

        return u10.new({
            error = p31,
            kind = u10.Kind.ExecutionError,
            trace = debug.traceback(tostring(p31), 2),
            context = "Promise created at:\n\n" .. u30
        });
    end;
end;

local function runExecutor(u32, p33, ...) -- Line: 195
    -- upvalues: packResult (copy), u10 (ref)
    local v34 = xpcall;
    assert(u32 ~= nil, "traceback is nil");

    return packResult(v34(p33, function(p35) -- Line: 175
        -- upvalues: u10 (ref), u32 (copy)
        if type(p35) == "table" then
            return p35;
        end;

        return u10.new({
            error = p35,
            kind = u10.Kind.ExecutionError,
            trace = debug.traceback(tostring(p35), 2),
            context = "Promise created at:\n\n" .. u32
        });
    end, ...));
end;

local function createAdvancer(u36, u37, u38, u39) -- Line: 203
    -- upvalues: runExecutor (copy)
    return function(...) -- Line: 204
        -- upvalues: runExecutor (ref), u36 (copy), u37 (copy), u38 (copy), u39 (copy)
        local v40, v41, v42 = runExecutor(u36, u37, ...);

        if v40 then
            u38(unpack(v42, 1, v41));

            return;
        end;

        u39(v42[1]);
    end;
end;

local function isEmpty(p43) -- Line: 215
    return next(p43) == nil;
end;

local u44 = {
    Error = u10,
    Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
    _getTime = os.clock,
    _timeEvent = game:GetService("RunService").Heartbeat,
    _unhandledRejectionCallbacks = {},
    prototype = {}
};
u44.__index = u44.prototype;

function u44._new(p45, u46, p47) -- Line: 254
    -- upvalues: u44 (copy), u1 (copy), runExecutor (copy)
    if p47 ~= nil and not u44.is(p47) then
        error("Argument #2 to Promise.new must be a promise or nil", 2);
    end;

    local u48 = {
        _thread = nil,
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = true,
        _cancellationHook = nil,
        _source = p45,
        _status = u44.Status.Started,
        _queuedResolve = {},
        _queuedReject = {},
        _queuedFinally = {},
        _parent = p47,
        _consumers = setmetatable({}, u1)
    };

    if p47 and p47._status == u44.Status.Started then
        p47._consumers[u48] = true;
    end;

    setmetatable(u48, u44);

    local function resolve(...) -- Line: 302
        -- upvalues: u48 (copy)
        u48:_resolve(...);
    end;

    local function reject(...) -- Line: 306
        -- upvalues: u48 (copy)
        u48:_reject(...);
    end;

    local function onCancel(p49) -- Line: 310
        -- upvalues: u48 (copy), u44 (ref)
        if p49 then
            if u48._status == u44.Status.Cancelled then
                p49();
            else
                u48._cancellationHook = p49;
            end;
        end;

        return u48._status == u44.Status.Cancelled;
    end;

    u48._thread = coroutine.create(function() -- Line: 322
        -- upvalues: runExecutor (ref), u48 (copy), u46 (copy), resolve (copy), reject (copy), onCancel (copy)
        local v50, _, v51 = runExecutor(u48._source, u46, resolve, reject, onCancel);

        if not v50 then
            reject(v51[1]);
        end;
    end);
    task.spawn(u48._thread);

    return u48;
end;

function u44.new(p52) -- Line: 373
    -- upvalues: u44 (copy)
    return u44._new(debug.traceback(nil, 2), p52);
end;

function u44.__tostring(p53) -- Line: 377
    return string.format("Promise(%s)", p53._status);
end;

function u44.defer(u54) -- Line: 399
    -- upvalues: u44 (copy), runExecutor (copy)
    local debug_traceback_ret = debug.traceback(nil, 2);

    return u44._new(debug_traceback_ret, function(u55, u56, u57) -- Line: 402
        -- upvalues: runExecutor (ref), debug_traceback_ret (copy), u54 (copy)
        task.defer(function() -- Line: 403
            -- upvalues: runExecutor (ref), debug_traceback_ret (ref), u54 (ref), u55 (copy), u56 (copy), u57 (copy)
            local v58, _, v59 = runExecutor(debug_traceback_ret, u54, u55, u56, u57);

            if not v58 then
                u56(v59[1]);
            end;
        end);
    end);
end;

u44.async = u44.defer;

function u44.resolve(...) -- Line: 440
    -- upvalues: pack (copy), u44 (copy)
    local u60, u61 = pack(...);

    return u44._new(debug.traceback(nil, 2), function(p62) -- Line: 442
        -- upvalues: u61 (copy), u60 (copy)
        p62(unpack(u61, 1, u60));
    end);
end;

function u44.reject(...) -- Line: 457
    -- upvalues: pack (copy), u44 (copy)
    local u63, u64 = pack(...);

    return u44._new(debug.traceback(nil, 2), function(p65, p66) -- Line: 459
        -- upvalues: u64 (copy), u63 (copy)
        p66(unpack(u64, 1, u63));
    end);
end;

function u44._try(p67, u68, ...) -- Line: 468
    -- upvalues: pack (copy), u44 (copy)
    local u69, u70 = pack(...);

    return u44._new(p67, function(p71) -- Line: 471
        -- upvalues: u68 (copy), u70 (copy), u69 (copy)
        p71(u68(unpack(u70, 1, u69)));
    end);
end;

function u44.try(p72, ...) -- Line: 499
    -- upvalues: u44 (copy)
    return u44._try(debug.traceback(nil, 2), p72, ...);
end;

function u44._all(p73, u74, u75) -- Line: 508
    -- upvalues: u44 (copy)
    if type(u74) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3);
    end;

    for i, v in pairs(u74) do
        if not u44.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(i))), 3);
        end;
    end;

    if #u74 == 0 or u75 == 0 then
        return u44.resolve({});
    end;

    return u44._new(p73, function(u76, u77, p78) -- Line: 526
        -- upvalues: u75 (copy), u74 (copy)
        local u79 = {};
        local u80 = {};
        local u81 = 0;
        local u82 = 0;
        local u83 = false;

        local function resolveOne(p84, ...) -- Line: 544
            -- upvalues: u83 (ref), u81 (ref), u75 (ref), u79 (copy), u74 (ref), u76 (copy), u80 (copy)
            if u83 then
                return;
            end;

            u81 = u81 + 1;

            if u75 == nil then
                u79[p84] = ...;
            else
                u79[u81] = ...;
            end;

            if u81 >= (u75 or #u74) then
                u83 = true;
                u76(u79);

                for _, v in ipairs(u80) do
                    v:cancel();
                end;
            end;
        end;

        p78(function() -- Line: 537, Name: cancel
            -- upvalues: u80 (copy)
            for _, v in ipairs(u80) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u74) do
            u80[i] = v:andThen(function(...) -- Line: 569
                -- upvalues: resolveOne (copy), i (copy)
                resolveOne(i, ...);
            end, function(...) -- Line: 571
                -- upvalues: u82 (ref), u75 (ref), u74 (ref), u80 (copy), u83 (ref), u77 (copy)
                u82 = u82 + 1;

                if u75 == nil or #u74 - u82 < u75 then
                    for _, v2 in ipairs(u80) do
                        v2:cancel();
                    end;

                    u83 = true;
                    u77(...);
                end;
            end);
        end;

        if u83 then
            for _, v in ipairs(u80) do
                v:cancel();
            end;
        end;
    end);
end;

function u44.all(p85) -- Line: 613
    -- upvalues: u44 (copy)
    return u44._all(debug.traceback(nil, 2), p85);
end;

function u44.fold(p86, u87, p88) -- Line: 642
    -- upvalues: u44 (copy)
    local v89 = type(p86) == "table";
    assert(v89, "Bad argument #1 to Promise.fold: must be a table");
    local v90;

    if type(u87) == "function" then
        v90 = true;
    elseif type(u87) == "table" then
        local v91 = getmetatable(u87);

        if v91 then
            local v92 = rawget(v91, "__call");
            v90 = type(v92) == "function";
        else
            v90 = false;
        end;
    else
        v90 = false;
    end;

    assert(v90, "Bad argument #2 to Promise.fold: must be a function");
    local u93 = u44.resolve(p88);

    return u44.each(p86, function(u94, u95) -- Line: 647
        -- upvalues: u93 (ref), u87 (copy)
        u93 = u93:andThen(function(p96) -- Line: 648
            -- upvalues: u87 (ref), u94 (copy), u95 (copy)
            return u87(p96, u94, u95);
        end);
    end):andThen(function() -- Line: 651
        -- upvalues: u93 (ref)
        return u93;
    end);
end;

function u44.some(p97, p98) -- Line: 675
    -- upvalues: u44 (copy)
    local v99 = type(p98) == "number";
    assert(v99, "Bad argument #2 to Promise.some: must be a number");

    return u44._all(debug.traceback(nil, 2), p97, p98);
end;

function u44.any(p100) -- Line: 699
    -- upvalues: u44 (copy)
    return u44._all(debug.traceback(nil, 2), p100, 1):andThen(function(p101) -- Line: 700
        return p101[1];
    end);
end;

function u44.allSettled(u102) -- Line: 721
    -- upvalues: u44 (copy)
    if type(u102) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2);
    end;

    for i, v in pairs(u102) do
        if not u44.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(i))), 2);
        end;
    end;

    if #u102 == 0 then
        return u44.resolve({});
    end;

    return u44._new(debug.traceback(nil, 2), function(u103, p104, p105) -- Line: 739
        -- upvalues: u102 (copy)
        local u106 = {};
        local u107 = {};
        local u108 = 0;

        local function u110(p109, ...) -- Line: 749
            -- upvalues: u108 (ref), u106 (copy), u102 (ref), u103 (copy)
            u108 = u108 + 1;
            u106[p109] = ...;

            if u108 >= #u102 then
                u103(u106);
            end;
        end;

        p105(function() -- Line: 759
            -- upvalues: u107 (copy)
            for _, v in ipairs(u107) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u102) do
            u107[i] = v:finally(function(...) -- Line: 768
                -- upvalues: u110 (copy), i (copy)
                u110(i, ...);
            end);
        end;
    end);
end;

function u44.race(u111) -- Line: 799
    -- upvalues: u44 (copy)
    local v112 = type(u111) == "table";
    assert(v112, string.format("Please pass a list of promises to %s", "Promise.race"));

    for i, v in pairs(u111) do
        local v113 = u44.is(v);
        local string_format = string.format;
        local v114 = tostring(i);
        assert(v113, string_format("Non-promise value passed into %s at index %s", "Promise.race", v114));
    end;

    return u44._new(debug.traceback(nil, 2), function(u115, u116, p117) -- Line: 806
        -- upvalues: u111 (copy)
        local u118 = {};
        local u119 = false;

        local function cancel() -- Line: 810
            -- upvalues: u118 (copy)
            for _, v in ipairs(u118) do
                v:cancel();
            end;
        end;

        local function finalize(u120) -- Line: 816
            -- upvalues: u118 (copy), u119 (ref)
            return function(...) -- Line: 817
                -- upvalues: u118 (ref), u119 (ref), u120 (copy)
                for _, v in ipairs(u118) do
                    v:cancel();
                end;

                u119 = true;

                return u120(...);
            end;
        end;

        if p117(function(...) -- Line: 817
            -- upvalues: u118 (copy), u119 (ref), u116 (copy)
            for _, v in ipairs(u118) do
                v:cancel();
            end;

            u119 = true;

            return u116(...);
        end) then
            return;
        end;

        for i, v in ipairs(u111) do
            u118[i] = v:andThen(function(...) -- Line: 817
                -- upvalues: u118 (copy), u119 (ref), u115 (copy)
                for _, v2 in ipairs(u118) do
                    v2:cancel();
                end;

                u119 = true;

                return u115(...);
            end, function(...) -- Line: 817
                -- upvalues: u118 (copy), u119 (ref), u116 (copy)
                for _, v2 in ipairs(u118) do
                    v2:cancel();
                end;

                u119 = true;

                return u116(...);
            end);
        end;

        if u119 then
            for _, v in ipairs(u118) do
                v:cancel();
            end;
        end;
    end);
end;

function u44.each(u121, u122) -- Line: 894
    -- upvalues: u44 (copy), u10 (ref)
    local v123 = type(u121) == "table";
    assert(v123, string.format("Please pass a list of promises to %s", "Promise.each"));
    local v124;

    if type(u122) == "function" then
        v124 = true;
    elseif type(u122) == "table" then
        local v125 = getmetatable(u122);

        if v125 then
            local v126 = rawget(v125, "__call");
            v124 = type(v126) == "function";
        else
            v124 = false;
        end;
    else
        v124 = false;
    end;

    assert(v124, string.format("Please pass a handler function to %s!", "Promise.each"));

    return u44._new(debug.traceback(nil, 2), function(p127, p128, p129) -- Line: 898
        -- upvalues: u121 (copy), u44 (ref), u10 (ref), u122 (copy)
        local v130 = {};
        local u131 = {};
        local u132 = false;

        local function _() -- Line: 904
            -- upvalues: u131 (copy)
            for _, v in ipairs(u131) do
                v:cancel();
            end;
        end;

        p129(function() -- Line: 910
            -- upvalues: u132 (ref), u131 (copy)
            u132 = true;

            for _, v in ipairs(u131) do
                v:cancel();
            end;
        end);
        local v133 = {};

        for i, v in ipairs(u121) do
            if u44.is(v) then
                if v:getStatus() == u44.Status.Cancelled then
                    for _, v2 in ipairs(u131) do
                        v2:cancel();
                    end;

                    return p128(u10.new({
                        error = "Promise is cancelled",
                        kind = u10.Kind.AlreadyCancelled,
                        context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", i, v._source)
                    }));
                end;

                if v:getStatus() == u44.Status.Rejected then
                    for _, v2 in ipairs(u131) do
                        v2:cancel();
                    end;

                    return p128(select(2, v:await()));
                end;

                local v134 = v:andThen(function(...) -- Line: 943
                    return ...;
                end);
                table.insert(u131, v134);
                v133[i] = v134;
            else
                v133[i] = v;
            end;
        end;

        for i, v in ipairs(v133) do
            local v135;

            if u44.is(v) then
                local v136;
                v136, v135 = v:await();

                if not v136 then
                    for _, v2 in ipairs(u131) do
                        v2:cancel();
                    end;

                    return p128(v135);
                end;
            else
                v135 = v;
            end;

            if u132 then
                return;
            end;

            local v137 = u44.resolve(u122(v135, i));
            table.insert(u131, v137);
            local v138, v139 = v137:await();

            if not v138 then
                for _, v2 in ipairs(u131) do
                    v2:cancel();
                end;

                return p128(v139);
            end;

            v130[i] = v139;
        end;

        p127(v130);
    end);
end;

function u44.is(p140) -- Line: 993
    -- upvalues: u44 (copy)
    if type(p140) ~= "table" then
        return false;
    end;

    local v141 = getmetatable(p140);

    if v141 == u44 then
        return true;
    end;

    if v141 ~= nil then
        if type(v141) == "table" then
            local v142 = rawget(v141, "__index");

            if type(v142) == "table" then
                local v143 = rawget(v141, "__index");
                local v144 = rawget(v143, "andThen");
                local v145;

                if type(v144) == "function" then
                    v145 = true;
                else
                    local v146 = type(v144) == "table" and getmetatable(v144);

                    if v146 then
                        local v147 = rawget(v146, "__call");
                        v145 = type(v147) == "function";
                    else
                        v145 = false;
                    end;
                end;

                if v145 then
                    return true;
                end;
            end;
        end;

        return false;
    end;

    local andThen = p140.andThen;

    if type(andThen) == "function" then
        return true;
    end;

    local v148 = type(andThen) == "table" and getmetatable(andThen);

    if v148 then
        local v149 = rawget(v148, "__call");

        if type(v149) == "function" then
            return true;
        end;
    end;

    return false;
end;

function u44.promisify(u150) -- Line: 1042
    -- upvalues: u44 (copy)
    return function(...) -- Line: 1043
        -- upvalues: u44 (ref), u150 (copy)
        return u44._try(debug.traceback(nil, 2), u150, ...);
    end;
end;

function u44.delay(u151) -- Line: 1066
    -- upvalues: u44 (copy)
    local v152 = type(u151) == "number";
    assert(v152, "Bad argument #1 to Promise.delay, must be a number.");
    local u153 = u44._getTime();

    return u44._new(debug.traceback(nil, 2), function(u154) -- Line: 1069
        -- upvalues: u151 (copy), u44 (ref), u153 (copy)
        task.delay(u151, function() -- Line: 1070
            -- upvalues: u154 (copy), u44 (ref), u153 (ref)
            u154(u44._getTime() - u153);
        end);
    end);
end;

function u44.prototype.timeout(p155, u156, u157) -- Line: 1114
    -- upvalues: u44 (copy), u10 (ref)
    local debug_traceback_ret = debug.traceback(nil, 2);

    return u44.race({ u44.delay(u156):andThen(function() -- Line: 1118
            -- upvalues: u44 (ref), u157 (copy), u10 (ref), u156 (copy), debug_traceback_ret (copy)
            return u44.reject(u157 == nil and u10.new({
                error = "Timed out",
                kind = u10.Kind.TimedOut,
                context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", u156, debug_traceback_ret)
            }) or u157);
        end), p155 });
end;

function u44.prototype.getStatus(p158) -- Line: 1134
    return p158._status;
end;

function u44.prototype._andThen(u159, u160, u161, u162) -- Line: 1143
    -- upvalues: u44 (copy), runExecutor (copy)
    u159._unhandledRejection = false;

    if u159._status ~= u44.Status.Cancelled then
        return u44._new(u160, function(u163, u164, p165) -- Line: 1155
            -- upvalues: u161 (copy), u160 (copy), runExecutor (ref), u162 (copy), u159 (copy), u44 (ref)
            local u166;

            if u161 then
                local u167 = u160;
                local u168 = u161;

                u166 = function(...) -- Line: 204
                    -- upvalues: runExecutor (ref), u167 (copy), u168 (copy), u163 (copy), u164 (copy)
                    local v169, v170, v171 = runExecutor(u167, u168, ...);

                    if v169 then
                        u163(unpack(v171, 1, v170));

                        return;
                    end;

                    u164(v171[1]);
                end;
            else
                u166 = u163;
            end;

            if u162 then
                local u172 = u160;
                local u173 = u162;

                u164 = function(...) -- Line: 204
                    -- upvalues: runExecutor (ref), u172 (copy), u173 (copy), u163 (copy), u164 (copy)
                    local v174, v175, v176 = runExecutor(u172, u173, ...);

                    if v174 then
                        u163(unpack(v176, 1, v175));

                        return;
                    end;

                    u164(v176[1]);
                end;
            end;

            if u159._status == u44.Status.Started then
                table.insert(u159._queuedResolve, u166);
                table.insert(u159._queuedReject, u164);
                p165(function() -- Line: 1174
                    -- upvalues: u159 (ref), u44 (ref), u166 (ref), u164 (ref)
                    if u159._status == u44.Status.Started then
                        table.remove(u159._queuedResolve, table.find(u159._queuedResolve, u166));
                        table.remove(u159._queuedReject, table.find(u159._queuedReject, u164));
                    end;
                end);
            elseif u159._status == u44.Status.Resolved then
                u166(unpack(u159._values, 1, u159._valuesLength));
            elseif u159._status == u44.Status.Rejected then
                u164(unpack(u159._values, 1, u159._valuesLength));
            end;
        end, u159);
    end;

    local v177 = u44.new(function() -- Line: 1148
    end);
    v177:cancel();

    return v177;
end;

function u44.prototype.andThen(p178, p179, p180) -- Line: 1213
    local v181;

    if p179 == nil or type(p179) == "function" then
        v181 = true;
    elseif type(p179) == "table" then
        local v182 = getmetatable(p179);

        if v182 then
            local v183 = rawget(v182, "__call");
            v181 = type(v183) == "function";
        else
            v181 = false;
        end;
    else
        v181 = false;
    end;

    assert(v181, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    local v184;

    if p180 == nil or type(p180) == "function" then
        v184 = true;
    elseif type(p180) == "table" then
        local v185 = getmetatable(p180);

        if v185 then
            local v186 = rawget(v185, "__call");
            v184 = type(v186) == "function";
        else
            v184 = false;
        end;
    else
        v184 = false;
    end;

    assert(v184, string.format("Please pass a handler function to %s!", "Promise:andThen"));

    return p178:_andThen(debug.traceback(nil, 2), p179, p180);
end;

function u44.prototype.catch(p187, p188) -- Line: 1240
    local v189;

    if p188 == nil or type(p188) == "function" then
        v189 = true;
    elseif type(p188) == "table" then
        local v190 = getmetatable(p188);

        if v190 then
            local v191 = rawget(v190, "__call");
            v189 = type(v191) == "function";
        else
            v189 = false;
        end;
    else
        v189 = false;
    end;

    assert(v189, string.format("Please pass a handler function to %s!", "Promise:catch"));

    return p187:_andThen(debug.traceback(nil, 2), nil, p188);
end;

function u44.prototype.tap(p192, u193) -- Line: 1261
    -- upvalues: u44 (copy), pack (copy)
    local v194;

    if type(u193) == "function" then
        v194 = true;
    elseif type(u193) == "table" then
        local v195 = getmetatable(u193);

        if v195 then
            local v196 = rawget(v195, "__call");
            v194 = type(v196) == "function";
        else
            v194 = false;
        end;
    else
        v194 = false;
    end;

    assert(v194, string.format("Please pass a handler function to %s!", "Promise:tap"));

    return p192:_andThen(debug.traceback(nil, 2), function(...) -- Line: 1263
        -- upvalues: u193 (copy), u44 (ref), pack (ref)
        local v197 = u193(...);

        if not u44.is(v197) then
            return ...;
        end;

        local u198, u199 = pack(...);

        return v197:andThen(function() -- Line: 1268
            -- upvalues: u199 (copy), u198 (copy)
            return unpack(u199, 1, u198);
        end);
    end);
end;

function u44.prototype.andThenCall(p200, u201, ...) -- Line: 1296
    -- upvalues: pack (copy)
    local v202;

    if type(u201) == "function" then
        v202 = true;
    elseif type(u201) == "table" then
        local v203 = getmetatable(u201);

        if v203 then
            local v204 = rawget(v203, "__call");
            v202 = type(v204) == "function";
        else
            v202 = false;
        end;
    else
        v202 = false;
    end;

    assert(v202, string.format("Please pass a handler function to %s!", "Promise:andThenCall"));
    local u205, u206 = pack(...);

    return p200:_andThen(debug.traceback(nil, 2), function() -- Line: 1299
        -- upvalues: u201 (copy), u206 (copy), u205 (copy)
        return u201(unpack(u206, 1, u205));
    end);
end;

function u44.prototype.andThenReturn(p207, ...) -- Line: 1326
    -- upvalues: pack (copy)
    local u208, u209 = pack(...);

    return p207:_andThen(debug.traceback(nil, 2), function() -- Line: 1328
        -- upvalues: u209 (copy), u208 (copy)
        return unpack(u209, 1, u208);
    end);
end;

function u44.prototype.cancel(p210) -- Line: 1344
    -- upvalues: u44 (copy)
    if p210._status ~= u44.Status.Started then
        return;
    end;

    p210._status = u44.Status.Cancelled;

    if p210._cancellationHook then
        p210._cancellationHook();
    end;

    coroutine.close(p210._thread);

    if p210._parent then
        p210._parent:_consumerCancelled(p210);
    end;

    for i in pairs(p210._consumers) do
        i:cancel();
    end;

    p210:_finalize();
end;

function u44.prototype._consumerCancelled(p211, p212) -- Line: 1372
    -- upvalues: u44 (copy)
    if p211._status ~= u44.Status.Started then
        return;
    end;

    p211._consumers[p212] = nil;

    if next(p211._consumers) == nil then
        p211:cancel();
    end;
end;

function u44.prototype._finally(u213, u214, u215) -- Line: 1388
    -- upvalues: u44 (copy), runExecutor (copy)
    u213._unhandledRejection = false;

    return u44._new(u214, function(u216, u217, p218) -- Line: 1391
        -- upvalues: u213 (copy), u215 (copy), runExecutor (ref), u214 (copy), u44 (ref)
        local u219 = nil;
        p218(function() -- Line: 1394
            -- upvalues: u213 (ref), u219 (ref)
            u213:_consumerCancelled(u213);

            if u219 then
                u219:cancel();
            end;
        end);
        local v224 = u215 and function(...) -- Line: 1407
            -- upvalues: runExecutor (ref), u214 (ref), u215 (ref), u217 (copy), u44 (ref), u219 (ref), u216 (copy), u213 (ref)
            local v220, _, v221 = runExecutor(u214, u215, ...);
            local v222 = v221[1];

            if not v220 then
                return u217(v222);
            end;

            if not u44.is(v222) then
                u216(u213);

                return;
            end;

            u219 = v222;
            v222:finally(function(p223) -- Line: 1418
                -- upvalues: u44 (ref), u216 (ref), u213 (ref)
                if p223 ~= u44.Status.Rejected then
                    u216(u213);
                end;
            end):catch(function(...) -- Line: 1423
                -- upvalues: u217 (ref)
                u217(...);
            end);
        end or u216;

        if u213._status == u44.Status.Started then
            table.insert(u213._queuedFinally, v224);
        else
            v224(u213._status);
        end;
    end);
end;

function u44.prototype.finally(p225, p226) -- Line: 1493
    local v227;

    if p226 == nil or type(p226) == "function" then
        v227 = true;
    elseif type(p226) == "table" then
        local v228 = getmetatable(p226);

        if v228 then
            local v229 = rawget(v228, "__call");
            v227 = type(v229) == "function";
        else
            v227 = false;
        end;
    else
        v227 = false;
    end;

    assert(v227, string.format("Please pass a handler function to %s!", "Promise:finally"));

    return p225:_finally(debug.traceback(nil, 2), p226);
end;

function u44.prototype.finallyCall(p230, u231, ...) -- Line: 1507
    -- upvalues: pack (copy)
    local v232;

    if type(u231) == "function" then
        v232 = true;
    elseif type(u231) == "table" then
        local v233 = getmetatable(u231);

        if v233 then
            local v234 = rawget(v233, "__call");
            v232 = type(v234) == "function";
        else
            v232 = false;
        end;
    else
        v232 = false;
    end;

    assert(v232, string.format("Please pass a handler function to %s!", "Promise:finallyCall"));
    local u235, u236 = pack(...);

    return p230:_finally(debug.traceback(nil, 2), function() -- Line: 1510
        -- upvalues: u231 (copy), u236 (copy), u235 (copy)
        return u231(unpack(u236, 1, u235));
    end);
end;

function u44.prototype.finallyReturn(p237, ...) -- Line: 1533
    -- upvalues: pack (copy)
    local u238, u239 = pack(...);

    return p237:_finally(debug.traceback(nil, 2), function() -- Line: 1535
        -- upvalues: u239 (copy), u238 (copy)
        return unpack(u239, 1, u238);
    end);
end;

function u44.prototype.awaitStatus(p240) -- Line: 1547
    -- upvalues: u44 (copy)
    p240._unhandledRejection = false;

    if p240._status == u44.Status.Started then
        local coroutine_running_ret = coroutine.running();
        p240:finally(function() -- Line: 1554
            -- upvalues: coroutine_running_ret (copy)
            task.spawn(coroutine_running_ret);
        end):catch(function() -- Line: 1560
        end);
        coroutine.yield();
    end;

    if p240._status == u44.Status.Resolved then
        return p240._status, unpack(p240._values, 1, p240._valuesLength);
    end;

    if p240._status == u44.Status.Rejected then
        return p240._status, unpack(p240._values, 1, p240._valuesLength);
    end;

    return p240._status;
end;

local function awaitHelper(p241, ...) -- Line: 1575
    -- upvalues: u44 (copy)
    return p241 == u44.Status.Resolved, ...;
end;

function u44.prototype.await(p242) -- Line: 1600
    -- upvalues: awaitHelper (copy)
    return awaitHelper(p242:awaitStatus());
end;

local function expectHelper(p243, ...) -- Line: 1604
    -- upvalues: u44 (copy)
    if p243 ~= u44.Status.Resolved then
        error(... == nil and "Expected Promise rejected with no value." or ..., 3);
    end;

    return ...;
end;

function u44.prototype.expect(p244) -- Line: 1637
    -- upvalues: expectHelper (copy)
    return expectHelper(p244:awaitStatus());
end;

u44.prototype.awaitValue = u44.prototype.expect;

function u44.prototype._unwrap(p245) -- Line: 1651
    -- upvalues: u44 (copy)
    if p245._status == u44.Status.Started then
        error("Promise has not resolved or rejected.", 2);
    end;

    return p245._status == u44.Status.Resolved, unpack(p245._values, 1, p245._valuesLength);
end;

function u44.prototype._resolve(u246, ...) -- Line: 1661
    -- upvalues: u44 (copy), u10 (ref), pack (copy)
    if u246._status ~= u44.Status.Started then
        if u44.is((...)) then
            (...):_consumerCancelled(u246);
        end;

        return;
    end;

    if u44.is((...)) then
        if select("#", ...) > 1 then
            local string_format_ret = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", u246._source);
            warn(string_format_ret);
        end;

        local u247 = ...;
        local v249 = u247:andThen(function(...) -- Line: 1682
            -- upvalues: u246 (copy)
            u246:_resolve(...);
        end, function(...) -- Line: 1684
            -- upvalues: u247 (copy), u10 (ref), u246 (copy)
            local v248 = u247._values[1];

            if u247._error then
                v248 = u10.new({
                    context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
                    error = u247._error,
                    kind = u10.Kind.ExecutionError
                });
            end;

            if u10.isKind(v248, u10.Kind.ExecutionError) then
                return u246:_reject(v248:extend({
                    error = "This Promise was chained to a Promise that errored.",
                    trace = "",
                    context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", u246._source)
                }));
            end;

            u246:_reject(...);
        end);

        if v249._status == u44.Status.Cancelled then
            u246:cancel();

            return;
        end;

        if v249._status == u44.Status.Started then
            u246._parent = v249;
            v249._consumers[u246] = true;
        end;

        return;
    end;

    u246._status = u44.Status.Resolved;
    local v250, v251 = pack(...);
    u246._valuesLength = v250;
    u246._values = v251;

    for _, v in ipairs(u246._queuedResolve) do
        coroutine.wrap(v)(...);
    end;

    u246:_finalize();
end;

function u44.prototype._reject(u252, ...) -- Line: 1732
    -- upvalues: u44 (copy), pack (copy)
    if u252._status ~= u44.Status.Started then
        return;
    end;

    u252._status = u44.Status.Rejected;
    local v253, v254 = pack(...);
    u252._valuesLength = v253;
    u252._values = v254;

    if next(u252._queuedReject) == nil then
        local u255 = tostring((...));
        coroutine.wrap(function() -- Line: 1754
            -- upvalues: u44 (ref), u252 (copy), u255 (copy)
            u44._timeEvent:Wait();

            if not u252._unhandledRejection then
                return;
            end;

            local string_format_ret = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", u255, u252._source);

            for _, v in ipairs(u44._unhandledRejectionCallbacks) do
                task.spawn(v, u252, unpack(u252._values, 1, u252._valuesLength));
            end;

            if u44.TEST then
                return;
            end;

            warn(string_format_ret);
        end)();
    else
        for _, v in ipairs(u252._queuedReject) do
            coroutine.wrap(v)(...);
        end;
    end;

    u252:_finalize();
end;

function u44.prototype._finalize(p256) -- Line: 1786
    -- upvalues: u44 (copy)
    for _, v in ipairs(p256._queuedFinally) do
        coroutine.wrap(v)(p256._status);
    end;

    p256._queuedFinally = nil;
    p256._queuedReject = nil;
    p256._queuedResolve = nil;

    if not u44.TEST then
        p256._parent = nil;
        p256._consumers = nil;
    end;

    task.defer(coroutine.close, p256._thread);
end;

function u44.prototype.now(p257, p258) -- Line: 1823
    -- upvalues: u44 (copy), u10 (ref)
    local debug_traceback_ret = debug.traceback(nil, 2);

    if p257._status == u44.Status.Resolved then
        return p257:_andThen(debug_traceback_ret, function(...) -- Line: 1826
            return ...;
        end);
    end;

    local reject = u44.reject;

    if p258 == nil then
        p258 = u10.new({
            error = "This Promise was not resolved in time for :now()",
            kind = u10.Kind.NotResolvedInTime,
            context = ":now() was called at:\n\n" .. debug_traceback_ret
        }) or p258;
    end;

    return reject(p258);
end;

function u44.retry(u259, u260, ...) -- Line: 1868
    -- upvalues: u44 (copy)
    local v261;

    if type(u259) == "function" then
        v261 = true;
    elseif type(u259) == "table" then
        local v262 = getmetatable(u259);

        if v262 then
            local v263 = rawget(v262, "__call");
            v261 = type(v263) == "function";
        else
            v261 = false;
        end;
    else
        v261 = false;
    end;

    assert(v261, "Parameter #1 to Promise.retry must be a function");
    local v264 = type(u260) == "number";
    assert(v264, "Parameter #2 to Promise.retry must be a number");
    local u265 = { ... };
    local u266 = select("#", ...);

    return u44.resolve(u259(...)):catch(function(...) -- Line: 1874
        -- upvalues: u260 (copy), u44 (ref), u259 (copy), u265 (copy), u266 (copy)
        if u260 > 0 then
            return u44.retry(u259, u260 - 1, unpack(u265, 1, u266));
        end;

        return u44.reject(...);
    end);
end;

function u44.retryWithDelay(u267, u268, u269, ...) -- Line: 1896
    -- upvalues: u44 (copy)
    local v270;

    if type(u267) == "function" then
        v270 = true;
    elseif type(u267) == "table" then
        local v271 = getmetatable(u267);

        if v271 then
            local v272 = rawget(v271, "__call");
            v270 = type(v272) == "function";
        else
            v270 = false;
        end;
    else
        v270 = false;
    end;

    assert(v270, "Parameter #1 to Promise.retry must be a function");
    local v273 = type(u268) == "number";
    assert(v273, "Parameter #2 (times) to Promise.retry must be a number");
    local v274 = type(u269) == "number";
    assert(v274, "Parameter #3 (seconds) to Promise.retry must be a number");
    local u275 = { ... };
    local u276 = select("#", ...);

    return u44.resolve(u267(...)):catch(function(...) -- Line: 1903
        -- upvalues: u268 (copy), u44 (ref), u269 (copy), u267 (copy), u275 (copy), u276 (copy)
        if u268 <= 0 then
            return u44.reject(...);
        end;

        u44.delay(u269):await();

        return u44.retryWithDelay(u267, u268 - 1, u269, unpack(u275, 1, u276));
    end);
end;

function u44.fromEvent(u277, p278) -- Line: 1938
    -- upvalues: u44 (copy)
    local u279 = p278 or function() -- Line: 1939
        return true;
    end;

    return u44._new(debug.traceback(nil, 2), function(u280, p281, p282) -- Line: 1943
        -- upvalues: u277 (copy), u279 (ref)
        local u283 = nil;
        local u284 = false;

        local function disconnect() -- Line: 1947
            -- upvalues: u283 (ref)
            u283:Disconnect();
            u283 = nil;
        end;

        u283 = u277:Connect(function(...) -- Line: 1956
            -- upvalues: u279 (ref), u280 (copy), u283 (ref), u284 (ref)
            local v285 = u279(...);

            if v285 ~= true then
                if type(v285) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean");
                end;

                return;
            end;

            u280(...);

            if not u283 then
                u284 = true;

                return;
            end;

            u283:Disconnect();
            u283 = nil;
        end);

        if u284 and u283 then
            return disconnect();
        end;

        p282(disconnect);
    end);
end;

function u44.onUnhandledRejection(u286) -- Line: 1990
    -- upvalues: u44 (copy)
    table.insert(u44._unhandledRejectionCallbacks, u286);

    return function() -- Line: 1993
        -- upvalues: u44 (ref), u286 (copy)
        local table_find_ret = table.find(u44._unhandledRejectionCallbacks, u286);

        if table_find_ret then
            table.remove(u44._unhandledRejectionCallbacks, table_find_ret);
        end;
    end;
end;

return u44;