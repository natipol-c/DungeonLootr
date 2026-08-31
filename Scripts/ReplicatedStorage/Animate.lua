--[[
  Type:     Script[Client]
  Method:   decompile
  Name:     Animate
  Path:     game.ReplicatedStorage.Assets.Scripts.Animate
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:04 2026
]]

-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;
local u1 = script_Parent:FindFirstChildWhichIsA("Humanoid");
local v2 = u1 or script_Parent:FindFirstChildWhichIsA("AnimationController");
local v3 = 0;

while not (v2 and v2:FindFirstChildOfClass("Animator")) and (v3 < 5 and script_Parent.Parent ~= nil) do
    task.wait(0.1);
    v3 = v3 + 0.1;
    u1 = u1 or script_Parent:FindFirstChildWhichIsA("Humanoid");
    v2 = u1 or script_Parent:FindFirstChildWhichIsA("AnimationController");
end;

if not v2 then
    return;
end;

local u4 = v2:FindFirstChildOfClass("Animator");

if not u4 then
    return;
end;

local u5 = "Standing";
local success, result = pcall(function() -- Line: 30
    return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop");
end);
local u6 = success and result;
local success2, result2 = pcall(function() -- Line: 33
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun");
end);
local u7 = success2 and result2;

local function getRigScale() -- Line: 36
    -- upvalues: u7 (copy), script_Parent (copy)
    return not u7 and 1 or script_Parent:GetScale();
end;

local ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent");
local u8 = "";
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = 1;
local u13 = nil;
local u14 = nil;
local u15 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EnemyResolver = require(ReplicatedStorage:WaitForChild("GameInfo"):WaitForChild("EnemyResolver"));
local v16 = EnemyResolver(script.Parent.Name) or EnemyResolver(script.Parent:GetAttribute("ItemId"));

if not v16 then
    warn((`Item info not found for {script.Parent.Name}`));

    return;
end;

local v17 = v16.WalkAnim or "rbxassetid://122199389926212";
local u18 = {};
local u19 = {
    idle = {
        {
            weight = 1,
            id = v16.IdleAnim or "rbxassetid://86607592181647"
        }
    },
    walk = {
        {
            weight = 10,
            id = v17
        }
    },
    run = {
        {
            weight = 10,
            id = v17
        }
    },
    swim = { {
            id = "http://www.roblox.com/asset/?id=507784897",
            weight = 10
        } },
    swimidle = { {
            id = "http://www.roblox.com/asset/?id=507785072",
            weight = 10
        } },
    jump = { {
            id = "http://www.roblox.com/asset/?id=507765000",
            weight = 10
        } },
    fall = { {
            id = "http://www.roblox.com/asset/?id=507767968",
            weight = 10
        } },
    climb = { {
            id = "http://www.roblox.com/asset/?id=507765644",
            weight = 10
        } },
    sit = { {
            id = "http://www.roblox.com/asset/?id=2506281703",
            weight = 10
        } },
    toolnone = { {
            id = "http://www.roblox.com/asset/?id=507768375",
            weight = 10
        } },
    toolslash = { {
            id = "http://www.roblox.com/asset/?id=522635514",
            weight = 10
        } },
    toollunge = { {
            id = "http://www.roblox.com/asset/?id=522638767",
            weight = 10
        } },
    wave = { {
            id = "http://www.roblox.com/asset/?id=507770239",
            weight = 10
        } },
    point = { {
            id = "http://www.roblox.com/asset/?id=507770453",
            weight = 10
        } },
    dance = { {
            id = "http://www.roblox.com/asset/?id=507771019",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507771955",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507772104",
            weight = 10
        } },
    dance2 = { {
            id = "http://www.roblox.com/asset/?id=507776043",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507776720",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507776879",
            weight = 10
        } },
    dance3 = { {
            id = "http://www.roblox.com/asset/?id=507777268",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507777451",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507777623",
            weight = 10
        } },
    laugh = { {
            id = "http://www.roblox.com/asset/?id=507770818",
            weight = 10
        } },
    cheer = { {
            id = "http://www.roblox.com/asset/?id=507770677",
            weight = 10
        } }
};
local u20 = {
    wave = false,
    point = false,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};
math.randomseed(tick());

function findExistingAnimationInSet(p21, p22)
    if p21 == nil or p22 == nil then
        return 0;
    end;

    for i = 1, p21.count do
        if p21[i].anim.AnimationId == p22.AnimationId then
            return i;
        end;

        local _ = i;
    end;

    return 0;
end;

function configureAnimationSet(u23, u24)
    -- upvalues: u18 (copy), u15 (copy), u4 (copy)
    if u18[u23] ~= nil then
        for _, v in pairs(u18[u23].connections) do
            v:disconnect();
        end;
    end;

    u18[u23] = {};
    u18[u23].count = 0;
    u18[u23].totalWeight = 0;
    u18[u23].connections = {};
    local u25 = true;
    local success3, _ = pcall(function() -- Line: 174
        -- upvalues: u25 (ref)
        u25 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u25 = not success3 and true or u25;
    local v26 = script:FindFirstChild(u23);

    if u25 and v26 ~= nil then
        table.insert(u18[u23].connections, v26.ChildAdded:connect(function(p27) -- Line: 182
            -- upvalues: u23 (copy), u24 (copy)
            configureAnimationSet(u23, u24);
        end));
        table.insert(u18[u23].connections, v26.ChildRemoved:connect(function(p28) -- Line: 183
            -- upvalues: u23 (copy), u24 (copy)
            configureAnimationSet(u23, u24);
        end));

        for _, child in pairs(v26:GetChildren()) do
            if child:IsA("Animation") then
                local Weight = child:FindFirstChild("Weight");
                local v29 = Weight == nil and 1 or Weight.Value;
                u18[u23].count = u18[u23].count + 1;
                local count = u18[u23].count;
                u18[u23][count] = {};
                u18[u23][count].anim = child;
                u18[u23][count].weight = v29;
                u18[u23].totalWeight = u18[u23].totalWeight + u18[u23][count].weight;
                table.insert(u18[u23].connections, child.Changed:connect(function(p30) -- Line: 199
                    -- upvalues: u23 (copy), u24 (copy)
                    configureAnimationSet(u23, u24);
                end));
                table.insert(u18[u23].connections, child.ChildAdded:connect(function(p31) -- Line: 200
                    -- upvalues: u23 (copy), u24 (copy)
                    configureAnimationSet(u23, u24);
                end));
                table.insert(u18[u23].connections, child.ChildRemoved:connect(function(p32) -- Line: 201
                    -- upvalues: u23 (copy), u24 (copy)
                    configureAnimationSet(u23, u24);
                end));
            end;
        end;
    end;

    if u18[u23].count <= 0 then
        for i, v in pairs(u24) do
            u18[u23][i] = {};
            u18[u23][i].anim = Instance.new("Animation");
            u18[u23][i].anim.Name = u23;
            u18[u23][i].anim.AnimationId = v.id;
            u18[u23][i].weight = v.weight;
            u18[u23].count = u18[u23].count + 1;
            u18[u23].totalWeight = u18[u23].totalWeight + v.weight;
        end;
    end;

    for _, v in pairs(u18) do
        local v33 = v;

        for i = 1, v.count do
            local v34;

            if u15[v33[i].anim.AnimationId] == nil and (v33[i].anim and v33[i].anim.AnimationId ~= "") then
                u4:LoadAnimation(v33[i].anim);
                u15[v33[i].anim.AnimationId] = true;
                v34 = i;
            else
                v34 = i;
            end;
        end;
    end;
end;

function configureAnimationSetOld(u35, u36)
    -- upvalues: u18 (copy), u4 (copy)
    if u18[u35] ~= nil then
        for _, v in pairs(u18[u35].connections) do
            v:disconnect();
        end;
    end;

    u18[u35] = {};
    u18[u35].count = 0;
    u18[u35].totalWeight = 0;
    u18[u35].connections = {};
    local u37 = true;
    local success3, _ = pcall(function() -- Line: 247
        -- upvalues: u37 (ref)
        u37 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u37 = not success3 and true or u37;
    local v38 = script:FindFirstChild(u35);

    if u37 and v38 ~= nil then
        table.insert(u18[u35].connections, v38.ChildAdded:connect(function(p39) -- Line: 255
            -- upvalues: u35 (copy), u36 (copy)
            configureAnimationSet(u35, u36);
        end));
        table.insert(u18[u35].connections, v38.ChildRemoved:connect(function(p40) -- Line: 256
            -- upvalues: u35 (copy), u36 (copy)
            configureAnimationSet(u35, u36);
        end));
        local v41 = 1;

        for _, child in pairs(v38:GetChildren()) do
            if child:IsA("Animation") then
                table.insert(u18[u35].connections, child.Changed:connect(function(p42) -- Line: 260
                    -- upvalues: u35 (copy), u36 (copy)
                    configureAnimationSet(u35, u36);
                end));
                u18[u35][v41] = {};
                u18[u35][v41].anim = child;
                local Weight = child:FindFirstChild("Weight");

                if Weight == nil then
                    u18[u35][v41].weight = 1;
                else
                    u18[u35][v41].weight = Weight.Value;
                end;

                u18[u35].count = u18[u35].count + 1;
                u18[u35].totalWeight = u18[u35].totalWeight + u18[u35][v41].weight;
                v41 = v41 + 1;
            end;
        end;
    end;

    if u18[u35].count <= 0 then
        for i, v in pairs(u36) do
            u18[u35][i] = {};
            u18[u35][i].anim = Instance.new("Animation");
            u18[u35][i].anim.Name = u35;
            u18[u35][i].anim.AnimationId = v.id;
            u18[u35][i].weight = v.weight;
            u18[u35].count = u18[u35].count + 1;
            u18[u35].totalWeight = u18[u35].totalWeight + v.weight;
        end;
    end;

    for _, v in pairs(u18) do
        local v43 = v;

        for i = 1, v.count do
            u4:LoadAnimation(v43[i].anim);
            local _ = i;
        end;
    end;
end;

function scriptChildModified(p44)
    -- upvalues: u19 (copy)
    local v45 = u19[p44.Name];

    if v45 ~= nil then
        configureAnimationSet(p44.Name, v45);
    end;
end;

script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);

if u4 then
    local PlayingAnimationTracks = u4:GetPlayingAnimationTracks();

    for _, v in ipairs(PlayingAnimationTracks) do
        v:Stop(0);
        v:Destroy();
    end;
end;

for i, v in pairs(u19) do
    configureAnimationSet(i, v);
end;

local u46 = "None";
local u47 = 0;
local u48 = 0;
local u49 = false;

function stopAllAnimations()
    -- upvalues: u8 (ref), u20 (copy), u49 (ref), u9 (ref), u11 (ref), u10 (ref), u14 (ref), u13 (ref)
    local v50 = u8;
    local v51 = u20[v50] ~= nil and u20[v50] == false and "idle" or v50;

    if u49 then
        v51 = "idle";
        u49 = false;
    end;

    u8 = "";
    u9 = nil;

    if u11 ~= nil then
        u11:disconnect();
    end;

    if u10 ~= nil then
        u10:Stop();
        u10:Destroy();
        u10 = nil;
    end;

    if u14 ~= nil then
        u14:disconnect();
    end;

    if u13 ~= nil then
        u13:Stop();
        u13:Destroy();
        u13 = nil;
    end;

    return v51;
end;

function getHeightScale()
    -- upvalues: u1 (ref), getRigScale (copy), ScaleDampeningPercent (ref)
    if not u1 then
        return getRigScale();
    end;

    if not u1.AutomaticScalingEnabled then
        return getRigScale();
    end;

    local v52 = u1.HipHeight / 2;

    if ScaleDampeningPercent == nil then
        ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent");
    end;

    if ScaleDampeningPercent ~= nil then
        v52 = 1 + (u1.HipHeight - 2) * ScaleDampeningPercent.Value / 2;
    end;

    return v52;
end;

local function rootMotionCompensation(p53) -- Line: 399
    return p53 * 1.25 / getHeightScale();
end;

local function setRunSpeed(p54) -- Line: 407
    -- upvalues: u10 (ref), u13 (ref)
    local v55 = p54 * 1.25 / getHeightScale();
    local v56 = 0.0001;
    local v57 = 0.0001;

    if v55 <= 0.5 then
        local _ = v55 / 0.5;
        v56 = 1;
    elseif v55 < 1 then
        v57 = (v55 - 0.5) / 0.5;
        v56 = 1 - v57;
    else
        local _ = v55 / 1;
        v57 = 1;
    end;

    u10:AdjustWeight(v56);
    u13:AdjustWeight(v57);
end;

function setAnimationSpeed(p58)
    -- upvalues: u8 (ref), u10 (ref), u13 (ref), u12 (ref)
    if u8 ~= "walk" then
        if p58 ~= u12 then
            u12 = p58;
        end;

        return;
    end;

    local v59 = p58 * 1.25 / getHeightScale();
    local v60 = 0.0001;
    local v61 = 0.0001;

    if v59 <= 0.5 then
        local _ = v59 / 0.5;
        v60 = 1;
    elseif v59 < 1 then
        v61 = (v59 - 0.5) / 0.5;
        v60 = 1 - v61;
    else
        local _ = v59 / 1;
        v61 = 1;
    end;

    u10:AdjustWeight(v60);
    u13:AdjustWeight(v61);
end;

function keyFrameReachedFunc(p62)
    -- upvalues: u8 (ref), u6 (copy), u13 (ref), u10 (ref), u20 (copy), u49 (ref), u12 (ref), u1 (ref)
    if p62 == "End" then
        if u8 == "walk" then
            if u6 ~= true then
                u13.TimePosition = 0;
                u10.TimePosition = 0;

                return;
            end;

            if u13.Looped ~= true then
                u13.TimePosition = 0;
            end;

            if u10.Looped ~= true then
                u10.TimePosition = 0;
            end;
        else
            local v63 = u8;
            local v64 = u20[v63] ~= nil and u20[v63] == false and "idle" or v63;

            if u49 then
                if u10.Looped then
                    return;
                end;

                v64 = "idle";
                u49 = false;
            end;

            playAnimation(v64, 0.15, u1);
            setAnimationSpeed(u12);
        end;
    end;
end;

function rollAnimation(p65)
    -- upvalues: u18 (copy)
    local math_random_ret = math.random(1, u18[p65].totalWeight);
    local v66 = 1;

    while u18[p65][v66].weight < math_random_ret do
        math_random_ret = math_random_ret - u18[p65][v66].weight;
        v66 = v66 + 1;
    end;

    return v66;
end;

local function switchToAnim(p67, p68, p69, p70) -- Line: 493
    -- upvalues: u9 (ref), u10 (ref), u13 (ref), u6 (copy), u12 (ref), u4 (copy), u8 (ref), u11 (ref), u18 (copy), u14 (ref)
    if p67 ~= u9 then
        if u10 ~= nil then
            u10:Stop(p69);
            u10:Destroy();
        end;

        if u13 ~= nil then
            u13:Stop(p69);
            u13:Destroy();

            if u6 == true then
                u13 = nil;
            end;
        end;

        u12 = 1;
        u10 = u4:LoadAnimation(p67);
        u10.Priority = Enum.AnimationPriority.Core;
        u10:Play(p69);
        u8 = p68;
        u9 = p67;

        if u11 ~= nil then
            u11:disconnect();
        end;

        u11 = u10.KeyframeReached:connect(keyFrameReachedFunc);

        if p68 == "walk" then
            local v71 = rollAnimation("run");
            u13 = u4:LoadAnimation(u18.run[v71].anim);
            u13.Priority = Enum.AnimationPriority.Core;
            u13:Play(p69);

            if u14 ~= nil then
                u14:disconnect();
            end;

            u14 = u13.KeyframeReached:connect(keyFrameReachedFunc);
        end;
    end;
end;

function playAnimation(p72, p73, p74)
    -- upvalues: u18 (copy), switchToAnim (copy), u49 (ref)
    local v75 = rollAnimation(p72);
    local anim = u18[p72][v75].anim;

    if anim.AnimationId == "" then
        return;
    end;

    switchToAnim(anim, p72, p73, p74);
    u49 = false;
end;

function playEmote(p76, p77, p78)
    -- upvalues: switchToAnim (copy), u49 (ref)
    switchToAnim(p76, p76.Name, p77, p78);
    u49 = true;
end;

local u79 = "";
local u80 = nil;
local u81 = nil;
local u82 = nil;

function toolKeyFrameReachedFunc(p83)
    -- upvalues: u79 (ref), u1 (ref)
    if p83 == "End" then
        playToolAnimation(u79, 0, u1);
    end;
end;

function playToolAnimation(p84, p85, p86, p87)
    -- upvalues: u18 (copy), u81 (ref), u80 (ref), u4 (copy), u79 (ref), u82 (ref)
    local v88 = rollAnimation(p84);
    local anim = u18[p84][v88].anim;

    if u81 ~= anim then
        if u80 ~= nil then
            u80:Stop();
            u80:Destroy();
            p85 = 0;
        end;

        u80 = u4:LoadAnimation(anim);

        if p87 then
            u80.Priority = p87;
        end;

        u80:Play(p85);
        u79 = p84;
        u81 = anim;
        u82 = u80.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;

function stopToolAnimations()
    -- upvalues: u79 (ref), u82 (ref), u81 (ref), u80 (ref)
    local v89 = u79;

    if u82 ~= nil then
        u82:disconnect();
    end;

    u79 = "";
    u81 = nil;

    if u80 ~= nil then
        u80:Stop();
        u80:Destroy();
        u80 = nil;
    end;

    return v89;
end;

function onRunning(p90)
    -- upvalues: u7 (copy), u1 (ref), u49 (ref), u5 (ref), u20 (copy), u8 (ref)
    local v91 = not u7 and 1 or getHeightScale();

    if (u1 and u49 and u1.MoveDirection == Vector3.new(0, 0, 0) and (u1.WalkSpeed / v91 or 0.75) or 0.75) * v91 >= p90 then
        if u20[u8] == nil and not u49 then
            playAnimation("idle", 0.2, u1);
            u5 = "Standing";
        end;

        return;
    end;

    playAnimation("walk", 0.2, u1);
    setAnimationSpeed(p90 / 16);
    u5 = "Running";
end;

function onDied()
    -- upvalues: u5 (ref)
    u5 = "Dead";
end;

function onJumping()
    -- upvalues: u1 (ref), u48 (ref), u5 (ref)
    playAnimation("jump", 0.1, u1);
    u48 = 0.31;
    u5 = "Jumping";
end;

function onClimbing(p92)
    -- upvalues: u7 (copy), u1 (ref), u5 (ref)
    if u7 then
        p92 = p92 / getHeightScale();
    end;

    playAnimation("climb", 0.1, u1);
    setAnimationSpeed(p92 / 5);
    u5 = "Climbing";
end;

function onGettingUp()
    -- upvalues: u5 (ref)
    u5 = "GettingUp";
end;

function onFreeFall()
    -- upvalues: u48 (ref), u1 (ref), u5 (ref)
    if u48 <= 0 then
        playAnimation("fall", 0.2, u1);
    end;

    u5 = "FreeFall";
end;

function onFallingDown()
    -- upvalues: u5 (ref)
    u5 = "FallingDown";
end;

function onSeated()
    -- upvalues: u5 (ref)
    u5 = "Seated";
end;

function onPlatformStanding()
    -- upvalues: u5 (ref)
    u5 = "PlatformStanding";
end;

function onSwimming(p93)
    -- upvalues: u7 (copy), u1 (ref), u5 (ref)
    if u7 then
        p93 = p93 / getHeightScale();
    end;

    if p93 <= 1 then
        playAnimation("swimidle", 0.4, u1);
        u5 = "Standing";

        return;
    end;

    playAnimation("swim", 0.4, u1);
    setAnimationSpeed(p93 / 10);
    u5 = "Swimming";
end;

function animateTool()
    -- upvalues: u46 (ref), u1 (ref)
    if u46 == "None" then
        playToolAnimation("toolnone", 0.1, u1, Enum.AnimationPriority.Idle);

        return;
    end;

    if u46 == "Slash" then
        playToolAnimation("toolslash", 0, u1, Enum.AnimationPriority.Action);

        return;
    end;

    if u46 ~= "Lunge" then
        return;
    end;

    playToolAnimation("toollunge", 0, u1, Enum.AnimationPriority.Action);
end;

function getToolAnim(p94)
    for _, child in ipairs(p94:GetChildren()) do
        if child.Name == "toolanim" and child.className == "StringValue" then
            return child;
        end;
    end;

    return nil;
end;

local u95 = 0;

function stepAnimate(p96)
    -- upvalues: u95 (ref), u1 (ref), script_Parent (copy), u48 (ref), u5 (ref), u46 (ref), u47 (ref), u81 (ref)
    local v97 = p96 - u95;
    u95 = p96;
    local v98 = not u1 and (script_Parent.PrimaryPart or script_Parent:FindFirstChild("HumanoidRootPart"));

    if v98 then
        local AssemblyLinearVelocity = v98.AssemblyLinearVelocity;
        onRunning(Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude);
    end;

    if u48 > 0 then
        u48 = u48 - v97;
    end;

    if u5 == "FreeFall" and u48 <= 0 then
        playAnimation("fall", 0.2, u1);
    else
        if u5 == "Seated" then
            playAnimation("sit", 0.5, u1);

            return;
        end;

        if u5 == "Running" then
            playAnimation("walk", 0.2, u1);
        elseif u5 == "Dead" or (u5 == "GettingUp" or (u5 == "FallingDown" or (u5 == "Seated" or u5 == "PlatformStanding"))) then
            stopAllAnimations();
        end;
    end;

    local v99 = script_Parent:FindFirstChildOfClass("Tool");

    if v99 and v99:FindFirstChild("Handle") then
        local v100 = getToolAnim(v99);

        if v100 then
            u46 = v100.Value;
            v100.Parent = nil;
            u47 = p96 + 0.3;
        end;

        if u47 < p96 then
            u47 = 0;
            u46 = "None";
        end;

        animateTool();

        return;
    end;

    stopToolAnimations();
    u46 = "None";
    u81 = nil;
    u47 = 0;
end;

if u1 then
    u1.Died:connect(onDied);
    u1.Running:connect(onRunning);
    u1.Jumping:connect(onJumping);
    u1.Climbing:connect(onClimbing);
    u1.GettingUp:connect(onGettingUp);
    u1.FreeFalling:connect(onFreeFall);
    u1.FallingDown:connect(onFallingDown);
    u1.Seated:connect(onSeated);
    u1.PlatformStanding:connect(onPlatformStanding);
    u1.Swimming:connect(onSwimming);
end;

script:WaitForChild("PlayEmote").OnInvoke = function(p101) -- Line: 812
    -- upvalues: u5 (ref), u20 (copy), u1 (ref), u10 (ref)
    if u5 == "Standing" then
        if u20[p101] ~= nil then
            playAnimation(p101, 0.1, u1);

            return true, u10;
        end;

        if typeof(p101) ~= "Instance" or not p101:IsA("Animation") then
            return false;
        end;

        playEmote(p101, 0.1, u1);

        return true, u10;
    end;
end;

if script_Parent.Parent ~= nil then
    playAnimation("idle", 0.1, u1);
    u5 = "Standing";
end;

while script_Parent.Parent ~= nil do
    local _, v102 = wait(0.1);
    stepAnimate(v102);
end;