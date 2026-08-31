--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Right
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UI.Right
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UIController = require(script.Parent.Parent.Controllers.UIController);
local v1 = {};
local u2 = nil;
local u3 = {
    Quests = "Quests"
};
local u4 = {
    Quests = true
};
local TweenInfo_new_ret = TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

local function wireButtonHoverReveal(p5: userdata) -- Line: 44
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
    local Background = p5:FindFirstChild("Background");

    if Background then
        Background = Background:FindFirstChildOfClass("CanvasGroup");
    end;

    if not Background then
        return;
    end;

    local Size = Background.Size;
    local UDim2_new_ret = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset);
    Background.Size = UDim2_new_ret;
    Background.GroupTransparency = 1;
    local u6 = nil;
    local u7 = nil;

    local function playTo(p8: number, p9) -- Line: 55
        -- upvalues: u6 (ref), u7 (ref), TweenService (ref), Background (copy), TweenInfo_new_ret (ref), TweenInfo_new_ret2 (ref)
        if u6 then
            u6:Cancel();
        end;

        if u7 then
            u7:Cancel();
        end;

        u6 = TweenService:Create(Background, TweenInfo_new_ret, {
            GroupTransparency = p8
        });
        u7 = TweenService:Create(Background, TweenInfo_new_ret2, {
            Size = p9
        });
        u6:Play();
        u7:Play();
    end;

    p5.MouseEnter:Connect(function() -- Line: 64
        -- upvalues: playTo (copy), Size (copy)
        playTo(0, Size);
    end);
    p5.MouseLeave:Connect(function() -- Line: 65
        -- upvalues: playTo (copy), UDim2_new_ret (copy)
        playTo(1, UDim2_new_ret);
    end);
end;

function v1._Init(p10) -- Line: 68
    -- upvalues: u2 (ref), ReplicatedStorage (copy), u4 (copy), wireButtonHoverReveal (copy), u3 (copy), UIController (copy)
    u2 = p10;
    local Right = u2.HUD.Actions:FindFirstChild("Right");

    if not Right then
        return;
    end;

    local Buttons = Right:FindFirstChild("Buttons");

    if not Buttons then
        warn("[Right] HUD.Actions.Right.Buttons missing — no buttons wired");

        return;
    end;

    local v11 = ReplicatedStorage:GetAttribute("IsDungeon") == true;

    for _, child in Buttons:GetChildren() do
        if child:IsA("GuiButton") then
            if v11 and u4[child.Name] then
                child.Visible = false;
            else
                wireButtonHoverReveal(child);
            end;
        end;
    end;

    for i, v in u3 do
        if not (v11 and u4[i]) then
            local v12 = Buttons:FindFirstChild(i);

            if v12 then
                local v13 = u2.Frames:FindFirstChild(v);

                if v13 then
                    local u14 = UIController._cached[v13];

                    if not u14 then
                        u14 = UIController.new(v13);
                        local v15 = v13:FindFirstChild("Exit", true) or v13:FindFirstChild("Close", true);

                        if v15 and v15:IsA("GuiButton") then
                            v15.MouseButton1Click:Connect(function() -- Line: 120
                                -- upvalues: u14 (ref)
                                u14:close();
                            end);
                        end;
                    end;

                    v12.Activated:Connect(function() -- Line: 126
                        -- upvalues: u14 (ref)
                        u14:toggle();
                    end);
                else
                    warn((`[Right] Buttons.{i}: no Frames.{v} — skipping`));
                end;
            end;
        end;
    end;
end;

return v1;