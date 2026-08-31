--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EmitAnimate
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.EmitAnimate
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local Range = require(script.Parent.Range);
local Particles = require(script.Parent.Particles);
local PartConstants = require(script.Parent.PartConstants);
local DirectionVectors = PartConstants.DirectionVectors;
local shapeFunctions = PartConstants.shapeFunctions;

return function(p1) -- Line: 14
    -- upvalues: Range (copy), DirectionVectors (copy), shapeFunctions (copy), Graph (copy), Particles (copy)
    function p1.EmitPartAnimate(p2, p3, p4) -- Line: 16
        -- upvalues: Range (ref), DirectionVectors (ref), shapeFunctions (ref), Graph (ref), Particles (ref)
        local Data = p2:GetData(p3);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v5 = p4 or Data.Link;
        local v6 = Range.RandomValueFromRange(Data.Lifetime);
        local v7 = v6 <= 0 and 0.001 or v6;
        local v8 = p3:GetAttribute("AnimateLoop") or false;
        local RenderTemplate = Data.RenderTemplate;
        local CFrame2 = RenderTemplate.CFrame;
        local CFrame3 = p3.CFrame;
        local v9 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v10 = CFrame3[v9.vector] * v9.multiplier;
        local v11 = shapeFunctions[Data.ParticleData.Shape];
        local Vector3_new_ret = Vector3.new();
        local CFrame_new_ret = CFrame.new();

        if v11 and Data.ParticleData.ShapeInOut == Enum.ParticleEmitterShapeInOut.InAndOut then
            Vector3_new_ret, CFrame_new_ret = v11(p3, Data.ParticleData);
        end;

        local v12;

        if typeof(CFrame_new_ret) == "CFrame" and Data.ParticleData.ShapeStyle == Enum.ParticleEmitterShapeStyle.Surface then
            local v13, v14, v15 = CFrame3:ToEulerAnglesXYZ();
            v12 = CFrame.new((CFrame3 * CFrame.new(Vector3_new_ret)).Position) * CFrame_new_ret * CFrame.Angles(v13, v14, v15);
        else
            v12 = CFrame.new((CFrame3 * CFrame.new(Vector3_new_ret)).Position) * CFrame3.Rotation;
        end;

        local v16 = Range.RandomValueFromRange(Data.RotX);
        local v17 = Range.RandomValueFromRange(Data.RotY);
        local v18 = Range.RandomValueFromRange(Data.RotZ);
        local v19 = v12 * CFrame.Angles(math.rad(v16), math.rad(v17), (math.rad(v18)));

        if Data.VelocityVectored then
            v10 = v19[v9.vector] * v9.multiplier;
        end;

        local v20, v21;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v20 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v21 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v20 = 0;
            v21 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v20), math.rad(v21), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v10) * CFrame_Angles_ret).LookVector;
        local v22 = {
            SizeX = Graph.GenerateSeed(Data.SizeX),
            SizeY = Graph.GenerateSeed(Data.SizeY),
            SizeZ = Graph.GenerateSeed(Data.SizeZ),
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ),
            Speed = Graph.GenerateSeed(Data.Speed),
            Brightness = Graph.GenerateSeed(Data.Brightness),
            Transparency = Graph.GenerateSeed(Data.Transparency)
        };
        local InvertMotion = Data.InvertMotion;
        local v23;

        if InvertMotion then
            v23 = p2:PreSimulateForward(Data, v22, v19, LookVector, CFrame_Angles_ret, v5, v7);
        else
            v23 = nil;
        end;

        local v24;

        if v5 then
            local v25 = v5:IsA("Attachment");
            local v26 = v25 and v5.WorldPosition or v5.Position;
            v24 = v25 and v5.WorldCFrame or v5.CFrame;

            if Data.LinkMode == "Follow" then
                v24 = CFrame.new(v26) or v24;
            end;
        else
            v24 = CFrame.new();
        end;

        if InvertMotion and v23 then
            v19 = v23[Data.TotalKeyFrames] or v23[0];
        elseif v5 then
            v19 = v24:ToObjectSpace(v19) or v19;
        end;

        RenderTemplate.CFrame = v24 * v19;
        local v27 = {
            Type = "Part",
            VisualPart = RenderTemplate,
            Link = v5,
            LinkMode = Data.LinkMode,
            SpecialMesh = RenderTemplate:FindFirstChildOfClass("SpecialMesh"),
            Decal = RenderTemplate:FindFirstChildOfClass("Decal"),
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            CurrentStep = 0,
            AccumulatedDT = 0,
            LifeTime = v7,
            PartLife = 0,
            CurrentPosition = RenderTemplate.Position,
            LocalCF = v19,
            BaseDirection = LookVector,
            EmissionDirection = Data.EmissionDirection,
            SpreadRotation = CFrame_Angles_ret,
            Acceleration = Data.ParticleData.Acceleration,
            Drag = Data.ParticleData.Drag,
            VelocityVectored = Data.VelocityVectored,
            InvertMotion = InvertMotion,
            SimLocalCFrames = v23,
            RotMode = Data.RotMode or "OverLife",
            AccRotX = 0,
            AccRotY = 0,
            AccRotZ = 0,
            NeedsFullIteration = Data.VelocityVectored
        };
        local v28;

        if Data.RotMode == "Speed" then
            v28 = not Data.VelocityVectored;
        else
            v28 = false;
        end;

        v27.NeedsRotAccum = v28;
        v27.HasDrag = Data.ParticleData.Drag ~= 0;
        v27.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v27.HasDecal = RenderTemplate:FindFirstChildOfClass("Decal") ~= nil;
        v27.Graphs = {
            SizeX = Data.SizeX,
            SizeY = Data.SizeY,
            SizeZ = Data.SizeZ,
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ,
            Speed = Data.Speed,
            Brightness = Data.Brightness,
            Transparency = Data.Transparency,
            Color = Data.Color
        };
        v27.Seeds = v22;
        v27.IsAnimate = true;
        v27.AnimateLoop = v8;
        v27.AnimateItem = p3;
        v27.InitialWorldCF = CFrame2;
        v27.InitialLocalCF = v19;
        local v29 = Graph.QueryPointsWithTime(0, v27.Graphs.SizeX, v27.Seeds.SizeX);
        local v30 = Graph.QueryPointsWithTime(0, v27.Graphs.SizeY, v27.Seeds.SizeY);
        local Vector3_new_ret2 = Vector3.new(v29, v30, Graph.QueryPointsWithTime(0, v27.Graphs.SizeZ, v27.Seeds.SizeZ));
        local v31 = Graph.QueryPointsWithTime(0, v27.Graphs.Transparency, v27.Seeds.Transparency);
        local v32 = Graph.QueryColorPointWithTime(0, v27.Graphs.Color);
        local v33 = Graph.QueryPointsWithTime(0, v27.Graphs.Brightness, v27.Seeds.Brightness);

        if v27.SpecialMesh then
            v27.SpecialMesh.Scale = Vector3_new_ret2;
        else
            v27.VisualPart.Size = Vector3_new_ret2;
        end;

        if v27.Decal then
            v27.Decal.Transparency = v31;
            v27.Decal.Color3 = Color3.fromRGB(v32.R * 255 * v33, v32.G * 255 * v33, v32.B * 255 * v33);
        else
            v27.VisualPart.Transparency = v31;
            v27.VisualPart.Color = v32;
        end;

        for _, descendant in RenderTemplate:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, child in RenderTemplate:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child);
            end;

            Particles.EnableEmitSingle(child);
        end;

        table.insert(p2.ActiveEmits, v27);
        p2.ActiveAnimates[p3] = v27;

        for _, child in RenderTemplate:GetChildren() do
            if child:GetAttribute("Transformed") then
                p2:EnableEmit(child, RenderTemplate);
            end;
        end;
    end;

    function p1.EmitAttachmentAnimate(p34, p35, p36) -- Line: 189
        -- upvalues: Range (ref), DirectionVectors (ref), Graph (ref)
        local Data = p34:GetData(p35);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v37 = p36 or Data.Link;
        local v38 = Range.RandomValueFromRange(Data.Lifetime);
        local v39 = v38 <= 0 and 0.001 or v38;
        local v40 = p35:GetAttribute("AnimateLoop") or false;
        local RenderTemplate = Data.RenderTemplate;
        local CFrame2 = RenderTemplate.CFrame;
        local CFrame3 = p35.CFrame;
        local v41 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local LookVector = CFrame.new(Vector3.new(), CFrame3[v41.vector] * v41.multiplier).LookVector;
        local v42 = Range.RandomValueFromRange(Data.RotX);
        local v43 = Range.RandomValueFromRange(Data.RotY);
        local v44 = Range.RandomValueFromRange(Data.RotZ);
        local v45 = CFrame3 * CFrame.Angles(math.rad(v42), math.rad(v43), (math.rad(v44)));
        local v46, v47;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v46 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v47 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v46 = 0;
            v47 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v46), math.rad(v47), 0);
        local LookVector2 = (CFrame.lookAt(Vector3.new(), LookVector) * CFrame_Angles_ret).LookVector;
        local v48 = {
            Speed = Graph.GenerateSeed(Data.Speed),
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ)
        };
        local InvertMotion = Data.InvertMotion;
        local v49;

        if InvertMotion then
            v49 = p34:PreSimulateAttachmentForward(Data, v48, v45, LookVector2, CFrame_Angles_ret, v39);
        else
            v49 = nil;
        end;

        if InvertMotion and v49 then
            v45 = v49[Data.TotalKeyFrames] or v49[0];
        end;

        RenderTemplate.CFrame = v45;
        local v50 = {
            Type = "Attachment",
            VisualPart = RenderTemplate,
            Link = v37,
            LinkMode = Data.LinkMode,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            CurrentStep = 0,
            AccumulatedDT = 0,
            LifeTime = v39,
            PartLife = 0,
            LocalCF = v45,
            BaseDirection = LookVector2,
            EmissionDirection = Data.EmissionDirection,
            SpreadRotation = CFrame_Angles_ret,
            Acceleration = Data.ParticleData.Acceleration,
            Drag = Data.ParticleData.Drag,
            VelocityVectored = Data.VelocityVectored,
            InvertMotion = InvertMotion,
            SimLocalCFrames = v49,
            RotMode = Data.RotMode or "OverLife",
            AccRotX = 0,
            AccRotY = 0,
            AccRotZ = 0,
            NeedsFullIteration = Data.VelocityVectored
        };
        local v51;

        if Data.RotMode == "Speed" then
            v51 = not Data.VelocityVectored;
        else
            v51 = false;
        end;

        v50.NeedsRotAccum = v51;
        v50.HasDrag = Data.ParticleData.Drag ~= 0;
        v50.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v50.Graphs = {
            Speed = Data.Speed,
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ
        };
        v50.Seeds = v48;
        v50.IsAnimate = true;
        v50.AnimateLoop = v40;
        v50.AnimateItem = p35;
        v50.InitialWorldCF = CFrame2;
        v50.InitialLocalCF = v45;
        table.insert(p34.ActiveEmits, v50);
        p34.ActiveAnimates[p35] = v50;

        for _, child in RenderTemplate:GetChildren() do
            if child:GetAttribute("Transformed") then
                p34:EnableEmit(child, RenderTemplate.Parent);
            end;
        end;
    end;

    function p1.EmitBeamAnimate(p52, p53, p54) -- Line: 280
        -- upvalues: Graph (ref), Range (ref)
        local Data = p52:GetData(p53);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v55 = p53:GetAttribute("AnimateLoop") or false;
        local RenderTemplate = Data.RenderTemplate;
        RenderTemplate.Enabled = true;

        if Data.FaceCamera ~= nil then
            RenderTemplate.FaceCamera = Data.FaceCamera;
        end;

        local v56 = {};

        for i, v in pairs(Data.BeamProps) do
            if v then
                if Graph.IsStatic(v) then
                    RenderTemplate[i] = Graph.GetStaticValue(v, RenderTemplate[i]);
                else
                    v56[i] = {
                        Sequence = v,
                        Seed = Graph.GenerateSeed(v)
                    };
                end;
            end;
        end;

        local v57, v58 = Graph.CollectGraphStates(Data.GraphBlender);
        local v59 = {};

        for i = 1, #v57 - 1 do
            v59[i] = Graph.PrecomputeMergedTimes(v57[i].Graph, v57[i + 1].Graph);
            local _ = i;
        end;

        local v60 = {};

        for i = 1, #v58 - 1 do
            v60[i] = Graph.PrecomputeMergedColorTimes(v58[i].Graph, v58[i + 1].Graph);
            local _ = i;
        end;

        if #v57 > 0 then
            RenderTemplate.Transparency = v57[1].Graph;
        end;

        if #v58 > 0 then
            RenderTemplate.Color = v58[1].Graph;
        end;

        local v61 = Range.RandomValueFromRange(Data.Lifetime);
        local v62 = {
            Type = "Beam",
            CurrentStep = 0,
            PartLife = 0,
            IsAnimate = true,
            VisualPart = RenderTemplate,
            Link = p54,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v61 <= 0 and 0.001 or v61,
            AnimatedProps = v56,
            TransStates = v57,
            ColorStates = v58,
            TransMergedTimes = v59,
            ColorMergedTimes = v60,
            AnimateLoop = v55,
            AnimateItem = p53
        };
        table.insert(p52.ActiveEmits, v62);
        p52.ActiveAnimates[p53] = v62;
    end;
end;