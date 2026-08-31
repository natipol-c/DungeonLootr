--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UpdateModel
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.UpdateModel
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local DirectionVectors = require(script.Parent.PartConstants).DirectionVectors;

local function getLinkCF(p1) -- Line: 13
    local Link = p1.Link;

    if not (Link and Link.Parent) then
        return CFrame.new(), false;
    end;

    if p1.LinkMode == "Follow" then
        return CFrame.new(Link.Position), false;
    end;

    return Link.CFrame, p1.LinkMode == "Weld";
end;

return function(p2) -- Line: 20
    -- upvalues: Graph (copy), DirectionVectors (copy)
    function p2.UpdateModel(p3, p4, p5, p6) -- Line: 22
        -- upvalues: Graph (ref), DirectionVectors (ref)
        local v7 = (p6 - p4.StartTime) / p4.LifeTime;

        if v7 >= 1 or not (p4.VisualPart and p4.VisualPart.Parent) then
            return true;
        end;

        if p4.TotalKeyFrames <= 0 then
            return true;
        end;

        p4.AccumulatedDT = p4.AccumulatedDT + p5;
        local math_floor_ret = math.floor(v7 * p4.TotalKeyFrames);

        if p4.CurrentStep < math_floor_ret then
            local CurrentStep = p4.CurrentStep;
            local v8 = p4.AccumulatedDT / (math_floor_ret - CurrentStep);
            p4.AccumulatedDT = 0;

            if p4.InvertMotion then
                p4.CurrentStep = math_floor_ret;
                local v9 = p4.SimLocalCFrames[p4.TotalKeyFrames - math_floor_ret] or p4.SimLocalCFrames[0];
                local Link = p4.Link;
                local v10;

                if Link and Link.Parent then
                    if p4.LinkMode == "Follow" then
                        v10 = CFrame.new(Link.Position);
                    else
                        v10 = Link.CFrame;
                        local _ = p4.LinkMode == "Weld";
                    end;
                else
                    v10 = CFrame.new();
                end;

                p4.VisualPart:PivotTo(v10 * v9);
                p4.CurrentPosition = p4.VisualPart:GetPivot().Position;
            elseif p4.NeedsFullIteration then
                local HasDrag = p4.HasDrag;
                local HasAccel = p4.HasAccel;

                for i = CurrentStep + 1, math_floor_ret do
                    local v11 = i / p4.TotalKeyFrames;
                    local v12 = v11 * p4.LifeTime;
                    local v13 = Graph.QueryPointsWithTime(v11, p4.Graphs.Speed, p4.Seeds.Speed);

                    if HasDrag then
                        v13 = v13 * math.exp(-p4.Drag * v12) or v13;
                    end;

                    local v14;

                    if HasAccel then
                        v14 = (p4.BaseDirection * v13 + p4.Acceleration * v12) * v8;
                    else
                        v14 = p4.BaseDirection * (v13 * v8);
                    end;

                    local Link = p4.Link;
                    local v15, v16;

                    if Link and Link.Parent then
                        if p4.LinkMode == "Follow" then
                            v15 = CFrame.new(Link.Position);
                            v16 = false;
                        else
                            v15 = Link.CFrame;

                            if p4.LinkMode == "Weld" then
                                v16 = true;
                            else
                                v16 = false;
                            end;
                        end;
                    else
                        v15 = CFrame.new();
                        v16 = false;
                    end;

                    if v16 then
                        v14 = v15:VectorToObjectSpace(v14) or v14;
                    end;

                    p4.LocalCF = CFrame.new(v14) * p4.LocalCF;
                    local v17 = Graph.QueryPointsWithTime(v11, p4.Graphs.RotSpeedX, p4.Seeds.RotSpeedX);
                    local v18 = Graph.QueryPointsWithTime(v11, p4.Graphs.RotSpeedY, p4.Seeds.RotSpeedY);
                    local v19 = Graph.QueryPointsWithTime(v11, p4.Graphs.RotSpeedZ, p4.Seeds.RotSpeedZ);
                    local v20;

                    if p4.RotMode == "Speed" then
                        p4.AccRotX = p4.AccRotX + v17 * v8;
                        p4.AccRotY = p4.AccRotY + v18 * v8;
                        p4.AccRotZ = p4.AccRotZ + v19 * v8;
                        v20 = CFrame.Angles(math.rad(p4.AccRotX), math.rad(p4.AccRotY), (math.rad(p4.AccRotZ)));
                    else
                        v20 = CFrame.Angles(math.rad(v17), math.rad(v18), (math.rad(v19)));
                    end;

                    p4.VisualPart:PivotTo(v15 * p4.LocalCF * v20);
                    p4.CurrentPosition = p4.VisualPart:GetPivot().Position;
                    local v21 = p4.VisualPart:GetPivot() * p4.SpreadRotation;
                    local v22 = DirectionVectors[p4.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                    p4.BaseDirection = v21[v22.vector] * v22.multiplier;
                    local _ = i;
                end;

                p4.CurrentStep = math_floor_ret;
            elseif p4.NeedsRotAccum then
                local HasDrag = p4.HasDrag;
                local HasAccel = p4.HasAccel;
                local v23 = 0;
                local v24 = 0;

                for i = CurrentStep + 1, math_floor_ret do
                    local v25 = i / p4.TotalKeyFrames;
                    local v26 = v25 * p4.LifeTime;
                    local v27 = Graph.QueryPointsWithTime(v25, p4.Graphs.Speed, p4.Seeds.Speed);

                    if HasDrag then
                        v27 = v27 * math.exp(-p4.Drag * v26);
                    end;

                    v24 = v24 + v27 * v8;

                    if HasAccel then
                        v23 = v23 + v26 * v8;
                    end;

                    local v28 = Graph.QueryPointsWithTime(v25, p4.Graphs.RotSpeedX, p4.Seeds.RotSpeedX);
                    local v29 = Graph.QueryPointsWithTime(v25, p4.Graphs.RotSpeedY, p4.Seeds.RotSpeedY);
                    local v30 = Graph.QueryPointsWithTime(v25, p4.Graphs.RotSpeedZ, p4.Seeds.RotSpeedZ);
                    p4.AccRotX = p4.AccRotX + v28 * v8;
                    p4.AccRotY = p4.AccRotY + v29 * v8;
                    p4.AccRotZ = p4.AccRotZ + v30 * v8;
                    local _ = i;
                end;

                local v31 = p4.BaseDirection * v24;

                if HasAccel then
                    v31 = v31 + p4.Acceleration * v23;
                end;

                local Link = p4.Link;
                local v32, v33;

                if Link and Link.Parent then
                    if p4.LinkMode == "Follow" then
                        v32 = CFrame.new(Link.Position);
                        v33 = false;
                    else
                        v32 = Link.CFrame;

                        if p4.LinkMode == "Weld" then
                            v33 = true;
                        else
                            v33 = false;
                        end;
                    end;
                else
                    v32 = CFrame.new();
                    v33 = false;
                end;

                if v33 then
                    v31 = v32:VectorToObjectSpace(v31) or v31;
                end;

                p4.LocalCF = CFrame.new(v31) * p4.LocalCF;
                local CFrame_Angles_ret = CFrame.Angles(math.rad(p4.AccRotX), math.rad(p4.AccRotY), (math.rad(p4.AccRotZ)));
                p4.VisualPart:PivotTo(v32 * p4.LocalCF * CFrame_Angles_ret);
                p4.CurrentPosition = p4.VisualPart:GetPivot().Position;
                p4.CurrentStep = math_floor_ret;
            else
                local HasDrag = p4.HasDrag;
                local HasAccel = p4.HasAccel;
                local v34 = 0;
                local v35 = 0;

                for i = CurrentStep + 1, math_floor_ret do
                    local v36 = i / p4.TotalKeyFrames;
                    local v37 = v36 * p4.LifeTime;
                    local v38 = Graph.QueryPointsWithTime(v36, p4.Graphs.Speed, p4.Seeds.Speed);

                    if HasDrag then
                        v38 = v38 * math.exp(-p4.Drag * v37);
                    end;

                    v34 = v34 + v38 * v8;
                    local v39;

                    if HasAccel then
                        v35 = v35 + v37 * v8;
                        v39 = i;
                    else
                        v39 = i;
                    end;
                end;

                local v40 = p4.BaseDirection * v34;

                if HasAccel then
                    v40 = v40 + p4.Acceleration * v35;
                end;

                local Link = p4.Link;
                local v41, v42;

                if Link and Link.Parent then
                    if p4.LinkMode == "Follow" then
                        v41 = CFrame.new(Link.Position);
                        v42 = false;
                    else
                        v41 = Link.CFrame;

                        if p4.LinkMode == "Weld" then
                            v42 = true;
                        else
                            v42 = false;
                        end;
                    end;
                else
                    v41 = CFrame.new();
                    v42 = false;
                end;

                if v42 then
                    v40 = v41:VectorToObjectSpace(v40) or v40;
                end;

                p4.LocalCF = CFrame.new(v40) * p4.LocalCF;
                local v43 = math_floor_ret / p4.TotalKeyFrames;
                local v44 = Graph.QueryPointsWithTime(v43, p4.Graphs.RotSpeedX, p4.Seeds.RotSpeedX);
                local v45 = Graph.QueryPointsWithTime(v43, p4.Graphs.RotSpeedY, p4.Seeds.RotSpeedY);
                local v46 = Graph.QueryPointsWithTime(v43, p4.Graphs.RotSpeedZ, p4.Seeds.RotSpeedZ);
                local CFrame_Angles_ret = CFrame.Angles(math.rad(v44), math.rad(v45), (math.rad(v46)));
                p4.VisualPart:PivotTo(v41 * p4.LocalCF * CFrame_Angles_ret);
                p4.CurrentPosition = p4.VisualPart:GetPivot().Position;
                p4.CurrentStep = math_floor_ret;
            end;

            local v47 = Graph.QueryPointsWithTime(math_floor_ret / p4.TotalKeyFrames, p4.Graphs.Scale, p4.Seeds.Scale);
            p4.VisualPart:ScaleTo(v47);

            for i, v in pairs(p4.PESnapshots) do
                if i.Parent then
                    i.Size = Graph.ScaleSequence(v, v47);
                end;
            end;
        end;

        return false;
    end;
end;