--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     shockwave_line
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.shockwave_line
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/logger");
local u4 = require("../mod/utility");
local u5 = require("../obj/Bezier");
local u6 = require("../pkg/Promise");
require("../obj/ObjectCache");
local Random_new_ret = Random.new();
local v7 = {};
local u8 = nil;

function v7.init(p9) -- Line: 19
    -- upvalues: u8 (ref)
    u8 = p9;
end;

function v7.deinit() -- Line: 23
    -- upvalues: u8 (ref)
    u8 = nil;
end;

function v7.emit(u10: userdata, u11: userdata, u12: any) -- Line: 27
    -- upvalues: u8 (ref), u1 (copy), CollectionService (copy), u4 (copy), u2 (copy), u3 (copy), u5 (copy), Random_new_ret (copy), u6 (copy)
    if not u8 then
        return;
    end;

    local u13 = u1.get(u10, "RayDirection", Vector3.new(0, -50, 0));
    local v14 = u1.get(u10, "RayCollisionGroup", "Default");
    local v15 = u1.get(u10, "FilterTag", "");
    local v16 = u1.get(u10, "FilterType", "Exclude");
    local v17 = u1.get(u10, "IgnoreWater", true);
    local v18 = u1.get(u10, "IgnoreCanCollide", false);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.CollisionGroup = v14;
    RaycastParams_new_ret.IgnoreWater = v17;
    RaycastParams_new_ret.RespectCanCollide = not v18;
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType[v16];
    RaycastParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged(v15);

    if v16 == "Exclude" then
        RaycastParams_new_ret:AddToFilter({ workspace.Terrain });
    end;

    local v19 = u1.get(u11, "EmitDelay", 0);
    local u20 = u1.get(u11, "Rate_Start", 30);
    local u21 = u1.get(u11, "Rate_End", 30);
    local v22 = u1.get(u11, "FixedAmount", 0);
    local u23 = u1.get(u11, "Scale_Start", 1);
    local u24 = u1.get(u11, "Scale_End", 1);
    local v25 = u1.get(u11, "Duration", 1);
    local v26 = u1.get(u11, "Direction", Vector3.new(0, 0, -1));
    local u27 = u1.get(u11, "Length", 50);
    local Range = u1.getRange(u11, "Rotation", NumberRange.new(-180, 180));
    local v28 = u1.get(u11, "PartOffset", Vector3.new(0, 0, 0), true);
    local u29 = u1.get(u11, "BaseOffset", v28);
    local u30 = u1.get(u11, "Offset_Start", v28);
    local u31 = u1.get(u11, "Offset_End", v28);
    local u32 = u1.get(u11, "Offset_Start_Duration", 0.5);
    local u33 = u1.get(u11, "Offset_End_Duration", 0.5);
    local Range2 = u1.getRange(u11, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local u34 = u1.get(u11, "SizeScaleStart", Vector3.new(0, 0, 0));
    local u35 = u1.get(u11, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local u36 = u1.get(u11, "MinSize", Vector3.new(2, 1, 2));
    local u37 = u1.get(u11, "MaxSize", Vector3.new(3, 2, 3));
    local v38 = u1.get(u11, "Size_Curve", u4.default_bezier, true);
    local v39 = u1.get(u11, "Size_Duration", 0.5, true);
    local u40 = u1.get(u11, "Size_Start_Curve", v38);
    local u41 = u1.get(u11, "Size_End_Curve", v38);
    local u42 = u1.get(u11, "Size_Start_Duration", v39);
    local u43 = u1.get(u11, "Size_End_Duration", v39);
    local u44 = u1.get(u11, "Transparency_Duration", 0.5);
    local u45 = u1.get(u11, "Transparency_Start", 0);
    local u46 = u1.get(u11, "Transparency_End", 0);
    local u47 = u1.get(u11, "SyncPosition", false);
    local math_max_ret = math.max(v25, 0.001);

    if v22 > 0 then
        u20 = v22 / math_max_ret;
        u21 = u20;
    end;

    local Unit = v26.Unit;
    local u48 = Unit ~= Unit and Vector3.new(-0, -0, -1) or Unit;
    task.wait(v19);
    local u49 = {};
    local TransformedOriginExtents = u4.getTransformedOriginExtents(u10);
    local u50 = 0;
    local u51 = 0;
    local u52 = u20;
    local u53 = u23;

    if u23 ~= u24 then
        local fromParams = u2.fromParams;
        local v54 = u1.get(u11, "Scale_Curve", u4.default_bezier);
        table.insert(u12, fromParams(v54, math_max_ret, function(p55, p56) -- Line: 131
            -- upvalues: u53 (ref), u4 (ref), u23 (copy), u24 (copy)
            u53 = u4.lerp(u23, u24, p55);

            return p56;
        end));
    end;

    if u20 ~= u21 then
        local fromParams = u2.fromParams;
        local v57 = u1.get(u11, "Rate_Curve", u4.default_bezier);
        table.insert(u12, fromParams(v57, math_max_ret, function(p58, p59) -- Line: 141
            -- upvalues: u52 (ref), u4 (ref), u20 (ref), u21 (ref)
            u52 = u4.lerp(u20, u21, p58);

            return p59;
        end));
    end;

    local u60 = u1.get(u11, "Path_Curve", u4.linear_bezier);
    local success, result = pcall(function() -- Line: 150
        -- upvalues: u4 (ref), u60 (copy)
        return u4.deserializePath(u60);
    end);

    if not success then
        u3.error((`failed to decode bezier path data with error: {result}`));
    end;

    local u61 = u5.new(result, 0);
    table.insert(u12, u2.fromParams(u4.linear_bezier, math_max_ret, function(p62, p63) -- Line: 162
        -- upvalues: u50 (ref), u52 (ref), math_max_ret (ref), u51 (ref), u61 (copy), u47 (copy), TransformedOriginExtents (ref), u4 (ref), u10 (copy), u48 (ref), u27 (copy), u13 (copy), RaycastParams_new_ret (copy), Random_new_ret (ref), u36 (copy), u37 (copy), u8 (ref), u11 (copy), u12 (copy), u45 (copy), Range (copy), u30 (copy), u29 (copy), u2 (ref), u1 (ref), u32 (copy), u53 (ref), u34 (copy), u40 (copy), u42 (copy), u49 (copy), Range2 (copy), u35 (copy), u41 (copy), u43 (copy), u31 (copy), u33 (copy), u46 (copy), u44 (copy)
        u50 = u50 + p63;
        local v64 = 1 / u52;
        local v65 = math_max_ret * u52;

        if u50 < v64 or v65 <= u51 then
            return p63;
        end;

        for i = 1, u50 // v64 do
            local v66;

            if v65 <= u51 then
                v66 = i;
            else
                u51 = u51 + 1;
                local v67 = 1 - u61:getEase((math.clamp(u51 / v65, 0, 1))).y;

                if u47 then
                    TransformedOriginExtents = u4.getTransformedOriginExtents(u10);
                end;

                local TransformedOriginExtents2 = u4.getTransformedOriginExtents(u10);
                local v68 = workspace:Raycast(TransformedOriginExtents.Position + TransformedOriginExtents:VectorToWorldSpace(u48) * u27 * v67, TransformedOriginExtents2:VectorToWorldSpace(u13), RaycastParams_new_ret);

                if not v68 then
                    u50 = 0;

                    return p63;
                end;

                local v69 = Random_new_ret:NextNumber(u36.X, u37.X);
                local v70 = Random_new_ret:NextNumber(u36.Y, u37.Y);
                local v71 = Random_new_ret:NextNumber(u36.Z, u37.Z);
                local RandomId = u4.getRandomId();
                local u72 = u8:get(RandomId);
                local u73 = u72._getReal();
                u4.copyProperties(u11, u73, u4.COPY_PART_PROPERTIES);
                u4.copyProperties(u11, u73, u4.COPY_EXTENDED_PART_PROPERTIES);

                if #u11:GetChildren() == 0 then
                    v66 = i;
                else
                    local v74 = u11:Clone();
                    v66 = i;

                    for _, child in v74:GetChildren() do
                        child.Parent = u73;
                    end;

                    v74:Destroy();
                end;

                local u75 = u12.effects.prepareEmitOnFinish(u73, u12);
                table.insert(u12, function() -- Line: 226
                    -- upvalues: u8 (ref), RandomId (copy)
                    if u8 then
                        u8:free(RandomId);
                    end;
                end);
                u72.Color = v68.Instance.Color;
                u72.Material = v68.Material;
                u72.Transparency = v68.Instance.Transparency;

                if u72.Transparency == 0 then
                    u72.Transparency = u45;
                end;

                u72.Size = Vector3.new(0, 0, 0);
                local v76 = Random_new_ret:NextNumber(Range.Min, Range.Max);
                local v77 = -math.cos(v76);
                local v78 = -math.sin(v76);
                local Unit2 = TransformedOriginExtents2:VectorToWorldSpace((Vector3.new(v77, 0, v78))):Cross(v68.Normal).Unit;
                local u79 = CFrame.fromMatrix(v68.Position, Unit2, v68.Normal) * CFrame.fromOrientation(-math.atan(v70 / v71), 0, 0);
                u72.CFrame = CFrame.new(u30) * u79;
                local u80 = nil;
                local u81 = nil;
                local u82 = Vector3.new(0, 0, 0);

                if u30 ~= u29 then
                    u81 = u2.fromParams(u1.get(u11, "Offset_Start_Curve", u4.default_bezier), u32, function(p83, p84) -- Line: 264
                        -- upvalues: u82 (ref), u30 (ref), u29 (ref), u72 (copy), u79 (copy)
                        u82 = u30:Lerp(u29, p83);
                        u72.CFrame = CFrame.new(u82) * u79;

                        return p84;
                    end);
                    table.insert(u12, u81);
                end;

                local u85 = Vector3.new(v69, v70, v71) * u53;

                if u85 * u34 == u85 then
                    u72.Size = u85 * u34;
                else
                    u80 = u2.fromParams(u40, u42, function(p86, p87) -- Line: 277
                        -- upvalues: u72 (copy), u85 (copy), u34 (ref)
                        u72.Size = (u85 * u34):Lerp(u85, p86);

                        return p87;
                    end);
                    table.insert(u12, u80);
                end;

                local Finished = u12.effects.emitNested(u73, u12.depth + 1, u12).Finished;
                table.insert(u49, Finished);
                task.delay(Random_new_ret:NextNumber(Range2.Min, Range2.Max), function() -- Line: 290
                    -- upvalues: u80 (ref), u81 (ref), u72 (copy), u85 (copy), u35 (ref), u12 (ref), u2 (ref), u41 (ref), u43 (ref), u82 (ref), u31 (ref), u1 (ref), u11 (ref), u4 (ref), u33 (ref), u79 (copy), u46 (ref), u44 (ref), u75 (copy), u73 (copy), u49 (ref)
                    if u80 then
                        u80:Disconnect();
                    end;

                    if u81 then
                        u81:Disconnect();
                    end;

                    local Size = u72.Size;
                    local Transparency = u72.Transparency;

                    if Size ~= u85 * u35 then
                        table.insert(u12, u2.fromParams(u41, u43, function(p88, p89) -- Line: 305
                            -- upvalues: u72 (ref), Size (copy), u85 (ref), u35 (ref)
                            u72.Size = Size:Lerp(u85 * u35, p88);

                            return p89;
                        end));
                    end;

                    if u82 ~= u31 then
                        local fromParams = u2.fromParams;
                        local v90 = u1.get(u11, "Offset_End_Curve", u4.default_bezier);
                        table.insert(u12, fromParams(v90, u33, function(p91, p92) -- Line: 318
                            -- upvalues: u72 (ref), u82 (ref), u31 (ref), u79 (ref)
                            u72.CFrame = CFrame.new(u82:Lerp(u31, p91)) * u79;

                            return p92;
                        end));
                    end;

                    if Transparency ~= u46 then
                        local fromParams = u2.fromParams;
                        local v93 = u1.get(u11, "Transparency_Curve", u4.default_bezier);
                        table.insert(u12, fromParams(v93, u44, function(p94, p95) -- Line: 332
                            -- upvalues: u72 (ref), u4 (ref), Transparency (copy), u46 (ref)
                            u72.Transparency = u4.lerp(Transparency, u46, p94);

                            return p95;
                        end));
                    end;

                    local Finished2 = u12.effects.emitOnFinish(u75, u73, u12.depth + 1, u12).Finished;
                    table.insert(u49, Finished2);
                end);
            end;
        end;

        u50 = u50 % v64;

        return p63;
    end, nil, nil, true, u4.RENDER_PRIORITY + u12.depth));
    task.wait(Range2.Max + math_max_ret + math.max(u43, u33));
    u6.all(u49):await();
end;

return v7;