--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TypeData
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles.TypeRegistry.TypeData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {
    PartProperties = {
        Brightness = {
            type = "NumberSequence",
            default = NumberSequence.new(1)
        },
        Color = {
            type = "ColorSequence",
            default = ColorSequence.new(Color3.new(1, 1, 1))
        },
        SizeX = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        SizeY = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        SizeZ = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        Transparency = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        Speed = {
            type = "NumberSequence",
            default = NumberSequence.new(5)
        },
        RotSpeedX = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        RotSpeedY = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        RotSpeedZ = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        Lifetime = {
            type = "NumberRange",
            default = NumberRange.new(1)
        },
        Rate = {
            type = "number",
            default = 10
        },
        Drag = {
            type = "number",
            default = 0
        },
        Acceleration = {
            type = "Vector3",
            default = Vector3.new(0, 0, 0)
        },
        SpreadAngle = {
            type = "Vector2",
            default = Vector2.new(0, 0)
        },
        RotX = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotY = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotZ = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotMode = {
            type = "string",
            default = "OverLife"
        },
        TotalKeyFrames = {
            type = "number",
            default = 100
        },
        PartLife = {
            type = "number",
            default = 0
        },
        ShapePartial = {
            type = "number",
            default = 0
        },
        VelocityVectored = {
            type = "boolean",
            default = false
        },
        InvertMotion = {
            type = "boolean",
            default = false
        },
        Enabled = {
            type = "boolean",
            default = false
        },
        Shape = {
            type = "enum",
            enumType = "ParticleEmitterShape",
            default = Enum.ParticleEmitterShape.Box
        },
        ShapeInOut = {
            type = "enum",
            enumType = "ParticleEmitterShapeInOut",
            default = Enum.ParticleEmitterShapeInOut.Outward
        },
        ShapeStyle = {
            type = "enum",
            enumType = "ParticleEmitterShapeStyle",
            default = Enum.ParticleEmitterShapeStyle.Volume
        },
        EmissionDirection = {
            type = "enum",
            enumType = "NormalId",
            default = Enum.NormalId.Top
        },
        FlipbookMode = {
            type = "enum",
            enumType = "ParticleFlipbookMode",
            default = Enum.ParticleFlipbookMode.OneShot
        },
        FlipbookFramerate = {
            type = "NumberRange",
            default = NumberRange.new(1)
        },
        FlipbookStartRandom = {
            type = "boolean",
            default = false
        }
    },
    BeamProperties = {
        Brightness = {
            type = "NumberSequence",
            attrName = "BeamBrightness",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        Width0 = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        Width1 = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        CurveSize0 = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        CurveSize1 = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        LightEmission = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        Segments = {
            type = "NumberSequence",
            default = NumberSequence.new(10)
        },
        TextureLength = {
            type = "NumberSequence",
            default = NumberSequence.new(1)
        },
        TextureSpeed = {
            type = "NumberSequence",
            default = NumberSequence.new(1)
        },
        Lifetime = {
            type = "NumberRange",
            attrName = "BeamLifetime",
            default = NumberRange.new(1)
        },
        Rate = {
            type = "number",
            default = 10
        },
        TotalKeyFrames = {
            type = "number",
            default = 100
        },
        Enabled = {
            type = "boolean",
            default = false
        },
        FaceCamera = {
            type = "boolean",
            default = false
        },
        FlipbookMode = {
            type = "enum",
            enumType = "ParticleFlipbookMode",
            attrName = "BeamFlipbookMode",
            default = Enum.ParticleFlipbookMode.OneShot
        },
        FlipbookFramerate = {
            type = "NumberRange",
            attrName = "BeamFlipbookFramerate",
            default = NumberRange.new(1)
        },
        FlipbookStartRandom = {
            type = "boolean",
            default = false,
            attrName = "BeamFlipbookStartRandom"
        }
    },
    PointLightProperties = {
        Range = {
            type = "NumberSequence",
            attrName = "PLRange",
            nonNegative = true,
            default = NumberSequence.new(8)
        },
        Brightness = {
            type = "NumberSequence",
            attrName = "PLBrightness",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        Color = {
            type = "ColorSequence",
            attrName = "PLColor",
            default = ColorSequence.new(Color3.new(1, 1, 1))
        },
        Lifetime = {
            type = "NumberRange",
            default = NumberRange.new(1)
        },
        Rate = {
            type = "number",
            default = 10
        },
        TotalKeyFrames = {
            type = "number",
            default = 100
        },
        Enabled = {
            type = "boolean",
            default = false
        }
    },
    TrailProperties = {
        Transparency = {
            type = "NumberSequence",
            default = NumberSequence.new(0.5)
        },
        WidthScale = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        Color = {
            type = "ColorSequence",
            default = ColorSequence.new(Color3.new(1, 1, 1))
        },
        Brightness = {
            type = "number",
            default = 1
        },
        LightEmission = {
            type = "number",
            default = 0
        },
        LightInfluence = {
            type = "number",
            default = 1
        },
        TextureLength = {
            type = "number",
            default = 1
        },
        Lifetime = {
            type = "number",
            default = 2
        },
        MinLength = {
            type = "number",
            default = 0.1
        },
        MaxLength = {
            type = "number",
            default = 0
        },
        Duration = {
            type = "string",
            default = "2",
            attribute = true,
            attrName = "EmitDuration"
        },
        Enabled = {
            type = "boolean",
            default = true
        },
        FaceCamera = {
            type = "boolean",
            default = false
        },
        TextureMode = {
            type = "enum",
            enumType = "TextureMode",
            default = Enum.TextureMode.Stretch
        }
    },
    AttachmentProperties = {
        Speed = {
            type = "NumberSequence",
            default = NumberSequence.new(5)
        },
        RotSpeedX = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        RotSpeedY = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        RotSpeedZ = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        Lifetime = {
            type = "NumberRange",
            default = NumberRange.new(1)
        },
        Rate = {
            type = "number",
            default = 10
        },
        Drag = {
            type = "number",
            default = 0
        },
        Acceleration = {
            type = "Vector3",
            default = Vector3.new(0, 0, 0)
        },
        SpreadAngle = {
            type = "Vector2",
            default = Vector2.new(0, 0)
        },
        RotX = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotY = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotZ = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotMode = {
            type = "string",
            default = "OverLife"
        },
        TotalKeyFrames = {
            type = "number",
            default = 100
        },
        PartLife = {
            type = "number",
            default = 0
        },
        VelocityVectored = {
            type = "boolean",
            default = false
        },
        InvertMotion = {
            type = "boolean",
            default = false
        },
        Enabled = {
            type = "boolean",
            default = false
        },
        EmissionDirection = {
            type = "enum",
            enumType = "NormalId",
            default = Enum.NormalId.Top
        }
    },
    ModelProperties = {
        Speed = {
            type = "NumberSequence",
            default = NumberSequence.new(5)
        },
        RotSpeedX = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        RotSpeedY = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        RotSpeedZ = {
            type = "NumberSequence",
            default = NumberSequence.new(0)
        },
        Scale = {
            type = "NumberSequence",
            nonNegative = true,
            default = NumberSequence.new(1)
        },
        Lifetime = {
            type = "NumberRange",
            default = NumberRange.new(1)
        },
        Rate = {
            type = "number",
            default = 10
        },
        Drag = {
            type = "number",
            default = 0
        },
        Acceleration = {
            type = "Vector3",
            default = Vector3.new(0, 0, 0)
        },
        SpreadAngle = {
            type = "Vector2",
            default = Vector2.new(0, 0)
        },
        RotX = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotY = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotZ = {
            type = "NumberRange",
            default = NumberRange.new(0)
        },
        RotMode = {
            type = "string",
            default = "OverLife"
        },
        TotalKeyFrames = {
            type = "number",
            default = 100
        },
        PartLife = {
            type = "number",
            default = 0
        },
        VelocityVectored = {
            type = "boolean",
            default = false
        },
        InvertMotion = {
            type = "boolean",
            default = false
        },
        Enabled = {
            type = "boolean",
            default = false
        },
        EmissionDirection = {
            type = "enum",
            enumType = "NormalId",
            default = Enum.NormalId.Top
        }
    }
};
v1.Types = {
    Part = {
        pDataType = "Part",
        uiSection = "Meshes",

        classCheck = function(p2) -- Line: 202, Name: classCheck
            return p2:IsA("BasePart");
        end,

        properties = v1.PartProperties,
        resize = {
            scaleGraphs = { "SizeX", "SizeY", "SizeZ", "Speed" },
            scaleVectors = { "Acceleration" }
        },
        retime = {
            multiplyNumbers = { "Rate", "Drag" },
            divideRanges = { "Lifetime", "FlipbookFramerate" },
            multiplyGraphs = { "Speed", "RotSpeedX", "RotSpeedY", "RotSpeedZ" },
            scaleVectors = { "Acceleration" }
        },
        clipboard = { {
                name = "Spawning",
                props = { "Rate", "Lifetime", "SpreadAngle", "EmissionDirection" }
            }, {
                name = "Appearance",
                props = { "Brightness", "Color", "SizeX", "SizeY", "SizeZ", "Transparency", "Material" }
            }, {
                name = "Movement",
                props = { "Speed", "RotMode", "RotSpeedX", "RotSpeedY", "RotSpeedZ", "Acceleration", "Drag", "VelocityVectored", "InvertMotion" }
            }, {
                name = "Shape",
                props = { "Shape", "ShapeInOut", "ShapeStyle", "ShapePartial" }
            }, {
                name = "Flipbook",
                props = { "FlipbookMode", "FlipbookFramerate", "FlipbookStartRandom" }
            }, {
                name = "Advanced",
                props = { "TotalKeyFrames", "PartLife", "RotX", "RotY", "RotZ" }
            } }
    },
    Beam = {
        pDataType = "Beam",
        uiSection = "Beams",

        classCheck = function(p3) -- Line: 228, Name: classCheck
            return p3:IsA("Beam");
        end,

        properties = v1.BeamProperties,
        resize = {
            scaleGraphs = { "Width0", "Width1" }
        },
        retime = {
            multiplyNumbers = { "Rate" },
            divideRanges = { "Lifetime", "FlipbookFramerate" },
            multiplyGraphs = { "TextureSpeed" }
        },
        clipboard = { {
                name = "Spawning",
                props = { "Rate", "Lifetime" }
            }, {
                name = "Appearance",
                props = { "Brightness", "Width0", "Width1", "LightEmission" }
            }, {
                name = "Geometry",
                props = { "CurveSize0", "CurveSize1", "Segments", "TextureLength", "TextureSpeed", "FaceCamera" }
            }, {
                name = "Flipbook",
                props = { "FlipbookMode", "FlipbookFramerate", "FlipbookStartRandom" }
            }, {
                name = "Advanced",
                props = { "TotalKeyFrames" }
            }, {
                name = "Blender",
                props = { "Blender" }
            } }
    },
    PointLight = {
        pDataType = "PointLight",
        uiSection = "PointLights",

        classCheck = function(p4) -- Line: 252, Name: classCheck
            return p4:IsA("PointLight");
        end,

        properties = v1.PointLightProperties,
        resize = {
            scaleGraphs = { "Range" }
        },
        retime = {
            multiplyNumbers = { "Rate" },
            divideRanges = { "Lifetime" }
        },
        clipboard = { {
                name = "Spawning",
                props = { "Rate", "Lifetime" }
            }, {
                name = "Appearance",
                props = { "Range", "Brightness", "Color" }
            }, {
                name = "Advanced",
                props = { "TotalKeyFrames" }
            } }
    },
    Trail = {
        pDataType = "Trail",
        uiSection = "Trails",
        directAccess = true,

        classCheck = function(p5) -- Line: 272, Name: classCheck
            return p5:IsA("Trail");
        end,

        properties = v1.TrailProperties,
        resize = {
            scaleGraphs = { "WidthScale" }
        },
        retime = {
            divideNumbers = { "Lifetime" }
        },
        clipboard = { {
                name = "Emission",
                props = { "Duration", "Lifetime" }
            }, {
                name = "Appearance",
                props = { "Brightness", "Transparency", "Color", "WidthScale", "LightEmission", "LightInfluence" }
            }, {
                name = "Geometry",
                props = { "MinLength", "MaxLength", "TextureLength", "TextureMode", "FaceCamera" }
            } }
    },
    Attachment = {
        pDataType = "Attachment",
        uiSection = "Attachments",

        classCheck = function(p6) -- Line: 292, Name: classCheck
            return p6:IsA("Attachment");
        end,

        properties = v1.AttachmentProperties,
        resize = {
            scaleGraphs = { "Speed" },
            scaleVectors = { "Acceleration" }
        },
        retime = {
            multiplyNumbers = { "Rate", "Drag" },
            divideRanges = { "Lifetime" },
            multiplyGraphs = { "Speed", "RotSpeedX", "RotSpeedY", "RotSpeedZ" },
            scaleVectors = { "Acceleration" }
        },
        clipboard = { {
                name = "Spawning",
                props = { "Rate", "Lifetime", "SpreadAngle", "EmissionDirection" }
            }, {
                name = "Movement",
                props = { "Speed", "RotMode", "RotSpeedX", "RotSpeedY", "RotSpeedZ", "Acceleration", "Drag", "VelocityVectored", "InvertMotion" }
            }, {
                name = "Advanced",
                props = { "TotalKeyFrames", "PartLife", "RotX", "RotY", "RotZ" }
            } }
    },
    Model = {
        pDataType = "Model",
        uiSection = "Models",

        classCheck = function(p7) -- Line: 315, Name: classCheck
            return p7:IsA("Model");
        end,

        properties = v1.ModelProperties,
        resize = {
            scaleGraphs = { "Speed", "Scale" },
            scaleVectors = { "Acceleration" }
        },
        retime = {
            multiplyNumbers = { "Rate", "Drag" },
            divideRanges = { "Lifetime" },
            multiplyGraphs = { "Speed", "RotSpeedX", "RotSpeedY", "RotSpeedZ" },
            scaleVectors = { "Acceleration" }
        },
        clipboard = { {
                name = "Spawning",
                props = { "Rate", "Lifetime", "SpreadAngle", "EmissionDirection" }
            }, {
                name = "Scale",
                props = { "Scale" }
            }, {
                name = "Movement",
                props = { "Speed", "RotMode", "RotSpeedX", "RotSpeedY", "RotSpeedZ", "Acceleration", "Drag", "VelocityVectored", "InvertMotion" }
            }, {
                name = "Advanced",
                props = { "TotalKeyFrames", "PartLife", "RotX", "RotY", "RotZ" }
            } }
    }
};

return v1;