--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GIF
  Path:     game.ReplicatedStorage.Assets.UI.Purchase Pending.Frame.gif.LocalScript.GIF
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:04 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5, p6, p7) -- Line: 5
    -- upvalues: u1 (copy)
    local u8 = setmetatable({}, u1);
    u8.ImageLabel = p2;
    u8.SpritesheetImageId = p3 or p2.Image;
    u8.Columns = p4 or 5;
    u8.Rows = p5 or 5;
    u8.TotalFrames = p6 or 25;
    u8.FramesPerSecond = p7 or 29;
    u8.CurrentFrame = 1;
    u8.IsPlaying = false;
    u8.Timing = tick();
    u8.AnimationFunction = nil;
    u8.FrameUpdated = false;
    u8.ImageLabel.Image = u8.SpritesheetImageId;
    u8.ImageLabel.Size = UDim2.new(u8.Columns, 0, u8.Rows, 0);
    u8.RSConnection = game:GetService("RunService").Heartbeat:Connect(function() -- Line: 26
        -- upvalues: u8 (copy)
        u8:Update();
    end);

    return u8;
end;

function u1.Play(p9) -- Line: 34
    p9.IsPlaying = true;
end;

function u1.Pause(p10) -- Line: 39
    p10.IsPlaying = false;
end;

function u1.Stop(p11) -- Line: 44
    p11.IsPlaying = false;
    p11.CurrentFrame = 1;
    p11:UpdateFrame(p11.CurrentFrame);
end;

function u1.GoToFrame(p12, p13) -- Line: 51
    p12.CurrentFrame = math.clamp(p13, 1, p12.TotalFrames);
    p12:UpdateFrame(p12.CurrentFrame);
end;

function u1.UpdateFrame(p14, p15) -- Line: 57
    local v16 = 1;

    while true do
        if p14.Columns < p15 then
            p15 = p15 - p14.Columns;
            v16 = v16 + 1;
        end;

        if p14.Columns >= p15 then
            p14.ImageLabel.Position = UDim2.new(-(p15 - 1), 0, -(v16 - 1), 0);

            return;
        end;
    end;
end;

function u1.Update(p17) -- Line: 74
    if p17.IsPlaying and tick() - p17.Timing >= 1 / p17.FramesPerSecond then
        p17.CurrentFrame = p17.CurrentFrame + 1;

        if p17.CurrentFrame > p17.TotalFrames then
            p17.CurrentFrame = 1;
        end;

        p17:UpdateFrame(p17.CurrentFrame);

        if p17.AnimationFunction then
            p17.AnimationFunction();
        end;

        p17.Timing = tick();
    end;
end;

function u1.Destroy(p18) -- Line: 95
    p18.IsPlaying = false;
    p18.ImageLabel = nil;
    p18.SpritesheetImageId = nil;
    p18.Columns = nil;
    p18.Rows = nil;
    p18.TotalFrames = nil;
    p18.FramesPerSecond = nil;

    if p18.RSConnection then
        p18.RSConnection:Disconnect();
    end;
end;

function u1.SetAnimationFunction(p19, p20) -- Line: 109
    p19.AnimationFunction = p20;
end;

return u1;