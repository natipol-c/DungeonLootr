--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GetData
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.GetData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local Flipbook = require(script.Parent.Flipbook);
local TypeRegistry = require(script.Parent.TypeRegistry);

return function(p1) -- Line: 9
    -- upvalues: TypeRegistry (copy), Flipbook (copy)
    function p1.GetData(p2, p3) -- Line: 11
        -- upvalues: TypeRegistry (ref), Flipbook (ref)
        local v4 = {};
        local Config = TypeRegistry.getConfig(p3);

        if not Config then
            return nil;
        end;

        local EmitParent = p3:FindFirstChild("EmitParent");
        v4.EmitParent = EmitParent and (EmitParent:IsA("ObjectValue") and EmitParent.Value) or nil;
        local Link = p3:FindFirstChild("Link");
        v4.Link = Link and (Link:IsA("ObjectValue") and Link.Value) or nil;
        v4.LinkMode = p3:GetAttribute("LinkMode") or "Weld";
        v4.RenderTemplate = p3:FindFirstChild("RenderTemplate");
        local v5 = Config:GetAttribute("TotalKeyFrames") or 0;
        v4.TotalKeyFrames = v5 > 0 and v5 and v5 or 100;

        function v4.CheckEnabled() -- Line: 33
            -- upvalues: Config (copy)
            local v6;

            if Config.Parent == nil then
                v6 = false;
            else
                v6 = Config:GetAttribute("Enabled") == true;
            end;

            return v6;
        end;

        if p3:IsA("Model") then
            v4.PartLife = Config:GetAttribute("PartLife") or 0;
            v4.VelocityVectored = Config:GetAttribute("VelocityVectored") or false;
            v4.InvertMotion = Config:GetAttribute("InvertMotion") or false;
            v4.RotMode = Config:GetAttribute("RotMode") or "OverLife";
            v4.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v4.Rate = Config:GetAttribute("Rate") or 10;
            local Attribute = Config:GetAttribute("EmissionDirection");
            v4.EmissionDirection = Attribute and Enum.NormalId[Attribute] or Enum.NormalId.Top;
            v4.ParticleData = {
                SpreadAngle = Config:GetAttribute("SpreadAngle") or Vector2.new(0, 0),
                Acceleration = Config:GetAttribute("Acceleration") or Vector3.new(0, 0, 0),
                Drag = Config:GetAttribute("Drag") or 0
            };
            v4.Speed = Config:GetAttribute("Speed");
            v4.Scale = Config:GetAttribute("Scale");
            v4.RotX = Config:GetAttribute("RotX");
            v4.RotY = Config:GetAttribute("RotY");
            v4.RotZ = Config:GetAttribute("RotZ");
            v4.RotSpeedX = Config:GetAttribute("RotSpeedX");
            v4.RotSpeedY = Config:GetAttribute("RotSpeedY");
            v4.RotSpeedZ = Config:GetAttribute("RotSpeedZ");

            return v4;
        end;

        if p3:IsA("PointLight") then
            v4.PartLife = 0;
            v4.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v4.Rate = Config:GetAttribute("Rate") or 10;
            v4.PLRange = Config:GetAttribute("PLRange");
            v4.PLBrightness = Config:GetAttribute("PLBrightness");
            v4.PLColor = Config:GetAttribute("PLColor");

            return v4;
        end;

        if p3:IsA("Attachment") then
            v4.PartLife = Config:GetAttribute("PartLife") or 0;
            v4.VelocityVectored = Config:GetAttribute("VelocityVectored") or false;
            v4.InvertMotion = Config:GetAttribute("InvertMotion") or false;
            v4.RotMode = Config:GetAttribute("RotMode") or "OverLife";
            v4.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
            v4.Rate = Config:GetAttribute("Rate") or 10;
            local Attribute = Config:GetAttribute("EmissionDirection");
            v4.EmissionDirection = Attribute and Enum.NormalId[Attribute] or Enum.NormalId.Top;
            v4.ParticleData = {
                SpreadAngle = Config:GetAttribute("SpreadAngle") or Vector2.new(0, 0),
                Acceleration = Config:GetAttribute("Acceleration") or Vector3.new(0, 0, 0),
                Drag = Config:GetAttribute("Drag") or 0
            };
            v4.Speed = Config:GetAttribute("Speed");
            v4.RotX = Config:GetAttribute("RotX");
            v4.RotY = Config:GetAttribute("RotY");
            v4.RotZ = Config:GetAttribute("RotZ");
            v4.RotSpeedX = Config:GetAttribute("RotSpeedX");
            v4.RotSpeedY = Config:GetAttribute("RotSpeedY");
            v4.RotSpeedZ = Config:GetAttribute("RotSpeedZ");

            return v4;
        end;

        v4.PartLife = Config:GetAttribute("PartLife") or 0;

        if p3:IsA("Beam") then
            v4.GraphBlender = p3:FindFirstChild("GraphBlender");
            v4.Lifetime = Config:GetAttribute("BeamLifetime") or NumberRange.new(1);
            v4.Rate = Config:GetAttribute("Rate") or 10;
            v4.BeamFlipbooks = p3:FindFirstChild("BeamFlipbooks");
            local v7 = {};
            local v8;

            if Config:GetAttribute("BeamFlipbookMode") then
                v8 = Enum.ParticleFlipbookMode[Config:GetAttribute("BeamFlipbookMode")] or nil;
            else
                v8 = nil;
            end;

            v7.FlipbookMode = v8;
            v7.FlipbookFramerate = Config:GetAttribute("BeamFlipbookFramerate") or nil;
            v7.FlipbookStartRandom = Config:GetAttribute("BeamFlipbookStartRandom") or false;
            v4.FlipbookParticle = v7;

            if v4.BeamFlipbooks then
                v4.CachedBeamTextures = Flipbook.GetSortedBeamTextures(v4.BeamFlipbooks);
            end;

            v4.FaceCamera = Config:GetAttribute("FaceCamera");
            v4.BeamProps = {
                Brightness = Config:GetAttribute("BeamBrightness"),
                CurveSize0 = Config:GetAttribute("CurveSize0"),
                CurveSize1 = Config:GetAttribute("CurveSize1"),
                Width0 = Config:GetAttribute("Width0"),
                Width1 = Config:GetAttribute("Width1"),
                LightEmission = Config:GetAttribute("LightEmission"),
                Segments = Config:GetAttribute("Segments"),
                TextureLength = Config:GetAttribute("TextureLength"),
                TextureSpeed = Config:GetAttribute("TextureSpeed")
            };

            return v4;
        end;

        v4.MeshFlipbooks = p3:FindFirstChild("MeshFlipbooks");

        if v4.MeshFlipbooks then
            v4.CachedMeshTextures = Flipbook.GetSortedTextures(v4.MeshFlipbooks);
        end;

        v4.VelocityVectored = Config:GetAttribute("VelocityVectored") or false;
        v4.InvertMotion = Config:GetAttribute("InvertMotion") or false;
        v4.RotMode = Config:GetAttribute("RotMode") or "OverLife";
        v4.Lifetime = Config:GetAttribute("Lifetime") or NumberRange.new(1);
        v4.Rate = Config:GetAttribute("Rate") or 10;
        local Attribute = Config:GetAttribute("Shape");
        local Attribute2 = Config:GetAttribute("ShapeInOut");
        local Attribute3 = Config:GetAttribute("ShapeStyle");
        local Attribute4 = Config:GetAttribute("EmissionDirection");
        v4.Shape = Attribute and Enum.ParticleEmitterShape[Attribute] or Enum.ParticleEmitterShape.Box;
        v4.ShapeInOut = Attribute2 and Enum.ParticleEmitterShapeInOut[Attribute2] or Enum.ParticleEmitterShapeInOut.Outward;
        v4.ShapeStyle = Attribute3 and Enum.ParticleEmitterShapeStyle[Attribute3] or Enum.ParticleEmitterShapeStyle.Volume;
        v4.EmissionDirection = Attribute4 and Enum.NormalId[Attribute4] or Enum.NormalId.Top;
        local v9 = {
            Shape = v4.Shape,
            ShapeInOut = v4.ShapeInOut,
            ShapeStyle = v4.ShapeStyle,
            ShapePartial = Config:GetAttribute("ShapePartial") or 0,
            EmissionDirection = v4.EmissionDirection,
            SpreadAngle = Config:GetAttribute("SpreadAngle") or Vector2.new(0, 0),
            Acceleration = Config:GetAttribute("Acceleration") or Vector3.new(0, 0, 0),
            Drag = Config:GetAttribute("Drag") or 0
        };
        local v10;

        if Config:GetAttribute("FlipbookMode") then
            v10 = Enum.ParticleFlipbookMode[Config:GetAttribute("FlipbookMode")] or nil;
        else
            v10 = nil;
        end;

        v9.FlipbookMode = v10;
        v9.FlipbookFramerate = Config:GetAttribute("FlipbookFramerate") or nil;
        v9.FlipbookStartRandom = Config:GetAttribute("FlipbookStartRandom") or false;
        v4.ParticleData = v9;
        v4.Transparency = Config:GetAttribute("Transparency");
        v4.Color = Config:GetAttribute("Color");
        v4.Speed = Config:GetAttribute("Speed");
        v4.Brightness = Config:GetAttribute("Brightness");
        v4.SizeX = Config:GetAttribute("SizeX");
        v4.SizeY = Config:GetAttribute("SizeY");
        v4.SizeZ = Config:GetAttribute("SizeZ");
        v4.RotX = Config:GetAttribute("RotX");
        v4.RotY = Config:GetAttribute("RotY");
        v4.RotZ = Config:GetAttribute("RotZ");
        v4.RotSpeedX = Config:GetAttribute("RotSpeedX");
        v4.RotSpeedY = Config:GetAttribute("RotSpeedY");
        v4.RotSpeedZ = Config:GetAttribute("RotSpeedZ");

        return v4;
    end;
end;