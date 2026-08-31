--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BossHealthBars
  Path:     game.ReplicatedStorage.ClientTools.BossHealthBars
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:28 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DungeonData = require(ReplicatedStorage:WaitForChild("GameInfo"):WaitForChild("DungeonData"));
local u1 = {};
local u2 = {
    Color3.fromRGB(255, 234, 79),
    Color3.fromRGB(49, 101, 225),
    Color3.fromRGB(115, 46, 194),
    Color3.fromRGB(138, 0, 44)
};
u1.Manual = {};
local u3 = {
    healthBar = nil,
    countLabel = nil,
    original = nil,
    trail = nil,
    originalTint = nil,
    barCount = 1,
    activeIndex = 1,
    bossKey = nil,
    layers = {}
};
local u4 = nil;

local function BuildDataOverrides() -- Line: 92
    -- upvalues: u4 (ref), DungeonData (copy)
    u4 = {};

    local function scan(p5) -- Line: 94
        -- upvalues: u4 (ref)
        if p5 and (p5.Name and tonumber(p5.HealthBars)) then
            u4[p5.Name] = tonumber(p5.HealthBars);
        end;
    end;

    for _, v in DungeonData.Dungeons do
        local Boss = v.Boss;

        if Boss and (Boss.Name and tonumber(Boss.HealthBars)) then
            u4[Boss.Name] = tonumber(Boss.HealthBars);
        end;

        local MiniBoss = v.MiniBoss;

        if MiniBoss and (MiniBoss.Name and tonumber(MiniBoss.HealthBars)) then
            u4[MiniBoss.Name] = tonumber(MiniBoss.HealthBars);
        end;

        local SpecialBoss = v.SpecialBoss;

        if SpecialBoss and (SpecialBoss.Name and tonumber(SpecialBoss.HealthBars)) then
            u4[SpecialBoss.Name] = tonumber(SpecialBoss.HealthBars);
        end;
    end;
end;

local function TintForDepth(p6: number) -- Line: 107
    -- upvalues: u3 (copy), u2 (copy)
    if p6 <= 1 then
        return u3.originalTint or Color3.fromRGB(214, 214, 214);
    end;

    return u2[(p6 - 2) % #u2 + 1];
end;

local function SetupLayers(p7: number) -- Line: 116
    -- upvalues: u3 (copy), u2 (copy)
    local healthBar = u3.healthBar;
    local original = u3.original;

    if not (healthBar and original) then
        return;
    end;

    local math_clamp_ret = math.clamp(p7 or 1, 1, 10);

    for _, child in healthBar:GetChildren() do
        if child ~= original and child.Name:match("^Health_Color_%d+$") then
            child:Destroy();
        end;
    end;

    table.clear(u3.layers);
    u3.barCount = math_clamp_ret;
    u3.activeIndex = math_clamp_ret;

    for i = 1, math_clamp_ret do
        local v8;

        if i == math_clamp_ret then
            v8 = original;
        else
            v8 = original:Clone();
            v8.Name = "Health_Color_" .. i;
            v8.Parent = healthBar;
        end;

        v8.ZIndex = i * 2;
        local v9 = math_clamp_ret - i + 1;
        local v10;

        if v9 <= 1 then
            v10 = u3.originalTint or Color3.fromRGB(214, 214, 214);
        else
            v10 = u2[(v9 - 2) % #u2 + 1];
        end;

        v8.ImageColor3 = v10;
        v8.Size = UDim2.fromScale(1, 1);
        u3.layers[i] = v8;
        local _ = i;
    end;

    if u3.trail then
        u3.trail.ZIndex = math_clamp_ret * 2 - 1;
        u3.trail.Size = UDim2.fromScale(1, 1);
    end;

    if u3.countLabel then
        u3.countLabel.Text = "x" .. math_clamp_ret;
        u3.countLabel.Visible = math_clamp_ret > 1;
    end;
end;

function u1.GetBarCount(p11: string?, p12: number) -- Line: 161
    -- upvalues: u1 (copy), u4 (ref), BuildDataOverrides (copy)
    local v13;

    if p11 then
        v13 = u1.Manual[p11] or nil;
    else
        v13 = nil;
    end;

    if not v13 and p11 then
        if not u4 then
            BuildDataOverrides();
        end;

        v13 = u4[p11];
    end;

    if v13 then
        return math.clamp(v13, 1, 10);
    end;

    if not p12 or p12 < 20000 then
        return 1;
    end;

    local math_log_ret = math.log(p12 / 10000, 2);
    local v14 = math.floor(math_log_ret) + 1;

    return math.clamp(v14, 1, 5);
end;

function u1.SetRefs(p15: userdata?, p16: userdata?) -- Line: 179
    -- upvalues: u3 (copy)
    u3.healthBar = p15;
    u3.countLabel = p16;
    local v17;

    if p15 then
        v17 = p15:FindFirstChild("Health_Color");
    else
        v17 = p15;
    end;

    u3.original = v17;
    local v18;

    if p15 then
        v18 = p15:FindFirstChild("Trail");
    else
        v18 = p15;
    end;

    u3.trail = v18;
    u3.bossKey = nil;

    if p16 then
        p16.Visible = false;
    end;

    if u3.original and not u3.originalTint then
        u3.originalTint = u3.original.ImageColor3;
    end;

    if p15 then
        for _, child in p15:GetChildren() do
            if child.Name == "Star" then
                child.ZIndex = 21;
            elseif child.Name == "Amount" then
                child.ZIndex = 22;
            end;
        end;
    end;
end;

function u1.Prime(p19: string?, p20: number?) -- Line: 210
    -- upvalues: u3 (copy), SetupLayers (copy), u1 (copy)
    if not u3.healthBar then
        return;
    end;

    u3.bossKey = tostring(p19) .. "|" .. tostring(p20);
    SetupLayers(u1.GetBarCount(p19, p20 or 0));
end;

function u1.Update(p21: number, p22: number, p23: string?) -- Line: 219
    -- upvalues: u3 (copy), SetupLayers (copy), u1 (copy)
    if not (u3.healthBar and u3.original) then
        return;
    end;

    local v24 = tostring(p23) .. "|" .. tostring(p22);

    if v24 ~= u3.bossKey then
        u3.bossKey = v24;
        SetupLayers(u1.GetBarCount(p23, p22));
    end;

    local v25 = (p22 > 0 and math.clamp(p21 / p22, 0, 1) or 0) * u3.barCount;

    for i, v in u3.layers do
        v.Size = UDim2.fromScale(math.clamp(v25 - (i - 1), 0, 1), 1);
    end;

    local math_ceil_ret = math.ceil(v25);
    local math_clamp_ret = math.clamp(math_ceil_ret, 1, u3.barCount);

    if math_clamp_ret ~= u3.activeIndex then
        u3.activeIndex = math_clamp_ret;

        if u3.trail then
            u3.trail.ZIndex = math_clamp_ret * 2 - 1;
            u3.trail.Size = UDim2.fromScale(v25 > 0 and 1 or 0, 1);
        end;
    end;

    if u3.countLabel then
        local v26 = v25 > 0 and math.ceil(v25) or 0;
        u3.countLabel.Text = "x" .. v26;
        u3.countLabel.Visible = u3.barCount > 1;
    end;
end;

function u1.GetActiveSize() -- Line: 257
    -- upvalues: u3 (copy)
    local v27 = u3.layers[u3.activeIndex];

    return v27 and v27.Size or nil;
end;

function u1.ResetToFull() -- Line: 263
    -- upvalues: u3 (copy)
    for _, v in u3.layers do
        v.Size = UDim2.fromScale(1, 1);
    end;

    u3.activeIndex = u3.barCount;

    if u3.trail then
        u3.trail.ZIndex = 2 * u3.barCount - 1;
        u3.trail.Size = UDim2.fromScale(1, 1);
    end;

    if u3.countLabel then
        u3.countLabel.Text = "x" .. u3.barCount;
        u3.countLabel.Visible = u3.barCount > 1;
    end;
end;

return u1;