--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Update
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.Update
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local DirectionVectors = require(script.Parent.PartConstants).DirectionVectors;

local function getLinkCF(p1) -- Line: 6
    local Link = p1.Link;

    if not (Link and Link.Parent) then
        return CFrame.new(), false;
    end;

    local v2 = Link:IsA("Attachment");

    if p1.LinkMode == "Follow" then
        return CFrame.new(v2 and Link.WorldPosition or Link.Position), false;
    end;

    return v2 and Link.WorldCFrame or Link.CFrame, p1.LinkMode == "Weld";
end;

return function(p3) -- Line: 14
    -- upvalues: getLinkCF (copy), Graph (copy), DirectionVectors (copy)
    function p3.UpdatePart(p4, p5, p6, p7) -- Line: 16
        -- upvalues: getLinkCF (ref), Graph (ref), DirectionVectors (ref)
        local v8 = (p7 - p5.StartTime) / p5.LifeTime;

        if v8 >= 1 or not (p5.VisualPart and p5.VisualPart.Parent) then
            return true;
        end;

        if p5.TotalKeyFrames <= 0 then
            return true;
        end;

        p5.AccumulatedDT = p5.AccumulatedDT + p6;
        local math_floor_ret = math.floor(v8 * p5.TotalKeyFrames);

        if p5.CurrentStep < math_floor_ret then
            local CurrentStep = p5.CurrentStep;
            local v9 = p5.AccumulatedDT / (math_floor_ret - CurrentStep);
            p5.AccumulatedDT = 0;

            if p5.InvertMotion then
                p5.CurrentStep = math_floor_ret;
                local v10 = p5.SimLocalCFrames[p5.TotalKeyFrames - math_floor_ret] or p5.SimLocalCFrames[0];
                local v11 = getLinkCF(p5);
                p5.VisualPart.CFrame = v11 * v10;
                p5.CurrentPosition = p5.VisualPart.Position;
            elseif p5.NeedsFullIteration then
                local HasDrag = p5.HasDrag;
                local HasAccel = p5.HasAccel;

                for i = CurrentStep + 1, math_floor_ret do
                    local v12 = i / p5.TotalKeyFrames;
                    local v13 = v12 * p5.LifeTime;
                    local v14 = Graph.QueryPointsWithTime(v12, p5.Graphs.Speed, p5.Seeds.Speed);

                    if HasDrag then
                        v14 = v14 * math.exp(-p5.Drag * v13) or v14;
                    end;

                    local v15;

                    if HasAccel then
                        v15 = (p5.BaseDirection * v14 + p5.Acceleration * v13) * v9;
                    else
                        v15 = p5.BaseDirection * (v14 * v9);
                    end;

                    local v16, v17 = getLinkCF(p5);

                    if v17 then
                        v15 = v16:VectorToObjectSpace(v15) or v15;
                    end;

                    p5.LocalCF = CFrame.new(v15) * p5.LocalCF;
                    local v18 = Graph.QueryPointsWithTime(v12, p5.Graphs.RotSpeedX, p5.Seeds.RotSpeedX);
                    local v19 = Graph.QueryPointsWithTime(v12, p5.Graphs.RotSpeedY, p5.Seeds.RotSpeedY);
                    local v20 = Graph.QueryPointsWithTime(v12, p5.Graphs.RotSpeedZ, p5.Seeds.RotSpeedZ);
                    local v21;

                    if p5.RotMode == "Speed" then
                        p5.AccRotX = p5.AccRotX + v18 * v9;
                        p5.AccRotY = p5.AccRotY + v19 * v9;
                        p5.AccRotZ = p5.AccRotZ + v20 * v9;
                        v21 = CFrame.Angles(math.rad(p5.AccRotX), math.rad(p5.AccRotY), (math.rad(p5.AccRotZ)));
                    else
                        v21 = CFrame.Angles(math.rad(v18), math.rad(v19), (math.rad(v20)));
                    end;

                    p5.VisualPart.CFrame = v16 * p5.LocalCF * v21;
                    p5.CurrentPosition = p5.VisualPart.Position;
                    local v22 = DirectionVectors[p5.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                    p5.BaseDirection = (p5.VisualPart.CFrame * p5.SpreadRotation)[v22.vector] * v22.multiplier;
                    local _ = i;
                end;

                p5.CurrentStep = math_floor_ret;
            elseif p5.NeedsRotAccum then
                local HasDrag = p5.HasDrag;
                local HasAccel = p5.HasAccel;
                local v23 = 0;
                local v24 = 0;

                for i = CurrentStep + 1, math_floor_ret do
                    local v25 = i / p5.TotalKeyFrames;
                    local v26 = v25 * p5.LifeTime;
                    local v27 = Graph.QueryPointsWithTime(v25, p5.Graphs.Speed, p5.Seeds.Speed);

                    if HasDrag then
                        v27 = v27 * math.exp(-p5.Drag * v26);
                    end;

                    v24 = v24 + v27 * v9;

                    if HasAccel then
                        v23 = v23 + v26 * v9;
                    end;

                    local v28 = Graph.QueryPointsWithTime(v25, p5.Graphs.RotSpeedX, p5.Seeds.RotSpeedX);
                    local v29 = Graph.QueryPointsWithTime(v25, p5.Graphs.RotSpeedY, p5.Seeds.RotSpeedY);
                    local v30 = Graph.QueryPointsWithTime(v25, p5.Graphs.RotSpeedZ, p5.Seeds.RotSpeedZ);
                    p5.AccRotX = p5.AccRotX + v28 * v9;
                    p5.AccRotY = p5.AccRotY + v29 * v9;
                    p5.AccRotZ = p5.AccRotZ + v30 * v9;
                    local _ = i;
                end;

                local v31 = p5.BaseDirection * v24;

                if HasAccel then
                    v31 = v31 + p5.Acceleration * v23;
                end;

                local v32, v33 = getLinkCF(p5);

                if v33 then
                    v31 = v32:VectorToObjectSpace(v31) or v31;
                end;

                p5.LocalCF = CFrame.new(v31) * p5.LocalCF;
                local CFrame_Angles_ret = CFrame.Angles(math.rad(p5.AccRotX), math.rad(p5.AccRotY), (math.rad(p5.AccRotZ)));
                p5.VisualPart.CFrame = v32 * p5.LocalCF * CFrame_Angles_ret;
                p5.CurrentPosition = p5.VisualPart.Position;
                p5.CurrentStep = math_floor_ret;
            else
                local HasDrag = p5.HasDrag;
                local HasAccel = p5.HasAccel;
                local v34 = 0;
                local v35 = 0;

                for i = CurrentStep + 1, math_floor_ret do
                    local v36 = i / p5.TotalKeyFrames;
                    local v37 = v36 * p5.LifeTime;
                    local v38 = Graph.QueryPointsWithTime(v36, p5.Graphs.Speed, p5.Seeds.Speed);

                    if HasDrag then
                        v38 = v38 * math.exp(-p5.Drag * v37);
                    end;

                    v34 = v34 + v38 * v9;
                    local v39;

                    if HasAccel then
                        v35 = v35 + v37 * v9;
                        v39 = i;
                    else
                        v39 = i;
                    end;
                end;

                local v40 = p5.BaseDirection * v34;

                if HasAccel then
                    v40 = v40 + p5.Acceleration * v35;
                end;

                local v41, v42 = getLinkCF(p5);

                if v42 then
                    v40 = v41:VectorToObjectSpace(v40) or v40;
                end;

                p5.LocalCF = CFrame.new(v40) * p5.LocalCF;
                local v43 = math_floor_ret / p5.TotalKeyFrames;
                local v44 = Graph.QueryPointsWithTime(v43, p5.Graphs.RotSpeedX, p5.Seeds.RotSpeedX);
                local v45 = Graph.QueryPointsWithTime(v43, p5.Graphs.RotSpeedY, p5.Seeds.RotSpeedY);
                local v46 = Graph.QueryPointsWithTime(v43, p5.Graphs.RotSpeedZ, p5.Seeds.RotSpeedZ);
                local CFrame_Angles_ret = CFrame.Angles(math.rad(v44), math.rad(v45), (math.rad(v46)));
                p5.VisualPart.CFrame = v41 * p5.LocalCF * CFrame_Angles_ret;
                p5.CurrentPosition = p5.VisualPart.Position;
                p5.CurrentStep = math_floor_ret;
            end;

            local v47 = math_floor_ret / p5.TotalKeyFrames;
            local v48 = Graph.QueryPointsWithTime(v47, p5.Graphs.SizeX, p5.Seeds.SizeX);
            local v49 = Graph.QueryPointsWithTime(v47, p5.Graphs.SizeY, p5.Seeds.SizeY);
            local v50 = Graph.QueryPointsWithTime(v47, p5.Graphs.SizeZ, p5.Seeds.SizeZ);

            if p5.SpecialMesh then
                p5.SpecialMesh.Scale = Vector3.new(v48, v49, v50);
            else
                p5.VisualPart.Size = Vector3.new(v48, v49, v50);
            end;

            local v51 = Graph.QueryPointsWithTime(v47, p5.Graphs.Transparency, p5.Seeds.Transparency);

            if p5.HasDecal then
                local v52 = Graph.QueryPointsWithTime(v47, p5.Graphs.Brightness, p5.Seeds.Brightness);
                local v53 = Graph.QueryColorPointWithTime(v47, p5.Graphs.Color);
                p5.Decal.Transparency = v51;
                p5.Decal.Color3 = Color3.fromRGB(v53.R * 255 * v52, v53.G * 255 * v52, v53.B * 255 * v52);
            else
                p5.VisualPart.Transparency = v51;
                p5.VisualPart.Color = Graph.QueryColorPointWithTime(v47, p5.Graphs.Color);
            end;
        end;

        return false;
    end;

    function p3.UpdateBeam(p54, p55, p56, p57) -- Line: 190
        -- upvalues: Graph (ref)
        local v58 = (p57 - p55.StartTime) / p55.LifeTime;

        if v58 >= 1 or not p55.VisualPart.Parent then
            return true;
        end;

        if p55.TotalKeyFrames <= 0 then
            return true;
        end;

        local math_floor_ret = math.floor(v58 * p55.TotalKeyFrames);

        if p55.CurrentStep < math_floor_ret then
            p55.CurrentStep = math_floor_ret;
            local v59 = p55.CurrentStep / p55.TotalKeyFrames;
            local TransStates = p55.TransStates;
            local ColorStates = p55.ColorStates;

            if TransStates and #TransStates >= 2 then
                local v60 = #TransStates - 1;

                for i = p55._lastTransIdx or 1, #TransStates - 1 do
                    if TransStates[i].Time <= v59 and v59 <= TransStates[i + 1].Time then
                        v60 = i;
                        break;
                    end;

                    local _ = i;
                end;

                p55._lastTransIdx = v60;
                local v61 = TransStates[v60];
                local v62 = TransStates[v60 + 1] or TransStates[#TransStates];
                local v63 = v62.Time - v61.Time;
                local v64 = v63 > 0 and ((v59 - v61.Time) / v63 or 0) or 0;
                local v65 = p55.TransMergedTimes[v60];

                if v65 then
                    p55.VisualPart.Transparency = Graph.LerpGraphFast(v61.Graph, v62.Graph, v64, v65);
                else
                    p55.VisualPart.Transparency = Graph.LerpGraph(v61.Graph, v62.Graph, v64);
                end;
            elseif TransStates and #TransStates == 1 then
                p55.VisualPart.Transparency = TransStates[1].Graph;
            end;

            if ColorStates and #ColorStates >= 2 then
                local v66 = #ColorStates - 1;

                for i = p55._lastColorIdx or 1, #ColorStates - 1 do
                    if ColorStates[i].Time <= v59 and v59 <= ColorStates[i + 1].Time then
                        v66 = i;
                        break;
                    end;

                    local _ = i;
                end;

                p55._lastColorIdx = v66;
                local v67 = ColorStates[v66];
                local v68 = ColorStates[v66 + 1] or ColorStates[#ColorStates];
                local v69 = v68.Time - v67.Time;
                local v70 = v69 > 0 and ((v59 - v67.Time) / v69 or 0) or 0;
                local v71 = p55.ColorMergedTimes[v66];

                if v71 then
                    p55.VisualPart.Color = Graph.LerpColorGraphFast(v67.Graph, v68.Graph, v70, v71);
                else
                    p55.VisualPart.Color = Graph.LerpColorGraph(v67.Graph, v68.Graph, v70);
                end;
            elseif ColorStates and #ColorStates == 1 then
                p55.VisualPart.Color = ColorStates[1].Graph;
            end;

            for i, v in pairs(p55.AnimatedProps) do
                p55.VisualPart[i] = Graph.QueryPointsWithTime(v59, v.Sequence, v.Seed);
            end;
        end;

        return false;
    end;

    function p3.UpdateAttachment(p72, p73, p74, p75) -- Line: 266
        -- upvalues: Graph (ref), DirectionVectors (ref)
        local v76 = (p75 - p73.StartTime) / p73.LifeTime;

        if v76 >= 1 or not (p73.VisualPart and p73.VisualPart.Parent) then
            return true;
        end;

        if p73.TotalKeyFrames <= 0 then
            return true;
        end;

        p73.AccumulatedDT = p73.AccumulatedDT + p74;
        local math_floor_ret = math.floor(v76 * p73.TotalKeyFrames);

        if p73.CurrentStep < math_floor_ret then
            local CurrentStep = p73.CurrentStep;
            local v77 = p73.AccumulatedDT / (math_floor_ret - CurrentStep);
            p73.AccumulatedDT = 0;

            if p73.InvertMotion then
                p73.CurrentStep = math_floor_ret;
                local v78 = p73.SimLocalCFrames[p73.TotalKeyFrames - math_floor_ret] or p73.SimLocalCFrames[0];
                p73.VisualPart.CFrame = v78;
                p73.LocalCF = v78;
            elseif p73.NeedsFullIteration then
                local HasDrag = p73.HasDrag;
                local HasAccel = p73.HasAccel;

                for i = CurrentStep + 1, math_floor_ret do
                    local v79 = i / p73.TotalKeyFrames;
                    local v80 = v79 * p73.LifeTime;
                    local v81 = Graph.QueryPointsWithTime(v79, p73.Graphs.Speed, p73.Seeds.Speed);

                    if HasDrag then
                        v81 = v81 * math.exp(-p73.Drag * v80) or v81;
                    end;

                    local v82;

                    if HasAccel then
                        v82 = (p73.BaseDirection * v81 + p73.Acceleration * v80) * v77;
                    else
                        v82 = p73.BaseDirection * (v81 * v77);
                    end;

                    p73.LocalCF = CFrame.new(v82) * p73.LocalCF;
                    local v83 = Graph.QueryPointsWithTime(v79, p73.Graphs.RotSpeedX, p73.Seeds.RotSpeedX);
                    local v84 = Graph.QueryPointsWithTime(v79, p73.Graphs.RotSpeedY, p73.Seeds.RotSpeedY);
                    local v85 = Graph.QueryPointsWithTime(v79, p73.Graphs.RotSpeedZ, p73.Seeds.RotSpeedZ);
                    local v86;

                    if p73.RotMode == "Speed" then
                        p73.AccRotX = p73.AccRotX + v83 * v77;
                        p73.AccRotY = p73.AccRotY + v84 * v77;
                        p73.AccRotZ = p73.AccRotZ + v85 * v77;
                        v86 = CFrame.Angles(math.rad(p73.AccRotX), math.rad(p73.AccRotY), (math.rad(p73.AccRotZ)));
                    else
                        v86 = CFrame.Angles(math.rad(v83), math.rad(v84), (math.rad(v85)));
                    end;

                    p73.VisualPart.CFrame = p73.LocalCF * v86;
                    local v87 = DirectionVectors[p73.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                    p73.BaseDirection = (p73.VisualPart.CFrame * p73.SpreadRotation)[v87.vector] * v87.multiplier;
                    local _ = i;
                end;

                p73.CurrentStep = math_floor_ret;
            elseif p73.NeedsRotAccum then
                local HasDrag = p73.HasDrag;
                local HasAccel = p73.HasAccel;
                local v88 = 0;
                local v89 = 0;

                for i = CurrentStep + 1, math_floor_ret do
                    local v90 = i / p73.TotalKeyFrames;
                    local v91 = v90 * p73.LifeTime;
                    local v92 = Graph.QueryPointsWithTime(v90, p73.Graphs.Speed, p73.Seeds.Speed);

                    if HasDrag then
                        v92 = v92 * math.exp(-p73.Drag * v91);
                    end;

                    v89 = v89 + v92 * v77;

                    if HasAccel then
                        v88 = v88 + v91 * v77;
                    end;

                    local v93 = Graph.QueryPointsWithTime(v90, p73.Graphs.RotSpeedX, p73.Seeds.RotSpeedX);
                    local v94 = Graph.QueryPointsWithTime(v90, p73.Graphs.RotSpeedY, p73.Seeds.RotSpeedY);
                    local v95 = Graph.QueryPointsWithTime(v90, p73.Graphs.RotSpeedZ, p73.Seeds.RotSpeedZ);
                    p73.AccRotX = p73.AccRotX + v93 * v77;
                    p73.AccRotY = p73.AccRotY + v94 * v77;
                    p73.AccRotZ = p73.AccRotZ + v95 * v77;
                    local _ = i;
                end;

                local v96 = p73.BaseDirection * v89;

                if HasAccel then
                    v96 = v96 + p73.Acceleration * v88;
                end;

                p73.LocalCF = CFrame.new(v96) * p73.LocalCF;
                local CFrame_Angles_ret = CFrame.Angles(math.rad(p73.AccRotX), math.rad(p73.AccRotY), (math.rad(p73.AccRotZ)));
                p73.VisualPart.CFrame = p73.LocalCF * CFrame_Angles_ret;
                p73.CurrentStep = math_floor_ret;
            else
                local HasDrag = p73.HasDrag;
                local HasAccel = p73.HasAccel;
                local v97 = 0;
                local v98 = 0;

                for i = CurrentStep + 1, math_floor_ret do
                    local v99 = i / p73.TotalKeyFrames;
                    local v100 = v99 * p73.LifeTime;
                    local v101 = Graph.QueryPointsWithTime(v99, p73.Graphs.Speed, p73.Seeds.Speed);

                    if HasDrag then
                        v101 = v101 * math.exp(-p73.Drag * v100);
                    end;

                    v97 = v97 + v101 * v77;
                    local v102;

                    if HasAccel then
                        v98 = v98 + v100 * v77;
                        v102 = i;
                    else
                        v102 = i;
                    end;
                end;

                local v103 = p73.BaseDirection * v97;

                if HasAccel then
                    v103 = v103 + p73.Acceleration * v98;
                end;

                p73.LocalCF = CFrame.new(v103) * p73.LocalCF;
                local v104 = math_floor_ret / p73.TotalKeyFrames;
                local v105 = Graph.QueryPointsWithTime(v104, p73.Graphs.RotSpeedX, p73.Seeds.RotSpeedX);
                local v106 = Graph.QueryPointsWithTime(v104, p73.Graphs.RotSpeedY, p73.Seeds.RotSpeedY);
                local v107 = Graph.QueryPointsWithTime(v104, p73.Graphs.RotSpeedZ, p73.Seeds.RotSpeedZ);
                local CFrame_Angles_ret = CFrame.Angles(math.rad(v105), math.rad(v106), (math.rad(v107)));
                p73.VisualPart.CFrame = p73.LocalCF * CFrame_Angles_ret;
                p73.CurrentStep = math_floor_ret;
            end;
        end;

        return false;
    end;
end;