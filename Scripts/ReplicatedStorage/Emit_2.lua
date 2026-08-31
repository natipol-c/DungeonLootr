--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Emit
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.Emit
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
local Flipbook = require(script.Parent.Flipbook);
local PartConstants = require(script.Parent.PartConstants);
local DirectionVectors = PartConstants.DirectionVectors;
local shapeFunctions = PartConstants.shapeFunctions;

return function(p1) -- Line: 14
    -- upvalues: Range (copy), DirectionVectors (copy), shapeFunctions (copy), Graph (copy), Particles (copy), Flipbook (copy)
    function p1.EmitPart(p2, p3, p4) -- Line: 16
        -- upvalues: Range (ref), DirectionVectors (ref), shapeFunctions (ref), Graph (ref), Particles (ref), Flipbook (ref)
        local Data = p2:GetData(p3);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v5 = p4 or Data.Link;
        local v6 = Range.RandomValueFromRange(Data.Lifetime);
        local v7 = v6 <= 0 and 0.001 or v6;
        local v8;

        if v5 then
            local v9 = v5:IsA("Attachment");
            local v10 = v9 and v5.WorldPosition or v5.Position;
            local v11 = v9 and v5.WorldCFrame or v5.CFrame;

            if Data.LinkMode == "Follow" then
                v8 = CFrame.new(v10) * p3.CFrame.Rotation;
            else
                v8 = CFrame.new(v10) * v11.Rotation * p3.CFrame.Rotation;
            end;
        else
            v8 = p3.CFrame;
        end;

        local v12 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v13 = v8[v12.vector] * v12.multiplier;
        local v14 = shapeFunctions[Data.ParticleData.Shape];
        local Vector3_new_ret = Vector3.new();
        local CFrame_new_ret = CFrame.new();

        if v14 and Data.ParticleData.ShapeInOut == Enum.ParticleEmitterShapeInOut.InAndOut then
            Vector3_new_ret, CFrame_new_ret = v14(p3, Data.ParticleData);
        end;

        local v15;

        if typeof(CFrame_new_ret) == "CFrame" and Data.ParticleData.ShapeStyle == Enum.ParticleEmitterShapeStyle.Surface then
            local v16, v17, v18 = v8:ToEulerAnglesXYZ();
            v15 = CFrame.new((v8 * CFrame.new(Vector3_new_ret)).Position) * CFrame_new_ret * CFrame.Angles(v16, v17, v18);
        else
            v15 = CFrame.new((v8 * CFrame.new(Vector3_new_ret)).Position) * v8.Rotation;
        end;

        local v19 = Range.RandomValueFromRange(Data.RotX);
        local v20 = Range.RandomValueFromRange(Data.RotY);
        local v21 = Range.RandomValueFromRange(Data.RotZ);
        local v22 = v15 * CFrame.Angles(math.rad(v19), math.rad(v20), (math.rad(v21)));

        if Data.VelocityVectored then
            v13 = v22[v12.vector] * v12.multiplier;
        end;

        local v23, v24;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v23 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v24 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v23 = 0;
            v24 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v23), math.rad(v24), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v13) * CFrame_Angles_ret).LookVector;
        local v25 = {
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
        local v26;

        if InvertMotion then
            v26 = p2:PreSimulateForward(Data, v25, v22, LookVector, CFrame_Angles_ret, v5, v7);
        else
            v26 = nil;
        end;

        local v27 = Data.RenderTemplate:Clone();
        local v28;

        if v5 then
            local v29 = v5:IsA("Attachment");
            local v30 = v29 and v5.WorldPosition or v5.Position;
            v28 = v29 and v5.WorldCFrame or v5.CFrame;

            if Data.LinkMode == "Follow" then
                v28 = CFrame.new(v30) or v28;
            end;
        else
            v28 = CFrame.new();
        end;

        if InvertMotion and v26 then
            v22 = v26[Data.TotalKeyFrames] or v26[0];
            v27.CFrame = v28 * v22;
        else
            if v5 then
                v22 = v28:ToObjectSpace(v22) or v22;
            end;

            v27.CFrame = v28 * v22;
        end;

        local v31 = {
            Type = "Part",
            VisualPart = v27,
            Link = v5,
            LinkMode = Data.LinkMode,
            SpecialMesh = v27:FindFirstChildOfClass("SpecialMesh"),
            Decal = v27:FindFirstChildOfClass("Decal"),
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            CurrentStep = 0,
            AccumulatedDT = 0,
            LifeTime = v7,
            PartLife = Data.PartLife,
            CurrentPosition = v27.Position,
            LocalCF = v22,
            BaseDirection = LookVector,
            EmissionDirection = Data.EmissionDirection,
            SpreadRotation = CFrame_Angles_ret,
            Acceleration = Data.ParticleData.Acceleration,
            Drag = Data.ParticleData.Drag,
            VelocityVectored = Data.VelocityVectored,
            InvertMotion = InvertMotion,
            SimLocalCFrames = v26,
            RotMode = Data.RotMode or "OverLife",
            AccRotX = 0,
            AccRotY = 0,
            AccRotZ = 0,
            NeedsFullIteration = Data.VelocityVectored
        };
        local v32;

        if Data.RotMode == "Speed" then
            v32 = not Data.VelocityVectored;
        else
            v32 = false;
        end;

        v31.NeedsRotAccum = v32;
        v31.HasDrag = Data.ParticleData.Drag ~= 0;
        v31.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v31.HasDecal = v27:FindFirstChildOfClass("Decal") ~= nil;
        v31.Graphs = {
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
        v31.Seeds = v25;
        local v33 = Graph.QueryPointsWithTime(0, v31.Graphs.SizeX, v31.Seeds.SizeX);
        local v34 = Graph.QueryPointsWithTime(0, v31.Graphs.SizeY, v31.Seeds.SizeY);
        local Vector3_new_ret2 = Vector3.new(v33, v34, Graph.QueryPointsWithTime(0, v31.Graphs.SizeZ, v31.Seeds.SizeZ));
        local v35 = Graph.QueryPointsWithTime(0, v31.Graphs.Transparency, v31.Seeds.Transparency);
        local v36 = Graph.QueryColorPointWithTime(0, v31.Graphs.Color);
        local v37 = Graph.QueryPointsWithTime(0, v31.Graphs.Brightness, v31.Seeds.Brightness);

        if v31.SpecialMesh then
            v31.SpecialMesh.Scale = Vector3_new_ret2;
        else
            v31.VisualPart.Size = Vector3_new_ret2;
        end;

        if v31.Decal then
            v31.Decal.Transparency = v35;
            v31.Decal.Color3 = Color3.fromRGB(v36.R * 255 * v37, v36.G * 255 * v37, v36.B * 255 * v37);
        else
            v31.VisualPart.Transparency = v35;
            v31.VisualPart.Color = v36;
        end;

        v27.Parent = Data.EmitParent or p2:GetFolder();

        for _, descendant in v27:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, child in v27:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child);
            end;

            Particles.EnableEmitSingle(child);
        end;

        table.insert(p2.ActiveEmits, v31);

        if v31.Decal and (Data.CachedMeshTextures and #Data.CachedMeshTextures > 0) then
            Flipbook.Flip(Data.ParticleData, Data.CachedMeshTextures, v31.Decal, v7);
        end;

        for _, child in v27:GetChildren() do
            if child:GetAttribute("Transformed") then
                p2:EnableEmit(child, v27);
            end;
        end;
    end;

    function p1.EmitAttachment(p38, p39, p40) -- Line: 211
        -- upvalues: Range (ref), DirectionVectors (ref), Graph (ref)
        local Data = p38:GetData(p39);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v41 = p40 or Data.Link;
        local v42 = Range.RandomValueFromRange(Data.Lifetime);
        local v43 = v42 <= 0 and 0.001 or v42;
        local CFrame2 = p39.CFrame;
        local v44 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local LookVector = CFrame.new(Vector3.new(), CFrame2[v44.vector] * v44.multiplier).LookVector;
        local v45 = Range.RandomValueFromRange(Data.RotX);
        local v46 = Range.RandomValueFromRange(Data.RotY);
        local v47 = Range.RandomValueFromRange(Data.RotZ);
        local v48 = CFrame2 * CFrame.Angles(math.rad(v45), math.rad(v46), (math.rad(v47)));
        local v49, v50;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v49 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v50 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v49 = 0;
            v50 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v49), math.rad(v50), 0);
        local LookVector2 = (CFrame.lookAt(Vector3.new(), LookVector) * CFrame_Angles_ret).LookVector;
        local v51 = {
            Speed = Graph.GenerateSeed(Data.Speed),
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ)
        };
        local InvertMotion = Data.InvertMotion;
        local v52;

        if InvertMotion then
            v52 = p38:PreSimulateAttachmentForward(Data, v51, v48, LookVector2, CFrame_Angles_ret, v43);
        else
            v52 = nil;
        end;

        local v53 = Data.RenderTemplate:Clone();

        if InvertMotion and v52 then
            v48 = v52[Data.TotalKeyFrames] or v52[0];
        end;

        local v54 = Data.EmitParent or (v41 or p39.Parent);
        local Parent = p39.Parent;

        if v54 and v54 ~= Parent then
            if Parent:IsA("BasePart") then
                v48 = Parent.CFrame * v48 or v48;
            end;

            if v54:IsA("BasePart") then
                v48 = v54.CFrame:ToObjectSpace(v48) or v48;
            end;
        end;

        v53.CFrame = v48;
        v53.Parent = v54;
        local v55 = {
            Type = "Attachment",
            CurrentStep = 0,
            AccumulatedDT = 0,
            AccRotX = 0,
            AccRotY = 0,
            AccRotZ = 0,
            VisualPart = v53,
            Link = v41,
            LinkMode = Data.LinkMode,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v43,
            PartLife = Data.PartLife,
            LocalCF = v48,
            BaseDirection = LookVector2,
            EmissionDirection = Data.EmissionDirection,
            SpreadRotation = CFrame_Angles_ret,
            Acceleration = Data.ParticleData.Acceleration,
            Drag = Data.ParticleData.Drag,
            VelocityVectored = Data.VelocityVectored,
            InvertMotion = InvertMotion,
            SimLocalCFrames = v52,
            RotMode = Data.RotMode or "OverLife",
            NeedsFullIteration = Data.VelocityVectored
        };
        local v56;

        if Data.RotMode == "Speed" then
            v56 = not Data.VelocityVectored;
        else
            v56 = false;
        end;

        v55.NeedsRotAccum = v56;
        v55.HasDrag = Data.ParticleData.Drag ~= 0;
        v55.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v55.Graphs = {
            Speed = Data.Speed,
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ
        };
        v55.Seeds = v51;
        table.insert(p38.ActiveEmits, v55);

        for _, child in v53:GetChildren() do
            if child:GetAttribute("Transformed") then
                p38:EnableEmit(child, v53.Parent);
            end;
        end;
    end;

    function p1.EmitBeam(p57, p58, p59) -- Line: 328
        -- upvalues: Graph (ref), Range (ref), Flipbook (ref)
        local Data = p57:GetData(p58);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v60 = Data.RenderTemplate:Clone();
        v60.Enabled = true;

        if Data.FaceCamera ~= nil then
            v60.FaceCamera = Data.FaceCamera;
        end;

        v60.Parent = Data.EmitParent or p57:GetFolder();
        local v61 = {};

        for i, v in pairs(Data.BeamProps) do
            if v then
                if Graph.IsStatic(v) then
                    v60[i] = Graph.GetStaticValue(v, v60[i]);
                else
                    v61[i] = {
                        Sequence = v,
                        Seed = Graph.GenerateSeed(v)
                    };
                end;
            end;
        end;

        local v62, v63 = Graph.CollectGraphStates(Data.GraphBlender);
        local v64 = {};

        for i = 1, #v62 - 1 do
            v64[i] = Graph.PrecomputeMergedTimes(v62[i].Graph, v62[i + 1].Graph);
            local _ = i;
        end;

        local v65 = {};

        for i = 1, #v63 - 1 do
            v65[i] = Graph.PrecomputeMergedColorTimes(v63[i].Graph, v63[i + 1].Graph);
            local _ = i;
        end;

        if #v62 > 0 then
            v60.Transparency = v62[1].Graph;
        end;

        if #v63 > 0 then
            v60.Color = v63[1].Graph;
        end;

        local v66 = Range.RandomValueFromRange(Data.Lifetime);
        local v67 = v66 <= 0 and 0.001 or v66;
        local v68 = {
            Type = "Beam",
            CurrentStep = 0,
            PartLife = 0,
            VisualPart = v60,
            Link = p59,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v67,
            AnimatedProps = v61,
            TransStates = v62,
            ColorStates = v63,
            TransMergedTimes = v64,
            ColorMergedTimes = v65
        };
        table.insert(p57.ActiveEmits, v68);

        if Data.CachedBeamTextures and (#Data.CachedBeamTextures > 0 and Data.FlipbookParticle) then
            Flipbook.FlipBeam(Data.FlipbookParticle, Data.CachedBeamTextures, v60, v67);
        end;
    end;
end;