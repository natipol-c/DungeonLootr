--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CooldownOverlay
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.CooldownOverlay
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});

local function bump(p3: userdata) -- Line: 32
    -- upvalues: u2 (copy)
    local v4 = (u2[p3] or 0) + 1;
    u2[p3] = v4;

    return v4;
end;

function v1.Reset(p5: userdata?, p6: userdata?) -- Line: 40
    -- upvalues: u2 (copy)
    if p5 then
        u2[p5] = (u2[p5] or 0) + 1;
        p5.BackgroundTransparency = 1;
        p5.Visible = false;
    end;

    if p6 then
        p6.TextTransparency = 1;
    end;
end;

function v1.Show(p7: userdata?, p8: userdata?) -- Line: 52
    -- upvalues: u2 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    if not p7 then
        return;
    end;

    u2[p7] = (u2[p7] or 0) + 1;
    p7.Visible = true;
    TweenService:Create(p7, TweenInfo_new_ret, {
        BackgroundTransparency = 0.2
    }):Play();

    if p8 then
        TweenService:Create(p8, TweenInfo_new_ret, {
            TextTransparency = 0
        }):Play();
    end;
end;

function v1.Hide(u9: userdata?, p10: userdata?) -- Line: 63
    -- upvalues: u2 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    if not u9 then
        return;
    end;

    local u11 = (u2[u9] or 0) + 1;
    u2[u9] = u11;
    local v12 = TweenService:Create(u9, TweenInfo_new_ret, {
        BackgroundTransparency = 1
    });
    v12:Play();

    if p10 then
        TweenService:Create(p10, TweenInfo_new_ret, {
            TextTransparency = 1
        }):Play();
    end;

    v12.Completed:Once(function(p13) -- Line: 75
        -- upvalues: u2 (ref), u9 (copy), u11 (copy)
        if p13 ~= Enum.PlaybackState.Completed then
            return;
        end;

        if u2[u9] ~= u11 then
            return;
        end;

        if u9.Parent then
            u9.Visible = false;
        end;
    end);
end;

return v1;