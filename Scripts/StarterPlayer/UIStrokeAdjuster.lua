--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UIStrokeAdjuster
  Path:     game.StarterPlayer.StarterPlayerScripts.StrokeAdjuster.UIStrokeAdjuster
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

local Vector2_new_ret = Vector2.new(1616, 880);
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
Players.LocalPlayer:WaitForChild("PlayerGui", 100);
local workspace_CurrentCamera = workspace.CurrentCamera;

local function getBox(p1) -- Line: 61
    return math.min(p1.X, p1.Y);
end;

local function getScreenRatio() -- Line: 69
    -- upvalues: workspace_CurrentCamera (copy), Vector2_new_ret (copy)
    local ViewportSize = workspace_CurrentCamera.ViewportSize;
    local v2 = Vector2_new_ret;

    return math.min(ViewportSize.X, ViewportSize.Y) / math.min(v2.X, v2.Y);
end;

local function tagRecursive(p3: userdata, u4: string, u5: string) -- Line: 80
    -- upvalues: tagRecursive (copy)
    if p3:IsA(u4) then
        p3:AddTag(u5);
    end;

    for _, child in p3:GetChildren() do
        tagRecursive(child, u4, u5);
    end;

    p3.ChildAdded:Connect(function(p6) -- Line: 87
        -- upvalues: tagRecursive (ref), u4 (copy), u5 (copy)
        tagRecursive(p6, u4, u5);
    end);
end;

local function getInstancePosition(p7: userdata) -- Line: 97
    if p7:IsA("Part") then
        return p7.Position;
    end;

    return not p7:IsA("Model") and Vector3.new(0, 0, 0) or p7:GetPivot().Position;
end;

local function initTaggedUIStroke(p8: userdata) -- Line: 113
    -- upvalues: workspace_CurrentCamera (copy), Vector2_new_ret (copy)
    if p8:IsA("UIStroke") then
        if not p8:GetAttribute("OriginalThickness") then
            p8:SetAttribute("OriginalThickness", p8.Thickness);
        end;

        if p8:HasTag("ScreenStroke") then
            local ViewportSize = workspace_CurrentCamera.ViewportSize;
            local v9 = Vector2_new_ret;
            p8.Thickness = p8.Thickness * (math.min(ViewportSize.X, ViewportSize.Y) / math.min(v9.X, v9.Y));
        end;

        return;
    end;

    p8:RemoveTag("ScreenStroke");
    p8:RemoveTag("UIStroke");
end;

for _, v in CollectionService:GetTagged("UIStroke") do
    initTaggedUIStroke(v);
end;

CollectionService:GetInstanceAddedSignal("UIStroke"):Connect(initTaggedUIStroke);

for _, v in CollectionService:GetTagged("ScreenStroke") do
    v:AddTag("UIStroke");
end;

CollectionService:GetInstanceAddedSignal("ScreenStroke"):Connect(function(p10: userdata) -- Line: 147
    p10:AddTag("UIStroke");
end);

for _, v in CollectionService:GetTagged("ScreenGui") do
    if v:IsA("ScreenGui") then
        tagRecursive(v, "UIStroke", "ScreenStroke");
    else
        v:RemoveTag("ScreenGui");
    end;
end;

CollectionService:GetInstanceAddedSignal("ScreenGui"):Connect(function(p11: userdata) -- Line: 162
    -- upvalues: tagRecursive (copy)
    if not p11:IsA("ScreenGui") then
        return;
    end;

    tagRecursive(p11, "UIStroke", "ScreenStroke");
end);
workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 171, Name: updateScreenGuiStrokes
    -- upvalues: CollectionService (copy), workspace_CurrentCamera (copy), Vector2_new_ret (copy)
    for _, v in CollectionService:GetTagged("ScreenStroke") do
        local Attribute = v:GetAttribute("OriginalThickness");

        if Attribute then
            local ViewportSize = workspace_CurrentCamera.ViewportSize;
            local v12 = Vector2_new_ret;
            v.Thickness = Attribute * (math.min(ViewportSize.X, ViewportSize.Y) / math.min(v12.X, v12.Y));
        end;
    end;
end);
local u13 = {};

local function recurseGetUIStrokes(p14: userdata, u15: userdata) -- Line: 194
    -- upvalues: u13 (copy), recurseGetUIStrokes (copy)
    if p14:IsA("UIStroke") then
        p14:AddTag("UIStroke");
        table.insert(u13[u15], p14);
    end;

    for _, child in p14:GetChildren() do
        recurseGetUIStrokes(child, u15);
    end;

    p14.ChildAdded:Connect(function(p16: userdata) -- Line: 202
        -- upvalues: recurseGetUIStrokes (ref), u15 (copy)
        recurseGetUIStrokes(p16, u15);
    end);
end;

local function initBillboard(u17: userdata) -- Line: 208
    -- upvalues: u13 (copy), recurseGetUIStrokes (copy)
    if not u17:IsA("BillboardGui") then
        u17:RemoveTag("Billboard");

        return;
    end;

    u13[u17] = {};
    u17.Destroying:Once(function() -- Line: 218
        -- upvalues: u13 (ref), u17 (copy)
        u13[u17] = nil;
    end);
    recurseGetUIStrokes(u17, u17);
end;

for _, v in CollectionService:GetTagged("Billboard") do
    initBillboard(v);
end;

CollectionService:GetInstanceAddedSignal("Billboard"):Connect(initBillboard);
local u18 = tick();
RunService.Heartbeat:Connect(function() -- Line: 238
    -- upvalues: u18 (ref), u13 (copy), workspace_CurrentCamera (copy), Vector2_new_ret (copy)
    if tick() - u18 < 1 then
        return;
    end;

    u18 = tick();

    for i, v in u13 do
        local Adornee = i.Adornee;
        local v19 = nil;

        if Adornee then
            if Adornee:IsA("Part") then
                v19 = Adornee.Position;
            else
                v19 = not Adornee:IsA("Model") and Vector3.new(0, 0, 0) or Adornee:GetPivot().Position;
            end;
        elseif i.Parent then
            local Parent = i.Parent;

            if Parent:IsA("Part") then
                v19 = Parent.Position;
            else
                v19 = not Parent:IsA("Model") and Vector3.new(0, 0, 0) or Parent:GetPivot().Position;
            end;
        end;

        if v19 then
            local Magnitude = (workspace_CurrentCamera.CFrame.Position - v19).Magnitude;

            if i.MaxDistance >= Magnitude then
                local v20 = (i:GetAttribute("Distance") or 10) / Magnitude;
                local v21 = v;
                local v22 = i;

                for _, v2 in v do
                    if not v2:IsDescendantOf(v22) then
                        table.remove(v21, table.find(v21, v2));
                    end;

                    local Attribute = v2:GetAttribute("OriginalThickness");

                    if Attribute then
                        local ViewportSize = workspace_CurrentCamera.ViewportSize;
                        local v23 = Vector2_new_ret;
                        v2.Thickness = Attribute * v20 * (math.min(ViewportSize.X, ViewportSize.Y) / math.min(v23.X, v23.Y));
                    end;
                end;
            end;
        end;
    end;
end);

return {
    TagScreenGui = function(p24: any, p25: userdata) -- Line: 316, Name: TagScreenGui
        -- upvalues: CollectionService (copy)
        if p25:IsA("ScreenGui") then
            CollectionService:AddTag(p25, "ScreenGui");
        end;
    end,

    TagBillboardGui = function(p26: any, p27: userdata) -- Line: 326, Name: TagBillboardGui
        -- upvalues: CollectionService (copy)
        if p27:IsA("BillboardGui") then
            CollectionService:AddTag(p27, "Billboard");
        end;
    end
};