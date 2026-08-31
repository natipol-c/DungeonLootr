--[[
  Type:     ModuleScript
  Method:   cached
  Name:     ViewportModel
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.ViewportModel
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = { 0, 1, 2, 3, 4, 5, 6, 7 };
local u2 = { 0, 1, 3, 4, 5, 7 };
local u3 = { 0, 1, 4, 5, 6 };
local u4 = {};
u4.__index = u4;
u4.ClassName = "ViewportModel";

local function getIndices(p5) -- Line: 13
    -- upvalues: u2 (copy), u3 (copy), u1 (copy)
    if p5:IsA("WedgePart") then
        return u2;
    end;

    if p5:IsA("CornerWedgePart") then
        return u3;
    end;

    return u1;
end;

local function getCorners(p6, p7, p8) -- Line: 22
    local v9 = {};

    for _, v in pairs(p8) do
        local v10 = math.floor(v / 4) % 2 * 2 - 1;
        local v11 = math.floor(v / 2) % 2 * 2 - 1;
        v9[v + 1] = p6 * (p7 * Vector3.new(v10, v11, 2 * (v % 2) - 1));
    end;

    return v9;
end;

local function getModelPointCloud(p12) -- Line: 31
    -- upvalues: u2 (copy), u3 (copy), u1 (copy), getCorners (copy)
    local v13 = {};

    for _, descendant in pairs(p12:GetDescendants()) do
        if descendant:IsA("BasePart") then
            local v14;

            if descendant:IsA("WedgePart") then
                v14 = u2;
            elseif descendant:IsA("CornerWedgePart") then
                v14 = u3;
            else
                v14 = u1;
            end;

            local v15 = getCorners(descendant.CFrame, descendant.Size / 2, v14);

            for _, v in pairs(v15) do
                table.insert(v13, v);
            end;
        end;
    end;

    return v13;
end;

local function viewProjectionEdgeHits(p16, p17, p18, p19) -- Line: 45
    local v20 = (-1 / 0);
    local v21 = (1 / 0);

    for _, v in pairs(p16) do
        local v22 = p19 * (p18 - v.Z);
        local v23 = v[p17] + v22;
        local v24 = v[p17] - v22;
        v20 = math.max(v20, v23, v24);
        v21 = math.min(v21, v23, v24);
    end;

    return v20, v21;
end;

function u4.new(p25, p26) -- Line: 64
    -- upvalues: u4 (copy)
    local v27 = setmetatable({}, u4);
    v27.Model = nil;
    v27.ViewportFrame = p25;
    v27.Camera = p26;
    v27._points = {};
    v27._modelCFrame = CFrame.new();
    v27._modelSize = Vector3.new();
    v27._modelRadius = 0;
    v27._viewport = {};
    v27:Calibrate();

    return v27;
end;

function u4.SetModel(p28, p29) -- Line: 88
    -- upvalues: getModelPointCloud (copy)
    p28.Model = p29;
    local BoundingBox, v30 = p29:GetBoundingBox();
    p28._points = getModelPointCloud(p29);
    p28._modelCFrame = BoundingBox;
    p28._modelSize = v30;
    p28._modelRadius = v30.Magnitude / 2;
end;

function u4.Calibrate(p31) -- Line: 101
    local v32 = {};
    local AbsoluteSize = p31.ViewportFrame.AbsoluteSize;
    v32.aspect = AbsoluteSize.X / AbsoluteSize.Y;
    v32.yFov2 = math.rad(p31.Camera.FieldOfView / 2);
    v32.tanyFov2 = math.tan(v32.yFov2);
    v32.xFov2 = math.atan(v32.tanyFov2 * v32.aspect);
    v32.tanxFov2 = math.tan(v32.xFov2);
    local v33 = v32.tanyFov2 * math.min(1, v32.aspect);
    v32.cFov2 = math.atan(v33);
    v32.sincFov2 = math.sin(v32.cFov2);
    p31._viewport = v32;
end;

function u4.GetFitDistance(p34, p35) -- Line: 123
    return (p34._modelRadius + (p35 and ((p35 - p34._modelCFrame.Position).Magnitude or 0) or 0)) / p34._viewport.sincFov2;
end;

function u4.GetMinimumFitCFrame(p36, p37) -- Line: 135
    -- upvalues: viewProjectionEdgeHits (copy)
    if not p36.Model then
        return CFrame.new();
    end;

    local v38 = (p37 - p37.Position):Inverse();
    local _points = p36._points;
    local v39 = { v38 * _points[1] };
    local Z = v39[1].Z;

    for i = 2, #_points do
        local v40 = v38 * _points[i];
        Z = math.min(Z, v40.Z);
        v39[i] = v40;
        local _ = i;
    end;

    local v41, v42 = viewProjectionEdgeHits(v39, "X", Z, p36._viewport.tanxFov2);
    local v43, v44 = viewProjectionEdgeHits(v39, "Y", Z, p36._viewport.tanyFov2);
    local math_max_ret = math.max((v41 - v42) / 2 / p36._viewport.tanxFov2, (v43 - v44) / 2 / p36._viewport.tanyFov2);

    return p37 * CFrame.new((v41 + v42) / 2, (v43 + v44) / 2, Z + math_max_ret);
end;

return u4;