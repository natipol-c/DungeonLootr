--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Janitor.test
  Path:     game.ReplicatedStorage.Packages._Index.howmanysmall_janitor@1.18.3.janitor.__tests__.Janitor.test
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

_G.__IS_UNIT_TESTING__ = true;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Workspace = game:GetService("Workspace");
local JestGlobals = require(script.Parent.Parent.Parent.DevPackages.JestGlobals);
local Parent = require(script.Parent.Parent);
local Promise = require(script.Parent.Parent.Promise);
local describe = JestGlobals.describe;
local expect = JestGlobals.expect;
local it = JestGlobals.it;
local BindableEvent = Instance.new("BindableEvent");
local u1 = false;
BindableEvent.Event:Once(function() -- Line: 20
    -- upvalues: u1 (ref)
    u1 = true;
end);
BindableEvent:Fire();
BindableEvent:Destroy();
local u2 = not u1;

local function AwaitCondition(p3: function, p4: number?) -- Line: 28
    local os_clock_ret = os.clock();
    local v5 = p4 or 10;

    while not p3() do
        if v5 < os.clock() - os_clock_ret then
            return false;
        end;

        task.wait();
    end;

    return true;
end;

local u6 = {
    ClassName = "BasicClass"
};
u6.__index = u6;

function u6.new() -- Line: 57
    -- upvalues: u6 (copy)
    return setmetatable({
        CleanupFunction = nil
    }, u6);
end;

function u6.AddCleanupFunction(p7: table, p8: function?) -- Line: 62
    p7.CleanupFunction = p8;

    return p7;
end;

function u6.Destroy(p9) -- Line: 66
    local CleanupFunction = p9.CleanupFunction;

    if CleanupFunction then
        CleanupFunction();
    end;

    table.clear(p9);
    setmetatable(p9, nil);
end;

local function NoOperation() -- Line: 75
end;

describe("Janitor.Is", function() -- Line: 77
    -- upvalues: it (copy), Parent (copy), expect (copy), NoOperation (copy), u6 (copy)
    it("should return true iff the passed value is a Janitor", function() -- Line: 78
        -- upvalues: Parent (ref), expect (ref)
        local v10 = Parent.new();
        expect(Parent.Is(v10)).toBe(true);
        v10:Destroy();
    end);
    it("should return false iff the passed value is anything else", function() -- Line: 84
        -- upvalues: expect (ref), Parent (ref), NoOperation (ref), u6 (ref)
        expect(Parent.Is(NoOperation)).toBe(false);
        expect(Parent.Is({})).toBe(false);
        expect(Parent.Is(u6.new())).toBe(false);
    end);
end);
describe("Janitor.new", function() -- Line: 91
    -- upvalues: it (copy), Parent (copy), expect (copy)
    it("should create a new Janitor", function() -- Line: 92
        -- upvalues: Parent (ref), expect (ref)
        local v11 = Parent.new();
        expect(v11).toBeDefined();
        expect(Parent.Is(v11)).toBe(true);
        v11:Destroy();
    end);
end);
describe("Janitor.Add", function() -- Line: 100
    -- upvalues: it (copy), Parent (copy), expect (copy), NoOperation (copy), ReplicatedStorage (copy), u6 (copy), u2 (copy)
    it("should add things", function() -- Line: 101
        -- upvalues: Parent (ref), expect (ref), NoOperation (ref)
        local u12 = Parent.new();
        expect(function() -- Line: 103
            -- upvalues: u12 (copy), NoOperation (ref)
            u12:Add(NoOperation, true);
        end).never.toThrow();
        u12:Destroy();
    end);
    it("should add things with the given index", function() -- Line: 110
        -- upvalues: Parent (ref), expect (ref), NoOperation (ref)
        local u13 = Parent.new();
        expect(function() -- Line: 112
            -- upvalues: u13 (copy), NoOperation (ref)
            u13:Add(NoOperation, true, "Function");
        end).never.toThrow();
        expect(u13:Get("Function")).toEqual(expect.any("function"));
        u13:Destroy();
    end);
    it("should overwrite indexes", function() -- Line: 120
        -- upvalues: Parent (ref), NoOperation (ref), expect (ref)
        local v14 = Parent.new();
        local u15 = false;
        v14:Add(function() -- Line: 123
            -- upvalues: u15 (ref)
            u15 = true;
        end, true, "Function");
        v14:Add(NoOperation, true, "Function");
        expect(u15).toBe(true);
        v14:Destroy();
    end);
    it("should return the passed object", function() -- Line: 133
        -- upvalues: Parent (ref), expect (ref)
        local v16 = Parent.new();
        local v17 = v16:Add(Instance.new("Part"), "Destroy");
        expect(v17).toBeDefined();
        expect(v17).toEqual(expect.any("Instance"));
        expect(v17.ClassName).toBe("Part");
        v16:Destroy();
    end);
    it("should clean up instances, objects, functions, connections, and threads", function() -- Line: 143
        -- upvalues: Parent (ref), ReplicatedStorage (ref), NoOperation (ref), u6 (ref), expect (ref)
        local u18 = false;
        local u19 = false;
        local u20 = false;
        local u21 = false;
        local v22 = Parent.new();
        local v23 = v22:Add(Instance.new("Part"), "Destroy");
        v23.Parent = ReplicatedStorage;
        local v24 = v22:Add(v23.ChildRemoved:Connect(NoOperation), "Disconnect");
        v22:Add(function() -- Line: 155
            -- upvalues: u18 (ref)
            u18 = true;
        end, true);
        v22:Add(Parent.new(), "Destroy"):Add(function() -- Line: 159
            -- upvalues: u19 (ref)
            u19 = true;
        end, true);
        v22:Add(u6.new(), "Destroy"):AddCleanupFunction(function() -- Line: 163
            -- upvalues: u20 (ref)
            u20 = true;
        end);
        v22:Add(task.delay(1, function() -- Line: 167
            -- upvalues: u21 (ref)
            u21 = true;
        end), true);
        v22:Destroy();
        expect(v23.Parent).toBeUndefined();
        expect(v24.Connected).toBe(false);
        expect(u18).toBe(true);
        expect(u19).toBe(true);
        expect(u20).toBe(true);
        expect(u21).toBe(false);
    end);
    it("should clean up everything correctly", function() -- Line: 180
        -- upvalues: Parent (ref), expect (ref)
        local v25 = Parent.new();
        local u26 = 0;

        for i = 1, 5000 do
            v25:Add(function() -- Line: 186
                -- upvalues: u26 (ref)
                u26 = u26 + 1;
            end, true, i);
            local _ = i;
        end;

        for i = 5000, 1, -1 do
            v25:Remove(i);
            local _ = i;
        end;

        v25:Destroy();
        expect(u26).toBe(5000);
    end);
    it("should infer types if not given", function() -- Line: 199
        -- upvalues: Parent (ref), ReplicatedStorage (ref), NoOperation (ref), u2 (ref), expect (ref)
        local v27 = Parent.new();
        local v28 = v27:Add(ReplicatedStorage.AncestryChanged:Connect(NoOperation));
        v27:Destroy();

        if u2 then
            task.wait();
        end;

        expect(v28.Connected).toBe(false);
    end);
end);
describe("Janitor.AddPromise", function() -- Line: 211
    -- upvalues: Promise (copy), it (copy), Parent (copy), expect (copy), u6 (copy)
    if not Promise then
        return;
    end;

    it("should add a Promise", function() -- Line: 216
        -- upvalues: Parent (ref), Promise (ref), expect (ref)
        local v29 = Parent.new();
        local v30 = v29:AddPromise(Promise.delay(60));
        expect(Promise.is(v30)).toBe(true);
        v29:Destroy();
    end);
    it("should cancel the Promise when destroyed", function() -- Line: 224
        -- upvalues: Parent (ref), Promise (ref), expect (ref)
        local v31 = Parent.new();
        local u32 = false;
        v31:AddPromise(Promise.new(function(p33, p34, p35) -- Line: 228
            -- upvalues: u32 (ref), Promise (ref)
            if not p35(function() -- Line: 229
                -- upvalues: u32 (ref)
                u32 = true;
            end) then
                return Promise.delay(60):andThen(p33);
            end;
        end));
        v31:Destroy();
        expect(u32).toBe(true);
    end);
    it("should not remove any values from the return", function() -- Line: 242
        -- upvalues: Parent (ref), Promise (ref), expect (ref)
        local v36 = Parent.new();
        local _, v38 = v36:AddPromise(Promise.new(function(p37) -- Line: 245
            p37(true);
        end)):await();
        expect(v38).toBe(true);
        v36:Destroy();
    end);
    it("should throw if the passed value isn\'t a Promise", function() -- Line: 254
        -- upvalues: Parent (ref), expect (ref), u6 (ref)
        local u39 = Parent.new();
        expect(function() -- Line: 256
            -- upvalues: u39 (copy), u6 (ref)
            u39:AddPromise((u6.new()));
        end).toThrow();
        u39:Destroy();
    end);
end);
describe("Janitor.Remove", function() -- Line: 264
    -- upvalues: it (copy), Parent (copy), NoOperation (copy), expect (copy), AwaitCondition (copy), u6 (copy)
    it("should always return the Janitor", function() -- Line: 265
        -- upvalues: Parent (ref), NoOperation (ref), expect (ref)
        local v40 = Parent.new();
        v40:Add(NoOperation, true, "Function");
        expect(v40:Remove("Function")).toBe(v40);
        expect(v40:Remove("Function")).toBe(v40);
        v40:Destroy();
    end);
    it("should always remove the value", function() -- Line: 274
        -- upvalues: Parent (ref), expect (ref), AwaitCondition (ref)
        local v41 = Parent.new();
        local u42 = false;
        v41:Add(function() -- Line: 278
            -- upvalues: u42 (ref)
            u42 = true;
        end, true, "Function");
        v41:Remove("Function");
        expect(AwaitCondition(function() -- Line: 284
            -- upvalues: u42 (ref)
            return u42;
        end, 1)).toBe(true);
        v41:Destroy();
    end);
    it("should properly remove values that are already destroyed", function() -- Line: 290
        -- upvalues: Parent (ref), expect (ref)
        local u43 = Parent.new();
        local u44 = 0;
        local v45 = Parent.new();
        v45:Add(function() -- Line: 296
            -- upvalues: u44 (ref)
            u44 = u44 + 1;
        end, true);
        u43:Add(v45, "Destroy");
        v45:Destroy();
        expect(function() -- Line: 302
            -- upvalues: u43 (copy)
            u43:Destroy();
        end).never.toThrow();
        expect(u44).toBe(1);
    end);
    it("should clean up everything efficiently", function() -- Line: 309
        -- upvalues: Parent (ref), NoOperation (ref), u6 (ref)
        local v46 = Parent.new();
        local v47 = 0;

        for i = 1, 1000000 do
            v47 = v47 + 1;
            v46:Add(NoOperation, true, v47);
            local _ = i;
        end;

        for i = 1, 200000 do
            v47 = v47 + 1;
            v46:Add(task.delay(5, NoOperation), true, v47);
            local _ = i;
        end;

        for i = 1, 1000000 do
            v47 = v47 + 1;
            v46:Add(u6.new(), "Destroy", v47);
            local _ = i;
        end;

        for i = 1, 100000 do
            v47 = v47 + 1;
            v46:Add(Instance.new("Part"), "Destroy", v47);
            local _ = i;
        end;

        for i = 1, v47 do
            v46:Remove(i);
            local _ = i;
        end;

        v46:Destroy();
    end);
end);
describe("Janitor.RemoveList", function() -- Line: 343
    -- upvalues: it (copy), Parent (copy), NoOperation (copy), expect (copy)
    it("should always return the Janitor", function() -- Line: 344
        -- upvalues: Parent (ref), NoOperation (ref), expect (ref)
        local v48 = Parent.new();
        v48:Add(NoOperation, true, "Function");
        expect(v48:RemoveList("Function")).toBe(v48);
        expect(v48:RemoveList("Function")).toBe(v48);
        v48:Destroy();
    end);
    it("should always remove the value", function() -- Line: 353
        -- upvalues: Parent (ref), expect (ref)
        local v49 = Parent.new();
        local u50 = false;
        v49:Add(function() -- Line: 357
            -- upvalues: u50 (ref)
            u50 = true;
        end, true, "Function");
        v49:RemoveList("Function");
        expect(u50).toBe(true);
        v49:Destroy();
    end);
    it("should properly remove multiple values", function() -- Line: 367
        -- upvalues: Parent (ref), expect (ref)
        local v51 = Parent.new();
        local u52 = false;
        local u53 = false;
        local u54 = false;
        v51:Add(function() -- Line: 373
            -- upvalues: u52 (ref)
            u52 = true;
        end, true, 1);
        v51:Add(function() -- Line: 377
            -- upvalues: u53 (ref)
            u53 = true;
        end, true, 2);
        v51:Add(function() -- Line: 381
            -- upvalues: u54 (ref)
            u54 = true;
        end, true, 3);
        v51:RemoveList(1, 2, 3);
        expect(u52).toBe(true);
        expect(u53).toBe(true);
        expect(u54).toBe(true);
    end);
end);
describe("Janitor.Get", function() -- Line: 392
    -- upvalues: it (copy), Parent (copy), NoOperation (copy), expect (copy)
    it("should return the value iff it exists", function() -- Line: 393
        -- upvalues: Parent (ref), NoOperation (ref), expect (ref)
        local v55 = Parent.new();
        v55:Add(NoOperation, true, "Function");
        expect(v55:Get("Function")).toBe(NoOperation);
        v55:Destroy();
    end);
    it("should return void iff the value doesn\'t exist", function() -- Line: 400
        -- upvalues: Parent (ref), expect (ref)
        local v56 = Parent.new();
        expect(v56:Get("Function")).toBeUndefined();
        v56:Destroy();
    end);
end);
describe("Janitor.Cleanup", function() -- Line: 407
    -- upvalues: it (copy), Parent (copy), expect (copy), AwaitCondition (copy)
    it("should cleanup everything", function() -- Line: 408
        -- upvalues: Parent (ref), expect (ref)
        local v57 = Parent.new();
        local u58 = 0;

        for i = 1, 500 do
            v57:Add(function() -- Line: 414
                -- upvalues: u58 (ref)
                u58 = u58 + 1;
            end, true);
            local _ = i;
        end;

        v57:Cleanup();
        expect(u58).toBe(500);

        for i = 1, 500 do
            v57:Add(function() -- Line: 423
                -- upvalues: u58 (ref)
                u58 = u58 + 1;
            end, true);
            local _ = i;
        end;

        v57:Cleanup();
        expect(u58).toBe(1000);
    end);
    it("should be unique", function() -- Line: 432
        -- upvalues: Parent (ref), expect (ref), AwaitCondition (ref)
        local u59 = Parent.new();
        local v60 = Parent.new();
        expect(u59.CurrentlyCleaning).toBe(false);
        expect(v60.CurrentlyCleaning).toBe(false);
        local u61 = 0;
        local u62 = false;

        for i = 1, 500 do
            local v63;

            if i == 500 then
                u59:Add(function() -- Line: 445
                    -- upvalues: u61 (ref), u62 (ref)
                    u61 = u61 + 1;
                    task.wait(1);
                    u62 = true;
                end, true);
                v63 = i;
            else
                u59:Add(function() -- Line: 451
                    -- upvalues: u61 (ref)
                    u61 = u61 + 1;
                end, true);
                v63 = i;
            end;
        end;

        task.spawn(function() -- Line: 457
            -- upvalues: u59 (copy)
            u59:Cleanup();
        end);
        task.wait();
        expect(u59.CurrentlyCleaning).toBe(true);
        expect(v60.CurrentlyCleaning).toBe(false);
        expect(AwaitCondition(function() -- Line: 465
            -- upvalues: u62 (ref)
            return u62;
        end, 5)).toBe(true);
        expect(u61).toBe(500);
    end);
end);
describe("Janitor.Destroy", function() -- Line: 472
    -- upvalues: it (copy), Parent (copy), expect (copy), NoOperation (copy)
    it("should cleanup everything", function() -- Line: 473
        -- upvalues: Parent (ref), expect (ref)
        local v64 = Parent.new();
        local u65 = 0;

        for i = 1, 500 do
            v64:Add(function() -- Line: 479
                -- upvalues: u65 (ref)
                u65 = u65 + 1;
            end, true);
            local _ = i;
        end;

        v64:Destroy();
        expect(u65).toBe(500);
    end);
    it("should render the Janitor unusable", function() -- Line: 488
        -- upvalues: Parent (ref), expect (ref), NoOperation (ref)
        local u66 = Parent.new();
        u66:Destroy();
        expect(function() -- Line: 491
            -- upvalues: u66 (copy), NoOperation (ref)
            u66:Add(NoOperation, true);
        end).toBeTruthy();
    end);
end);
describe("Janitor.LinkToInstance", function() -- Line: 497
    -- upvalues: it (copy), Parent (copy), ReplicatedStorage (copy), expect (copy), Workspace (copy), AwaitCondition (copy), NoOperation (copy)
    it("should link to an Instance", function() -- Line: 498
        -- upvalues: Parent (ref), ReplicatedStorage (ref), expect (ref)
        local u67 = Parent.new();
        local u68 = u67:Add(Instance.new("Part"), "Destroy");
        u68.Parent = ReplicatedStorage;
        expect(function() -- Line: 503
            -- upvalues: u67 (copy), u68 (copy)
            u67:LinkToInstance(u68);
        end).never.toThrow();
        u67:Destroy();
    end);
    it("should cleanup once the Instance is destroyed", function() -- Line: 510
        -- upvalues: Parent (ref), Workspace (ref), expect (ref)
        local v69 = Parent.new();
        local u70 = false;
        local Part = Instance.new("Part");
        Part.Parent = Workspace;
        v69:Add(function() -- Line: 517
            -- upvalues: u70 (ref)
            u70 = true;
        end, true);
        v69:LinkToInstance(Part);
        Part:Destroy();
        task.wait(0.1);
        expect(u70).toBe(true);
        v69:Destroy();
    end);
    it("should work if the Instance is parented to nil when started", function() -- Line: 530
        -- upvalues: Parent (ref), Workspace (ref), expect (ref), AwaitCondition (ref)
        local v71 = Parent.new();
        local u72 = false;
        local Part = Instance.new("Part");
        v71:Add(function() -- Line: 535
            -- upvalues: u72 (ref)
            u72 = true;
        end, true);
        v71:LinkToInstance(Part);
        Part.Parent = Workspace;
        Part:Destroy();
        expect(AwaitCondition(function() -- Line: 543
            -- upvalues: u72 (ref)
            return u72;
        end, 1)).toBe(true);
        v71:Destroy();
    end);
    it("should work if the Instance is parented to nil", function() -- Line: 549
        -- upvalues: Parent (ref), expect (ref), AwaitCondition (ref)
        local v73 = Parent.new();
        local u74 = false;
        local Part = Instance.new("Part");
        v73:Add(function() -- Line: 554
            -- upvalues: u74 (ref)
            u74 = true;
        end, true);
        v73:LinkToInstance(Part);
        Part:Destroy();
        expect(AwaitCondition(function() -- Line: 561
            -- upvalues: u74 (ref)
            return u74;
        end, 1)).toBe(true);
        v73:Destroy();
    end);
    it("shouldn\'t run if the Instance is removed or parented to nil", function() -- Line: 567
        -- upvalues: Parent (ref), ReplicatedStorage (ref), NoOperation (ref), expect (ref)
        local u75 = Parent.new();
        local Part = Instance.new("Part");
        Part.Parent = ReplicatedStorage;
        u75:Add(NoOperation, true, "Function");
        u75:LinkToInstance(Part);
        Part.Parent = nil;
        expect(u75:Get("Function")).toBe(NoOperation);
        Part.Parent = ReplicatedStorage;
        expect(u75:Get("Function")).toBe(NoOperation);
        Part:Destroy();
        task.wait(0.1);
        expect(function() -- Line: 582
            -- upvalues: u75 (copy)
            u75:Destroy();
        end).never.toThrow();
    end);
end);

return false;