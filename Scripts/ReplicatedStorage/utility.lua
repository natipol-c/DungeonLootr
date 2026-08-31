--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     utility
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.utility
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local PhysicsService = game:GetService("PhysicsService");
local u1 = require("./attributes");
local u2 = require("./logger");
local u3 = require("../pkg/Promise");
local u4 = {};
local v5 = script:FindFirstAncestorOfClass("Plugin") or RunService:IsStudio() and not RunService:IsRunning();
u4.PLUGIN_CONTEXT = v5;
u4.SERVER_CONTEXT = RunService:IsServer() or u4.PLUGIN_CONTEXT;
u4.DEG_TO_RAD = 0.017453292519943295;
u4.BEZIER_TAG = "BezierParticle";
u4.LIGHTNING_TAG = "LightningBolt";
u4.SHOCKWAVE_TAG = "Shockwave";
u4.SCREENSHAKE_TAG = "CameraShake";
u4.PROPERTY_TWEENER_TAG = "PropertyTweener";
u4.PROPERTY_RANDOMIZER_TAG = "PropertyRandomizer";
u4.ATTRIBUTE_TWEENER_TAG = "AttributeTweener";
u4.ATTRIBUTE_RANDOMIZER_TAG = "AttributeRandomizer";
u4.ENABLED_VFX_TAG = "ConstantVFX";
u4.TEXTURE_LOAD_TAG = "LoadVFXTextures";
u4.CLEANUP_TAG = "__forge__cleanupOnExit";
u4.EMIT_EXCLUDE_TAG = "__forge_excludeFromEmit";
u4.RENDER_PRIORITY = Enum.RenderPriority.Camera.Value + 1;
u4.COLLISION_GROUPS = {
    StudioSelectable = {},
    ForgeDebris = {
        ForgeDebris = false
    },
    ForgeMouseIgnore = {
        StudioSelectable = false
    }
};
u4.COPY_SPECIALMESH_PROPERTIES = { "MeshId", "MeshType", "Offset", "Scale", "TextureId", "VertexColor" };
u4.COPY_PART_PROPERTIES = { "CastShadow", "Color", "Material", "MaterialVariant", "Reflectance", "Shape", "FrontSurface", "BackSurface", "LeftSurface", "RightSurface", "TopSurface", "BottomSurface" };
u4.COPY_EXTENDED_PART_PROPERTIES = { "Size", "Transparency", "CustomPhysicalProperties", "CanCollide", "CanQuery", "CanTouch", "CollisionGroup" };
local u6 = setmetatable({}, {
    __mode = "k"
});

function u4.lock(p7: userdata) -- Line: 94
    -- upvalues: u6 (copy)
    if u6[p7] then
        return true;
    end;

    u6[p7] = coroutine.running();

    return false;
end;

function u4.unlock(p8: userdata, p9: thread?) -- Line: 104
    -- upvalues: u6 (copy), u2 (copy)
    local v10 = u6[p8];

    if coroutine.running() ~= v10 and p9 ~= v10 then
        u2.error("attempt to unlock an instance owned by a different thread");
    end;

    u6[p8] = nil;
end;

function u4.setCollisionGroups(p11) -- Line: 114
    -- upvalues: PhysicsService (copy), RunService (copy)
    local v12 = {};

    for i, v in p11 do
        PhysicsService:RegisterCollisionGroup(i);

        if not i:match("Studio") or RunService:IsStudio() then
            v12[i] = v;
        end;
    end;

    for i, v in v12 do
        local v13 = i;

        for i2, v2 in v do
            if not i2:match("Studio") or RunService:IsStudio() then
                PhysicsService:CollisionGroupSetCollidable(v13, i2, v2);
            end;
        end;
    end;
end;

local u14 = 0;

function u4.getRandomId() -- Line: 138
    -- upvalues: u14 (ref)
    u14 = u14 + 1;

    return tostring(u14);
end;

function u4.copyProperties(p15: userdata, p16: userdata, p17: table) -- Line: 143
    for _, v in p17 do
        p16[v] = p15[v];
    end;
end;

function u4.lerp(p18: number, p19: number, p20: number) -- Line: 149
    return p18 + (p19 - p18) * p20;
end;

function u4.try(u21: string, p22: function, ...) -- Line: 153
    -- upvalues: u2 (copy)
    local v24 = { xpcall(p22, function(p23) -- Line: 154
            -- upvalues: u2 (ref), u21 (copy)
            u2.warn(string.format(u21, p23));
        end, ...) };

    return v24[1], table.unpack(v24, 2);
end;

function u4.reboundfn(u25: number, u26: function) -- Line: 161
    local u27 = nil;

    return function(...) -- Line: 164
        -- upvalues: u27 (ref), u25 (copy), u26 (copy)
        if u27 then
            task.cancel(u27);
        end;

        local u28 = { ... };
        u27 = task.delay(u25, function() -- Line: 171
            -- upvalues: u27 (ref), u26 (ref), u28 (copy)
            u27 = nil;
            u26(table.unpack(u28));
        end);
    end;
end;

function u4.randomUnitVector(p29: vector, p30: vector, p31: userdata?) -- Line: 178
    local v32 = p31 or Random.new();
    local v33 = v32:NextNumber(p29.X, p30.X);
    local v34 = v32:NextNumber(p29.Y, p30.Y);

    return Vector3.new(v33, v34, v32:NextNumber(p29.Z, p30.Z));
end;

function u4.getImpulseForce(p35: vector, p36: vector, p37: number) -- Line: 183
    return (p36 - p35) / p37 + Vector3.new(0, workspace.Gravity * p37 * 0.5, 0);
end;

function u4.isMeshVFX(p38: userdata) -- Line: 187
    local v39 = p38 and (p38:IsA("Model") and p38:FindFirstChild("Start") and (p38.Start:IsA("BasePart") and p38:FindFirstChild("End"))) and p38.End:IsA("BasePart");

    return v39;
end;

function u4.isSpinModelStatic(p40: userdata) -- Line: 196
    -- upvalues: u1 (copy)
    local v41;

    if u1.get(p40, "SpinRotation", Vector3.new(0, 0, 0), true) == Vector3.new(0, 0, 0) and (u1.get(p40, "Scale_Start", 1, true) == 1 and u1.get(p40, "Scale_End", 1, true) == 1) then
        v41 = u1.get(p40, "SyncPosition", false, true) == false;
    else
        v41 = false;
    end;

    return v41;
end;

function u4.shouldSkipNested(p42: userdata) -- Line: 203
    -- upvalues: u4 (copy)
    local v43 = p42:IsA("Beam") or p42:HasTag(u4.BEZIER_TAG) or (p42:HasTag(u4.LIGHTNING_TAG) or u4.isMeshVFX(p42)) or p42:IsA("BasePart") and u4.findFirstClassWithTag(p42, "Attachment", u4.SHOCKWAVE_TAG) ~= nil;

    return v43;
end;

function u4.getTarget(p44: userdata) -- Line: 211
    local v45 = p44:FindFirstChildOfClass("ObjectValue");

    if v45 and v45.Value then
        return v45.Value;
    end;

    local Parent = p44.Parent;

    if not Parent then
        return nil;
    end;

    while Parent:IsA("Folder") do
        Parent = Parent.Parent;

        if not Parent then
            return nil;
        end;
    end;

    return Parent;
end;

function u4.createEmitPromise(u46: any, p47: userdata, u48: number, u49: any, u50: table?) -- Line: 235
    -- upvalues: u3 (copy), u4 (copy)
    local v55 = u3.new(function(p51, p52, p53) -- Line: 242
        -- upvalues: u48 (copy), u46 (copy), u50 (copy), u4 (ref), u49 (copy)
        local u54 = {
            depth = u48,
            effects = u46,
            _context = u50
        };
        p53(function() -- Line: 248
            -- upvalues: u54 (copy), u4 (ref)
            if u54._onCancel then
                for _, v in u54._onCancel do
                    v();
                end;
            end;

            u4.cleanupScope(u54);
        end);
        u49(u54);
        u4.cleanupScope(u54);
        p51();
    end);

    if u50 then
        table.insert(u50._promises, v55);
    end;

    return v55;
end;

function u4.onCancel(p56: table, p57: function) -- Line: 272
    if not p56._onCancel then
        p56._onCancel = {};
    end;

    table.insert(p56._onCancel, p57);
end;

local u58 = setmetatable({}, {
    __mode = "k"
});
local u59 = setmetatable({}, {
    __mode = "k"
});

function u4.forceEmit(p60: userdata, p61: boolean) -- Line: 287
    -- upvalues: u59 (copy)
    u59[p60] = p61 and true or nil;
end;

function u4.isForceEmitting(p62: userdata) -- Line: 291
    -- upvalues: u59 (copy)
    return u59[p62] == true;
end;

function u4.setEnabledCancelToken(p63: userdata, p64: table?) -- Line: 295
    -- upvalues: u58 (copy)
    u58[p63] = p64;
end;

function u4.getEnabledCancelToken(p65: userdata) -- Line: 299
    -- upvalues: u58 (copy)
    return u58[p65];
end;

function u4.cancelToken(p66: table) -- Line: 303
    -- upvalues: u4 (copy)
    for _, v in p66._promises do
        v:cancel();
    end;

    for _, v in p66._scopes do
        u4.cleanupScope(v, true);
    end;

    table.clear(p66._promises);
    table.clear(p66._scopes);
end;

function u4.stopEmitDuration(p67: userdata) -- Line: 316
    -- upvalues: u4 (copy), u1 (copy)
    local EnabledCancelToken = u4.getEnabledCancelToken(p67);
    u1.trigger(p67, "Enabled", false);
    u1.clearState(p67);
    u4.forceEmit(p67, false);

    return EnabledCancelToken;
end;

function u4.awaitEmitDuration(p68: table?) -- Line: 326
    -- upvalues: u3 (copy)
    if not p68 then
        return;
    end;

    local v69 = {};

    for _, v in p68._promises do
        table.insert(v69, v);
    end;

    if #v69 > 0 then
        u3.all(v69):await();
    end;
end;

function u4.cleanupScope(p70: table, p71: boolean?) -- Line: 342
    -- upvalues: u4 (copy)
    local depth = p70.depth;
    local effects = p70.effects;
    local _context = p70._context;
    local _onCancel = p70._onCancel;

    for i, v in p70 do
        if i ~= "depth" and (i ~= "effects" and (i ~= "_context" and i ~= "_onCancel")) then
            local v72 = typeof(v);

            if v72 == "Instance" then
                v:Destroy();
            elseif v72 == "RBXScriptConnection" then
                v:Disconnect();
            elseif v72 == "thread" then
                if coroutine.status(v) ~= "dead" then
                    task.cancel(v);
                end;
            elseif v72 == "function" then
                if p71 then
                    v();
                else
                    task.spawn(v);
                end;
            elseif v72 == "table" then
                u4.cleanupScope(v);
            end;
        end;
    end;

    table.clear(p70);
    p70.depth = depth;
    p70.effects = effects;
    p70._context = _context;
    p70._onCancel = _onCancel;
end;

function u4.protectParent(p73: table, u74: userdata) -- Line: 385
    table.insert(p73, u74.AncestryChanged:Connect(function(p75, p76) -- Line: 388
        -- upvalues: u74 (copy)
        if u74.Parent == workspace.Terrain then
            return;
        end;

        u74.Parent = workspace.Terrain;
    end));
end;

function u4.findFirstClassWithTag(p77: userdata?, p78: string, p79: string) -- Line: 398
    -- upvalues: u4 (copy)
    if p77 and p77.Parent ~= game then
        if p77.ClassName == p78 and p77:HasTag(p79) then
            return p77;
        end;

        return u4.findFirstClassWithTag(p77.Parent, p78, p79);
    end;
end;

function u4.cloneParticleAncestry(u80: userdata, u81: table) -- Line: 410
    if u80:FindFirstAncestorWhichIsA("BasePart") or u80:FindFirstAncestorOfClass("Attachment") then
        local function findAncestor(p82: userdata?) -- Line: 418
            -- upvalues: findAncestor (copy)
            if p82 then
                if p82.Parent and (p82.Parent:IsA("BasePart") or p82.Parent:IsA("Attachment")) then
                    p82 = findAncestor(p82.Parent);
                end;

                return p82;
            end;
        end;

        local function recurse(p83: userdata?) -- Line: 432
            -- upvalues: u81 (copy), u80 (copy), findAncestor (copy), recurse (copy)
            if p83 then
                local v84 = u81[p83];

                if v84 then
                    if p83 == u80 then
                        return v84, u81[p83.Parent];
                    end;

                    local Parent = p83.Parent;

                    if Parent then
                        if Parent.Parent and (Parent.Parent:IsA("BasePart") or Parent.Parent:IsA("Attachment")) then
                            Parent = findAncestor(Parent.Parent);
                        end;
                    else
                        Parent = nil;
                    end;

                    return v84, u81[Parent] or u81[p83];
                end;

                local Instance_fromExisting_ret = Instance.fromExisting(p83);
                Instance_fromExisting_ret.Archivable = false;

                if Instance_fromExisting_ret:IsA("BasePart") then
                    Instance_fromExisting_ret.Locked = true;
                end;

                if u81 then
                    u81[p83] = Instance_fromExisting_ret;
                end;

                local v85;

                if p83.Parent and (p83.Parent:IsA("BasePart") or p83.Parent:IsA("Attachment")) then
                    local v86, v87 = recurse(p83.Parent);
                    v85 = v87 or Instance_fromExisting_ret;

                    if v86 then
                        Instance_fromExisting_ret.Parent = v86;
                    end;
                else
                    v85 = Instance_fromExisting_ret;
                end;

                return Instance_fromExisting_ret, v85;
            end;
        end;

        return recurse(u80.Parent);
    end;
end;

function u4.getTransformedOriginExtents(p88: userdata) -- Line: 474
    -- upvalues: u1 (copy), u4 (copy)
    local CFrame_identity = CFrame.identity;

    if p88:IsA("BasePart") then
        return p88.CFrame, p88.Size;
    end;

    if p88:IsA("Attachment") then
        CFrame_identity = p88.WorldCFrame;
        local Parent = p88.Parent;
        local v89 = u1.get(p88, "PositionScale", Vector3.new(0, 0, 0), true);

        if Parent and (Parent:IsA("BasePart") and v89 ~= Vector3.new(0, 0, 0)) then
            CFrame_identity = CFrame_identity + Parent.Size / 2 * v89;
        end;

        local v90 = u1.get(p88, "OverrideWorldRotation", false, true);
        local v91 = u1.get(p88, "WorldRotation", Vector3.new(0, 0, 0), true);

        if v90 then
            local v92 = v91 * u4.DEG_TO_RAD;
            CFrame_identity = CFrame.new(CFrame_identity.Position) * CFrame.fromOrientation(v92.X, v92.Y, v92.Z);
        end;
    end;

    return CFrame_identity, Vector3.new(0, 0, 0);
end;

function u4.getMeshDecals(p93: userdata, p94: userdata) -- Line: 510
    -- upvalues: u1 (copy), u4 (copy)
    local v95 = {};
    local v96 = {};
    local v97 = {};

    local function filter(p98: table) -- Line: 517
        local v99 = {};

        for _, v in p98 do
            if v:IsA("Decal") then
                table.insert(v99, v);
            end;
        end;

        return v99;
    end;

    if u1.get(p93, "Flipbook", false, true) then
        return filter(p94:GetChildren()), v96, v97;
    end;

    local End = p93:FindFirstChild("End");
    local Start = p93:FindFirstChild("Start");

    if End then
        for _, child in p94:GetChildren() do
            if child:IsA("Decal") then
                local v100 = End:FindFirstChild(child.Name);

                if v100 and v100:IsA("Decal") then
                    table.insert(v95, child);
                    v97[child] = v100;

                    if u1.get(child, "FlipbookEnabled", nil) then
                        local v101 = u1.get(child, "FlipbookTextures", nil);

                        if v101 then
                            v96[child] = u4.deserializeFlipbook(v101);
                        end;
                    else
                        table.insert(v95, child);
                    end;
                end;
            end;
        end;

        for _, child in Start:GetChildren() do
            if child:IsA("Decal") then
                local Children = child:GetChildren();
                local v102 = child;
                local v103 = 0;

                for i = 1, #Children do
                    local v104 = i - v103;
                    local v105;

                    if Children[v104]:IsA("Decal") then
                        v105 = i;
                    else
                        table.remove(Children, v104);
                        v103 = v103 + 1;
                        v105 = i;
                    end;
                end;

                if #Children ~= 0 then
                    local function idx(p106: string) -- Line: 588
                        return tonumber(p106:match("%d+")) or 0;
                    end;

                    table.sort(Children, function(p107, p108) -- Line: 592
                        return (tonumber(p107.Name:match("%d+")) or 0) < (tonumber(p108.Name:match("%d+")) or 0);
                    end);
                    local v109 = {};

                    for _, v in Children do
                        local v110 = tonumber(v.Texture:match("%d+")) or 0;
                        table.insert(v109, v110);
                        v:Destroy();
                    end;

                    local v111 = u4.serializeFlipbook(v109);
                    u1.set(v102, "FlipbookEnabled", true);
                    u1.set(v102, "FlipbookTextures", buffer.tostring(v111));
                end;
            end;
        end;
    end;

    return v95, v96, v97;
end;

function u4.assembleMeshVFX(p112: userdata, p113: table, u114: any) -- Line: 615
    -- upvalues: u4 (copy)
    local RandomId = u4.getRandomId();

    if not p112:IsA("Part") then
        local v115 = p112:Clone();
        v115.Archivable = false;
        v115.Locked = true;
        v115.Parent = workspace.Terrain;
        v115:AddTag(u4.CLEANUP_TAG);
        table.insert(p113, v115);

        return v115;
    end;

    local v116 = u114:get(RandomId);
    v116.CFrame = p112.CFrame;
    local v117 = v116._getReal();
    u4.copyProperties(p112, v117, u4.COPY_PART_PROPERTIES);
    u4.copyProperties(p112, v117, u4.COPY_EXTENDED_PART_PROPERTIES);
    local v118 = p112:Clone();

    for _, child in v118:GetChildren() do
        child.Parent = v117;
    end;

    v118:Destroy();
    table.insert(p113, function() -- Line: 635
        -- upvalues: u114 (copy), RandomId (copy)
        u114:free(RandomId);
    end);

    return v116;
end;

function u4.getBezierPoints(u119: userdata, u120: boolean?) -- Line: 654
    local Children = u119:GetChildren();
    table.sort(Children, function(p121, p122) -- Line: 657
        return tonumber(p121.Name) < tonumber(p122.Name);
    end);
    local u123 = {};
    local u124 = {};
    local u125 = {};

    local function vec(p126: userdata) -- Line: 665
        -- upvalues: u119 (copy), u123 (copy), u120 (copy), u125 (copy), u124 (copy)
        local v127 = u119.WorldCFrame:PointToObjectSpace(p126.WorldPosition);
        local vector_create_ret = vector.create(v127.X, v127.Y, v127.Z);
        table.insert(u123, vector_create_ret);

        if u120 then
            u125[p126] = vector_create_ret;
            table.insert(u124, p126);
        end;

        return vector_create_ret;
    end;

    for i, v in Children do
        local T0 = v:FindFirstChild("T0");
        local T1 = v:FindFirstChild("T1");

        if i == 1 then
            local v128 = u119.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v128.X, v128.Y, v128.Z);
            table.insert(u123, vector_create_ret);

            if u120 then
                u125[v] = vector_create_ret;
                table.insert(u124, v);
            end;
        end;

        if i ~= 1 then
            if T1 then
                local v129 = u119.WorldCFrame:PointToObjectSpace(T1.WorldPosition);
                local vector_create_ret = vector.create(v129.X, v129.Y, v129.Z);
                table.insert(u123, vector_create_ret);

                if u120 then
                    u125[T1] = vector_create_ret;
                    table.insert(u124, T1);
                end;
            else
                local v130 = u119.WorldCFrame:PointToObjectSpace(v.WorldPosition);
                local vector_create_ret = vector.create(v130.X, v130.Y, v130.Z);
                table.insert(u123, vector_create_ret);

                if u120 then
                    u125[v] = vector_create_ret;
                    table.insert(u124, v);
                end;
            end;
        end;

        if i ~= 1 and i ~= #Children then
            local v131 = u119.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v131.X, v131.Y, v131.Z);
            table.insert(u123, vector_create_ret);

            if u120 then
                u125[v] = vector_create_ret;
                table.insert(u124, v);
            end;
        end;

        if i ~= #Children then
            if T0 then
                local v132 = u119.WorldCFrame:PointToObjectSpace(T0.WorldPosition);
                local vector_create_ret = vector.create(v132.X, v132.Y, v132.Z);
                table.insert(u123, vector_create_ret);

                if u120 then
                    u125[T0] = vector_create_ret;
                    table.insert(u124, T0);
                end;
            else
                local v133 = u119.WorldCFrame:PointToObjectSpace(v.WorldPosition);
                local vector_create_ret = vector.create(v133.X, v133.Y, v133.Z);
                table.insert(u123, vector_create_ret);

                if u120 then
                    u125[v] = vector_create_ret;
                    table.insert(u124, v);
                end;
            end;
        end;

        if i == #Children then
            local v134 = u119.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v134.X, v134.Y, v134.Z);
            table.insert(u123, vector_create_ret);

            if u120 then
                u125[v] = vector_create_ret;
                table.insert(u124, v);
            end;
        end;
    end;

    return u123, u124, u125;
end;

function u4.scaleNumberSequence(p135: userdata, p136: any) -- Line: 717
    if p136 == 1 then
        return p135;
    end;

    local v137 = {};

    for _, v in p135.Keypoints do
        local v138, v139;

        if typeof(p136) == "function" then
            v138, v139 = p136(v.Value, v.Envelope);
        else
            v138 = v.Value * p136;
            v139 = v.Envelope * p136;
        end;

        table.insert(v137, NumberSequenceKeypoint.new(v.Time, v138, v139));
    end;

    return NumberSequence.new(v137);
end;

function u4.serializePath(p140: table) -- Line: 742
    local buffer_create_ret = buffer.create(#p140 * 4 * 6);
    local v141 = 0;

    for i, v in p140 do
        local Scale = v.Position.X.Scale;
        local Scale2 = v.Position.Y.Scale;

        if i ~= 1 then
            buffer.writef32(buffer_create_ret, v141, Scale + v.LeftTangent.X.Scale);
            buffer.writef32(buffer_create_ret, v141 + 4, Scale2 + v.LeftTangent.Y.Scale);
            v141 = v141 + 8;
        end;

        buffer.writef32(buffer_create_ret, v141, Scale);
        buffer.writef32(buffer_create_ret, v141 + 4, Scale2);
        v141 = v141 + 8;

        if i ~= #p140 then
            buffer.writef32(buffer_create_ret, v141, Scale + v.RightTangent.X.Scale);
            buffer.writef32(buffer_create_ret, v141 + 4, Scale2 + v.RightTangent.Y.Scale);
            v141 = v141 + 8;
        end;
    end;

    return buffer_create_ret;
end;

function u4.deserializePath(p142) -- Line: 774
    if typeof(p142) == "string" then
        p142 = buffer.fromstring(p142) or p142;
    end;

    local v143 = buffer.len(p142) / 24;
    local v144 = {};

    for i = 0, v143 - 1 do
        local v145 = i * 4 * 6;
        local buffer_readf32_ret = buffer.readf32(p142, v145);
        local buffer_readf32_ret2 = buffer.readf32(p142, v145 + 4);
        local vector_create_ret = vector.create(buffer_readf32_ret, buffer_readf32_ret2);
        table.insert(v144, vector_create_ret);
        local v146;

        if i == v143 - 1 then
            v146 = i;
        else
            local buffer_readf32_ret3 = buffer.readf32(p142, v145 + 8);
            local buffer_readf32_ret4 = buffer.readf32(p142, v145 + 12);
            local buffer_readf32_ret5 = buffer.readf32(p142, v145 + 16);
            local buffer_readf32_ret6 = buffer.readf32(p142, v145 + 20);
            local vector_create_ret2 = vector.create(buffer_readf32_ret3, buffer_readf32_ret4);
            table.insert(v144, vector_create_ret2);
            local vector_create_ret3 = vector.create(buffer_readf32_ret5, buffer_readf32_ret6);
            table.insert(v144, vector_create_ret3);
            v146 = i;
        end;
    end;

    return v144;
end;

local v147 = require("./common/flipbook");
u4.serializeFlipbook = v147.serialize;
u4.deserializeFlipbook = v147.deserialize;
u4.default_bezier = buffer.tostring(u4.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1), UDim2.new(), UDim2.fromScale(0.215, -0.61)), Path2DControlPoint.new(UDim2.fromScale(1, 0), UDim2.fromScale(-0.645, 0), UDim2.new()) }));
u4.linear_bezier = buffer.tostring(u4.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1)), Path2DControlPoint.new(UDim2.fromScale(1, 0)) }));

function u4.scaleAttribute(p148: userdata, p149: number, p150: string) -- Line: 820
    -- upvalues: u1 (copy)
    local v151 = u1.get(p148, p150, nil);

    if v151 ~= nil then
        if typeof(v151) == "number" then
            u1.set(p148, p150, v151 * p149);

            return;
        end;

        if typeof(v151) == "Vector3" then
            u1.set(p148, p150, v151 * p149);

            return;
        end;

        if typeof(v151) == "NumberRange" then
            u1.set(p148, p150, NumberRange.new(v151.Min * p149, v151.Max * p149));
        end;
    end;
end;

function u4.scaleAttachmentDistance(p152: userdata?, p153: userdata?, p154: number) -- Line: 834
    if not (p152 and p153) then
        return;
    end;

    local v155 = (p152.Position + p153.Position) / 2;
    p152.Position = v155 + (p152.Position - v155) * p154;
    p153.Position = v155 + (p153.Position - v155) * p154;
end;

return u4;