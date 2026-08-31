--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ForgeChoreographer
  Path:     game.ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ForgeVFXUtil = require(ReplicatedStorage.Modules.ForgeVFXUtil);
local v1 = {};

local function resolvePath(p2: userdata?, p3: string) -- Line: 128
    for i in string.gmatch(p3, "[^/]+") do
        if not p2 then
            return nil;
        end;

        p2 = p2:FindFirstChild(i);
    end;

    return p2;
end;

local function getClassVFX(p4: userdata, p5: string?) -- Line: 141
    local v6 = p4.Parent and p4.Parent.Parent;
    local v7;

    if v6 then
        v7 = `{v6.Name}/{p4.Name}`;
    else
        v7 = p4.Name;
    end;

    local v8;

    if v6 then
        v8 = v6.Name;
    else
        v8 = p4.Name;
    end;

    if v6 then
        v6 = v6:FindFirstChild(p5 or "VFX");
    end;

    return v7, v6, v8;
end;

local function emitRig(p9: any, p10: userdata, p11: userdata, p12: any) -- Line: 162
    -- upvalues: ForgeVFXUtil (copy)
    if p11 then
        p11 = p11:FindFirstChild("HumanoidRootPart");
    end;

    local Rotation = p10:GetPivot().Rotation;
    local v13 = p9.offset or CFrame.identity;
    local v14 = p10:GetAttribute("FollowCaster") == true;
    local Attribute = p10:GetAttribute("FollowOffset");

    if (p9.follow or v14) and p11 then
        local v15 = v13 * (p9.followOffset or CFrame.identity);
        local v16;

        if typeof(Attribute) == "Vector3" then
            v16 = CFrame.new(Attribute);
        else
            v16 = CFrame.identity;
        end;

        return ForgeVFXUtil.Emit(p10, {
            MaxDistance = (1 / 0),
            AttachTo = p11,
            Offset = v15 * v16 * Rotation,
            StripCameraShake = p9.stripCameraShake ~= false
        });
    end;

    if typeof(p12) == "CFrame" then
        p11 = p12;
    elseif p11 then
        p11 = p11.CFrame;
    end;

    if p11 then
        return ForgeVFXUtil.Emit(p10, {
            MaxDistance = (1 / 0),
            CFrame = p11 * v13 * Rotation,
            StripCameraShake = p9.stripCameraShake ~= false
        });
    end;

    return nil;
end;

local function makeDBreset(u17: any, u18: number) -- Line: 202
    return function(p19) -- Line: 203
        -- upvalues: u17 (copy), u18 (copy)
        local u20 = u17[p19];

        if u20 then
            u17[p19] = nil;
            task.delay(u18, function() -- Line: 207
                -- upvalues: u20 (copy)
                u20.Clear();
            end);
        end;
    end;
end;

function v1.single(p21: userdata, u22: table) -- Line: 216
    -- upvalues: resolvePath (copy), emitRig (copy)
    local v23 = p21.Parent and p21.Parent.Parent;
    local u24;

    if v23 then
        u24 = `{v23.Name}/{p21.Name}`;
    else
        u24 = p21.Name;
    end;

    if v23 then
        local _ = v23.Name;
    else
        local _ = p21.Name;
    end;

    if v23 then
        v23 = v23:FindFirstChild("VFX");
    end;

    local u25 = resolvePath(v23, u22.rigPath);
    local u26 = setmetatable({}, {
        __mode = "k"
    });
    local v31 = {
        init = function(p27) -- Line: 225, Name: init
        end,

        Start = function(p28, p29) -- Line: 229, Name: Start
            -- upvalues: u25 (copy), u24 (copy), u22 (copy), emitRig (ref), u26 (copy)
            if not u25 then
                warn((`[{u24}] VFX rig "VFX/{u22.rigPath}" not found in the class folder`));

                return;
            end;

            local v30 = emitRig(u22, u25, p28, p29);

            if v30 then
                u26[p28] = v30;
            end;
        end
    };
    local u32 = u22.garbageDelay or 2;

    function v31.DBreset(p33) -- Line: 203
        -- upvalues: u26 (copy), u32 (copy)
        local u34 = u26[p33];

        if u34 then
            u26[p33] = nil;
            task.delay(u32, function() -- Line: 207
                -- upvalues: u34 (copy)
                u34.Clear();
            end);
        end;
    end;

    return v31;
end;

function v1.group(p35: userdata, u36: table) -- Line: 248
    -- upvalues: resolvePath (copy), emitRig (copy)
    local u37 = p35.Parent and p35.Parent.Parent;
    local u38;

    if u37 then
        u38 = `{u37.Name}/{p35.Name}`;
    else
        u38 = p35.Name;
    end;

    if u37 then
        local _ = u37.Name;
    else
        local _ = p35.Name;
    end;

    if u37 then
        u37 = u37:FindFirstChild("VFX");
    end;

    local u39;

    if u36.modeRoot then
        u39 = nil;
    else
        u39 = resolvePath(u37, u36.groupPath);
    end;

    local u40 = {};

    local function getGroup(p41: userdata?) -- Line: 259
        -- upvalues: u36 (copy), u39 (copy), u40 (copy), resolvePath (ref), u37 (copy)
        if not u36.modeRoot then
            return u39;
        end;

        local v42 = p41 and p41:GetAttribute(u36.modeRoot.attribute) or u36.modeRoot.default;
        local v43 = tostring(v42);
        local v44 = u40[v43];

        if v44 == nil then
            v44 = resolvePath(u37, v43 .. "/" .. u36.groupPath) or false;
            u40[v43] = v44;
        end;

        return v44 or nil;
    end;

    local u45 = setmetatable({}, {
        __mode = "k"
    });

    local function resolveRig(p46: userdata?, p47: any) -- Line: 275
        -- upvalues: getGroup (copy), u38 (copy), u36 (copy)
        local v48 = getGroup(p46);

        if not v48 then
            warn((`[{u38}] VFX group "VFX/{u36.modeRoot and "<mode>/" or ""}{u36.groupPath}" not found in the class folder`));

            return nil;
        end;

        if not p47 or p47 == "" then
            return nil;
        end;

        local v49 = tostring(p47);
        local v50 = v48:FindFirstChild(v49);

        if not v50 and u36.nestedParams then
            v50 = v49:match("^([^_]+)_");

            if v50 then
                v50 = v48:FindFirstChild(v50);
            end;

            if v50 then
                v50 = v50:FindFirstChild(v49);
            end;
        end;

        return v50;
    end;

    local v56 = {
        init = function(p51) -- Line: 295, Name: init
        end,

        Hit = function(p52, p53, p54) -- Line: 299, Name: Hit
            -- upvalues: resolveRig (copy), emitRig (ref), u36 (copy)
            local v55 = resolveRig(p52, p54);

            if not v55 then
                return;
            end;

            emitRig(u36, v55, p52, p53);
        end
    };

    if u36.holdMethod then
        v56[u36.holdMethod] = function(p57, p58, p59) -- Line: 306
            -- upvalues: resolveRig (copy), emitRig (ref), u36 (copy), u45 (copy)
            local v60 = resolveRig(p57, p59);

            if not v60 then
                return;
            end;

            local v61 = emitRig(u36, v60, p57, p58);

            if v61 then
                u45[p57] = v61;
            end;
        end;
    end;

    local u62 = u36.garbageDelay or 2;

    function v56.DBreset(p63) -- Line: 203
        -- upvalues: u45 (copy), u62 (copy)
        local u64 = u45[p63];

        if u64 then
            u45[p63] = nil;
            task.delay(u62, function() -- Line: 207
                -- upvalues: u64 (copy)
                u64.Clear();
            end);
        end;
    end;

    return v56;
end;

function v1.markerEmit(p65: userdata, u66: table) -- Line: 333
    -- upvalues: resolvePath (copy), ForgeVFXUtil (copy), RunService (copy)
    local root = u66.root;
    local u67 = p65.Parent and p65.Parent.Parent;
    local u68;

    if u67 then
        u68 = `{u67.Name}/{p65.Name}`;
    else
        u68 = p65.Name;
    end;

    local u69;

    if u67 then
        u69 = u67.Name;
    else
        u69 = p65.Name;
    end;

    if u67 then
        u67 = u67:FindFirstChild(root or "VFX");
    end;

    local function buildTemplates(p70: string?) -- Line: 344
        -- upvalues: u66 (copy), resolvePath (ref), u67 (copy), u68 (copy)
        local v71 = {};

        for _, v in u66.models do
            local v72;

            if p70 then
                v72 = resolvePath(u67, p70 .. "/" .. v);
            else
                v72 = nil;
            end;

            local v73 = v72 or resolvePath(u67, v);

            if v73 then
                table.insert(v71, {
                    name = v73.Name,
                    model = v73
                });
            elseif not u66.modeRoot then
                warn((`[{u68}] VFX model "VFX/{v}" not found in the class folder`));
            end;
        end;

        return v71;
    end;

    local u74;

    if u66.modeRoot then
        u74 = nil;
    else
        u74 = buildTemplates(nil);
    end;

    local u75 = {};

    local function getTemplates(p76: userdata?) -- Line: 361
        -- upvalues: u66 (copy), u74 (copy), u75 (copy), buildTemplates (copy)
        if not u66.modeRoot then
            return u74;
        end;

        local v77 = p76 and p76:GetAttribute(u66.modeRoot.attribute) or u66.modeRoot.default;
        local v78 = tostring(v77);
        local v79 = u75[v78];

        if not v79 then
            v79 = buildTemplates(v78);
            u75[v78] = v79;
        end;

        return v79;
    end;

    local u80 = {};

    if u66.ownerOnlyParams then
        for _, v in u66.ownerOnlyParams do
            u80[tostring(v):lower()] = true;
        end;
    end;

    local u81 = {};

    if u66.limbAttachments then
        for i in u66.limbAttachments do
            local v82;

            if u67 then
                v82 = u67:FindFirstChild(i, true);
            else
                v82 = u67;
            end;

            if v82 then
                u81[i] = v82;
            else
                warn((`[{u68}] VFX limbAttachment template "{i}" not found in the class folder`));
            end;
        end;
    end;

    local function emitLimbAttachment(p83: userdata, p84: string) -- Line: 404
        -- upvalues: u81 (copy), u66 (copy), resolvePath (ref), u69 (copy), ForgeVFXUtil (ref)
        local v85 = u81[p84];
        local v86 = u66.limbAttachments and u66.limbAttachments[p84];

        if not (v85 and (v86 and p83)) then
            return false;
        end;

        local v87 = resolvePath(p83, v86);

        if not (v87 and v87:IsA("BasePart")) then
            return false;
        end;

        local v88 = v87:FindFirstChild(v85.Name);

        if v88 and v88:HasTag(u69) then
            ForgeVFXUtil.GetForge().emit(v88);

            return true;
        end;

        if v88 then
            v88:Destroy();
        end;

        local v89 = v85:Clone();

        if u66.stripCameraShake ~= false then
            for _, descendant in v89:GetDescendants() do
                if descendant:IsA("RayValue") and descendant:HasTag("CameraShake") then
                    descendant:Destroy();
                end;
            end;
        end;

        v89:AddTag(u69);
        v89.Parent = v87;
        ForgeVFXUtil.GetForge().emit(v89);

        return true;
    end;

    local function findDescendantCI(p90: userdata, p91: string) -- Line: 438
        for _, descendant in p90:GetDescendants() do
            if descendant.Name:lower() == p91 then
                return descendant;
            end;
        end;

        return nil;
    end;

    local function resolveTarget(p92, p93) -- Line: 447
        -- upvalues: findDescendantCI (copy)
        if not p92 or p92 == "" then
            return nil, nil, nil;
        end;

        local v94 = tostring(p92);

        for _, v in p93 do
            if v.name == v94 then
                return v.model, nil, nil;
            end;

            local v95 = v.model:FindFirstChild(v94) or v.model:FindFirstChild(v94, true);

            if v95 then
                return v.model, v94, v95;
            end;
        end;

        local v96 = v94:lower();

        for _, v in p93 do
            if v.name:lower() == v96 then
                return v.model, nil, nil;
            end;

            local v97 = findDescendantCI(v.model, v96);

            if v97 then
                return v.model, v97.Name, v97;
            end;
        end;

        return nil, nil, nil;
    end;

    local function readRigAttribute(p98: userdata?, p99: userdata, p100: string) -- Line: 487
        if p98 then
            p98 = p98:GetAttribute(p100);
        end;

        if p98 == nil then
            p98 = p99:GetAttribute(p100);
        end;

        return p98;
    end;

    local u101 = setmetatable({}, {
        __mode = "k"
    });
    local CFrame_new_ret = CFrame.new(0, -500, 0);

    local function getStagedClone(p102: userdata, p103: userdata) -- Line: 503
        -- upvalues: u101 (copy), u66 (copy), CFrame_new_ret (copy), ForgeVFXUtil (ref)
        local u104 = u101[p102];

        if not u104 then
            u104 = {};
            u101[p102] = u104;
            p102.Destroying:Once(function() -- Line: 508
                -- upvalues: u104 (ref)
                for _, v in u104 do
                    v:Destroy();
                end;

                table.clear(u104);
            end);
        end;

        local v105 = u104[p103];

        if v105 and v105.Parent then
            return v105;
        end;

        local v106 = p103:Clone();

        if u66.stripCameraShake ~= false then
            for _, descendant in v106:GetDescendants() do
                if descendant:IsA("RayValue") and descendant:HasTag("CameraShake") then
                    descendant:Destroy();
                end;
            end;
        end;

        for _, descendant in v106:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.Anchored = true;
            end;
        end;

        if v106:IsA("PVInstance") then
            v106:PivotTo(CFrame_new_ret);
        end;

        v106.Parent = ForgeVFXUtil.GetDefaultParent();
        u104[p103] = v106;

        return v106;
    end;

    local u107 = setmetatable({}, {
        __mode = "k"
    });

    local function startFollow(u108: userdata, u109: userdata, p110) -- Line: 550
        -- upvalues: u107 (copy), RunService (ref)
        if u109.Parent and u108:IsA("PVInstance") then
            u108:PivotTo(u109.CFrame * p110);
        end;

        local v111 = u107[u108];

        if v111 then
            v111.count = v111.count + 1;
            v111.offset = p110;

            return;
        end;

        local u112 = {
            count = 1,
            conn = nil,
            offset = p110
        };
        u112.conn = RunService.RenderStepped:Connect(function() -- Line: 565
            -- upvalues: u109 (copy), u108 (copy), u112 (ref)
            if u109.Parent and u108.Parent then
                u108:PivotTo(u109.CFrame * u112.offset);
            end;
        end);
        u107[u108] = u112;
        u108.Destroying:Once(function() -- Line: 571
            -- upvalues: u107 (ref), u108 (copy)
            local v113 = u107[u108];

            if v113 then
                v113.conn:Disconnect();
                u107[u108] = nil;
            end;
        end);
    end;

    local function releaseFollow(p114: userdata) -- Line: 580
        -- upvalues: u107 (copy)
        local v115 = u107[p114];

        if not v115 then
            return;
        end;

        v115.count = v115.count - 1;

        if v115.count <= 0 then
            v115.conn:Disconnect();
            u107[p114] = nil;
        end;
    end;

    local u116 = setmetatable({}, {
        __mode = "k"
    });

    local function schedulePark(u117: userdata) -- Line: 595
        -- upvalues: u116 (copy), u107 (copy)
        local u118 = (u116[u117] or 0) + 1;
        u116[u117] = u118;
        task.delay(2, function() -- Line: 598
            -- upvalues: u116 (ref), u117 (copy), u118 (copy), u107 (ref)
            if u116[u117] ~= u118 then
                return;
            end;

            if u107[u117] then
                return;
            end;

            if not u117.Parent then
                return;
            end;

            if u117:IsA("PVInstance") then
                u117:PivotTo(u117:GetPivot() + Vector3.new(0, -80, 0));

                return;
            end;

            for _, child in u117:GetChildren() do
                if child:IsA("PVInstance") then
                    child:PivotTo(child:GetPivot() + Vector3.new(0, -80, 0));
                end;
            end;
        end);
    end;

    local function isShockwavePart(p119: userdata) -- Line: 622
        if not p119:IsA("BasePart") then
            return false;
        end;

        for _, descendant in p119:GetDescendants() do
            if descendant:IsA("Attachment") and descendant:HasTag("Shockwave") then
                return true;
            end;
        end;

        return false;
    end;

    local function emitForgeTarget(p120: userdata) -- Line: 632
        -- upvalues: ForgeVFXUtil (ref), isShockwavePart (copy)
        local Forge = ForgeVFXUtil.GetForge();

        if isShockwavePart(p120) then
            local Children = p120:GetChildren();

            if #Children > 0 then
                return Forge.emit(table.unpack(Children));
            end;
        end;

        return Forge.emit(p120);
    end;

    local u121 = {};

    return {
        init = function(p122) -- Line: 648, Name: init
        end,

        Emit = function(p123, p124, p125) -- Line: 652, Name: Emit
            -- upvalues: u80 (copy), ForgeVFXUtil (ref), u66 (copy), emitLimbAttachment (copy), u121 (copy), u68 (copy), resolveTarget (copy), u74 (copy), u75 (copy), buildTemplates (copy), resolvePath (ref), u69 (copy), getStagedClone (copy), startFollow (copy), isShockwavePart (copy), u107 (copy), u116 (copy)
            if not p125 or p125 == "" then
                return;
            end;

            local v126 = tostring(p125);

            if u80[v126:lower()] and not ForgeVFXUtil.IsScreenOwner(p123) then
                return;
            end;

            if u66.limbAttachments and u66.limbAttachments[v126] then
                if not (emitLimbAttachment(p123, v126) or u121[v126]) then
                    u121[v126] = true;
                    warn((`[{u68}] VFX limb-attachment "{v126}": template or limb "{u66.limbAttachments[v126]}" not found on the character`));
                end;

                return;
            end;

            local v127;

            if u66.modeRoot then
                local v128 = p123 and p123:GetAttribute(u66.modeRoot.attribute) or u66.modeRoot.default;
                local v129 = tostring(v128);
                v127 = u75[v129];

                if not v127 then
                    v127 = buildTemplates(v129);
                    u75[v129] = v127;
                end;
            else
                v127 = u74;
            end;

            local v130, v131, v132 = resolveTarget(v126, v127);

            if not v130 then
                if u66.casterPaths and p123 then
                    for _, v in u66.casterPaths do
                        local v133 = resolvePath(p123, v);
                        local v134 = v133 and (v133:FindFirstChild(v126) or v133:FindFirstChild(v126, true));

                        if v134 then
                            ForgeVFXUtil.GetForge().emit(v134);

                            return;
                        end;
                    end;
                end;

                if u66.externalContainers then
                    for _, v in u66.externalContainers do
                        local v135 = v and (v:FindFirstChild(v126) or v:FindFirstChild(v126, true));

                        if v135 then
                            if ForgeVFXUtil.IsScreenOwner(p123) then
                                ForgeVFXUtil.GetForge().emit(v135);
                            end;

                            return;
                        end;
                    end;
                end;

                if not u121[v126] then
                    u121[v126] = true;
                    warn((`[{u68}] VFX marker param "{v126}" matches no configured rig object`));
                end;

                return;
            end;

            local v136 = v132 or v130;

            if v136:IsA("Highlight") and p123 then
                local v137 = p123:FindFirstChild(v136.Name);

                if v137 and v137:IsA("Highlight") then
                    if v137:HasTag(u69) then
                        ForgeVFXUtil.GetForge().emit(v137);

                        return;
                    end;

                    v137:Destroy();
                end;

                local v138 = v136:Clone();

                if u66.stripCameraShake ~= false then
                    for _, descendant in v138:GetDescendants() do
                        if descendant:IsA("RayValue") and descendant:HasTag("CameraShake") then
                            descendant:Destroy();
                        end;
                    end;
                end;

                v138:AddTag(u69);
                v138.Adornee = p123;
                v138.Parent = p123;
                ForgeVFXUtil.GetForge().emit(v138);

                return;
            end;

            local v139;

            if p123 then
                v139 = p123:FindFirstChild("HumanoidRootPart");
            else
                v139 = p123;
            end;

            if typeof(p124) ~= "CFrame" then
                if v139 then
                    p124 = v139.CFrame;
                else
                    p124 = v139;
                end;
            end;

            if not p124 then
                return;
            end;

            if u66.offset then
                p124 = p124 * u66.offset;
            end;

            local u140 = getStagedClone(p123, v130);
            local v141;

            if v131 then
                v141 = u140:FindFirstChild(v131) or u140:FindFirstChild(v131, true);
            else
                v141 = u140;
            end;

            if not v141 then
                return;
            end;

            local v142;

            if v141:IsA("Folder") then
                v142 = v141:FindFirstChild(v141.Name);

                if not (v142 and v142:IsA("PVInstance")) then
                    v142 = nil;

                    for _, child in v141:GetChildren() do
                        if child:IsA("PVInstance") then
                            v142 = child;
                            break;
                        end;
                    end;
                end;

                if v142 then
                    v132 = v130:FindFirstChild(v142.Name) or v132;
                else
                    v142 = v141;
                end;
            else
                v142 = v141;
            end;

            local u143 = nil;
            local v144 = nil;

            if u140:IsA("PVInstance") then
                u143 = u140;
                v144 = v130;
            elseif v142:IsA("PVInstance") then
                u143 = v142;
                v144 = v132 or v142;
            end;

            local v145;

            if v144 and v144:IsA("PVInstance") then
                v145 = v144:GetPivot().Rotation;
            else
                v145 = CFrame.identity;
            end;

            local v146;

            if v132 then
                v146 = v132:GetAttribute("FollowCaster");
            else
                v146 = v132;
            end;

            if v146 == nil then
                v146 = v130:GetAttribute("FollowCaster");
            end;

            local v147;

            if v132 then
                v147 = v132:GetAttribute("FollowOffset");
            else
                v147 = v132;
            end;

            if v147 == nil then
                v147 = v130:GetAttribute("FollowOffset");
            end;

            if v146 == true and (v139 and u143) then
                local v148 = u66.offset or CFrame.identity;
                local v149;

                if typeof(v147) == "Vector3" then
                    v149 = CFrame.new(v147);
                else
                    v149 = CFrame.identity;
                end;

                startFollow(u143, v139, v148 * v149 * v145);
                local Forge = ForgeVFXUtil.GetForge();
                local v150;

                if isShockwavePart(v142) then
                    local Children = v142:GetChildren();

                    if #Children > 0 then
                        v150 = Forge.emit(table.unpack(Children));
                    else
                        v150 = Forge.emit(v142);
                    end;
                else
                    v150 = Forge.emit(v142);
                end;

                v150.Finished:finally(function() -- Line: 824
                    -- upvalues: u143 (ref), u107 (ref), u140 (copy), u116 (ref)
                    local v151 = u143;
                    local v152 = u107[v151];

                    if v152 then
                        v152.count = v152.count - 1;

                        if v152.count <= 0 then
                            v152.conn:Disconnect();
                            u107[v151] = nil;
                        end;
                    end;

                    local u153 = u140;
                    local u154 = (u116[u153] or 0) + 1;
                    u116[u153] = u154;
                    task.delay(2, function() -- Line: 598
                        -- upvalues: u116 (ref), u153 (copy), u154 (copy), u107 (ref)
                        if u116[u153] ~= u154 then
                            return;
                        end;

                        if u107[u153] then
                            return;
                        end;

                        if not u153.Parent then
                            return;
                        end;

                        if u153:IsA("PVInstance") then
                            u153:PivotTo(u153:GetPivot() + Vector3.new(0, -80, 0));

                            return;
                        end;

                        for _, child in u153:GetChildren() do
                            if child:IsA("PVInstance") then
                                child:PivotTo(child:GetPivot() + Vector3.new(0, -80, 0));
                            end;
                        end;
                    end);
                end);

                return;
            end;

            local v155;

            if v132 then
                v155 = v132:GetAttribute("EmitOffset");
            else
                v155 = v132;
            end;

            if v155 == nil then
                v155 = v130:GetAttribute("EmitOffset");
            end;

            if typeof(v155) == "Vector3" then
                p124 = p124 * CFrame.new(v155);
            end;

            if v132 then
                v132 = v132:GetAttribute("SnapToGround");
            end;

            if v132 == nil then
                v132 = v130:GetAttribute("SnapToGround");
            end;

            if v132 == true then
                local RaycastParams_new_ret = RaycastParams.new();
                RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
                RaycastParams_new_ret.FilterDescendantsInstances = { ForgeVFXUtil.GetDefaultParent(), p123 };
                RaycastParams_new_ret.RespectCanCollide = true;
                local v156 = workspace:Raycast(p124.Position, Vector3.new(0, -100, 0), RaycastParams_new_ret);

                if v156 then
                    p124 = CFrame.new(v156.Position) * p124.Rotation;
                end;
            end;

            if u143 then
                u143:PivotTo(p124 * v145);
            end;

            local Forge = ForgeVFXUtil.GetForge();
            local v157;

            if isShockwavePart(v142) then
                local Children = v142:GetChildren();

                if #Children > 0 then
                    v157 = Forge.emit(table.unpack(Children));
                else
                    v157 = Forge.emit(v142);
                end;
            else
                v157 = Forge.emit(v142);
            end;

            v157.Finished:finally(function() -- Line: 859
                -- upvalues: u140 (copy), u116 (ref), u107 (ref)
                local u158 = u140;
                local u159 = (u116[u158] or 0) + 1;
                u116[u158] = u159;
                task.delay(2, function() -- Line: 598
                    -- upvalues: u116 (ref), u158 (copy), u159 (copy), u107 (ref)
                    if u116[u158] ~= u159 then
                        return;
                    end;

                    if u107[u158] then
                        return;
                    end;

                    if not u158.Parent then
                        return;
                    end;

                    if u158:IsA("PVInstance") then
                        u158:PivotTo(u158:GetPivot() + Vector3.new(0, -80, 0));

                        return;
                    end;

                    for _, child in u158:GetChildren() do
                        if child:IsA("PVInstance") then
                            child:PivotTo(child:GetPivot() + Vector3.new(0, -80, 0));
                        end;
                    end;
                end);
            end);
        end
    };
end;

return v1;