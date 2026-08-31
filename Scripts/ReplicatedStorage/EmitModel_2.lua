--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EmitModel
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.EmitModel
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
local DirectionVectors = require(script.Parent.PartConstants).DirectionVectors;

return function(p1) -- Line: 14
    -- upvalues: Range (copy), DirectionVectors (copy), Graph (copy), Particles (copy)
    function p1.EmitModel(p2, p3, p4) -- Line: 16
        -- upvalues: Range (ref), DirectionVectors (ref), Graph (ref), Particles (ref)
        local Data = p2:GetData(p3);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v5 = p4 or Data.Link;
        local v6 = Range.RandomValueFromRange(Data.Lifetime);
        local v7 = v6 <= 0 and 0.001 or v6;
        local Pivot = p3:GetPivot();
        local v8 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v9 = Pivot[v8.vector] * v8.multiplier;
        local v10 = Range.RandomValueFromRange(Data.RotX);
        local v11 = Range.RandomValueFromRange(Data.RotY);
        local v12 = Range.RandomValueFromRange(Data.RotZ);
        local v13 = Pivot * CFrame.Angles(math.rad(v10), math.rad(v11), (math.rad(v12)));

        if Data.VelocityVectored then
            v9 = v13[v8.vector] * v8.multiplier;
        end;

        local v14, v15;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v14 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v15 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v14 = 0;
            v15 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v14), math.rad(v15), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v9) * CFrame_Angles_ret).LookVector;
        local v16 = {
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ),
            Speed = Graph.GenerateSeed(Data.Speed),
            Scale = Graph.GenerateSeed(Data.Scale)
        };
        local InvertMotion = Data.InvertMotion;
        local v17;

        if InvertMotion then
            v17 = p2:PreSimulateForward(Data, v16, v13, LookVector, CFrame_Angles_ret, v5, v7);
        else
            v17 = nil;
        end;

        local v18 = Data.RenderTemplate:Clone();
        local v19;

        if v5 then
            local v20 = v5:IsA("Attachment");
            local v21 = v20 and v5.WorldPosition or v5.Position;
            v19 = v20 and v5.WorldCFrame or v5.CFrame;

            if Data.LinkMode == "Follow" then
                v19 = CFrame.new(v21) or v19;
            end;
        else
            v19 = CFrame.new();
        end;

        if InvertMotion and v17 then
            v13 = v17[Data.TotalKeyFrames] or v17[0];
            v18:PivotTo(v19 * v13);
        else
            if v5 then
                v13 = v19:ToObjectSpace(v13) or v13;
            end;

            v18:PivotTo(v19 * v13);
        end;

        local v22 = {};

        for _, descendant in v18:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                v22[descendant] = descendant.Size;
            end;
        end;

        local v23 = {
            Type = "Model",
            CurrentStep = 0,
            AccumulatedDT = 0,
            AccRotX = 0,
            AccRotY = 0,
            AccRotZ = 0,
            VisualPart = v18,
            Link = v5,
            LinkMode = Data.LinkMode,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            LifeTime = v7,
            PartLife = Data.PartLife,
            CurrentPosition = v18:GetPivot().Position,
            LocalCF = v13,
            BaseDirection = LookVector,
            EmissionDirection = Data.EmissionDirection,
            SpreadRotation = CFrame_Angles_ret,
            Acceleration = Data.ParticleData.Acceleration,
            Drag = Data.ParticleData.Drag,
            VelocityVectored = Data.VelocityVectored,
            InvertMotion = InvertMotion,
            SimLocalCFrames = v17,
            RotMode = Data.RotMode or "OverLife",
            NeedsFullIteration = Data.VelocityVectored
        };
        local v24;

        if Data.RotMode == "Speed" then
            v24 = not Data.VelocityVectored;
        else
            v24 = false;
        end;

        v23.NeedsRotAccum = v24;
        v23.HasDrag = Data.ParticleData.Drag ~= 0;
        v23.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v23.PESnapshots = v22;
        v23.Graphs = {
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ,
            Speed = Data.Speed,
            Scale = Data.Scale
        };
        v23.Seeds = v16;
        local v25 = Graph.QueryPointsWithTime(0, v23.Graphs.Scale, v23.Seeds.Scale);
        v18:ScaleTo(v25);

        for i, v in pairs(v22) do
            if i.Parent then
                i.Size = Graph.ScaleSequence(v, v25);
            end;
        end;

        v18.Parent = Data.EmitParent or p2:GetFolder();

        for _, descendant in v18:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, child in v18:GetChildren() do
            if child:IsA("Attachment") then
                Particles.EnableEmitChildrenAndRepeatForAttachments(child);
            end;

            Particles.EnableEmitSingle(child);
        end;

        table.insert(p2.ActiveEmits, v23);

        for _, child in v18:GetChildren() do
            if child:GetAttribute("Transformed") then
                p2:EnableEmit(child, v18.PrimaryPart or v18);
            end;
        end;
    end;

    function p1.EmitModelAnimate(p26, p27, p28) -- Line: 171
        -- upvalues: Range (ref), DirectionVectors (ref), Graph (ref), Particles (ref)
        local Data = p26:GetData(p27);

        if not (Data and Data.RenderTemplate) then
            return;
        end;

        local v29 = p28 or Data.Link;
        local v30 = Range.RandomValueFromRange(Data.Lifetime);
        local v31 = v30 <= 0 and 0.001 or v30;
        local v32 = p27:GetAttribute("AnimateLoop") or false;
        local RenderTemplate = Data.RenderTemplate;
        local Pivot = RenderTemplate:GetPivot();
        local Pivot2 = p27:GetPivot();
        local v33 = DirectionVectors[Data.EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
        local v34 = Pivot2[v33.vector] * v33.multiplier;
        local v35 = Range.RandomValueFromRange(Data.RotX);
        local v36 = Range.RandomValueFromRange(Data.RotY);
        local v37 = Range.RandomValueFromRange(Data.RotZ);
        local v38 = Pivot2 * CFrame.Angles(math.rad(v35), math.rad(v36), (math.rad(v37)));

        if Data.VelocityVectored then
            v34 = v38[v33.vector] * v33.multiplier;
        end;

        local v39, v40;

        if Data.ParticleData.SpreadAngle.X > 0 or Data.ParticleData.SpreadAngle.Y > 0 then
            v39 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.X;
            v40 = (math.random() * 2 - 1) * Data.ParticleData.SpreadAngle.Y;
        else
            v39 = 0;
            v40 = 0;
        end;

        local CFrame_Angles_ret = CFrame.Angles(math.rad(v39), math.rad(v40), 0);
        local LookVector = (CFrame.lookAt(Vector3.new(), v34) * CFrame_Angles_ret).LookVector;
        local v41 = {
            RotSpeedX = Graph.GenerateSeed(Data.RotSpeedX),
            RotSpeedY = Graph.GenerateSeed(Data.RotSpeedY),
            RotSpeedZ = Graph.GenerateSeed(Data.RotSpeedZ),
            Speed = Graph.GenerateSeed(Data.Speed),
            Scale = Graph.GenerateSeed(Data.Scale)
        };
        local InvertMotion = Data.InvertMotion;
        local v42;

        if InvertMotion then
            v42 = p26:PreSimulateForward(Data, v41, v38, LookVector, CFrame_Angles_ret, v29, v31);
        else
            v42 = nil;
        end;

        local v43;

        if v29 then
            local v44 = v29:IsA("Attachment");
            local v45 = v44 and v29.WorldPosition or v29.Position;
            v43 = v44 and v29.WorldCFrame or v29.CFrame;

            if Data.LinkMode == "Follow" then
                v43 = CFrame.new(v45) or v43;
            end;
        else
            v43 = CFrame.new();
        end;

        if InvertMotion and v42 then
            v38 = v42[Data.TotalKeyFrames] or v42[0];
        elseif v29 then
            v38 = v43:ToObjectSpace(v38) or v38;
        end;

        RenderTemplate:PivotTo(v43 * v38);
        local v46 = {};

        for _, descendant in RenderTemplate:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                v46[descendant] = descendant.Size;
            end;
        end;

        local v47 = {
            Type = "Model",
            VisualPart = RenderTemplate,
            Link = v29,
            LinkMode = Data.LinkMode,
            StartTime = os.clock(),
            TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
            CurrentStep = 0,
            AccumulatedDT = 0,
            LifeTime = v31,
            PartLife = 0,
            CurrentPosition = RenderTemplate:GetPivot().Position,
            LocalCF = v38,
            BaseDirection = LookVector,
            EmissionDirection = Data.EmissionDirection,
            SpreadRotation = CFrame_Angles_ret,
            Acceleration = Data.ParticleData.Acceleration,
            Drag = Data.ParticleData.Drag,
            VelocityVectored = Data.VelocityVectored,
            InvertMotion = InvertMotion,
            SimLocalCFrames = v42,
            RotMode = Data.RotMode or "OverLife",
            AccRotX = 0,
            AccRotY = 0,
            AccRotZ = 0,
            NeedsFullIteration = Data.VelocityVectored
        };
        local v48;

        if Data.RotMode == "Speed" then
            v48 = not Data.VelocityVectored;
        else
            v48 = false;
        end;

        v47.NeedsRotAccum = v48;
        v47.HasDrag = Data.ParticleData.Drag ~= 0;
        v47.HasAccel = Data.ParticleData.Acceleration.Magnitude > 0;
        v47.PESnapshots = v46;
        v47.Graphs = {
            RotSpeedX = Data.RotSpeedX,
            RotSpeedY = Data.RotSpeedY,
            RotSpeedZ = Data.RotSpeedZ,
            Speed = Data.Speed,
            Scale = Data.Scale
        };
        v47.Seeds = v41;
        v47.IsAnimate = true;
        v47.AnimateLoop = v32;
        v47.AnimateItem = p27;
        v47.InitialWorldCF = Pivot;
        v47.InitialLocalCF = v38;
        local v49 = Graph.QueryPointsWithTime(0, v47.Graphs.Scale, v47.Seeds.Scale);
        RenderTemplate:ScaleTo(v49);

        for i, v in pairs(v46) do
            if i.Parent then
                i.Size = Graph.ScaleSequence(v, v49);
            end;
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

        table.insert(p26.ActiveEmits, v47);
        p26.ActiveAnimates[p27] = v47;

        for _, child in RenderTemplate:GetChildren() do
            if child:GetAttribute("Transformed") then
                p26:EnableEmit(child, RenderTemplate.PrimaryPart or RenderTemplate);
            end;
        end;
    end;
end;