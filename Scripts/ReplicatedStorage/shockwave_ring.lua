--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     shockwave_ring
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.shockwave_ring
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
local u3 = require("../mod/utility");
local u4 = require("../pkg/Promise");
require("../obj/ObjectCache");
local Random_new_ret = Random.new();
local v5 = {};
local u6 = nil;

function v5.init(p7) -- Line: 17
    -- upvalues: u6 (ref)
    u6 = p7;
end;

function v5.deinit() -- Line: 21
    -- upvalues: u6 (ref)
    u6 = nil;
end;

function v5.emit(p8: userdata, u9: userdata, u10: any) -- Line: 25
    -- upvalues: u6 (ref), u1 (copy), CollectionService (copy), u3 (copy), Random_new_ret (copy), u2 (copy), u4 (copy)
    if not u6 then
        return;
    end;

    local v11 = u1.get(p8, "RayDirection", Vector3.new(0, -50, 0));
    local v12 = u1.get(p8, "RayCollisionGroup", "Default");
    local v13 = u1.get(p8, "FilterTag", "");
    local v14 = u1.get(p8, "FilterType", "Exclude");
    local v15 = u1.get(p8, "IgnoreWater", true);
    local v16 = u1.get(p8, "IgnoreCanCollide", false);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.CollisionGroup = v12;
    RaycastParams_new_ret.IgnoreWater = v15;
    RaycastParams_new_ret.RespectCanCollide = not v16;
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType[v14];
    RaycastParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged(v13);

    if v14 == "Exclude" then
        RaycastParams_new_ret:AddToFilter({ workspace.Terrain });
    end;

    local v17 = u1.get(u9, "EmitDelay", 0);
    local v18 = u1.get(u9, "Radius", 5);
    local v19 = u1.get(u9, "Segments", 7);
    local Range = u1.getRange(u9, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local v20 = u1.get(u9, "PartOffset", Vector3.new(0, 0, 0), true);
    local u21 = u1.get(u9, "BaseOffset", v20);
    local u22 = u1.get(u9, "Offset_Start", v20);
    local u23 = u1.get(u9, "Offset_End", v20);
    local v24 = u1.get(u9, "Offset_Start_Duration", 0.5);
    local u25 = u1.get(u9, "Offset_End_Duration", 0.5);
    local u26 = u1.get(u9, "SizeScaleStart", Vector3.new(0, 0, 0));
    local u27 = u1.get(u9, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local v28 = u1.get(u9, "MinSize", Vector3.new(2, 1, 2));
    local v29 = u1.get(u9, "MaxSize", Vector3.new(3, 2, 3));
    local v30 = u1.get(u9, "Size_Curve", u3.default_bezier, true);
    local v31 = u1.get(u9, "Size_Duration", 0.5, true);
    local v32 = u1.get(u9, "Size_Start_Curve", v30);
    local u33 = u1.get(u9, "Size_End_Curve", v30);
    local v34 = u1.get(u9, "Size_Start_Duration", v31);
    local u35 = u1.get(u9, "Size_End_Duration", v31);
    local u36 = u1.get(u9, "Transparency_Duration", 0.5);
    local v37 = u1.get(u9, "Transparency_Start", 0);
    local u38 = u1.get(u9, "Transparency_End", 0);
    task.wait(v17);
    local TransformedOriginExtents = u3.getTransformedOriginExtents(p8);
    local u39 = {};

    for i = 0, v19 - 1 do
        local v40 = i / v19 * 3.141592653589793 * 2;
        local v41 = v18 * math.cos(v40);
        local v42 = v18 * math.sin(v40);
        local v43 = workspace:Raycast((TransformedOriginExtents * CFrame.new(v41, 0, v42)).Position, TransformedOriginExtents:VectorToWorldSpace(v11), RaycastParams_new_ret);
        local v44;

        if v43 then
            local v45 = Random_new_ret:NextNumber(v28.X, v29.X);
            local v46 = Random_new_ret:NextNumber(v28.Y, v29.Y);
            local v47 = Random_new_ret:NextNumber(v28.Z, v29.Z);
            local RandomId = u3.getRandomId();
            local u48 = u6:get(RandomId);
            local v49 = u48._getReal();
            u3.copyProperties(u9, v49, u3.COPY_PART_PROPERTIES);
            u3.copyProperties(u9, v49, u3.COPY_EXTENDED_PART_PROPERTIES);

            if #u9:GetChildren() == 0 then
                v44 = i;
            else
                local v50 = u9:Clone();
                v44 = i;

                for _, child in v50:GetChildren() do
                    child.Parent = v49;
                end;

                v50:Destroy();
            end;

            local u51 = u10.effects.prepareEmitOnFinish(u48, u10);
            table.insert(u10, function() -- Line: 130
                -- upvalues: u6 (ref), RandomId (copy)
                if u6 then
                    u6:free(RandomId);
                end;
            end);
            u48.Color = v43.Instance.Color;
            u48.Material = v43.Material;
            u48.Transparency = v43.Instance.Transparency;

            if u48.Transparency == 0 then
                u48.Transparency = v37;
            end;

            u48.Size = Vector3.new(0, 0, 0);
            local v52 = -math.cos(v40);
            local v53 = -math.sin(v40);
            local Unit = TransformedOriginExtents:VectorToWorldSpace((Vector3.new(v52, 0, v53))):Cross(v43.Normal).Unit;
            local u54 = CFrame.fromMatrix(v43.Position, Unit, v43.Normal) * CFrame.fromOrientation(-math.atan(v46 / v47), 0, 0);
            u48.CFrame = CFrame.new(u22) * u54;
            local u55 = nil;
            local u56 = nil;
            local u57 = Vector3.new(0, 0, 0);

            if u22 ~= u21 then
                u56 = u2.fromParams(u1.get(u9, "Offset_Start_Curve", u3.default_bezier), v24, function(p58, p59) -- Line: 166
                    -- upvalues: u57 (ref), u22 (copy), u21 (copy), u48 (copy), u54 (copy)
                    u57 = u22:Lerp(u21, p58);
                    u48.CFrame = CFrame.new(u57) * u54;

                    return p59;
                end);
                table.insert(u10, u55);
            end;

            local Vector3_new_ret = Vector3.new(v45, v46, v47);

            if Vector3_new_ret * u26 == Vector3_new_ret then
                u48.Size = Vector3_new_ret * u26;
            else
                u55 = u2.fromParams(v32, v34, function(p60, p61) -- Line: 179
                    -- upvalues: u48 (copy), Vector3_new_ret (copy), u26 (copy)
                    u48.Size = (Vector3_new_ret * u26):Lerp(Vector3_new_ret, p60);

                    return p61;
                end);
                table.insert(u10, u55);
            end;

            local Finished = u10.effects.emitNested(u48, u10.depth + 1, u10).Finished;
            table.insert(u39, Finished);
            task.delay(Random_new_ret:NextNumber(Range.Min, Range.Max), function() -- Line: 192
                -- upvalues: u55 (ref), u56 (ref), u48 (copy), Vector3_new_ret (copy), u27 (copy), u10 (copy), u2 (ref), u33 (copy), u35 (copy), u57 (ref), u23 (copy), u1 (ref), u9 (copy), u3 (ref), u25 (copy), u54 (copy), u38 (copy), u36 (copy), u51 (copy), u39 (copy)
                if u55 then
                    u55:Disconnect();
                end;

                if u56 then
                    u56:Disconnect();
                end;

                local Size = u48.Size;
                local Transparency = u48.Transparency;

                if Size ~= Vector3_new_ret * u27 then
                    table.insert(u10, u2.fromParams(u33, u35, function(p62, p63) -- Line: 207
                        -- upvalues: u48 (ref), Size (copy), Vector3_new_ret (ref), u27 (ref)
                        u48.Size = Size:Lerp(Vector3_new_ret * u27, p62);

                        return p63;
                    end));
                end;

                if u57 ~= u23 then
                    local fromParams = u2.fromParams;
                    local v64 = u1.get(u9, "Offset_End_Curve", u3.default_bezier);
                    table.insert(u10, fromParams(v64, u25, function(p65, p66) -- Line: 220
                        -- upvalues: u48 (ref), u57 (ref), u23 (ref), u54 (ref)
                        u48.CFrame = CFrame.new(u57:Lerp(u23, p65)) * u54;

                        return p66;
                    end));
                end;

                if Transparency ~= u38 then
                    local fromParams = u2.fromParams;
                    local v67 = u1.get(u9, "Transparency_Curve", u3.default_bezier);
                    table.insert(u10, fromParams(v67, u36, function(p68, p69) -- Line: 234
                        -- upvalues: u48 (ref), u3 (ref), Transparency (copy), u38 (ref)
                        u48.Transparency = u3.lerp(Transparency, u38, p68);

                        return p69;
                    end));
                end;

                local Finished2 = u10.effects.emitOnFinish(u51, u48, u10.depth + 1, u10).Finished;
                table.insert(u39, Finished2);
            end);
        else
            v44 = i;
        end;
    end;

    task.wait(Range.Max + math.max(u35, u25));
    u4.all(u39):await();
end;

return v5;