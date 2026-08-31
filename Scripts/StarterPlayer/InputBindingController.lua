--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     InputBindingController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.InputBindingController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Packages = ReplicatedStorage:WaitForChild("Packages");
local Knit = require(Packages:WaitForChild("Knit"));
local InputMapData = require(ReplicatedStorage:WaitForChild("Player"):WaitForChild("Modules"):WaitForChild("InputMapData"));
local Registry = require(script.Parent.Registry);
local u1 = {
    SkillE = true,
    ShiftLock = true
};

local function normalizeCombo(p2: string, p3: string) -- Line: 53
    if p3 < p2 then
        local v4 = p3;
        p3 = p2;
        p2 = v4;
    end;

    return p2 .. "+" .. p3;
end;

local function isGamepadUIT(p5) -- Line: 58
    return (p5 == Enum.UserInputType.Gamepad1 or (p5 == Enum.UserInputType.Gamepad2 or p5 == Enum.UserInputType.Gamepad3)) and true or p5 == Enum.UserInputType.Gamepad4;
end;

local v6 = Knit.CreateController({
    Name = "InputBindingController",
    _service = nil,
    _capturing = false,
    _overrides = {
        Keyboard = {},
        Gamepad = {}
    },
    _reverse = {
        Keyboard = {},
        Gamepad = {}
    },
    _combos = {
        Keyboard = {},
        Gamepad = {}
    },
    _comboReverse = {
        Keyboard = {},
        Gamepad = {}
    },
    _allCombos = {
        Keyboard = {},
        Gamepad = {}
    },
    _changedCallbacks = {}
});

local function fireChanged(p7: any, p8: string, p9: string, p10: string) -- Line: 123
    for _, v in p7._changedCallbacks do
        task.spawn(v, p8, p9, p10);
    end;
end;

local function resolve(p11: any, p12: string, p13: string) -- Line: 130
    -- upvalues: InputMapData (copy)
    local v14 = p11._overrides[p13];

    if v14 and v14[p12] ~= nil then
        return v14[p12];
    end;

    return InputMapData.GetDefault(p12, p13);
end;

local function rebuildReverse(p15: any, p16: string) -- Line: 140
    -- upvalues: InputMapData (copy), u1 (copy)
    local v17 = {};
    local v18 = {};
    local v19 = {};
    local v20 = {};

    for i in InputMapData.Actions do
        local v21 = p15._overrides[p16];
        local v22;

        if v21 and v21[i] ~= nil then
            v22 = v21[i];
        else
            v22 = InputMapData.GetDefault(i, p16);
        end;

        if v22 ~= "" and v22 ~= nil then
            if string.find(v22, "+", 1, true) then
                local v23, v24, v25 = InputMapData.ParseCombo(p16, v22);

                if v23 then
                    local v26, v27;

                    if v25 < v24 then
                        v26 = v24;
                        v27 = v25;
                    else
                        v26 = v25;
                        v27 = v24;
                    end;

                    v18[v27 .. "+" .. v26] = i;
                    table.insert(v19, {
                        parts = { v24, v25 }
                    });

                    if not u1[i] then
                        table.insert(v20, {
                            action = i,
                            parts = { v24, v25 }
                        });
                    end;
                end;
            else
                v17[v22] = i;
            end;
        end;
    end;

    p15._reverse[p16] = v17;
    p15._combos[p16] = v20;
    p15._comboReverse[p16] = v18;
    p15._allCombos[p16] = v19;
end;

local function rebuildAllReverse(p28) -- Line: 172
    -- upvalues: rebuildReverse (copy)
    rebuildReverse(p28, "Keyboard");
    rebuildReverse(p28, "Gamepad");
end;

local function inputToKeyName(p29) -- Line: 179
    local UserInputType = p29.UserInputType;

    if UserInputType == Enum.UserInputType.Keyboard then
        return p29.KeyCode.Name, "Keyboard";
    end;

    if UserInputType == Enum.UserInputType.MouseButton1 then
        return "MouseButton1", "Keyboard";
    end;

    if UserInputType == Enum.UserInputType.MouseButton2 then
        return "MouseButton2", "Keyboard";
    end;

    if UserInputType == Enum.UserInputType.MouseButton3 then
        return "MouseButton3", "Keyboard";
    end;

    if UserInputType == Enum.UserInputType.Gamepad1 or (UserInputType == Enum.UserInputType.Gamepad2 or (UserInputType == Enum.UserInputType.Gamepad3 or UserInputType == Enum.UserInputType.Gamepad4)) then
        return p29.KeyCode.Name, "Gamepad";
    end;

    return nil, nil;
end;

local function loadOverrides(p30) -- Line: 200
    -- upvalues: Registry (copy), InputMapData (copy)
    p30._overrides.Keyboard = {};
    p30._overrides.Gamepad = {};
    local v31 = Registry:Get("PlayerData");

    if not (v31 and (v31.Data and v31.Data.Keybinds)) then
        return;
    end;

    local Keyboard = v31.Data.Keybinds.Keyboard;
    local Gamepad = v31.Data.Keybinds.Gamepad;

    if type(Keyboard) == "table" then
        for i, v in Keyboard do
            if InputMapData.Actions[i] and type(v) == "string" then
                p30._overrides.Keyboard[i] = v;
            end;
        end;
    end;

    if type(Gamepad) == "table" then
        for i, v in Gamepad do
            if InputMapData.Actions[i] and type(v) == "string" then
                p30._overrides.Gamepad[i] = v;
            end;
        end;
    end;
end;

function v6.KnitInit(p32) -- Line: 229
    -- upvalues: rebuildReverse (copy)
    rebuildReverse(p32, "Keyboard");
    rebuildReverse(p32, "Gamepad");
end;

function v6.KnitStart(u33) -- Line: 235
    -- upvalues: loadOverrides (copy), rebuildReverse (copy), Registry (copy), InputMapData (copy), fireChanged (copy), resolve (copy), Knit (copy)
    loadOverrides(u33);
    rebuildReverse(u33, "Keyboard");
    rebuildReverse(u33, "Gamepad");
    local v34 = Registry:Get("PlayerData");

    if v34 and v34.OnChange then
        v34:OnChange(function(p35, p36) -- Line: 243
            -- upvalues: loadOverrides (ref), u33 (copy), rebuildReverse (ref), InputMapData (ref), fireChanged (ref), resolve (ref)
            if p36 and p36[1] == "Keybinds" then
                loadOverrides(u33);
                local v37 = u33;
                rebuildReverse(v37, "Keyboard");
                rebuildReverse(v37, "Gamepad");

                for i in InputMapData.Actions do
                    fireChanged(u33, i, "Keyboard", resolve(u33, i, "Keyboard"));
                    fireChanged(u33, i, "Gamepad", resolve(u33, i, "Gamepad"));
                end;
            end;
        end);
    end;

    local success, result = pcall(function() -- Line: 256
        -- upvalues: Knit (ref)
        return Knit.GetService("InputBindingService");
    end);

    if success and result then
        u33._service = result;
    end;
end;

function v6.GetKey(p38: table, p39: string, p40: string) -- Line: 267
    -- upvalues: resolve (copy)
    return resolve(p38, p39, p40);
end;

function v6.GetActionForInput(p41, p42) -- Line: 281
    -- upvalues: UserInputService (copy), inputToKeyName (copy)
    if p41._capturing then
        return nil;
    end;

    local UserInputType = p42.UserInputType;

    if (UserInputType == Enum.UserInputType.Gamepad1 or (UserInputType == Enum.UserInputType.Gamepad2 or UserInputType == Enum.UserInputType.Gamepad3)) and true or UserInputType == Enum.UserInputType.Gamepad4 then
        local Name = p42.KeyCode.Name;

        for _, v in p41._combos.Gamepad do
            local v43 = v.parts[1];
            local v44 = v.parts[2];

            if Name == v43 or Name == v44 then
                local v45 = Enum.KeyCode[v43];
                local v46 = Enum.KeyCode[v44];

                if v45 and (v46 and (UserInputService:IsGamepadButtonDown(UserInputType, v45) and UserInputService:IsGamepadButtonDown(UserInputType, v46))) then
                    return v.action;
                end;
            end;
        end;
    end;

    local v47, v48 = inputToKeyName(p42);

    if not (v47 and v48) then
        return nil;
    end;

    local v49 = p41._reverse[v48];

    return v49 and v49[v47] or nil;
end;

function v6.CompletesAnyCombo(p50, p51) -- Line: 314
    -- upvalues: UserInputService (copy)
    local UserInputType = p51.UserInputType;

    if UserInputType ~= Enum.UserInputType.Gamepad1 and (UserInputType ~= Enum.UserInputType.Gamepad2 and UserInputType ~= Enum.UserInputType.Gamepad3) and UserInputType ~= Enum.UserInputType.Gamepad4 then
        return false;
    end;

    local Name = p51.KeyCode.Name;

    for _, v in p50._allCombos.Gamepad do
        local v52 = v.parts[1];
        local v53 = v.parts[2];

        if Name == v52 or Name == v53 then
            local v54 = Enum.KeyCode[v52];
            local v55 = Enum.KeyCode[v53];

            if v54 and (v55 and (UserInputService:IsGamepadButtonDown(UserInputType, v54) and UserInputService:IsGamepadButtonDown(UserInputType, v55))) then
                return true;
            end;
        end;
    end;

    return false;
end;

function v6.GetActionForKey(p56: table, p57: string, p58: string) -- Line: 334
    local v59 = p56._reverse[p58];

    return v59 and v59[p57] or nil;
end;

function v6.GetAllBindings(p60: table, p61: string) -- Line: 340
    -- upvalues: InputMapData (copy)
    local v62 = {};

    for i in InputMapData.Actions do
        local v63 = p60._overrides[p61];
        local v64;

        if v63 and v63[i] ~= nil then
            v64 = v63[i];
        else
            v64 = InputMapData.GetDefault(i, p61);
        end;

        v62[i] = v64;
    end;

    return v62;
end;

function v6.GetBindingsForUI(p65: table, p66: string) -- Line: 350
    -- upvalues: InputMapData (copy)
    local v67 = {};

    for _, v in InputMapData.GetAllActions() do
        local v68 = InputMapData.Actions[v];
        local v69 = {
            Action = v
        };
        local v70 = p65._overrides[p66];
        local v71;

        if v70 and v70[v] ~= nil then
            v71 = v70[v];
        else
            v71 = InputMapData.GetDefault(v, p66);
        end;

        v69.Key = v71;
        v69.DisplayName = v68.DisplayName;
        v69.Description = v68.Description;
        v69.Category = v68.Category;
        v69.Remappable = InputMapData.IsRemappable(v, p66);
        v69.Order = v68.Order;
        table.insert(v67, v69);
    end;

    return v67;
end;

function v6.ValidateBinding(p72: table, p73: string, p74: string, p75: string) -- Line: 379
    -- upvalues: InputMapData (copy)
    if not InputMapData.Actions[p73] then
        return "INVALID_ACTION";
    end;

    if p74 ~= "Keyboard" and p74 ~= "Gamepad" then
        return "INVALID_PLATFORM";
    end;

    if not InputMapData.IsRemappable(p73, p74) then
        return "NOT_REMAPPABLE";
    end;

    if p75 ~= "" then
        if string.find(p75, "+", 1, true) then
            if not InputMapData.AllowsCombo(p73, p74) then
                return "NO_COMBOS";
            end;

            local v76, v77, v78 = InputMapData.ParseCombo(p74, p75);

            if not v76 then
                return "INVALID_COMBO";
            end;

            local v79 = p72._comboReverse[p74];

            if v79 then
                if v78 >= v77 then
                    local v80 = v77;
                    v77 = v78;
                    v78 = v80;
                end;

                v79 = v79[v78 .. "+" .. v77];
            end;

            if v79 and v79 ~= p73 then
                return "CONFLICT", v79;
            end;

            return "OK";
        end;

        if InputMapData.IsReservedKey(p74, p75) then
            return "RESERVED";
        end;

        local v81 = p72._reverse[p74] and p72._reverse[p74][p75];

        if v81 and v81 ~= p73 then
            return "CONFLICT", v81;
        end;
    end;

    return "OK";
end;

local function applyLocal(p82: any, p83: string, p84: string, p85: string) -- Line: 426
    -- upvalues: InputMapData (copy), rebuildReverse (copy), fireChanged (copy)
    if p85 == InputMapData.GetDefault(p83, p84) then
        p82._overrides[p84][p83] = nil;
    else
        p82._overrides[p84][p83] = p85;
    end;

    rebuildReverse(p82, p84);
    fireChanged(p82, p83, p84, p85);
end;

local function forwardToServer(p86: any, u87: string, ...) -- Line: 439
    local _service = p86._service;

    if not (_service and _service[u87]) then
        return;
    end;

    local u88 = { ... };
    task.spawn(function() -- Line: 443
        -- upvalues: _service (copy), u87 (copy), u88 (copy)
        local success, result = pcall(function() -- Line: 444
            -- upvalues: _service (ref), u87 (ref), u88 (ref)
            local v89 = _service[u87](_service, table.unpack(u88));

            if v89 and v89.await then
                local v90, v91 = v89:await();

                if not v90 then
                    error(tostring(v91), 0);
                end;
            end;
        end);

        if not success then
            warn((`[InputBindingController] server {u87} failed: {result}`));
        end;
    end);
end;

function v6.SetBinding(p92: table, p93: string, p94: string, p95: string) -- Line: 463
    -- upvalues: InputMapData (copy), rebuildReverse (copy), fireChanged (copy), forwardToServer (copy)
    local v96, v97 = p92:ValidateBinding(p93, p94, p95);

    if v96 ~= "OK" and v96 ~= "CONFLICT" then
        return false, v96, nil;
    end;

    if v96 == "CONFLICT" and v97 then
        if InputMapData.GetDefault(v97, p94) == "" then
            p92._overrides[p94][v97] = nil;
        else
            p92._overrides[p94][v97] = "";
        end;

        rebuildReverse(p92, p94);
        fireChanged(p92, v97, p94, "");
        forwardToServer(p92, "SetKeybind", p94, v97, "");
    else
        v97 = nil;
    end;

    if p95 == InputMapData.GetDefault(p93, p94) then
        p92._overrides[p94][p93] = nil;
    else
        p92._overrides[p94][p93] = p95;
    end;

    rebuildReverse(p92, p94);
    fireChanged(p92, p93, p94, p95);
    forwardToServer(p92, "SetKeybind", p94, p93, p95);

    return true, "OK", v97;
end;

function v6.ResetBinding(p98: table, p99: string, p100: string) -- Line: 483
    -- upvalues: InputMapData (copy)
    if not InputMapData.Actions[p99] then
        return false;
    end;

    local Default = InputMapData.GetDefault(p99, p100);

    return select(1, p98:SetBinding(p99, p100, Default));
end;

function v6.ResetAll(p101: table, p102: string) -- Line: 492
    -- upvalues: InputMapData (copy), rebuildReverse (copy), fireChanged (copy), forwardToServer (copy)
    if p102 ~= "Keyboard" and p102 ~= "Gamepad" then
        return;
    end;

    for i, v in InputMapData.Actions do
        local v103 = v.Defaults[p102] or "";

        if v103 == InputMapData.GetDefault(i, p102) then
            p101._overrides[p102][i] = nil;
        else
            p101._overrides[p102][i] = v103;
        end;

        rebuildReverse(p101, p102);
        fireChanged(p101, i, p102, v103);
    end;

    forwardToServer(p101, "ResetKeybinds", p102);
end;

function v6.OnBindingsChanged(u104, u105) -- Line: 505
    table.insert(u104._changedCallbacks, u105);

    return function() -- Line: 507
        -- upvalues: u104 (copy), u105 (copy)
        for i, v in u104._changedCallbacks do
            if v == u105 then
                table.remove(u104._changedCallbacks, i);

                return;
            end;
        end;
    end;
end;

function v6.SetCapturing(p106: table, p107: boolean) -- Line: 523
    p106._capturing = p107 == true;
end;

function v6.IsCapturing(p108) -- Line: 527
    return p108._capturing == true;
end;

function v6.PrettyKey(p109: table, p110: string) -- Line: 534
    -- upvalues: InputMapData (copy)
    return InputMapData.PrettyKey(p110);
end;

return v6;