--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DungeonNotificationController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.DungeonNotificationController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local ClassMasteryData = require(ReplicatedStorage.GameInfo.ClassMasteryData);
local v1 = Knit.CreateController({
    Name = "DungeonNotificationController"
});
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = {};
local u8 = false;

local function PlayNotification(p9: userdata, p10: function) -- Line: 48
    -- upvalues: u2 (ref), TweenService (copy)
    if not u2 then
        return;
    end;

    local Attribute = p9:GetAttribute("Hidden");
    local Attribute2 = p9:GetAttribute("Start");

    if not (Attribute and Attribute2) then
        warn("[DungeonNotification] Missing Hidden/Start attributes on", p9.Name);

        return;
    end;

    local UDim2_new_ret = UDim2.new(Attribute2.X.Scale, Attribute2.X.Offset, Attribute2.Y.Scale + -0.05, Attribute2.Y.Offset);
    p9.Position = Attribute;
    u2.GroupTransparency = 1;
    p9.Visible = true;
    p10();
    local v11 = TweenService:Create(p9, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = Attribute2
    });
    local v12 = TweenService:Create(u2, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    });
    v11:Play();
    v12:Play();
    v11.Completed:Wait();
    task.wait(1);
    local v13 = TweenService:Create(p9, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2_new_ret
    });
    local v14 = TweenService:Create(u2, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        GroupTransparency = 1
    });
    v13:Play();
    v14:Play();
    v14.Completed:Wait();
    p9.Visible = false;
    p9.Position = Attribute;
end;

local function ProcessQueue() -- Line: 114
    -- upvalues: u8 (ref), u7 (copy), PlayNotification (copy)
    if u8 then
        return;
    end;

    if #u7 == 0 then
        return;
    end;

    u8 = true;

    while #u7 > 0 do
        local table_remove_ret = table.remove(u7, 1);
        PlayNotification(table_remove_ret.Frame, table_remove_ret.Populate);
    end;

    u8 = false;
end;

local function QueueNotification(p15: userdata, p16: function) -- Line: 126
    -- upvalues: u7 (copy), ProcessQueue (copy)
    table.insert(u7, {
        Frame = p15,
        Populate = p16
    });
    task.spawn(ProcessQueue);
end;

function v1.KnitInit(p17) -- Line: 133
    -- upvalues: Knit (copy), u2 (ref), u3 (ref), u4 (ref), u5 (ref)
    local Dungeon_Container = Knit.PlayerGui:WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("Dungeon_Container");

    if not Dungeon_Container then
        return;
    end;

    u2 = Dungeon_Container:FindFirstChild("Notification_Canvas");

    if not u2 then
        warn("[DungeonNotificationController] Notification_Canvas not found");

        return;
    end;

    u2.GroupTransparency = 1;
    u3 = u2:FindFirstChild("Level_Up");
    u4 = u2:FindFirstChild("Zone_Cleared");
    u5 = u2:FindFirstChild("Boss_Slain");
end;

function v1.KnitStart(p18) -- Line: 154
    -- upvalues: u2 (ref), Knit (copy), u6 (ref), u5 (ref), u7 (copy), ProcessQueue (copy), u4 (ref), u3 (ref), ClassMasteryData (copy)
    if not u2 then
        return;
    end;

    local Service = Knit.GetService("DungeonRunService");
    local Service2 = Knit.GetService("LevelService");
    pcall(function() -- Line: 160
        -- upvalues: u6 (ref), Knit (ref)
        u6 = Knit.GetController("SoundController");
    end);
    Service.PhaseChange:Connect(function(p19: string, p20: any) -- Line: 165
        -- upvalues: u5 (ref), u6 (ref), u7 (ref), ProcessQueue (ref), u4 (ref)
        if p19 == "BossDefeated" then
            if u5 then
                table.insert(u7, {
                    Frame = u5,

                    Populate = function() -- Line: 169
                        -- upvalues: u6 (ref)
                        if u6 then
                            u6:Play("LevelUP1");
                        end;
                    end
                });
                task.spawn(ProcessQueue);
            end;

            return;
        end;

        if not u4 then
            return;
        end;

        if p19 == "RoomCleared" and p20 then
            local u21 = p20.ZonesLeft or (p20.TotalRooms or 0) - (p20.RoomIndex or 0);
            table.insert(u7, {
                Frame = u4,

                Populate = function() -- Line: 184
                    -- upvalues: u4 (ref), u21 (copy)
                    local Zone_Text = u4:FindFirstChild("Zone_Text");

                    if Zone_Text then
                        Zone_Text.Text = "Zones Left: " .. u21;
                    end;
                end
            });
            task.spawn(ProcessQueue);

            return;
        end;

        if p19 == "RushRoom" then
            table.insert(u7, {
                Frame = u4,

                Populate = function() -- Line: 192
                    -- upvalues: u4 (ref)
                    local Title = u4:FindFirstChild("Title");

                    if Title then
                        Title.Text = "RUSH INBOUND";
                        local BossGradient = Title:FindFirstChild("BossGradient");

                        if BossGradient then
                            BossGradient.Enabled = true;
                        end;

                        local UIStroke = Title:FindFirstChild("UIStroke");

                        if UIStroke then
                            UIStroke.Enabled = true;
                        end;
                    end;

                    local Zone_Text = u4:FindFirstChild("Zone_Text");

                    if Zone_Text then
                        Zone_Text.Text = "ELIMINATE ALL ENEMIES";
                    end;
                end
            });
            task.spawn(ProcessQueue);
            task.delay(2.5, function() -- Line: 207
                -- upvalues: u4 (ref)
                local Title = u4:FindFirstChild("Title");

                if Title then
                    Title.Text = "Zone Cleared";
                    local BossGradient = Title:FindFirstChild("BossGradient");

                    if BossGradient then
                        BossGradient.Enabled = false;
                    end;

                    local UIStroke = Title:FindFirstChild("UIStroke");

                    if UIStroke then
                        UIStroke.Enabled = false;
                    end;
                end;
            end);

            return;
        end;

        if p19 == "MightRoom" then
            table.insert(u7, {
                Frame = u4,

                Populate = function() -- Line: 220
                    -- upvalues: u4 (ref)
                    local Title = u4:FindFirstChild("Title");

                    if Title then
                        Title.Text = "MIGHT CHALLENGE";
                        local BossGradient = Title:FindFirstChild("BossGradient");

                        if BossGradient then
                            BossGradient.Enabled = true;
                        end;

                        local UIStroke = Title:FindFirstChild("UIStroke");

                        if UIStroke then
                            UIStroke.Enabled = true;
                        end;
                    end;

                    local Zone_Text = u4:FindFirstChild("Zone_Text");

                    if Zone_Text then
                        Zone_Text.Text = "DEFEAT THE CHAMPIONS";
                    end;
                end
            });
            task.spawn(ProcessQueue);
            task.delay(2.5, function() -- Line: 235
                -- upvalues: u4 (ref)
                local Title = u4:FindFirstChild("Title");

                if Title then
                    Title.Text = "Zone Cleared";
                    local BossGradient = Title:FindFirstChild("BossGradient");

                    if BossGradient then
                        BossGradient.Enabled = false;
                    end;

                    local UIStroke = Title:FindFirstChild("UIStroke");

                    if UIStroke then
                        UIStroke.Enabled = false;
                    end;
                end;
            end);

            return;
        end;

        if p19 ~= "SpecialBossSummoned" then
            if p19 == "SkullTotemActivated" then
                table.insert(u7, {
                    Frame = u4,

                    Populate = function() -- Line: 275
                        -- upvalues: u4 (ref)
                        local Title = u4:FindFirstChild("Title");

                        if Title then
                            Title.Text = "CHALLENGE ACTIVATED";
                            local BossGradient = Title:FindFirstChild("BossGradient");

                            if BossGradient then
                                BossGradient.Enabled = true;
                            end;

                            local UIStroke = Title:FindFirstChild("UIStroke");

                            if UIStroke then
                                UIStroke.Enabled = true;
                            end;
                        end;

                        local Zone_Text = u4:FindFirstChild("Zone_Text");

                        if Zone_Text then
                            Zone_Text.Text = "DOUBLE BOSS SPAWN";
                        end;
                    end
                });
                task.spawn(ProcessQueue);
                task.delay(2.5, function() -- Line: 290
                    -- upvalues: u4 (ref)
                    local Title = u4:FindFirstChild("Title");

                    if Title then
                        local BossGradient = Title:FindFirstChild("BossGradient");

                        if BossGradient then
                            BossGradient.Enabled = false;
                        end;

                        local UIStroke = Title:FindFirstChild("UIStroke");

                        if UIStroke then
                            UIStroke.Enabled = false;
                        end;
                    end;
                end);
            end;

            return;
        end;

        table.insert(u7, {
            Frame = u4,

            Populate = function() -- Line: 248
                -- upvalues: u4 (ref)
                local Title = u4:FindFirstChild("Title");

                if Title then
                    Title.Text = "SPECIAL BOSS SUMMONED";
                    local BossGradient = Title:FindFirstChild("BossGradient");

                    if BossGradient then
                        BossGradient.Enabled = true;
                    end;

                    local UIStroke = Title:FindFirstChild("UIStroke");

                    if UIStroke then
                        UIStroke.Enabled = true;
                    end;
                end;

                local Zone_Text = u4:FindFirstChild("Zone_Text");

                if Zone_Text then
                    Zone_Text.Text = "PREPARE FOR BATTLE";
                end;
            end
        });
        task.spawn(ProcessQueue);
        task.delay(2.5, function() -- Line: 263
            -- upvalues: u4 (ref)
            local Title = u4:FindFirstChild("Title");

            if Title then
                Title.Text = "Zone Cleared";
                local BossGradient = Title:FindFirstChild("BossGradient");

                if BossGradient then
                    BossGradient.Enabled = false;
                end;

                local UIStroke = Title:FindFirstChild("UIStroke");

                if UIStroke then
                    UIStroke.Enabled = false;
                end;
            end;
        end);
    end);
    Service2.PlayerLevelUp:Connect(function(u22: number, u23: number) -- Line: 303
        -- upvalues: u3 (ref), u7 (ref), ProcessQueue (ref)
        if not u3 then
            return;
        end;

        table.insert(u7, {
            Frame = u3,

            Populate = function() -- Line: 306
                -- upvalues: u3 (ref), u22 (copy), u23 (copy)
                local Title = u3:FindFirstChild("Title");

                if Title then
                    Title.Text = "Level Up!";
                end;

                local Level_Text = u3:FindFirstChild("Level_Text");

                if Level_Text then
                    Level_Text.Text = "Level " .. u22 - 1 .. " -> " .. u22;
                end;

                local Stat_Text = u3:FindFirstChild("Stat_Text");

                if Stat_Text then
                    if u23 > 1 then
                        Stat_Text.Text = "+" .. u23 .. " Stat Points";

                        return;
                    end;

                    Stat_Text.Text = "+1 Stat Point";
                end;
            end
        });
        task.spawn(ProcessQueue);
    end);
    Service2.ClassLevelUp:Connect(function(u24: string, u25: number) -- Line: 333
        -- upvalues: u3 (ref), ClassMasteryData (ref), u7 (ref), ProcessQueue (ref)
        if not u3 then
            return;
        end;

        table.insert(u7, {
            Frame = u3,

            Populate = function() -- Line: 336
                -- upvalues: u3 (ref), u24 (copy), u25 (copy), ClassMasteryData (ref)
                local Title = u3:FindFirstChild("Title");

                if Title then
                    Title.Text = "Class Level Up!";
                end;

                local Level_Text = u3:FindFirstChild("Level_Text");

                if Level_Text then
                    Level_Text.Text = u24 .. " Lv. " .. u25 - 1 .. " -> " .. u25;
                end;

                local Stat_Text = u3:FindFirstChild("Stat_Text");

                if Stat_Text then
                    local MilestonesAtLevel = ClassMasteryData.GetMilestonesAtLevel(u24, u25);

                    if #MilestonesAtLevel > 0 then
                        local v26 = {};

                        for _, v in MilestonesAtLevel do
                            if v.Type == "SkillDamage" then
                                local v27 = "Skill " .. v.Slot .. " DMG +" .. math.floor(v.Bonus * 100) .. "%";
                                table.insert(v26, v27);
                            elseif v.Type == "Stat" then
                                table.insert(v26, "+" .. v.Value .. " " .. v.Stat);
                            elseif v.Type == "CooldownReduction" then
                                table.insert(v26, "Cooldown -" .. v.Value .. "%");
                            elseif v.Type == "ItemReward" then
                                table.insert(v26, "Reward Unlocked!");
                            end;
                        end;

                        Stat_Text.Text = table.concat(v26, ", ");

                        return;
                    end;

                    Stat_Text.Text = "";
                end;
            end
        });
        task.spawn(ProcessQueue);
    end);
end;

return v1;