--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     recolor
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.recolor
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Single = {
        Color3 = { "Decal", "Texture" },
        Color = { "Part", "Union", "MeshPart", "SpotLight", "PointLight", "SurfaceLight", "SurfaceAppearance" }
    },
    Sequence = {
        Color = { "Beam", "Trail", "ParticleEmitter" }
    }
};

local function warp(p2: number) -- Line: 30
    return (p2 % 1 + 1) % 1;
end;

local function multiplyHue(p3: number, p4: number) -- Line: 34
    return ((p3 + (p4 - 0.5) * 1) % 1 + 1) % 1;
end;

local function multiplyChannel(p5: number, p6: number) -- Line: 39
    local v7 = p6 * 2 - 1;

    if v7 >= 0 then
        return math.clamp(p5 + (1 - p5) * v7, 0, 1);
    end;

    local v8 = p5 - p5 * math.abs(v7);

    return math.clamp(v8, 0, 1);
end;

local function normalizeColor(p9) -- Line: 49
    local R = p9.R;
    local G = p9.G;
    local B = p9.B;
    local math_max_ret = math.max(1, R, G, B);

    return math_max_ret, Color3.new(R / math_max_ret, G / math_max_ret, B / math_max_ret);
end;

local function multiplyRGB(p10, p11: number) -- Line: 55
    return Color3.new(p10.R * p11, p10.G * p11, p10.B * p11);
end;

local function recolorObj(p12: userdata, p13, p14: string, p15: boolean) -- Line: 59
    -- upvalues: u1 (copy), multiplyRGB (copy)
    if not p15 and p12:IsA("BasePart") then
        return;
    end;

    local v16, v17, v18 = p13:ToHSV();

    for _, v in u1 do
        for i, v2 in v do
            if table.find(v2, p12.ClassName) then
                local v19 = p12[i];

                if p14 == "multiply" then
                    if typeof(v19) == "Color3" then
                        local R = v19.R;
                        local G = v19.G;
                        local B = v19.B;
                        local math_max_ret = math.max(1, R, G, B);
                        local v20, v21, v22 = Color3.new(R / math_max_ret, G / math_max_ret, B / math_max_ret):ToHSV();
                        local v23 = v17 * 2 - 1;
                        local v24;

                        if v23 >= 0 then
                            v24 = math.clamp(v21 + (1 - v21) * v23, 0, 1);
                        else
                            local v25 = v21 - v21 * math.abs(v23);
                            v24 = math.clamp(v25, 0, 1);
                        end;

                        local v26 = v18 * 2 - 1;
                        local v27;

                        if v26 >= 0 then
                            v27 = math.clamp(v22 + (1 - v22) * v26, 0, 1);
                        else
                            local v28 = v22 - v22 * math.abs(v26);
                            v27 = math.clamp(v28, 0, 1);
                        end;

                        local Color3_fromHSV_ret = Color3.fromHSV(((v20 + (v16 - 0.5) * 1) % 1 + 1) % 1, v24, v27);
                        p12[i] = Color3.new(Color3_fromHSV_ret.R * math_max_ret, Color3_fromHSV_ret.G * math_max_ret, Color3_fromHSV_ret.B * math_max_ret);
                    elseif typeof(v19) == "ColorSequence" then
                        local v29 = {};

                        for _, v3 in v19.Keypoints do
                            local Value = v3.Value;
                            local R = Value.R;
                            local G = Value.G;
                            local B = Value.B;
                            local math_max_ret = math.max(1, R, G, B);
                            local v30, v31, v32 = Color3.new(R / math_max_ret, G / math_max_ret, B / math_max_ret):ToHSV();
                            local v33 = v17 * 2 - 1;
                            local v34;

                            if v33 >= 0 then
                                v34 = math.clamp(v31 + (1 - v31) * v33, 0, 1);
                            else
                                local v35 = v31 - v31 * math.abs(v33);
                                v34 = math.clamp(v35, 0, 1);
                            end;

                            local v36 = v18 * 2 - 1;
                            local v37;

                            if v36 >= 0 then
                                v37 = math.clamp(v32 + (1 - v32) * v36, 0, 1);
                            else
                                local v38 = v32 - v32 * math.abs(v36);
                                v37 = math.clamp(v38, 0, 1);
                            end;

                            local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
                            local Time = v3.Time;
                            local Color3_fromHSV_ret = Color3.fromHSV(((v30 + (v16 - 0.5) * 1) % 1 + 1) % 1, v34, v37);
                            table.insert(v29, ColorSequenceKeypoint_new(Time, multiplyRGB(Color3_fromHSV_ret, math_max_ret)));
                        end;

                        p12[i] = ColorSequence.new(v29);
                    end;
                elseif typeof(v19) == "Color3" then
                    local R = v19.R;
                    local G = v19.G;
                    local B = v19.B;
                    local math_max_ret = math.max(1, R, G, B);
                    Color3.new(R / math_max_ret, G / math_max_ret, B / math_max_ret);
                    p12[i] = Color3.new(p13.R * math_max_ret, p13.G * math_max_ret, p13.B * math_max_ret);
                elseif typeof(v19) == "ColorSequence" then
                    p12[i] = ColorSequence.new(p13);
                end;
            end;
        end;
    end;
end;

return function(p39, p40: string, ...) -- Line: 112, Name: recolor
    -- upvalues: recolorObj (copy)
    for _, v in { ... } do
        recolorObj(v, p39, p40, true);

        for _, descendant in v:GetDescendants() do
            recolorObj(descendant, p39, p40, false);
        end;
    end;
end;