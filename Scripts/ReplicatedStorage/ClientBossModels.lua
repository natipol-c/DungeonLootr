--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClientBossModels
  Path:     game.ReplicatedStorage.GameInfo.ClientBossModels
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local DungeonData = require(script.Parent.DungeonData);
local BossRushData = require(script.Parent.BossRushData);
local ChallengeData = require(script.Parent.ChallengeData);
local RaidData = require(script.Parent.RaidData);
local v1 = {};

for _, v in DungeonData.Dungeons do
    if v.Boss and v.Boss.HeroId then
        v1[v.Boss.HeroId] = true;
    end;

    if v.BossRotation then
        for _, v2 in v.BossRotation do
            if v2.HeroId then
                v1[v2.HeroId] = true;
            end;
        end;
    end;
end;

for _, v in BossRushData.FINAL_BOSS_ORDER do
    local FinalBoss = BossRushData.GetFinalBoss(v);

    if FinalBoss and FinalBoss.BossId then
        v1[FinalBoss.BossId] = true;
    end;
end;

for _, v in ChallengeData.BOSS_PREVIEW_ORDER do
    if v.HeroId then
        v1[v.HeroId] = true;
    end;
end;

for _, v in RaidData.RAID_ORDER do
    local Raid = RaidData.GetRaid(v);

    if Raid and Raid.BossId then
        v1[Raid.BossId] = true;
    end;
end;

local v2 = {};

for i in v1 do
    table.insert(v2, i);
end;

table.sort(v2);

return {
    Set = v1,
    List = v2
};