--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     StarBurst
  Path:     game.ReplicatedStorage.Modules.StarBurst
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Random_new_ret = Random.new();
local u1 = {};
local u2 = {
    MinCount = 4,
    MaxCount = 7,
    MinDistance = 60,
    MaxDistance = 180,
    MinFall = 50,
    MaxFall = 130,
    MinLifetime = 0.4,
    MaxLifetime = 0.7,
    MinScale = 0.6,
    MaxScale = 1.4,
    MinRotation = 120,
    MaxRotation = 540,
    EasingStyle = Enum.EasingStyle.Quad,
    EasingDirection = Enum.EasingDirection.Out
};
local u3 = nil;
local u4 = nil;

local function Init() -- Line: 48
    -- upvalues: u4 (ref), Players (copy), u3 (ref)
    if u4 then
        return true;
    end;

    u3 = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main"):WaitForChild("HUD"):WaitForChild("Screen_Effects");
    u4 = u3:WaitForChild("Star_Template");
    u4.Visible = false;

    return true;
end;

local function Lerp(p5: number, p6: number) -- Line: 60
    -- upvalues: Random_new_ret (copy)
    return Random_new_ret:NextNumber() * (p6 - p5) + p5;
end;

local function SpawnStar(p7: number, p8: number, p9: any) -- Line: 64
    -- upvalues: u4 (ref), Random_new_ret (copy), u3 (ref), TweenService (copy)
    local u10 = u4:Clone();
    local u11 = u10:FindFirstChildOfClass("UIScale");

    if not u11 then
        u11 = Instance.new("UIScale");
        u11.Parent = u10;
    end;

    local MinScale = p9.MinScale;
    local MaxScale = p9.MaxScale;
    local v12 = Random_new_ret:NextNumber() * (MaxScale - MinScale) + MinScale;
    local AbsoluteSize = u4.AbsoluteSize;
    local math_floor_ret = math.floor(AbsoluteSize.X * v12);
    local math_floor_ret2 = math.floor(AbsoluteSize.Y * v12);
    u10.Position = UDim2.fromOffset(p7 - math_floor_ret / 2, p8 - math_floor_ret2 / 2);
    u10.Size = UDim2.fromOffset(math_floor_ret, math_floor_ret2);
    u10.Rotation = Random_new_ret:NextNumber() * 360;
    u10.ImageTransparency = 1;
    u11.Scale = 0;
    u10.Visible = true;
    u10.ZIndex = 100;
    u10.Parent = u3;
    local v13 = Random_new_ret:NextNumber() * 3.141592653589793 * 2;
    local MinDistance = p9.MinDistance;
    local MaxDistance = p9.MaxDistance;
    local v14 = Random_new_ret:NextNumber() * (MaxDistance - MinDistance) + MinDistance;
    local v15 = p9.MinFall or 0;
    local v16 = p9.MaxFall or 0;
    local v17 = Random_new_ret:NextNumber() * (v16 - v15) + v15;
    local v18 = p7 + math.cos(v13) * v14 - math_floor_ret / 2;
    local v19 = p8 + math.sin(v13) * v14 + v17 - math_floor_ret2 / 2;
    local v20 = Random_new_ret:NextInteger(0, 1) == 0 and 1 or -1;
    local MinRotation = p9.MinRotation;
    local MaxRotation = p9.MaxRotation;
    local v21 = u10.Rotation + (Random_new_ret:NextNumber() * (MaxRotation - MinRotation) + MinRotation) * v20;
    local MinLifetime = p9.MinLifetime;
    local MaxLifetime = p9.MaxLifetime;
    local v22 = Random_new_ret:NextNumber() * (MaxLifetime - MinLifetime) + MinLifetime;
    local v23 = TweenService:Create(u10, TweenInfo.new(v22, p9.EasingStyle, p9.EasingDirection), {
        Position = UDim2.fromOffset(v18, v19),
        Rotation = v21
    });
    v23:Play();
    local v24 = v22 * 0.3;
    local TweenInfo_new_ret = TweenInfo.new(v24, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
    local TweenInfo_new_ret2 = TweenInfo.new(v22 - v24, p9.EasingStyle, p9.EasingDirection);
    local v25 = TweenService:Create(u10, TweenInfo_new_ret, {
        ImageTransparency = 0
    });
    TweenService:Create(u11, TweenInfo_new_ret, {
        Scale = 1
    }):Play();
    v25:Play();
    v25.Completed:Once(function() -- Line: 126
        -- upvalues: TweenService (ref), u10 (copy), TweenInfo_new_ret2 (copy), u11 (ref)
        TweenService:Create(u10, TweenInfo_new_ret2, {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(u11, TweenInfo_new_ret2, {
            Scale = 0
        }):Play();
    end);
    v23.Completed:Once(function() -- Line: 131
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
end;

function u1.AtPosition(p26: number, p27: number, p28: table?) -- Line: 139
    -- upvalues: Init (copy), u2 (copy), Random_new_ret (copy), SpawnStar (copy)
    if not Init() then
        return;
    end;

    local v29 = u2;

    if p28 then
        v29 = table.clone(u2);

        for i, v in p28 do
            v29[i] = v;
        end;
    end;

    for i = 1, Random_new_ret:NextInteger(v29.MinCount, v29.MaxCount) do
        SpawnStar(p26, p27, v29);
        local _ = i;
    end;
end;

function u1.AtGui(p30: userdata, p31: table?) -- Line: 157
    -- upvalues: u1 (copy)
    local AbsolutePosition = p30.AbsolutePosition;
    local AbsoluteSize = p30.AbsoluteSize;
    u1.AtPosition(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2, p31);
end;

function u1.AtMouse(p32: table?) -- Line: 166
    -- upvalues: Players (copy), u1 (copy)
    local Mouse = Players.LocalPlayer:GetMouse();
    u1.AtPosition(Mouse.X, Mouse.Y, p32);
end;

return u1;