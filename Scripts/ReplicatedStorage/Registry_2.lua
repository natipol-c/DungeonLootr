--[[
  Type:     ModuleScript
  Method:   cached
  Name:     Registry
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.Shared.Registry
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:40 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Util = require(script.Parent.Util);
local u14 = {
    Cmdr = nil,
    TypeMethods = Util.MakeDictionary({ "Transform", "Validate", "Autocomplete", "Parse", "DisplayName", "Listable", "ValidateOnce", "Prefixes", "Default", "ArgumentOperatorAliases" }),
    CommandMethods = Util.MakeDictionary({ "Name", "Aliases", "AutoExec", "Description", "Args", "Run", "ClientRun", "Data", "Group" }),
    CommandArgProps = Util.MakeDictionary({ "Name", "Type", "Description", "Optional", "Default" }),
    Types = {},
    TypeAliases = {},
    Commands = {},
    CommandsArray = {},
    Hooks = {
        BeforeRun = {},
        AfterRun = {}
    },
    Stores = setmetatable({}, {
        __index = function(p1, p2) -- Line: 20, Name: __index
            p1[p2] = {};

            return p1[p2];
        end
    }),
    AutoExecBuffer = {},

    RegisterType = function(p3, p4, p5) -- Line: 30, Name: RegisterType
        if not p4 or typeof(p4) ~= "string" then
            error("Invalid type name provided: nil");
        end;

        if not p4:find("^[%d%l]%w*$") then
            error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(p4));
        end;

        for i in pairs(p5) do
            if p3.TypeMethods[i] == nil then
                error("Unknown key/method in type \"" .. p4 .. "\": " .. i);
            end;
        end;

        if p3.Types[p4] ~= nil then
            error(("Type \"%s\" has already been registered."):format(p4));
        end;

        p5.Name = p4;
        p5.DisplayName = p5.DisplayName or p4;
        p3.Types[p4] = p5;

        if p5.Prefixes then
            p3:RegisterTypePrefix(p4, p5.Prefixes);
        end;
    end,

    RegisterTypePrefix = function(p6, p7, p8) -- Line: 59, Name: RegisterTypePrefix
        if not p6.TypeAliases[p7] then
            p6.TypeAliases[p7] = p7;
        end;

        p6.TypeAliases[p7] = ("%s %s"):format(p6.TypeAliases[p7], p8);
    end,

    RegisterTypeAlias = function(p9, p10, p11) -- Line: 67, Name: RegisterTypeAlias
        assert(p9.TypeAliases[p10] == nil, ("Type alias %s already exists!"):format(p11));
        p9.TypeAliases[p10] = p11;
    end,

    RegisterTypesIn = function(p12, p13) -- Line: 73, Name: RegisterTypesIn
        for _, child in pairs(p13:GetChildren()) do
            if child:IsA("ModuleScript") then
                child.Parent = p12.Cmdr.ReplicatedRoot.Types;
                require(child)(p12);
            else
                p12:RegisterTypesIn(child);
            end;
        end;
    end
};
u14.RegisterHooksIn = u14.RegisterTypesIn;

function u14.RegisterCommandObject(p15, p16, p17) -- Line: 90
    -- upvalues: RunService (copy)
    for i in pairs(p16) do
        if p15.CommandMethods[i] == nil then
            error("Unknown key/method in command " .. (p16.Name or "unknown command") .. ": " .. i);
        end;
    end;

    if p16.Args then
        for i, v in pairs(p16.Args) do
            if type(v) == "table" then
                local v18 = i;

                for i2 in pairs(v) do
                    if p15.CommandArgProps[i2] == nil then
                        error(("Unknown property in command \"%s\" argument #%d: %s"):format(p16.Name or "unknown", v18, i2));
                    end;
                end;
            end;
        end;
    end;

    if p16.AutoExec and RunService:IsClient() then
        table.insert(p15.AutoExecBuffer, p16.AutoExec);
        p15:FlushAutoExecBufferDeferred();
    end;

    local v19 = p15.Commands[p16.Name:lower()];

    if v19 and v19.Aliases then
        for _, v in pairs(v19.Aliases) do
            p15.Commands[v:lower()] = nil;
        end;
    elseif not v19 then
        table.insert(p15.CommandsArray, p16);
    end;

    p15.Commands[p16.Name:lower()] = p16;

    if p16.Aliases then
        for _, v in pairs(p16.Aliases) do
            p15.Commands[v:lower()] = p16;
        end;
    end;
end;

function u14.RegisterCommand(p20, p21, p22, p23) -- Line: 135
    -- upvalues: RunService (copy)
    local v24 = require(p21);
    local v25 = typeof(v24) == "table";
    local v26 = `Invalid return value from command script "{p21.Name}" (CommandDefinition expected, got {typeof(v24)})`;
    assert(v25, v26);

    if p22 then
        local v27 = RunService:IsServer();
        assert(v27, "The commandServerScript parameter is not valid for client usage.");
        v24.Run = require(p22);
    end;

    if p23 and not p23(v24) then
        return;
    end;

    p20:RegisterCommandObject(v24);
    p21.Parent = p20.Cmdr.ReplicatedRoot.Commands;
end;

function u14.RegisterCommandsIn(p28, p29, p30) -- Line: 157
    local v31 = {};
    local v32 = {};

    for _, child in pairs(p29:GetChildren()) do
        if child:IsA("ModuleScript") then
            if child.Name:find("Server") then
                v31[child] = true;
            else
                local v33 = p29:FindFirstChild(child.Name .. "Server");

                if v33 then
                    v32[v33] = true;
                end;

                p28:RegisterCommand(child, v33, p30);
            end;
        else
            p28:RegisterCommandsIn(child, p30);
        end;
    end;

    for i in pairs(v31) do
        if not v32[i] then
            warn("Command script " .. i.Name .. " was skipped because it has \'Server\' in its name, and has no equivalent shared script.");
        end;
    end;
end;

function u14.RegisterDefaultCommands(p34, u35) -- Line: 187
    -- upvalues: RunService (copy), Util (copy)
    local v36 = RunService:IsServer();
    assert(v36, "RegisterDefaultCommands cannot be called from the client.");
    local v37 = type(u35) == "table";

    if v37 then
        u35 = Util.MakeDictionary(u35);
    end;

    p34:RegisterCommandsIn(p34.Cmdr.DefaultCommandsFolder, v37 and function(p38) -- Line: 196
        -- upvalues: u35 (ref)
        return u35[p38.Group] or false;
    end or u35);
end;

function u14.GetCommand(p39, p40) -- Line: 202
    return p39.Commands[(p40 or ""):lower()];
end;

function u14.GetCommands(p41) -- Line: 208
    return p41.CommandsArray;
end;

function u14.GetCommandNames(p42) -- Line: 213
    local v43 = {};

    for _, v in pairs(p42.CommandsArray) do
        table.insert(v43, v.Name);
    end;

    return v43;
end;

u14.GetCommandsAsStrings = u14.GetCommandNames;

function u14.GetTypeNames(p44) -- Line: 226
    local v45 = {};

    for i in pairs(p44.Types) do
        table.insert(v45, i);
    end;

    return v45;
end;

function u14.GetType(p46, p47) -- Line: 238
    return p46.Types[p47];
end;

function u14.GetTypeName(p48, p49) -- Line: 243
    return p48.TypeAliases[p49] or p49;
end;

function u14.RegisterHook(p50, p51, p52, p53) -- Line: 248
    if not p50.Hooks[p51] then
        error(("Invalid hook name: %q"):format(p51), 2);
    end;

    table.insert(p50.Hooks[p51], {
        callback = p52,
        priority = p53 or 0
    });
    table.sort(p50.Hooks[p51], function(p54, p55) -- Line: 254
        return p54.priority < p55.priority;
    end);
end;

u14.AddHook = u14.RegisterHook;

function u14.GetStore(p56, p57) -- Line: 262
    return p56.Stores[p57];
end;

function u14.FlushAutoExecBufferDeferred(u58) -- Line: 267
    -- upvalues: RunService (copy)
    if u58.AutoExecFlushConnection then
        return;
    end;

    u58.AutoExecFlushConnection = RunService.Heartbeat:Connect(function() -- Line: 272
        -- upvalues: u58 (copy)
        u58.AutoExecFlushConnection:Disconnect();
        u58.AutoExecFlushConnection = nil;
        u58:FlushAutoExecBuffer();
    end);
end;

function u14.FlushAutoExecBuffer(p59) -- Line: 280
    for _, v in ipairs(p59.AutoExecBuffer) do
        for _, v2 in ipairs(v) do
            p59.Cmdr.Dispatcher:EvaluateAndRun(v2);
        end;
    end;

    p59.AutoExecBuffer = {};
end;

return function(p60) -- Line: 290
    -- upvalues: u14 (copy)
    u14.Cmdr = p60;

    return u14;
end;