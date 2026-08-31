--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     resize
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.resize
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("./utility");
local u6 = {
    apply = function(p2: userdata, p3: number) -- Line: 5, Name: apply
        -- upvalues: u1 (copy)
        if p2:IsA("ParticleEmitter") then
            p2.Size = u1.scaleNumberSequence(p2.Size, p3);
            p2.Speed = NumberRange.new(p2.Speed.Min * p3, p2.Speed.Max * p3);
            p2.Acceleration = p2.Acceleration * p3;

            return;
        end;

        if not p2:IsA("Beam") then
            if p2:IsA("Trail") then
                u1.scaleAttachmentDistance(p2.Attachment0, p2.Attachment1, p3);

                return;
            end;

            if not p2:IsA("Sound") then
                if p2:IsA("Model") then
                    if not u1.isMeshVFX(p2) then
                        u1.scaleAttribute(p2, p3, "Scale_Start");
                        u1.scaleAttribute(p2, p3, "Scale_End");

                        return;
                    end;

                    local Start = p2:FindFirstChild("Start");
                    local End = p2:FindFirstChild("End");

                    if Start and End then
                        Start.Size = Start.Size * p3;
                        End.Size = End.Size * p3;
                        local v4 = Start:FindFirstChildOfClass("SpecialMesh");
                        local v5 = End:FindFirstChildOfClass("SpecialMesh");

                        if v4 and v5 then
                            v4.Scale = v4.Scale * p3;
                            v5.Scale = v5.Scale * p3;

                            return;
                        end;
                    end;
                else
                    if p2:IsA("Attachment") and p2:HasTag(u1.LIGHTNING_TAG) then
                        u1.scaleAttribute(p2, p3, "OffsetScale");
                        u1.scaleAttribute(p2, p3, "Width_Start");
                        u1.scaleAttribute(p2, p3, "Width_End");

                        return;
                    end;

                    if p2:IsA("BasePart") and (p2.Parent and u1.findFirstClassWithTag(p2.Parent, "Attachment", u1.SHOCKWAVE_TAG)) then
                        u1.scaleAttribute(p2, p3, "Radius");
                        u1.scaleAttribute(p2, p3, "Length");
                        u1.scaleAttribute(p2, p3, "MinSize");
                        u1.scaleAttribute(p2, p3, "MaxSize");

                        if p2:GetAttribute("LinearMagnitude") then
                            p2.Size = p2.Size * p3;
                            u1.scaleAttribute(p2, p3, "LinearMagnitude");
                            u1.scaleAttribute(p2, p3, "AngularMagnitude");

                            return;
                        end;
                    elseif p2:IsA("RayValue") and p2:HasTag(u1.SCREENSHAKE_TAG) then
                        u1.scaleAttribute(p2, p3, "Falloff");
                    end;
                end;

                return;
            end;

            p2.RollOffMinDistance = p2.RollOffMinDistance * p3;
            p2.RollOffMaxDistance = p2.RollOffMaxDistance * p3;
            u1.scaleAttribute(p2, p3, "RollOff_Start");
            u1.scaleAttribute(p2, p3, "RollOff_End");

            return;
        end;

        u1.scaleAttribute(p2, p3, "Width0_Start");
        u1.scaleAttribute(p2, p3, "Width1_Start");
        u1.scaleAttribute(p2, p3, "Width0_End");
        u1.scaleAttribute(p2, p3, "Width1_End");
        u1.scaleAttribute(p2, p3, "CurveSize0_Start");
        u1.scaleAttribute(p2, p3, "CurveSize1_Start");
        u1.scaleAttribute(p2, p3, "CurveSize0_End");
        u1.scaleAttribute(p2, p3, "CurveSize1_End");
        u1.scaleAttribute(p2, p3, "Length_Scale_Start");
        u1.scaleAttribute(p2, p3, "Length_Scale_End");
        p2.Width0 = p2.Width0 * p3;
        p2.Width1 = p2.Width1 * p3;
        p2.CurveSize0 = p2.CurveSize0 * p3;
        p2.CurveSize1 = p2.CurveSize1 * p3;
        u1.scaleAttachmentDistance(p2.Attachment0, p2.Attachment1, p3);
    end
};

function u6.batch(p7: number, ...) -- Line: 85
    -- upvalues: u6 (copy)
    for _, v in { ... } do
        u6.apply(v, p7);

        for _, descendant in v:GetDescendants() do
            u6.apply(descendant, p7);
        end;
    end;
end;

return u6;