--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     shape
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.shape
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("./utility");
local u7 = {
    getSurfaceCFrame = function(p2, p3: vector, p4: vector) -- Line: 7, Name: getSurfaceCFrame
        local v5 = p3:Dot(Vector3.new(0, 1, 0));
        local v6 = math.abs(v5) > 0.99 and Vector3.new(0, 0, 1) or Vector3.new(0, 1, 0);
        local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), p3, v6);

        return p2 * CFrame.new(p4) * CFrame_lookAt_ret;
    end
};

function u7.getPointWithinBox(p8: number, p9, p10: vector, p11: any) -- Line: 13
    -- upvalues: u7 (copy)
    debug.profilebegin("getPointWithinBox");
    local Random_new_ret = Random.new(p8);
    local v12 = Random_new_ret:NextNumber(-1, 1);
    local v13 = Random_new_ret:NextNumber(-1, 1);
    local v14 = Vector3.new(v12, v13, Random_new_ret:NextNumber(-1, 1)) * (p10 / 2);
    local SurfaceCFrame = u7.getSurfaceCFrame(p9, Vector3.FromNormalId(p11), v14);
    debug.profileend();

    return SurfaceCFrame;
end;

function u7.getPointOnBox(p15: number, p16, p17: vector, p18: any) -- Line: 34
    -- upvalues: u7 (copy)
    debug.profilebegin("getPointOnBox");
    local Random_new_ret = Random.new(p15);
    local Vector3_FromNormalId_ret = Vector3.FromNormalId(p18);
    local v19 = p17 / 2;
    local v20 = Vector3.new(1, 1, 1) - Vector3_FromNormalId_ret:Abs();
    local v21 = Random_new_ret:NextNumber(-1, 1);
    local v22 = Random_new_ret:NextNumber(-1, 1);
    local v23 = Vector3.new(v21, v22, Random_new_ret:NextNumber(-1, 1)) * v19 * v20;
    local SurfaceCFrame = u7.getSurfaceCFrame(p16, Vector3_FromNormalId_ret, v23 + Vector3_FromNormalId_ret * v19);
    debug.profileend();

    return SurfaceCFrame;
end;

function u7.getPointWithinCylinder(p24: number, p25: number, p26: number, p27, p28: vector, p29: any) -- Line: 58
    -- upvalues: u1 (copy)
    debug.profilebegin("getPointWithinCylinder");
    local Random_new_ret = Random.new(p24);
    local v30 = Random_new_ret:NextNumber(p25, 1);
    local math_sqrt_ret = math.sqrt(v30);
    local v31 = Random_new_ret:NextNumber(0, 6.283185307179586);

    if p29 == Enum.NormalId.Left or p29 == Enum.NormalId.Right then
        p27 = p27 * CFrame.fromOrientation(0, 1.5707963267948966 * (p29 == Enum.NormalId.Right and -1 or 1), 0);
        p28 = Vector3.new(p28.Z, p28.Y, p28.X);
    elseif p29 == Enum.NormalId.Front or p29 == Enum.NormalId.Back then
        p27 = p27 * CFrame.fromOrientation(0, 3.141592653589793, 0);
    end;

    local v32 = 1 - Random_new_ret:NextNumber() ^ u1.lerp(0.5, 1, (math.sqrt(p26)));
    local v33 = u1.lerp(1, p26, v32);
    local v34 = math_sqrt_ret * math.sin(v31) * v33;
    local v35 = math_sqrt_ret * math.cos(v31) * v33;
    local v36 = Vector3.new(v32 * 2 - 1, v34, v35) * p28 / 2;
    local v37 = math.sin(v31) * v33;
    local v38 = math.cos(v31) * v33;
    local v39 = Vector3.new(0, v37, v38) * p28 / 2;
    local v40 = math.cos(v31) * v33;
    local v41 = -math.sin(v31) * v33;
    local v42 = Vector3.new(0, v40, v41) * p28 / 2;
    local v43 = v42.Magnitude > 0.001 and v42.Unit or p27.UpVector;
    local v44 = p27 * CFrame.new(v36) * CFrame.lookAt(Vector3.new(0, 0, 0), v39, v43);
    debug.profileend();

    return v44;
end;

function u7.getPointWithinSphere(p45: number, p46: number, p47: number, p48, p49: vector, p50: any) -- Line: 108
    -- upvalues: u7 (copy)
    debug.profilebegin("getPointWithinSphere");
    local Random_new_ret = Random.new(p45);
    local v51 = Random_new_ret:NextNumber();
    local v52 = Random_new_ret:NextNumber();
    local v53 = v51 * 2 * 3.141592653589793;
    local v54 = math.acos(2 * v52 - 1) * p47;
    local v55 = Random_new_ret:NextNumber(p46, 1) ^ 0.3333333333333333;
    local math_sin_ret = math.sin(v53);
    local math_cos_ret = math.cos(v53);
    local math_sin_ret2 = math.sin(v54);
    local math_cos_ret2 = math.cos(v54);
    local Vector3_FromNormalId_ret = Vector3.FromNormalId(p50);

    if p50 == Enum.NormalId.Left or p50 == Enum.NormalId.Right then
        p49 = Vector3.new(p49.Z, p49.Y, p49.X);
    elseif p50 == Enum.NormalId.Top or p50 == Enum.NormalId.Bottom then
        p49 = Vector3.new(p49.X, p49.Z, p49.Y);
    end;

    local v56 = p49 / 2;
    local SurfaceCFrame = u7.getSurfaceCFrame(p48, Vector3_FromNormalId_ret, Vector3.new(0, 0, 0));
    local v57 = Vector3.new(v55 * math_sin_ret2 * math_cos_ret, v55 * math_sin_ret2 * math_sin_ret, v55 * math_cos_ret2) * v56;
    local v58 = Vector3.new(-math_sin_ret2 * math_sin_ret, math_sin_ret2 * math_cos_ret, 0) * v56;
    local v59 = v58.Magnitude <= 0.001 and Vector3.new(1, 0, 0) or v58.Unit;
    local v60 = SurfaceCFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(v57) * CFrame.lookAt(Vector3.new(0, 0, 0), v57, v59);
    debug.profileend();

    return v60;
end;

function u7.getPointWithinDisc(p61: number, p62: number, p63: number, p64, p65: vector, p66: any) -- Line: 160
    -- upvalues: u1 (copy), u7 (copy)
    debug.profilebegin("getPointWithinDisc");
    local Random_new_ret = Random.new(p61);
    local Vector3_FromNormalId_ret = Vector3.FromNormalId(p66);
    local v67 = Vector3.new(1, 1, 1) - Vector3_FromNormalId_ret:Abs() * p62;
    local v68 = p65 / 2;
    local v69 = Random_new_ret:NextNumber(p62, 1);
    local v70 = u1.lerp(1, 0.5, p63 ^ 4);
    local v71 = Random_new_ret:NextNumber(1 - p63, 1) ^ v70;
    local v72 = Random_new_ret:NextNumber(0, 6.283185307179586);
    local v73 = v71 * math.sin(v72);
    local v74 = v71 * math.cos(v72);
    local Vector3_new_ret = Vector3.new(v69 * 2 - 1, v73, v74);

    if p66 == Enum.NormalId.Bottom or p66 == Enum.NormalId.Top then
        Vector3_new_ret = Vector3.new(Vector3_new_ret.Z, Vector3_new_ret.X, Vector3_new_ret.Y);
    elseif p66 == Enum.NormalId.Front or p66 == Enum.NormalId.Back then
        Vector3_new_ret = Vector3.new(Vector3_new_ret.Y, Vector3_new_ret.Z, Vector3_new_ret.X);
    end;

    local SurfaceCFrame = u7.getSurfaceCFrame(p64, Vector3_FromNormalId_ret, Vector3_new_ret * (v68 * v67) + Vector3_FromNormalId_ret * p62 * v68);
    debug.profileend();

    return SurfaceCFrame;
end;

return u7;