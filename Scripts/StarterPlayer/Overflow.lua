--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Overflow
  Path:     game.StarterPlayer.StarterPlayerScripts.Satchel.Satchel.Packages._Index.legitatx_topbarplus@3.0.5.topbarplus.Features.Overflow
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local u3 = {};
local u4 = nil;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u5 = {};
local u6 = {};
local Utility = require(script.Parent.Parent.Utility);
local u7 = nil;

function u1.start(p8) -- Line: 23
    -- upvalues: u7 (ref), u4 (ref), u2 (copy), Utility (copy), u1 (copy), workspace_CurrentCamera (copy)
    u7 = p8;
    u4 = u7.iconsDictionary;
    local v9 = nil;

    for _, v in pairs(u7.container) do
        if v9 == nil then
            if v.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
                v9 = v;
            end;
        end;

        for _, child in pairs(v.Holders:GetChildren()) do
            if child:GetAttribute("IsAHolder") then
                u2[child.Name] = child;
            end;
        end;
    end;

    local u10 = false;
    local u12 = Utility.createStagger(0.1, function(p11) -- Line: 41
        -- upvalues: u10 (ref), u1 (ref)
        if not u10 then
            return;
        end;

        if not p11 then
            u1.updateAvailableIcons("Center");
        end;

        u1.updateBoundary("Left");
        u1.updateBoundary("Right");
    end);
    task.delay(1, function() -- Line: 51
        -- upvalues: u10 (ref), u12 (copy)
        u10 = true;
        u12();
    end);
    u7.iconAdded:Connect(u12);
    u7.iconRemoved:Connect(u12);
    u7.iconChanged:Connect(u12);
    workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 61
        -- upvalues: u12 (copy)
        u12(true);
    end);
    v9:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 64
        -- upvalues: u12 (copy)
        u12(true);
    end);
end;

function u1.getWidth(p13, p14) -- Line: 69
    local widget = p13.widget;

    return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X;
end;

function u1.getAvailableIcons(p15) -- Line: 74
    -- upvalues: u3 (copy), u1 (copy)
    return u3[p15] or u1.updateAvailableIcons(p15);
end;

function u1.updateAvailableIcons(p16) -- Line: 82
    -- upvalues: u2 (copy), u4 (ref), u6 (copy), u3 (copy)
    local _ = u2[p16].UIListLayout;
    local v17 = 0;
    local v18 = {};

    for _, v in pairs(u4) do
        local parentIconUID = v.parentIconUID;

        if (not parentIconUID or u6[parentIconUID]) and (v.alignment == p16 and not u6[v.UID]) then
            table.insert(v18, v);
            v17 = v17 + 1;
        end;
    end;

    if v17 <= 0 then
        return {};
    end;

    table.sort(v18, function(p19, p20) -- Line: 106
        local LayoutOrder = p19.widget.LayoutOrder;
        local LayoutOrder2 = p20.widget.LayoutOrder;
        local parentIconUID = p19.parentIconUID;
        local parentIconUID2 = p20.parentIconUID;

        if parentIconUID == parentIconUID2 then
            if LayoutOrder < LayoutOrder2 then
                return true;
            end;

            if LayoutOrder2 < LayoutOrder then
                return false;
            end;

            return p19.widget.AbsolutePosition.X < p20.widget.AbsolutePosition.X;
        end;

        if parentIconUID2 then
            return false;
        end;

        if parentIconUID then
            return true;
        end;
    end);
    u3[p16] = v18;

    return v18;
end;

function u1.getRealXPositions(p21, p22) -- Line: 132
    -- upvalues: u2 (copy), Utility (copy), u1 (copy)
    local v23 = p21 == "Left";
    local v24 = u2[p21];
    local X = v24.AbsolutePosition.X;
    local Offset = v24.UIListLayout.Padding.Offset;
    local v25 = v23 and X and X or X + v24.AbsoluteSize.X;
    local v26 = {};

    if v23 then
        Utility.reverseTable(p22);
    end;

    for i = #p22, 1, -1 do
        local v27 = p22[i];
        local Width = u1.getWidth(v27);

        if not v23 then
            v25 = v25 - Width;
        end;

        v26[v27.UID] = v25;

        if v23 then
            v25 = v25 + Width;
        end;

        v25 = v25 + (v23 and Offset and Offset or -Offset);
        local _ = i;
    end;

    return v26;
end;

function u1.updateBoundary(p28) -- Line: 162
    -- upvalues: u2 (copy), u1 (copy), u5 (copy), u7 (ref), u6 (copy), Utility (copy)
    local v29 = u2[p28];
    local UIListLayout = v29.UIListLayout;
    local X = v29.AbsolutePosition.X;
    local X2 = v29.AbsoluteSize.X;
    local Offset = UIListLayout.Padding.Offset;
    local Offset2 = UIListLayout.Padding.Offset;
    local v30 = u1.updateAvailableIcons(p28);
    local v31 = 0;
    local v32 = 0;

    for _, v in pairs(v30) do
        v31 = v31 + (u1.getWidth(v) + Offset2);
        v32 = v32 + 1;
    end;

    if v32 <= 0 then
        return;
    end;

    local v33 = p28 == "Left";
    local v34 = not v33;
    local v35 = u5[p28];

    if not v35 and (not (p28 == "Central") and #v30 > 0) then
        v35 = u7.new();
        v35:setImage(6069276526, "Deselected");
        v35:setName("Overflow" .. p28);
        v35:setOrder(v33 and -9999999 or 9999999);
        v35:setAlignment(p28);
        v35:autoDeselect(false);
        v35.isAnOverflow = true;
        v35:select("OverflowStart", v35);
        v35:setEnabled(false);
        u5[p28] = v35;
        u6[v35.UID] = true;
    end;

    local v36 = p28 == "Left" and "Right" or "Left";
    local v37 = u1.updateAvailableIcons(v36);
    local v38 = v33 and v37[1];

    if not v38 then
        if v34 then
            v38 = v37[#v37];
        else
            v38 = v34;
        end;
    end;

    local v39 = u5[v36];
    local v40;

    if v33 then
        v40 = X + X2 or X;
    else
        v40 = X;
    end;

    if v38 then
        local _ = v38.widget;
        local v41 = u1.getRealXPositions(v36, v37)[v38.UID];
        local Width = u1.getWidth(v38);
        v40 = v33 and v41 - Offset or v41 + Width + Offset;
    end;

    local AvailableIcons = u1.getAvailableIcons("Center");
    local v42 = AvailableIcons[v33 and 1 or #AvailableIcons];

    if v42 and not v42.hasRelocatedInOverflow then
        local v43 = v33 and v30[#v30];

        if not v43 then
            if v34 then
                v43 = v30[1];
            else
                v43 = v34;
            end;
        end;

        local X3 = v42.widget.AbsolutePosition.X;
        local X4 = v43.widget.AbsolutePosition.X;
        local Width = u1.getWidth(v43);
        local v44 = v33 and X3 - Offset or X3 + u1.getWidth(v42) + Offset;

        if v33 then
            X4 = X4 + Width or X4;
        end;

        if v33 then
            if v44 < X4 then
                v42:align("Left");
                v42.hasRelocatedInOverflow = true;
            end;
        elseif v34 and X4 < v44 then
            v42:align("Right");
            v42.hasRelocatedInOverflow = true;
        end;
    end;

    if v35 then
        local Instance = v35:getInstance("Menu");
        local v45 = X + X2;

        if Instance and v39 then
            local X3 = v39.widget.AbsolutePosition.X;
            local Width = u1.getWidth(v39);
            local v46 = v33 and X3 - Offset or X3 + Width + Offset;
            local Instance2 = v39:getInstance("Menu");
            local v47 = X + X2 / 2;
            local v48 = v33 and v47 - Offset / 2 or v47 + Offset / 2;

            if Instance.AbsoluteCanvasSize.X >= Instance2.AbsoluteCanvasSize.X then
                v48 = v46;
            end;

            X2 = v33 and v48 - X or v45 - v48;
        end;

        local v49;

        if Instance then
            v49 = Instance:GetAttribute("MaxWidth");
        else
            v49 = Instance;
        end;

        local v50 = Utility.round(X2);

        if Instance and v49 ~= v50 then
            Instance:SetAttribute("MaxWidth", v50);
        end;
    end;

    local RealXPositions = u1.getRealXPositions(p28, v30);
    local v51 = false;

    for i = #v30, 1, -1 do
        local v52 = v30[i];
        local Width = u1.getWidth(v52);
        local v53 = RealXPositions[v52.UID];
        local v54;

        if v33 and v40 <= v53 + Width or v34 and v53 <= v40 then
            v54 = i;
            v51 = true;
        else
            v54 = i;
        end;
    end;

    for i = #v30, 1, -1 do
        local v55 = v30[i];
        local v56;

        if u6[v55.UID] then
            v56 = i;
        elseif v51 and not v55.parentIconUID then
            v55:joinMenu(v35);
            v56 = i;
        elseif v51 or not v55.parentIconUID then
            v56 = i;
        else
            v55:leave();
            v56 = i;
        end;
    end;

    if v35.isEnabled ~= v51 then
        v35:setEnabled(v51);
    end;

    if v35.isEnabled and not v35.overflowAlreadyOpened then
        v35.overflowAlreadyOpened = true;
        v35:select();
    end;
end;

return u1;