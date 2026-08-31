--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     bezier
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.common.bezier
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local u1 = require("../attributes");
local u2 = require("../shape");
local u3 = require("../tween");
local u4 = require("../utility");
local u5 = require("../color/Oklab");
local u6 = require("../../obj/Bezier");
local u51 = {
    drawFuncMap = {
        Box = {
            Volume = u2.getPointWithinBox,
            Surface = u2.getPointOnBox
        },
        Cylinder = {
            Volume = function(p7, p8, p9, p10, p11) -- Line: 21, Name: Volume
                -- upvalues: u2 (copy)
                return u2.getPointWithinCylinder(p7, 0, p11, p8, p9, p10);
            end,

            Surface = function(p12, p13, p14, p15, p16) -- Line: 25, Name: Surface
                -- upvalues: u2 (copy)
                return u2.getPointWithinCylinder(p12, 1, p16, p13, p14, p15);
            end
        },
        Sphere = {
            Volume = function(p17, p18, p19, p20, p21) -- Line: 31, Name: Volume
                -- upvalues: u2 (copy)
                return u2.getPointWithinSphere(p17, 0, p21, p18, p19, p20);
            end,

            Surface = function(p22, p23, p24, p25, p26) -- Line: 35, Name: Surface
                -- upvalues: u2 (copy)
                return u2.getPointWithinSphere(p22, 1, p26, p23, p24, p25);
            end
        },
        Disc = {
            Volume = function(p27, p28, p29, p30, p31) -- Line: 41, Name: Volume
                -- upvalues: u2 (copy)
                return u2.getPointWithinDisc(p27, 0, p31, p28, p29, p30);
            end,

            Surface = function(p32, p33, p34, p35, p36) -- Line: 45, Name: Surface
                -- upvalues: u2 (copy)
                return u2.getPointWithinDisc(p32, 1, p36, p33, p34, p35);
            end
        }
    },

    getColorAtTime = function(p37: userdata, p38: number) -- Line: 51, Name: getColorAtTime
        local Keypoints = p37.Keypoints;

        if p38 <= Keypoints[1].Time then
            return Keypoints[1].Value;
        end;

        if Keypoints[#Keypoints].Time <= p38 then
            return Keypoints[#Keypoints].Value;
        end;

        local v39 = nil;
        local v40 = nil;

        for i = 1, #Keypoints do
            local v41 = Keypoints[i];

            if v41.Time == p38 then
                return v41.Value;
            end;

            local v42;

            if v41.Time < p38 then
                v39 = v41;
                v42 = i;
            else
                if p38 < v41.Time then
                    v40 = v41;
                    break;
                end;

                v42 = i;
            end;
        end;

        if v39 and v40 then
            return v39.Value:Lerp(v40.Value, (p38 - v39.Time) / (v40.Time - v39.Time));
        end;

        return Keypoints[1].Value;
    end,

    getColorAtTimeOklab = function(p43: userdata, p44: number) -- Line: 85, Name: getColorAtTimeOklab
        -- upvalues: u5 (copy)
        local Keypoints = p43.Keypoints;

        if p44 <= Keypoints[1].Time then
            return Keypoints[1].Value;
        end;

        if Keypoints[#Keypoints].Time <= p44 then
            return Keypoints[#Keypoints].Value;
        end;

        local v45 = nil;
        local v46 = nil;

        for i = 1, #Keypoints do
            local v47 = Keypoints[i];

            if v47.Time == p44 then
                return v47.Value;
            end;

            local v48;

            if v47.Time < p44 then
                v45 = v47;
                v48 = i;
            else
                if p44 < v47.Time then
                    v46 = v47;
                    break;
                end;

                v48 = i;
            end;
        end;

        if not (v45 and v46) then
            return Keypoints[1].Value;
        end;

        local v49 = (p44 - v45.Time) / (v46.Time - v45.Time);
        local v50 = u5.fromSRGB(v45.Value):Lerp(u5.fromSRGB(v46.Value), v49);

        return u5.toSRGB(v50);
    end
};

function u51.getColorWithEasingOklab(p52: userdata, p53: number, p54: any) -- Line: 125
    -- upvalues: u51 (copy)
    local v55 = 1 - p54:getEase((math.clamp(p53, 0, 1))).y;

    return u51.getColorAtTimeOklab(p52, (math.clamp(v55, 0, 1)));
end;

function u51.createHitboxParams(p56: table, p57: userdata, p58: userdata?) -- Line: 138
    -- upvalues: CollectionService (copy)
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.MaxParts = 1;
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType[p56.filterType];
    OverlapParams_new_ret.CollisionGroup = p56.collisionGroup;
    OverlapParams_new_ret.RespectCanCollide = not p56.ignoreCanCollide;
    OverlapParams_new_ret:AddToFilter(CollectionService:GetTagged(p56.filterTag));

    if p56.filterType == "Exclude" then
        if p58 then
            p58 = p58:FindFirstAncestorOfClass("Part");
        end;

        OverlapParams_new_ret:AddToFilter({ workspace.Terrain, p57, p58 });
    end;

    return OverlapParams_new_ret;
end;

function u51.calculateEmissionCFrame(p59, p60: vector, p61: table, p62: function?, p63: userdata, p64: userdata?, p65: boolean) -- Line: 164
    -- upvalues: u4 (copy)
    local v66;

    if p65 then
        v66 = p59 * CFrame.new(Vector3.new(0, 0, 0), Vector3.FromNormalId(p61.emissionDirection)).Rotation;
    elseif p62 then
        v66 = p62(nil, p59, p60, p61.emissionDirection, p61.partial);
    else
        v66 = p59;
    end;

    local Vector3_FromNormalId_ret = Vector3.FromNormalId(p61.emissionDirection);
    local v67 = Vector3_FromNormalId_ret:Cross(p59.LookVector);

    if v67.Magnitude < 0.001 then
        v67 = Vector3_FromNormalId_ret:Cross(p59.UpVector);
    end;

    local CFrame_fromAxisAngle = CFrame.fromAxisAngle;
    local v68 = p63:NextNumber(-p61.spreadAngle.X, p61.spreadAngle.X);
    local v69 = CFrame_fromAxisAngle(Vector3_FromNormalId_ret, (math.rad(v68)));
    local CFrame_fromAxisAngle2 = CFrame.fromAxisAngle;
    local v70 = p63:NextNumber(-p61.spreadAngle.Y, p61.spreadAngle.Y);
    local v71 = v66 * (v69 * CFrame_fromAxisAngle2(v67, (math.rad(v70))));

    if p61.face == "Inward" or p61.face == "InAndOut" and p63:NextInteger(0, 1) == 1 then
        v71 = v71 * CFrame.fromOrientation(0, 3.141592653589793, 0);
    end;

    if p64 and (p61.mirror and (v71.Position - p64.WorldPosition).Unit:Dot(v71.RightVector) >= 0) then
        local v72 = p61.mirrorRot * u4.DEG_TO_RAD;
        v71 = v71 * CFrame.fromOrientation(v72.X, v72.Y, v72.Z);
    end;

    return v71;
end;

function u51.createBezierWithEndpoint(p73: table, p74, p75: userdata?, p76: userdata?) -- Line: 207
    -- upvalues: u6 (copy)
    if not p75 then
        return u6.new(p73);
    end;

    local v77 = {};

    for i, v in p73 do
        local v78;

        if i == #p73 - 1 then
            v78 = p76 and p76.WorldPosition or p75.WorldPosition;
        elseif i == #p73 then
            v78 = p75.WorldPosition;
        else
            v78 = p74 * (v - p73[1]);
        end;

        table.insert(v77, v78);
    end;

    return u6.new(v77);
end;

function u51.createPosGetter(u79: any, u80: table, u81, u82: userdata?, u83: boolean?) -- Line: 226
    return function(p84: number) -- Line: 233
        -- upvalues: u83 (copy), u79 (copy), u82 (copy), u81 (copy), u80 (copy)
        local v85;

        if u83 == false then
            v85 = u79:getPosition(p84);
        else
            v85 = u79:getPositionArcSpace(p84);
        end;

        if u82 then
            return v85;
        end;

        return u81 * (v85 - u80[1]);
    end;
end;

function u51.readCommonAttributes(p86: userdata) -- Line: 244
    -- upvalues: u1 (copy)
    return {
        emitDelay = u1.get(p86, "EmitDelay", 0),
        emitCount = u1.get(p86, "EmitCount", 1),
        emitDuration = u1.get(p86, "EmitDuration", 0),
        destroyDelay = u1.get(p86, "DestroyDelay", 0),
        duration = u1.getRange(p86, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0))),
        shapeType = u1.getEnum(p86, "Shape", "Box", { "Box", "Cylinder", "Sphere", "Disc" }),
        shapeStyle = u1.getEnum(p86, "ShapeStyle", "Volume", { "Volume", "Surface" }),
        emissionDirection = Enum.NormalId[u1.getEnum(p86, "EmissionDirection", "Top", { "Top", "Bottom", "Left", "Right", "Front", "Back" })],
        face = u1.getEnum(p86, "ShapeFace", "Outward", { "InAndOut", "Inward", "Outward" }),
        spreadAngle = u1.get(p86, "SpreadAngle", Vector3.new(0, 0, 0)),
        partial = u1.get(p86, "ShapePartial", 1),
        syncPosition = u1.get(p86, "SyncPosition", false),
        mirror = u1.get(p86, "MirrorPaths", true),
        mirrorRot = u1.get(p86, "MirrorRotation", Vector3.new(0, 0, 180)),
        projectileEnabled = u1.get(p86, "ProjectileEnabled", false),
        projectileMatchEnd = u1.get(p86, "MatchEndDirection", false),
        projectileSpeed = u1.get(p86, "ProjectileSpeed", 30),
        projectileLifetime = u1.getRange(p86, "ProjectileLifetime", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0))),
        hitboxEnabled = u1.get(p86, "HitboxEnabled", false),
        hitboxCollisionGroup = u1.get(p86, "HitboxCollisionGroup", "Default"),
        hitboxFilterTag = u1.get(p86, "HitboxFilterTag", ""),
        hitboxFilterType = u1.get(p86, "HitboxFilterType", "Exclude"),
        hitboxIgnoreCanCollide = u1.get(p86, "HitboxIgnoreCanCollide", false),
        speedStart = u1.get(p86, "Speed_Start", 1),
        speedEnd = u1.get(p86, "Speed_End", 1)
    };
end;

function u51.getCurrentOriginCFrame(p87: userdata, p88) -- Line: 290
    if p87:IsA("BasePart") then
        return p87.CFrame;
    end;

    if p87:IsA("Attachment") then
        return p87.WorldCFrame;
    end;

    return p88;
end;

function u51.findEndAttachments(p89: userdata) -- Line: 300
    local End = p89:FindFirstChild("End");
    local v90;

    if End then
        v90 = End:FindFirstChild("T1");
    else
        v90 = End;
    end;

    if End and not End:IsA("Attachment") then
        End = nil;
    end;

    if v90 and not v90:IsA("Attachment") then
        v90 = nil;
    end;

    return End, v90;
end;

function u51.validateParent(p91: userdata) -- Line: 315
    local Parent = p91.Parent;

    if not Parent then
        return nil;
    end;

    if Parent:IsA("BasePart") then
        p91 = Parent;
    elseif Parent:IsA("Attachment") then
        p91 = Parent;
    end;

    return p91;
end;

function u51.getPerpendicularVectors(p92: vector) -- Line: 329
    local v93 = p92:Cross(Vector3.new(0, 1, 0));

    if v93.Magnitude < 0.001 then
        v93 = p92:Cross(Vector3.new(0, 0, 1));
    end;

    local Unit = v93.Unit;

    return Unit, p92:Cross(Unit).Unit;
end;

function u51.createPropertyTween(p94: any, p95: userdata, p96: string, p97: number, u98: number, u99: number, u100: function, u101: function, p102: any) -- Line: 343
    -- upvalues: u3 (copy), u1 (copy), u4 (copy)
    if u98 == u99 then
        return;
    end;

    local fromParams = u3.fromParams;
    local v103 = u1.get(p95, p96 .. "_Curve", u4.default_bezier);
    table.insert(p94, fromParams(v103, p97, function(p104, p105) -- Line: 363
        -- upvalues: u100 (copy), u4 (ref), u98 (copy), u99 (copy), u101 (copy)
        u100(u4.lerp(u98, u99, p104));

        return p105 * u101();
    end, p102));
end;

return u51;