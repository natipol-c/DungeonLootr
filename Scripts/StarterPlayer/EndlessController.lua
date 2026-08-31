--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EndlessController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.EndlessController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LoadingOverlay = require(ReplicatedStorage.ClientTools.LoadingOverlay);
local v1 = Knit.CreateController({
    Name = "EndlessController"
});
local u2 = false;

local function buildMessage(p3: number, p4: number) -- Line: 34
    return string.format("<b>Checkpoint %d cleared!</b>\n\nContinue and the dungeon regenerates — enemies grow <b>+30%%</b> stronger (next ×%.2f) and your lives refill.\n\n<font color=\"#ff8888\">Run out of lives past this checkpoint and you lose everything gained since it.</font>\n<i>Extract now to bank your run safely.</i>", (p3 or 0) + 1, p4 or 1);
end;

function v1._OnDecision(p5, p6) -- Line: 45
    -- upvalues: u2 (ref), Knit (copy)
    if u2 then
        return;
    end;

    u2 = true;
    local v7 = p6 and (p6.Seconds or 60) or 60;
    local u8 = p6 and (p6.ExtensionIndex or 0) or 0;
    local u9 = p6 and p6.NextMult or 1;
    local u10 = os.clock() + v7;
    task.spawn(function() -- Line: 54
        -- upvalues: Knit (ref), u10 (copy), u2 (ref), u8 (copy), u9 (copy)
        local Controller = Knit.GetController("WarningController");
        local Controller2 = Knit.GetController("ChestSelectionController");
        local Service = Knit.GetService("DungeonRunService");

        while Controller2 and (Controller2:IsActive() and os.clock() < u10 - 1) do
            task.wait(0.2);
        end;

        if not u2 then
            return;
        end;

        local task_spawn_ret = task.spawn(function() -- Line: 68
            -- upvalues: u2 (ref), u10 (ref), Controller (copy)
            while u2 and os.clock() < u10 do
                task.wait(0.25);
            end;

            if u2 and Controller then
                pcall(function() -- Line: 73
                    -- upvalues: Controller (ref)
                    Controller:Dismiss();
                end);
            end;
        end);
        local u11 = false;
        local v12;

        if Controller then
            v12 = pcall(function() -- Line: 80
                -- upvalues: u11 (ref), Controller (copy), u8 (ref), u9 (ref)
                u11 = Controller:Prompt({
                    ConfirmText = "Continue",
                    DenyText = "Extract",
                    Message = string.format("<b>Checkpoint %d cleared!</b>\n\nContinue and the dungeon regenerates — enemies grow <b>+30%%</b> stronger (next ×%.2f) and your lives refill.\n\n<font color=\"#ff8888\">Run out of lives past this checkpoint and you lose everything gained since it.</font>\n<i>Extract now to bank your run safely.</i>", (u8 or 0) + 1, u9 or 1)
                });
            end);
        else
            v12 = false;
        end;

        u2 = false;
        pcall(task.cancel, task_spawn_ret);

        if not v12 then
            return;
        end;

        Service:SubmitEndlessChoice(u11 == true);
    end);
end;

function v1._OnTransition(p13: table, p14: string) -- Line: 97
    -- upvalues: u2 (ref), Knit (copy), LoadingOverlay (copy)
    if p14 ~= "Begin" then
        if p14 == "Done" then
            LoadingOverlay.Hide();
        end;

        return;
    end;

    u2 = false;
    local Controller = Knit.GetController("WarningController");

    if Controller then
        pcall(function() -- Line: 102
            -- upvalues: Controller (copy)
            Controller:Dismiss();
        end);
    end;

    LoadingOverlay.Show({
        StatusText = "Descending",
        AnchorHRP = false
    });
end;

function v1.KnitStart(u15) -- Line: 110
    -- upvalues: Knit (copy)
    local Service = Knit.GetService("DungeonRunService");
    Service.EndlessDecision:Connect(function(p16) -- Line: 113
        -- upvalues: u15 (copy)
        u15:_OnDecision(p16);
    end);
    Service.EndlessTransition:Connect(function(p17) -- Line: 117
        -- upvalues: u15 (copy)
        u15:_OnTransition(p17);
    end);
end;

function v1.KnitInit(p18) -- Line: 122
end;

return v1;