--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ShowViewport
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.ShowViewport
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local script_ViewportModel = require(script.ViewportModel);

return function(p1: userdata, p2: userdata, p3: number?, p4: userdata?) -- Line: 5
    -- upvalues: script_ViewportModel (copy), RunService (copy)
    p1:ClearAllChildren();
    local u5 = {
        Playing = false
    };
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 70;
    Camera.Parent = p1;
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = p1;
    p2.Parent = WorldModel;
    p1.CurrentCamera = Camera;
    local v6 = script_ViewportModel.new(p1, Camera);
    local BoundingBox, _ = p2:GetBoundingBox();
    v6:SetModel(p2);
    local u7 = 0;
    CFrame.new();
    local u8 = p3 or -90;
    local math_rad_ret = math.rad(u8);
    local u9, u10;

    if p4 then
        u9 = p4.Position;
        local Size = p4.Size;
        local math_max_ret = math.max(Size.X, Size.Y, Size.Z);
        local math_rad_ret2 = math.rad(Camera.FieldOfView / 2);
        u10 = math_max_ret / (math.tan(math_rad_ret2) * 2) + 1;
    else
        u9 = BoundingBox.Position;
        u10 = v6:GetFitDistance(u9);
    end;

    local CFrame_fromEulerAnglesYXZ_ret = CFrame.fromEulerAnglesYXZ(0, math_rad_ret, 0);
    Camera.CFrame = CFrame.new(u9) * CFrame_fromEulerAnglesYXZ_ret * CFrame.new(0, 0, u10);
    u5.Connection = RunService.RenderStepped:Connect(function(p11) -- Line: 54
        -- upvalues: u5 (copy), u7 (ref), u8 (ref), CFrame_fromEulerAnglesYXZ_ret (ref), Camera (copy), u9 (ref), u10 (ref)
        if u5.Playing then
            u7 = u7 + math.rad(u8 * p11);
            CFrame_fromEulerAnglesYXZ_ret = CFrame.fromEulerAnglesYXZ(-0.3490658503988659, u7, 0);
            Camera.CFrame = CFrame.new(u9) * CFrame_fromEulerAnglesYXZ_ret * CFrame.new(0, 0, u10);
        end;
    end);
    u5.funcs = {};

    function u5.funcs.reset() -- Line: 64
        -- upvalues: u7 (ref), math_rad_ret (copy), CFrame_fromEulerAnglesYXZ_ret (ref), Camera (copy), u9 (ref), u10 (ref)
        u7 = math_rad_ret;
        CFrame_fromEulerAnglesYXZ_ret = CFrame.fromEulerAnglesYXZ(-0.3490658503988659, u7, 0);
        Camera.CFrame = CFrame.new(u9) * CFrame_fromEulerAnglesYXZ_ret * CFrame.new(0, 0, u10);
    end;

    local u12 = nil;

    function u5.funcs.destroy() -- Line: 72
        -- upvalues: u12 (ref), u5 (copy)
        if u12 then
            u12:Disconnect();
            u12 = nil;
        end;

        if u5.Connection then
            u5.Connection:Disconnect();
            u5.Connection = nil;
        end;

        u5.Playing = false;
    end;

    u12 = Camera.Destroying:Once(u5.funcs.destroy);

    return u5;
end;