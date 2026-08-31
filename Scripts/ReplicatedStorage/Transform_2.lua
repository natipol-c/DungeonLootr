--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Transform
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.Transform
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local TypeRegistry = require(script.Parent.TypeRegistry);
local DirectionVectors = require(script.Parent.PartConstants).DirectionVectors;

return function(p1) -- Line: 11
    -- upvalues: TypeRegistry (copy), Graph (copy), DirectionVectors (copy)
    function p1.Transform(p2, p3) -- Line: 13
        -- upvalues: TypeRegistry (ref)
        local TypeFor = TypeRegistry.getTypeFor(p3);

        if not TypeFor or TypeFor.directAccess then
            return;
        end;

        if p3:IsA("Model") then
            if p3.PrimaryPart then
                return p2:TransformModel(p3, TypeFor);
            end;

            warn("Part-Icles: Model requires PrimaryPart");

            return;
        end;

        local v4 = TypeRegistry.createConfig(p3, TypeFor);
        local v5 = p3:Clone();
        v5.Name = "RenderTemplate";

        for _, child in v5:GetChildren() do
            if not (child:GetAttribute("Transformed") or child:IsA("Attachment")) then
                if child.Name == TypeRegistry.CONFIG_NAME or (child.Name == "EmitParent" or child.Name == "Link") then
                    child:Destroy();
                elseif p3:IsA("PointLight") then
                    child:Destroy();
                elseif p3:IsA("Attachment") then
                    if child.Name == "MeshFlipbooks" or (child.Name == "BeamFlipbooks" or child.Name == "GraphBlender") then
                        child:Destroy();
                    end;
                elseif not (child:IsA("SpecialMesh") or (child:IsA("Decal") or child:IsA("Texture"))) then
                    child:Destroy();
                end;
            end;
        end;

        for i, _ in pairs(v5:GetAttributes()) do
            v5:SetAttribute(i, nil);
        end;

        if v5:IsA("BasePart") then
            v5.Anchored = true;
            v5.CanCollide = false;
            v5.CanQuery = false;
            v5.CanTouch = false;
            v5.CastShadow = false;
            v5.Massless = true;
            v5.Transparency = 1;

            for _, child in ipairs(v5:GetChildren()) do
                if child:IsA("Decal") or child:IsA("Texture") then
                    child.Transparency = 1;
                end;
            end;
        end;

        if v5:IsA("Attachment") then
            v5.CFrame = CFrame.new();
        end;

        v5.Parent = p3;

        if p3:IsA("BasePart") then
            for _, child in ipairs(p3:GetChildren()) do
                if child ~= v5 and (child:IsA("SpecialMesh") or (child:IsA("Decal") or child:IsA("Texture"))) then
                    child:Destroy();
                end;
            end;

            p3.Transparency = 1;
        elseif p3:IsA("PointLight") then
            p3.Enabled = false;
        end;

        if p3:IsA("BasePart") and not (p3:IsA("Terrain") or p3:FindFirstChild("MeshFlipbooks")) then
            local Folder = Instance.new("Folder");
            Folder.Name = "MeshFlipbooks";
            Folder.Parent = p3;
        end;

        if p3:IsA("Beam") then
            p3.Enabled = false;

            if v5:IsA("Beam") then
                v5.Enabled = false;
            end;

            if not p3:FindFirstChild("BeamFlipbooks") then
                local Folder = Instance.new("Folder");
                Folder.Name = "BeamFlipbooks";
                Folder.Parent = p3;
            end;

            v4:SetAttribute("BeamBrightness", NumberSequence.new(p3.Brightness));
            v4:SetAttribute("CurveSize0", NumberSequence.new(p3.CurveSize0));
            v4:SetAttribute("CurveSize1", NumberSequence.new(p3.CurveSize1));
            v4:SetAttribute("Width0", NumberSequence.new(p3.Width0));
            v4:SetAttribute("Width1", NumberSequence.new(p3.Width1));
            v4:SetAttribute("LightEmission", NumberSequence.new(p3.LightEmission));
            v4:SetAttribute("Segments", NumberSequence.new(p3.Segments));
            v4:SetAttribute("TextureLength", NumberSequence.new(p3.TextureLength));
            v4:SetAttribute("TextureSpeed", NumberSequence.new(p3.TextureSpeed));
            v4:SetAttribute("FaceCamera", p3.FaceCamera);
            local Folder = Instance.new("Folder");
            Folder.Name = "GraphBlender";
            local Configuration = Instance.new("Configuration");
            Configuration.Name = "1";
            Configuration:SetAttribute("Time", 0);
            Configuration:SetAttribute("Transparency", p3.Transparency);
            Configuration:SetAttribute("Color", p3.Color);
            Configuration.Parent = Folder;
            Folder.Parent = p3;
        end;

        if not p3:FindFirstChild("EmitParent") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "EmitParent";
            ObjectValue.Value = nil;
            ObjectValue.Parent = p3;
        end;

        if (p3:IsA("BasePart") or p3:IsA("Attachment")) and not p3:FindFirstChild("Link") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Link";
            ObjectValue.Value = nil;
            ObjectValue.Parent = p3;
        end;

        p3:SetAttribute("Transformed", true);
        p3:SetAttribute("Qwinkle", true);
        p3:SetAttribute("EmitCount", p3:IsA("Beam") and 1 or 0);
        p3:SetAttribute("EmitDuration", 0);
        p3:SetAttribute("EmitDelay", 0);
        p3:SetAttribute("IsEmitter", true);
        p3:SetAttribute("EmissionMode", "Emit");
        p3:SetAttribute("AnimateLoop", false);
        p3:SetAttribute("LinkMode", "Weld");
    end;

    function p1.PreSimulateForward(p6, p7, p8, p9, p10, p11, p12, p13) -- Line: 143
        -- upvalues: Graph (ref), DirectionVectors (ref)
        local v14 = p12 and (p12:IsA("Attachment") and p12.WorldCFrame or p12.CFrame) or CFrame.new();
        local math_max_ret = math.max(1, p7.TotalKeyFrames);
        local v15 = p13 / math_max_ret;
        local _ = p9.Position;
        local v16 = v14:ToObjectSpace(p9);
        local EmissionDirection = p7.EmissionDirection;
        local v17 = p7.RotMode or "OverLife";
        local v18 = { v14:ToObjectSpace(p9) };
        local v19 = 0;
        local v20 = 0;
        local v21 = 0;

        for i = 1, math_max_ret do
            local v22 = i / math_max_ret;
            local v23 = v22 * p13;
            local v24 = v14:VectorToObjectSpace((p10 * (Graph.QueryPointsWithTime(v22, p7.Speed, p8.Speed) * math.exp(-p7.ParticleData.Drag * v23)) + p7.ParticleData.Acceleration * v23) * v15);
            v16 = CFrame.new(v24) * v16;
            local v25 = Graph.QueryPointsWithTime(v22, p7.RotSpeedX, p8.RotSpeedX);
            local v26 = Graph.QueryPointsWithTime(v22, p7.RotSpeedY, p8.RotSpeedY);
            local v27 = Graph.QueryPointsWithTime(v22, p7.RotSpeedZ, p8.RotSpeedZ);
            local v28;

            if v17 == "Speed" then
                v19 = v19 + v25 * v15;
                v20 = v20 + v26 * v15;
                v21 = v21 + v27 * v15;
                v28 = CFrame.Angles(math.rad(v19), math.rad(v20), (math.rad(v21)));
            else
                v28 = CFrame.Angles(math.rad(v25), math.rad(v26), (math.rad(v27)));
            end;

            local v29 = v14 * v16 * v28;
            local _ = v29.Position;

            if p7.VelocityVectored then
                local v30 = DirectionVectors[EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                p10 = (v29 * p11)[v30.vector] * v30.multiplier;
            end;

            v18[i] = v14:ToObjectSpace(v29);
            local _ = i;
        end;

        return v18;
    end;

    function p1.PreSimulateAttachmentForward(p31, p32, p33, p34, p35, p36, p37) -- Line: 207
        -- upvalues: Graph (ref), DirectionVectors (ref)
        local math_max_ret = math.max(1, p32.TotalKeyFrames);
        local v38 = p37 / math_max_ret;
        local EmissionDirection = p32.EmissionDirection;
        local v39 = p32.RotMode or "OverLife";
        local v40 = { p34 };
        local v41 = 0;
        local v42 = 0;
        local v43 = 0;

        for i = 1, math_max_ret do
            local v44 = i / math_max_ret;
            local v45 = v44 * p37;
            local v46 = Graph.QueryPointsWithTime(v44, p32.Speed, p33.Speed) * math.exp(-p32.ParticleData.Drag * v45);
            p34 = CFrame.new((p35 * v46 + p32.ParticleData.Acceleration * v45) * v38) * p34;
            local v47 = Graph.QueryPointsWithTime(v44, p32.RotSpeedX, p33.RotSpeedX);
            local v48 = Graph.QueryPointsWithTime(v44, p32.RotSpeedY, p33.RotSpeedY);
            local v49 = Graph.QueryPointsWithTime(v44, p32.RotSpeedZ, p33.RotSpeedZ);
            local v50;

            if v39 == "Speed" then
                v41 = v41 + v47 * v38;
                v42 = v42 + v48 * v38;
                v43 = v43 + v49 * v38;
                v50 = CFrame.Angles(math.rad(v41), math.rad(v42), (math.rad(v43)));
            else
                v50 = CFrame.Angles(math.rad(v47), math.rad(v48), (math.rad(v49)));
            end;

            local v51 = p34 * v50;

            if p32.VelocityVectored then
                local v52 = DirectionVectors[EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                p35 = (v51 * p36)[v52.vector] * v52.multiplier;
            end;

            v40[i] = v51;
            local _ = i;
        end;

        return v40;
    end;

    function p1.TransformModel(p53, p54, p55) -- Line: 261
        -- upvalues: TypeRegistry (ref)
        TypeRegistry.createConfig(p54, p55);
        local v56 = p54:Clone();
        v56.Name = "RenderTemplate";

        for _, child in v56:GetChildren() do
            if child.Name == TypeRegistry.CONFIG_NAME or (child.Name == "EmitParent" or child.Name == "Link") then
                child:Destroy();
            end;
        end;

        for _, v in ipairs({ "Transformed", "Qwinkle", "IsEmitter", "EmitCount", "EmitDuration", "EmitDelay", "EmissionMode", "AnimateLoop" }) do
            v56:SetAttribute(v, nil);
        end;

        for _, descendant in v56:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.CastShadow = false;
                descendant.Massless = true;
            end;
        end;

        v56.Parent = p54;

        for _, descendant in ipairs(p54:GetDescendants()) do
            if not descendant:IsDescendantOf(v56) then
                if descendant:IsA("BasePart") then
                    descendant.Transparency = 1;
                elseif descendant:IsA("SpecialMesh") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                    descendant:Destroy();
                end;
            end;
        end;

        if not p54:FindFirstChild("EmitParent") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "EmitParent";
            ObjectValue.Value = nil;
            ObjectValue.Parent = p54;
        end;

        if not p54:FindFirstChild("Link") then
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Link";
            ObjectValue.Value = nil;
            ObjectValue.Parent = p54;
        end;

        p54:SetAttribute("Transformed", true);
        p54:SetAttribute("Qwinkle", true);
        p54:SetAttribute("EmitCount", 0);
        p54:SetAttribute("EmitDuration", 0);
        p54:SetAttribute("EmitDelay", 0);
        p54:SetAttribute("IsEmitter", true);
        p54:SetAttribute("EmissionMode", "Emit");
        p54:SetAttribute("AnimateLoop", false);
        p54:SetAttribute("LinkMode", "Weld");
    end;
end;