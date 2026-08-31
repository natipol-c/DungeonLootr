--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RevealCascade
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.RevealCascade
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local v1 = {};
local TweenInfo_new_ret = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out);

local function primeScale(p2: userdata) -- Line: 31
    local v3 = p2:FindFirstChildWhichIsA("UIScale");

    if not v3 then
        v3 = Instance.new("UIScale");
        v3.Parent = p2;
    end;

    v3.Scale = 0;

    return v3;
end;

function v1.prime(p4: table) -- Line: 44
    for _, v in p4 do
        if v and v.Parent then
            local v5 = v:FindFirstChildWhichIsA("UIScale");

            if not v5 then
                v5 = Instance.new("UIScale");
                v5.Parent = v;
            end;

            v5.Scale = 0;
        end;
    end;
end;

function v1.play(u6: table, p7: any) -- Line: 61
    -- upvalues: TweenInfo_new_ret (copy), TweenService (copy)
    local v8 = p7 or {};
    local u9 = v8.tween or TweenInfo_new_ret;
    local u10 = v8.stagger or 0.06;
    local isCurrent = v8.isCurrent;
    local u11 = {};

    for i, v in u6 do
        if v and v.Parent then
            local v12 = v:FindFirstChildWhichIsA("UIScale");

            if not v12 then
                v12 = Instance.new("UIScale");
                v12.Parent = v;
            end;

            v12.Scale = 0;
            u11[i] = v12;
        end;
    end;

    task.spawn(function() -- Line: 75
        -- upvalues: u6 (copy), isCurrent (copy), u11 (copy), TweenService (ref), u9 (copy), u10 (copy)
        for i, v in u6 do
            if isCurrent and not isCurrent() then
                return;
            end;

            local v13 = u11[i];

            if v13 and (v and v.Parent) then
                TweenService:Create(v13, u9, {
                    Scale = 1
                }):Play();
            end;

            task.wait(u10);
        end;
    end);
end;

return v1;