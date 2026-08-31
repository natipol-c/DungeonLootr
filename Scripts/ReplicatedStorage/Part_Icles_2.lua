--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Part_Icles
  Path:     game.ReplicatedStorage.Globals.Modules.Part_Icles
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local script_Graph = require(script.Graph);
local script_Range = require(script.Range);
local script_Particles = require(script.Particles);
local script_TypeRegistry = require(script.TypeRegistry);
local u1 = {
    Beam = {},
    ActiveEmits = {},
    ActiveLoops = {},
    ActiveAnimates = {},
    Connection = nil,
    _CachedFolder = nil
};
require(script.GetData)(u1);
require(script.Transform)(u1);
require(script.Update)(u1);
require(script.Emit)(u1);
require(script.EmitAnimate)(u1);
require(script.EmitModel)(u1);
require(script.UpdateModel)(u1);

function u1.Activate(u2) -- Line: 46
    -- upvalues: RunService (copy)
    if u2.Connection then
        return;
    end;

    u2.Connection = RunService.Heartbeat:Connect(function(p3) -- Line: 49
        -- upvalues: u2 (copy)
        local ActiveEmits = u2.ActiveEmits;

        if #ActiveEmits == 0 then
            return;
        end;

        local os_clock_ret = os.clock();
        local v4 = 1;

        while v4 <= #ActiveEmits do
            local v5 = ActiveEmits[v4];
            local v6 = false;

            if v5.Type == "Part" then
                v6 = u2:UpdatePart(v5, p3, os_clock_ret);
            elseif v5.Type == "Beam" then
                v6 = u2:UpdateBeam(v5, p3, os_clock_ret);
            elseif v5.Type == "PointLight" then
                v6 = u2:UpdatePointLight(v5, p3, os_clock_ret);
            elseif v5.Type == "Attachment" then
                v6 = u2:UpdateAttachment(v5, p3, os_clock_ret);
            elseif v5.Type == "Model" then
                v6 = u2:UpdateModel(v5, p3, os_clock_ret);
            end;

            if v6 then
                if v5.IsAnimate then
                    if v5.AnimateItem and (v5.AnimateItem.Parent and v5.AnimateItem:GetAttribute("AnimateLoop")) then
                        v5.StartTime = os_clock_ret;
                        v5.CurrentStep = 0;

                        if v5.AccumulatedDT then
                            v5.AccumulatedDT = 0;
                        end;

                        if v5.InitialLocalCF then
                            v5.LocalCF = v5.InitialLocalCF;
                        end;

                        if v5.AccRotX then
                            v5.AccRotX = 0;
                            v5.AccRotY = 0;
                            v5.AccRotZ = 0;
                        end;

                        if v5.InitialWorldCF and (v5.VisualPart and v5.VisualPart.Parent) then
                            if v5.Type == "Model" then
                                v5.VisualPart:PivotTo(v5.InitialWorldCF);
                            else
                                v5.VisualPart.CFrame = v5.InitialWorldCF;
                            end;
                        end;

                        v4 = v4 + 1;
                    else
                        if v5.InitialWorldCF and (v5.VisualPart and v5.VisualPart.Parent) then
                            if v5.Type == "Model" then
                                v5.VisualPart:PivotTo(v5.InitialWorldCF);
                            else
                                v5.VisualPart.CFrame = v5.InitialWorldCF;
                            end;
                        end;

                        if v5.Type == "Beam" then
                            v5.VisualPart.Enabled = false;
                        end;

                        u2.ActiveAnimates[v5.AnimateItem] = nil;
                        local v7 = #ActiveEmits;

                        if v4 < v7 then
                            ActiveEmits[v4] = ActiveEmits[v7];
                        end;

                        ActiveEmits[v7] = nil;
                    end;
                else
                    local VisualPart = v5.VisualPart;

                    if v5.PartLife and v5.PartLife > 0 then
                        task.delay(v5.PartLife, function() -- Line: 101
                            -- upvalues: VisualPart (copy)
                            if VisualPart then
                                VisualPart:Destroy();
                            end;
                        end);
                    elseif VisualPart then
                        VisualPart:Destroy();
                    end;

                    local v8 = #ActiveEmits;

                    if v4 < v8 then
                        ActiveEmits[v4] = ActiveEmits[v8];
                    end;

                    ActiveEmits[v8] = nil;
                end;
            else
                v4 = v4 + 1;
            end;
        end;
    end);
end;

function u1.Deactivate(p9) -- Line: 118
    if p9.Connection then
        p9.Connection:Disconnect();
        p9.Connection = nil;
    end;

    for i = #p9.ActiveEmits, 1, -1 do
        local u10 = p9.ActiveEmits[i];

        if u10.VisualPart then
            pcall(function() -- Line: 127
                -- upvalues: u10 (copy)
                u10.VisualPart:Destroy();
            end);
        end;

        p9.ActiveEmits[i] = nil;
        local _ = i;
    end;

    for _, v in pairs(p9.ActiveAnimates) do
        if v.InitialWorldCF and v.VisualPart then
            if v.Type == "Model" then
                pcall(function() -- Line: 135
                    -- upvalues: v (copy)
                    v.VisualPart:PivotTo(v.InitialWorldCF);
                end);
            else
                pcall(function() -- Line: 137
                    -- upvalues: v (copy)
                    v.VisualPart.CFrame = v.InitialWorldCF;
                end);
            end;
        end;

        if v.Type == "Beam" and v.VisualPart then
            pcall(function() -- Line: 141
                -- upvalues: v (copy)
                v.VisualPart.Enabled = false;
            end);
        end;
    end;

    table.clear(p9.ActiveAnimates);

    for i, v in pairs(p9.ActiveLoops) do
        pcall(function() -- Line: 147
            -- upvalues: v (copy)
            task.cancel(v);
        end);
        p9.ActiveLoops[i] = nil;
    end;

    p9._CachedFolder = nil;
end;

function u1.GetFolder(p11) -- Line: 153
    if p11._CachedFolder and p11._CachedFolder.Parent then
        return p11._CachedFolder;
    end;

    local EmittedPartsUsingPart_icle = workspace.Terrain:FindFirstChild("EmittedPartsUsingPart_icle");

    if not EmittedPartsUsingPart_icle then
        EmittedPartsUsingPart_icle = Instance.new("Folder");
        EmittedPartsUsingPart_icle.Name = "EmittedPartsUsingPart_icle";
        EmittedPartsUsingPart_icle.Parent = workspace.Terrain;
    end;

    p11._CachedFolder = EmittedPartsUsingPart_icle;

    return EmittedPartsUsingPart_icle;
end;

function u1.UpdatePointLight(p12, p13, p14, p15) -- Line: 171
    -- upvalues: script_Graph (copy)
    local v16 = (p15 - p13.StartTime) / p13.LifeTime;

    if v16 >= 1 or not p13.VisualPart.Parent then
        return true;
    end;

    if p13.TotalKeyFrames <= 0 then
        return true;
    end;

    local math_floor_ret = math.floor(v16 * p13.TotalKeyFrames);

    if p13.CurrentStep < math_floor_ret then
        p13.CurrentStep = math_floor_ret;
        local v17 = p13.CurrentStep / p13.TotalKeyFrames;

        if p13.Graphs.PLRange then
            p13.VisualPart.Range = script_Graph.QueryPointsWithTime(v17, p13.Graphs.PLRange, p13.Seeds.PLRange);
        end;

        if p13.Graphs.PLBrightness then
            p13.VisualPart.Brightness = script_Graph.QueryPointsWithTime(v17, p13.Graphs.PLBrightness, p13.Seeds.PLBrightness);
        end;

        if p13.Graphs.PLColor then
            p13.VisualPart.Color = script_Graph.QueryColorPointWithTime(v17, p13.Graphs.PLColor);
        end;
    end;

    return false;
end;

function u1.EmitPointLight(p18, p19, p20) -- Line: 202
    -- upvalues: script_Range (copy), script_Graph (copy)
    local Data = p18:GetData(p19);

    if not (Data and Data.RenderTemplate) then
        return;
    end;

    local v21 = Data.RenderTemplate:Clone();
    v21.Parent = Data.EmitParent or (p20 or p19.Parent);
    local v22 = script_Range.RandomValueFromRange(Data.Lifetime);
    local v23 = Data.PLRange and (script_Graph.GenerateSeed(Data.PLRange) or {}) or {};
    local v24 = Data.PLBrightness and (script_Graph.GenerateSeed(Data.PLBrightness) or {}) or {};

    if Data.PLRange then
        v21.Range = script_Graph.QueryPointsWithTime(0, Data.PLRange, v23);
    end;

    if Data.PLBrightness then
        v21.Brightness = script_Graph.QueryPointsWithTime(0, Data.PLBrightness, v24);
    end;

    if Data.PLColor then
        v21.Color = script_Graph.QueryColorPointWithTime(0, Data.PLColor);
    end;

    local v25 = {
        Type = "PointLight",
        CurrentStep = 0,
        PartLife = 0,
        VisualPart = v21,
        Link = p20,
        StartTime = os.clock(),
        TotalKeyFrames = math.max(1, Data.TotalKeyFrames),
        LifeTime = v22 <= 0 and 0.001 or v22,
        Graphs = {
            PLRange = Data.PLRange,
            PLBrightness = Data.PLBrightness,
            PLColor = Data.PLColor
        },
        Seeds = {
            PLRange = v23,
            PLBrightness = v24
        }
    };
    table.insert(p18.ActiveEmits, v25);
end;

function u1.Emit(p26, p27, p28) -- Line: 256
    if not (p27 and p27.Parent) then
        return;
    end;

    if p27:IsA("Beam") then
        p26:EmitBeam(p27, p28);

        return;
    end;

    if p27:IsA("PointLight") then
        p26:EmitPointLight(p27, p28);

        return;
    end;

    if p27:IsA("Attachment") then
        p26:EmitAttachment(p27, p28);

        return;
    end;

    if p27:IsA("Model") then
        p26:EmitModel(p27, p28);

        return;
    end;

    p26:EmitPart(p27, p28);
end;

function u1.Enable(u29, u30, u31, p32) -- Line: 275
    -- upvalues: script_TypeRegistry (copy), u1 (copy)
    local Data = u29:GetData(u30);

    if not Data then
        return;
    end;

    if (u30:GetAttribute("EmissionMode") or "Emit") == "Animate" then
        u30:SetAttribute("AnimateLoop", true);
        u29:EmitAnimate(u30, u31);

        return;
    end;

    local u33 = p32 or (1 / 0);
    local Config = script_TypeRegistry.getConfig(u30);

    if u1.ActiveLoops[u30] then
        task.cancel(u1.ActiveLoops[u30]);
    end;

    u1.ActiveLoops[u30] = task.spawn(function() -- Line: 292
        -- upvalues: u30 (copy), u1 (ref), u33 (copy), Data (copy), u29 (copy), u31 (copy), Config (copy)
        local os_clock_ret = os.clock();

        while u30 and u30.Parent do
            if u33 <= os.clock() - os_clock_ret or not Data.CheckEnabled() then
                u1.ActiveLoops[u30] = nil;

                return;
            end;

            u29:Emit(u30, u31);
            local v34 = Config and Config:GetAttribute("Rate") or 10;
            task.wait(1 / (v34 <= 0 and 1 or v34));
        end;

        u1.ActiveLoops[u30] = nil;
    end);
end;

function u1.EmitAnimate(p35, p36, p37) -- Line: 314
    local v38 = p35.ActiveAnimates[p36];

    if v38 then
        if v38.InitialWorldCF then
            v38.VisualPart.CFrame = v38.InitialWorldCF;
        end;

        if v38.Type == "Beam" then
            v38.VisualPart.Enabled = false;
        end;

        for i = #p35.ActiveEmits, 1, -1 do
            if p35.ActiveEmits[i] == v38 then
                local v39 = #p35.ActiveEmits;

                if i < v39 then
                    p35.ActiveEmits[i] = p35.ActiveEmits[v39];
                end;

                p35.ActiveEmits[v39] = nil;
                break;
            end;

            local _ = i;
        end;

        p35.ActiveAnimates[p36] = nil;
    end;

    if p36:IsA("Beam") then
        p35:EmitBeamAnimate(p36, p37);

        return;
    end;

    if p36:IsA("Attachment") then
        p35:EmitAttachmentAnimate(p36, p37);

        return;
    end;

    if p36:IsA("Model") then
        p35:EmitModelAnimate(p36, p37);

        return;
    end;

    p35:EmitPartAnimate(p36, p37);
end;

function u1.EnableEmit(u40, u41, u42) -- Line: 337
    -- upvalues: script_TypeRegistry (copy)
    if (u41:GetAttribute("EmissionMode") or "Emit") == "Animate" then
        local v43 = u41:GetAttribute("EmitDelay") or 0;

        local function doAnimate() -- Line: 342
            -- upvalues: u40 (copy), u41 (copy), u42 (copy)
            u40:EmitAnimate(u41, u42);
        end;

        if v43 > 0 then
            task.delay(v43, doAnimate);

            return;
        end;

        u40:EmitAnimate(u41, u42);

        return;
    end;

    local u44 = u41:GetAttribute("EmitCount") or 1;
    local v45 = u41:GetAttribute("EmitDelay") or 0;
    local u46 = u41:GetAttribute("EmitDuration") or 0;
    local Config = script_TypeRegistry.getConfig(u41);

    local function doEmit() -- Line: 353
        -- upvalues: u44 (copy), u40 (copy), u41 (copy), u42 (copy), u46 (copy), Config (copy)
        for i = 1, u44 do
            u40:Emit(u41, u42);
            local _ = i;
        end;

        if u46 > 0 then
            if Config then
                Config:SetAttribute("Enabled", true);
            end;

            u40:Enable(u41, u42, u46);
            task.delay(u46, function() -- Line: 359
                -- upvalues: Config (ref)
                if Config and Config.Parent then
                    Config:SetAttribute("Enabled", false);
                end;
            end);
        end;
    end;

    if v45 > 0 then
        task.delay(v45, doEmit);

        return;
    end;

    doEmit();
end;

function u1.AbsoluteEmit(p47, p48, p49) -- Line: 372
    -- upvalues: script_Particles (copy)
    if p48:GetAttribute("Transformed") then
        p47:EnableEmit(p48, nil);

        return;
    end;

    local v50;

    if p48:IsA("BasePart") or p48:IsA("Attachment") then
        v50 = not p49;
    else
        v50 = p48:IsA("Model") and not p49;
    end;

    if v50 then
        script_Particles.EnableEmit(p48);
    end;

    for _, child in p48:GetChildren() do
        if not p48:IsA("BasePart") or (not child:IsA("BasePart") or child:GetAttribute("Transformed")) then
            p47:AbsoluteEmit(child, v50);
        end;
    end;
end;

return u1;