--[[
  Type:     LocalScript
  Method:   cached
  Name:     Animate
  Path:     game.Workspace.Raphael_RWhite.Animate
  Service:  Workspace
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Sun Aug 30 01:48:33 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local script_Parent = script.Parent;
local Humanoid = script_Parent:WaitForChild("Humanoid");
local u1 = Humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", Humanoid);
local Value = ReplicatedStorage.Configuration.DEFAULT_WALK_SPEED.Value;
local AirState = ReplicatedStorage:WaitForChild("Player"):WaitForChild("Remotes"):WaitForChild("Inputs"):WaitForChild("AirState", 10);
local HumanoidRootPart = script_Parent:WaitForChild("HumanoidRootPart");
local u2 = {
    idle = "rbxassetid://94349756830490",
    walk = "rbxassetid://117074193930327",
    jog = "rbxassetid://113794444514508",
    run = "rbxassetid://94747982295498",
    jump = "rbxassetid://130357326946203",
    doublejump = "rbxassetid://74907941111026",
    fall = "rbxassetid://127466333406115",
    dance1 = "rbxassetid://182435998",
    dance2 = "rbxassetid://182436842",
    dance3 = "rbxassetid://182436935",
    land = "rbxassetid://118620906944170"
};
local Class_Data = require(game.ReplicatedStorage.Classes.Class_Data);
local table_clone_ret = table.clone(u2);
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = {};
local u8 = "Standing";
local u9 = {};
local u10 = true;
local u11 = {};
local u12 = "";
local u13 = nil;

for _, v in u1:GetPlayingAnimationTracks() do
    v:Stop(0);
    v:Destroy();
end;

local function getOrCreateAnimation(p14: string) -- Line: 95
    -- upvalues: table_clone_ret (ref), u9 (copy)
    local v15 = table_clone_ret[p14];

    if not v15 then
        warn("No animation found for: " .. p14);

        return nil;
    end;

    local v16 = p14 .. "_" .. v15;

    if not u9[v16] then
        local Animation = Instance.new("Animation");
        Animation.Name = p14;
        Animation.AnimationId = v15;
        u9[v16] = Animation;
    end;

    return u9[v16];
end;

local function getOrLoadTrack(p17: string) -- Line: 114
    -- upvalues: table_clone_ret (ref), u9 (copy), u11 (copy), u1 (copy)
    local v18 = table_clone_ret[p17];
    local v19;

    if v18 then
        local v20 = p17 .. "_" .. v18;

        if not u9[v20] then
            local Animation = Instance.new("Animation");
            Animation.Name = p17;
            Animation.AnimationId = v18;
            u9[v20] = Animation;
        end;

        v19 = u9[v20];
    else
        warn("No animation found for: " .. p17);
        v19 = nil;
    end;

    if not v19 then
        return nil;
    end;

    local v21 = p17 .. "_" .. v19.AnimationId;

    if not u11[v21] then
        u11[v21] = u1:LoadAnimation(v19);
    end;

    return u11[v21];
end;

local function play(p22: string, p23: number?) -- Line: 127
    -- upvalues: u12 (ref), u13 (ref), table_clone_ret (ref), u9 (copy), u11 (copy), u1 (copy)
    local v24 = p23 or 0.2;

    if u12 == p22 then
        return;
    end;

    if u13 then
        u13:Stop(v24);
    end;

    local v25 = table_clone_ret[p22];
    local v26;

    if v25 then
        local v27 = p22 .. "_" .. v25;

        if not u9[v27] then
            local Animation = Instance.new("Animation");
            Animation.Name = p22;
            Animation.AnimationId = v25;
            u9[v27] = Animation;
        end;

        v26 = u9[v27];
    else
        warn("No animation found for: " .. p22);
        v26 = nil;
    end;

    local v28;

    if v26 then
        local v29 = p22 .. "_" .. v26.AnimationId;

        if not u11[v29] then
            u11[v29] = u1:LoadAnimation(v26);
        end;

        v28 = u11[v29];
    else
        v28 = nil;
    end;

    if v28 then
        v28:Play(v24);
        u12 = p22;
        u13 = v28;
    end;
end;

local function stop(p30: number?) -- Line: 146
    -- upvalues: u13 (ref), u12 (ref)
    local v31 = p30 or 0.2;

    if u13 then
        u13:Stop(v31);
        u13 = nil;
        u12 = "";
    end;
end;

local function rebuildActiveAnimations() -- Line: 160
    -- upvalues: table_clone_ret (ref), u2 (copy), u3 (ref), u6 (ref), u7 (copy)
    table_clone_ret = table.clone(u2);

    if u3 then
        for i, v in u3 do
            table_clone_ret[i] = v;
        end;
    end;

    if u6 and u7[u6] then
        for i, v in u7[u6] do
            table_clone_ret[i] = v;
        end;
    end;
end;

local function changeClass() -- Line: 180
    -- upvalues: LocalPlayer (copy), Class_Data (copy), u3 (ref), table_clone_ret (ref), u2 (copy), u6 (ref), u7 (copy), u12 (ref), u13 (ref), u9 (copy), u11 (copy), u1 (copy)
    local Attribute = LocalPlayer:GetAttribute("Active_Class");

    if Attribute and Attribute ~= "" then
        local v32 = Class_Data.Get(Attribute);

        if v32 and v32.AnimationOverrides then
            u3 = v32.AnimationOverrides;
        else
            u3 = nil;
        end;
    else
        u3 = nil;
    end;

    table_clone_ret = table.clone(u2);

    if u3 then
        for i, v in u3 do
            table_clone_ret[i] = v;
        end;
    end;

    if u6 and u7[u6] then
        for i, v in u7[u6] do
            table_clone_ret[i] = v;
        end;
    end;

    local v33 = u12;
    u12 = "";
    local v34 = 0.1 or 0.2;

    if u12 == v33 then
        return;
    end;

    if u13 then
        u13:Stop(v34);
    end;

    local v35 = table_clone_ret[v33];
    local v36;

    if v35 then
        local v37 = v33 .. "_" .. v35;

        if not u9[v37] then
            local Animation = Instance.new("Animation");
            Animation.Name = v33;
            Animation.AnimationId = v35;
            u9[v37] = Animation;
        end;

        v36 = u9[v37];
    else
        warn("No animation found for: " .. v33);
        v36 = nil;
    end;

    local v38;

    if v36 then
        local v39 = v33 .. "_" .. v36.AnimationId;

        if not u11[v39] then
            u11[v39] = u1:LoadAnimation(v36);
        end;

        v38 = u11[v39];
    else
        v38 = nil;
    end;

    if v38 then
        v38:Play(v34);
        u12 = v33;
        u13 = v38;
    end;
end;

local function registerWeaponAnimations(p40: string, p41: table) -- Line: 203
    -- upvalues: u7 (copy)
    u7[p40] = p41;
end;

local function equipWeapon(p42: string) -- Line: 207
    -- upvalues: u7 (copy), u6 (ref), table_clone_ret (ref), u2 (copy), u3 (ref), u12 (ref), u13 (ref), u9 (copy), u11 (copy), u1 (copy)
    local v43 = u7[p42];

    if not v43 then
        return;
    end;

    u6 = p42;
    table_clone_ret = table.clone(u2);

    if u3 then
        for i, v in u3 do
            table_clone_ret[i] = v;
        end;
    end;

    if u6 and u7[u6] then
        for i, v in u7[u6] do
            table_clone_ret[i] = v;
        end;
    end;

    if v43[u12] then
        local v44 = u12;
        u12 = "";
        local v45 = 0.1 or 0.2;

        if u12 == v44 then
            return;
        end;

        if u13 then
            u13:Stop(v45);
        end;

        local v46 = table_clone_ret[v44];
        local v47;

        if v46 then
            local v48 = v44 .. "_" .. v46;

            if not u9[v48] then
                local Animation = Instance.new("Animation");
                Animation.Name = v44;
                Animation.AnimationId = v46;
                u9[v48] = Animation;
            end;

            v47 = u9[v48];
        else
            warn("No animation found for: " .. v44);
            v47 = nil;
        end;

        local v49;

        if v47 then
            local v50 = v44 .. "_" .. v47.AnimationId;

            if not u11[v50] then
                u11[v50] = u1:LoadAnimation(v47);
            end;

            v49 = u11[v50];
        else
            v49 = nil;
        end;

        if v49 then
            v49:Play(v45);
            u12 = v44;
            u13 = v49;
        end;
    end;
end;

local function unequipWeapon() -- Line: 224
    -- upvalues: u6 (ref), table_clone_ret (ref), u2 (copy), u3 (ref), u7 (copy), u12 (ref), u13 (ref), u9 (copy), u11 (copy), u1 (copy)
    u6 = nil;
    table_clone_ret = table.clone(u2);

    if u3 then
        for i, v in u3 do
            table_clone_ret[i] = v;
        end;
    end;

    if u6 and u7[u6] then
        for i, v in u7[u6] do
            table_clone_ret[i] = v;
        end;
    end;

    local v51 = u12;
    u12 = "";
    local v52 = 0.1 or 0.2;

    if u12 == v51 then
        return;
    end;

    if u13 then
        u13:Stop(v52);
    end;

    local v53 = table_clone_ret[v51];
    local v54;

    if v53 then
        local v55 = v51 .. "_" .. v53;

        if not u9[v55] then
            local Animation = Instance.new("Animation");
            Animation.Name = v51;
            Animation.AnimationId = v53;
            u9[v55] = Animation;
        end;

        v54 = u9[v55];
    else
        warn("No animation found for: " .. v51);
        v54 = nil;
    end;

    local v56;

    if v54 then
        local v57 = v51 .. "_" .. v54.AnimationId;

        if not u11[v57] then
            u11[v57] = u1:LoadAnimation(v54);
        end;

        v56 = u11[v57];
    else
        v56 = nil;
    end;

    if v56 then
        v56:Play(v52);
        u12 = v51;
        u13 = v56;
    end;
end;

local function dance(p58: number?) -- Line: 235
    -- upvalues: u8 (ref), u12 (ref), u13 (ref), table_clone_ret (ref), u9 (copy), u11 (copy), u1 (copy)
    if u8 ~= "Standing" then
        return false;
    end;

    local v59;

    if p58 and (p58 >= 1 and p58 <= 3) then
        v59 = "dance" .. p58;
    else
        v59 = "dance" .. math.random(1, 3);
    end;

    local v60 = 0.1 or 0.2;

    if u12 ~= v59 then
        if u13 then
            u13:Stop(v60);
        end;

        local v61 = table_clone_ret[v59];
        local v62;

        if v61 then
            local v63 = v59 .. "_" .. v61;

            if not u9[v63] then
                local Animation = Instance.new("Animation");
                Animation.Name = v59;
                Animation.AnimationId = v61;
                u9[v63] = Animation;
            end;

            v62 = u9[v63];
        else
            warn("No animation found for: " .. v59);
            v62 = nil;
        end;

        local v64;

        if v62 then
            local v65 = v59 .. "_" .. v62.AnimationId;

            if not u11[v65] then
                u11[v65] = u1:LoadAnimation(v62);
            end;

            v64 = u11[v65];
        else
            v64 = nil;
        end;

        if v64 then
            v64:Play(v60);
            u12 = v59;
            u13 = v64;
        end;
    end;

    return true;
end;

local function stopDance() -- Line: 251
    -- upvalues: u12 (ref), u13 (ref), table_clone_ret (ref), u9 (copy), u11 (copy), u1 (copy)
    if u12:match("^dance") then
        local v66 = 0.1 or 0.2;

        if u12 == "idle" then
            return;
        end;

        if u13 then
            u13:Stop(v66);
        end;

        local idle = table_clone_ret.idle;
        local v67;

        if idle then
            local v68 = "idle" .. "_" .. idle;

            if not u9[v68] then
                local Animation = Instance.new("Animation");
                Animation.Name = "idle";
                Animation.AnimationId = idle;
                u9[v68] = Animation;
            end;

            v67 = u9[v68];
        else
            warn("No animation found for: idle");
            v67 = nil;
        end;

        local v69;

        if v67 then
            local v70 = "idle" .. "_" .. v67.AnimationId;

            if not u11[v70] then
                u11[v70] = u1:LoadAnimation(v67);
            end;

            v69 = u11[v70];
        else
            v69 = nil;
        end;

        if v69 then
            v69:Play(v66);
            u12 = "idle";
            u13 = v69;
        end;
    end;
end;

local function getMovementDot() -- Line: 258
    -- upvalues: Humanoid (copy), HumanoidRootPart (copy)
    local MoveDirection = Humanoid.MoveDirection;

    if MoveDirection.Magnitude < 0.1 then
        return 1;
    end;

    local v71 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1);
    local v72 = MoveDirection * Vector3.new(1, 0, 1);

    return (v71.Magnitude < 0.01 or v72.Magnitude < 0.01) and 1 or v71.Unit:Dot(v72.Unit);
end;

local function onRunning(p73: number) -- Line: 272
    -- upvalues: u12 (ref), Humanoid (copy), HumanoidRootPart (copy), LocalPlayer (copy), u13 (ref), table_clone_ret (ref), u9 (copy), u11 (copy), u1 (copy), script_Parent (copy), Value (copy), u8 (ref)
    if u12:match("^dance") then
        return;
    end;

    if p73 <= 0.5 then
        local v74 = nil or 0.2;

        if u12 ~= "idle" then
            if u13 then
                u13:Stop(v74);
            end;

            local idle = table_clone_ret.idle;
            local v75;

            if idle then
                local v76 = "idle" .. "_" .. idle;

                if not u9[v76] then
                    local Animation = Instance.new("Animation");
                    Animation.Name = "idle";
                    Animation.AnimationId = idle;
                    u9[v76] = Animation;
                end;

                v75 = u9[v76];
            else
                warn("No animation found for: idle");
                v75 = nil;
            end;

            local v77;

            if v75 then
                local v78 = "idle" .. "_" .. v75.AnimationId;

                if not u11[v78] then
                    u11[v78] = u1:LoadAnimation(v75);
                end;

                v77 = u11[v78];
            else
                v77 = nil;
            end;

            if v77 then
                v77:Play(v74);
                u12 = "idle";
                u13 = v77;
            end;
        end;

        if not (script_Parent:GetAttribute("Combat_Facing") or (LocalPlayer:GetAttribute("IsTheft") or script_Parent:GetAttribute("Blocking"))) then
            local v79 = Humanoid:GetAttribute("BuffMoveSpeedBonus") or 0;
            local Attribute = LocalPlayer:GetAttribute("Sprint_Active");
            local v80 = LocalPlayer:GetAttribute("Walk_Active") == true and not Attribute and 0.5 or 1;
            Humanoid.WalkSpeed = Value * (Attribute and 1.8 or 1) * v80 * (1 + v79);
        end;

        u8 = "Standing";

        return;
    end;

    local MoveDirection = Humanoid.MoveDirection;
    local v81;

    if MoveDirection.Magnitude < 0.1 then
        v81 = 1;
    else
        local v82 = HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1);
        local v83 = MoveDirection * Vector3.new(1, 0, 1);
        v81 = (v82.Magnitude < 0.01 or v83.Magnitude < 0.01) and 1 or v82.Unit:Dot(v83.Unit);
    end;

    local Attribute = LocalPlayer:GetAttribute("Sprint_Active");
    local v84;

    if LocalPlayer:GetAttribute("Walk_Active") == true then
        v84 = not Attribute;
    else
        v84 = false;
    end;

    local v85 = v81 < -0.5 and "walk" or (math.abs(v81) <= 0.5 and "walk" or (Attribute and "run" or (v84 and "walk" or "jog")));
    local v86 = nil or 0.2;

    if u12 ~= v85 then
        if u13 then
            u13:Stop(v86);
        end;

        local v87 = table_clone_ret[v85];
        local v88;

        if v87 then
            local v89 = v85 .. "_" .. v87;

            if not u9[v89] then
                local Animation = Instance.new("Animation");
                Animation.Name = v85;
                Animation.AnimationId = v87;
                u9[v89] = Animation;
            end;

            v88 = u9[v89];
        else
            warn("No animation found for: " .. v85);
            v88 = nil;
        end;

        local v90;

        if v88 then
            local v91 = v85 .. "_" .. v88.AnimationId;

            if not u11[v91] then
                u11[v91] = u1:LoadAnimation(v88);
            end;

            v90 = u11[v91];
        else
            v90 = nil;
        end;

        if v90 then
            v90:Play(v86);
            u12 = v85;
            u13 = v90;
        end;
    end;

    if u13 then
        local v92 = v84 and 0.5 or 1;

        if v81 < -0.5 then
            u13:AdjustSpeed(-1 * v92);
        elseif math.abs(v81) <= 0.5 then
            u13:AdjustSpeed(0.85 * v92);
        else
            u13:AdjustSpeed(v84 and 0.75 or 1);
        end;
    end;

    if not (script_Parent:GetAttribute("Combat_Facing") or (LocalPlayer:GetAttribute("IsTheft") or script_Parent:GetAttribute("Blocking"))) then
        local v93 = v81 < -0.5 and 0.4 or (math.abs(v81) <= 0.5 and 0.8 or 1);
        local v94 = Humanoid:GetAttribute("BuffMoveSpeedBonus") or 0;
        Humanoid.WalkSpeed = Value * (Attribute and 1.8 or 1) * (v84 and 0.5 or 1) * (1 + v94) * v93;
    end;

    u8 = "Running";
end;

local function onJumping() -- Line: 370
    -- upvalues: u12 (ref), u13 (ref), table_clone_ret (ref), u9 (copy), u11 (copy), u1 (copy), u8 (ref)
    local v95 = 0.1 or 0.2;

    if u12 ~= "jump" then
        if u13 then
            u13:Stop(v95);
        end;

        local jump = table_clone_ret.jump;
        local v96;

        if jump then
            local v97 = "jump" .. "_" .. jump;

            if not u9[v97] then
                local Animation = Instance.new("Animation");
                Animation.Name = "jump";
                Animation.AnimationId = jump;
                u9[v97] = Animation;
            end;

            v96 = u9[v97];
        else
            warn("No animation found for: jump");
            v96 = nil;
        end;

        local v98;

        if v96 then
            local v99 = "jump" .. "_" .. v96.AnimationId;

            if not u11[v99] then
                u11[v99] = u1:LoadAnimation(v96);
            end;

            v98 = u11[v99];
        else
            v98 = nil;
        end;

        if v98 then
            v98:Play(v95);
            u12 = "jump";
            u13 = v98;
        end;
    end;

    u8 = "Jumping";
end;

local function onFreeFall() -- Line: 375
    -- upvalues: u8 (ref), u12 (ref), u13 (ref), table_clone_ret (ref), u9 (copy), u11 (copy), u1 (copy)
    task.delay(0.2, function() -- Line: 376
        -- upvalues: u8 (ref), u12 (ref), u13 (ref), table_clone_ret (ref), u9 (ref), u11 (ref), u1 (ref)
        if u8 == "Jumping" or u8 == "FreeFall" then
            local v100 = 0.3 or 0.2;

            if u12 == "fall" then
                return;
            end;

            if u13 then
                u13:Stop(v100);
            end;

            local fall = table_clone_ret.fall;
            local v101;

            if fall then
                local v102 = "fall" .. "_" .. fall;

                if not u9[v102] then
                    local Animation = Instance.new("Animation");
                    Animation.Name = "fall";
                    Animation.AnimationId = fall;
                    u9[v102] = Animation;
                end;

                v101 = u9[v102];
            else
                warn("No animation found for: fall");
                v101 = nil;
            end;

            local v103;

            if v101 then
                local v104 = "fall" .. "_" .. v101.AnimationId;

                if not u11[v104] then
                    u11[v104] = u1:LoadAnimation(v101);
                end;

                v103 = u11[v104];
            else
                v103 = nil;
            end;

            if v103 then
                v103:Play(v100);
                u12 = "fall";
                u13 = v103;
            end;
        end;
    end);
    u8 = "FreeFall";
end;

local function onDied() -- Line: 384
    -- upvalues: u13 (ref), u12 (ref), u8 (ref)
    local v105 = 0 or 0.2;

    if u13 then
        u13:Stop(v105);
        u13 = nil;
        u12 = "";
    end;

    u8 = "Dead";
end;

local function reportAirState(p106: string) -- Line: 393
    -- upvalues: AirState (copy)
    if AirState then
        AirState:FireServer(p106);
    end;
end;

local function landedOnOpaqueGround() -- Line: 401
    -- upvalues: script_Parent (copy)
    local HumanoidRootPart2 = script_Parent:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart2 then
        return false;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { script_Parent };
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.IgnoreWater = true;
    local v107 = workspace:Raycast(HumanoidRootPart2.Position, Vector3.new(0, -6, 0), RaycastParams_new_ret);

    return not (v107 and v107.Instance) and true or v107.Instance.Transparency == 0;
end;

local function playDoubleJumpAnim() -- Line: 432
    -- upvalues: table_clone_ret (ref), u9 (copy), u11 (copy), u1 (copy), u4 (ref)
    local doublejump = table_clone_ret.doublejump;
    local v108;

    if doublejump then
        local v109 = "doublejump" .. "_" .. doublejump;

        if not u9[v109] then
            local Animation = Instance.new("Animation");
            Animation.Name = "doublejump";
            Animation.AnimationId = doublejump;
            u9[v109] = Animation;
        end;

        v108 = u9[v109];
    else
        warn("No animation found for: doublejump");
        v108 = nil;
    end;

    local v110;

    if v108 then
        local v111 = "doublejump" .. "_" .. v108.AnimationId;

        if not u11[v111] then
            u11[v111] = u1:LoadAnimation(v108);
        end;

        v110 = u11[v111];
    else
        v110 = nil;
    end;

    if not v110 then
        return;
    end;

    v110.Priority = Enum.AnimationPriority.Action;
    v110.Looped = false;

    if v110.IsPlaying then
        v110:Stop(0);
    end;

    v110:Play(0.05);
    u4 = v110;
end;

local function stopDoubleJumpAnim() -- Line: 444
    -- upvalues: u4 (ref)
    if u4 then
        if u4.IsPlaying then
            u4:Stop(0.1);
        end;

        u4 = nil;
    end;
end;

local function tryDoubleJump() -- Line: 458
    -- upvalues: u8 (ref), Humanoid (copy), LocalPlayer (copy), u10 (ref), landedOnOpaqueGround (copy), u5 (ref), script_Parent (copy), AirState (copy), table_clone_ret (ref), u9 (copy), u11 (copy), u1 (copy), u4 (ref)
    if u8 == "Dead" or Humanoid.Health <= 0 then
        return;
    end;

    if LocalPlayer:GetAttribute("Dead") then
        return;
    end;

    if not u10 and (Humanoid.FloorMaterial ~= Enum.Material.Air and landedOnOpaqueGround()) then
        u10 = true;
    end;

    if not u10 then
        return;
    end;

    if not u5 then
        return;
    end;

    if os.clock() - u5 < 0.12 then
        return;
    end;

    local State = Humanoid:GetState();

    if State ~= Enum.HumanoidStateType.Freefall and State ~= Enum.HumanoidStateType.Jumping then
        return;
    end;

    local v112;

    if Humanoid.UseJumpPower then
        v112 = Humanoid.JumpPower;
    else
        local v113 = 2 * workspace.Gravity * math.max(Humanoid.JumpHeight, 0);
        v112 = math.sqrt(v113);
    end;

    if v112 <= 0 then
        return;
    end;

    local HumanoidRootPart2 = script_Parent:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart2 then
        return;
    end;

    u10 = false;

    if AirState then
        AirState:FireServer("double");
    end;

    local AssemblyLinearVelocity = HumanoidRootPart2.AssemblyLinearVelocity;
    HumanoidRootPart2.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, v112, AssemblyLinearVelocity.Z);
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
    u8 = "Jumping";
    local doublejump = table_clone_ret.doublejump;
    local v114;

    if doublejump then
        local v115 = "doublejump" .. "_" .. doublejump;

        if not u9[v115] then
            local Animation = Instance.new("Animation");
            Animation.Name = "doublejump";
            Animation.AnimationId = doublejump;
            u9[v115] = Animation;
        end;

        v114 = u9[v115];
    else
        warn("No animation found for: doublejump");
        v114 = nil;
    end;

    local v116;

    if v114 then
        local v117 = "doublejump" .. "_" .. v114.AnimationId;

        if not u11[v117] then
            u11[v117] = u1:LoadAnimation(v114);
        end;

        v116 = u11[v117];
    else
        v116 = nil;
    end;

    if not v116 then
        return;
    end;

    v116.Priority = Enum.AnimationPriority.Action;
    v116.Looped = false;

    if v116.IsPlaying then
        v116:Stop(0);
    end;

    v116:Play(0.05);
    u4 = v116;
end;

Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function() -- Line: 506
    -- upvalues: Humanoid (copy), onRunning (copy)
    if Humanoid:GetState() ~= Enum.HumanoidStateType.Running then
        return;
    end;

    onRunning(Humanoid.WalkSpeed);
end);
Humanoid.Running:Connect(onRunning);
Humanoid.Jumping:Connect(onJumping);
Humanoid.FreeFalling:Connect(onFreeFall);
Humanoid.Died:Connect(onDied);
Humanoid.StateChanged:Connect(function(p118, p119) -- Line: 519
    -- upvalues: u5 (ref), AirState (copy), u4 (ref), landedOnOpaqueGround (copy), u10 (ref)
    if p119 == Enum.HumanoidStateType.Jumping or p119 == Enum.HumanoidStateType.Freefall then
        if not u5 then
            u5 = os.clock();

            if AirState then
                AirState:FireServer("air");
            end;
        end;
    elseif p119 == Enum.HumanoidStateType.Landed or (p119 == Enum.HumanoidStateType.Running or p119 == Enum.HumanoidStateType.RunningNoPhysics) then
        if u5 then
            u5 = nil;

            if AirState then
                AirState:FireServer("ground");
            end;
        end;

        if u4 then
            if u4.IsPlaying then
                u4:Stop(0.1);
            end;

            u4 = nil;
        end;

        if landedOnOpaqueGround() then
            u10 = true;
        end;
    end;
end);
UserInputService.JumpRequest:Connect(tryDoubleJump);

local function setupMobileJumpButton() -- Line: 547
    -- upvalues: UserInputService (copy), LocalPlayer (copy), tryDoubleJump (copy)
    if not UserInputService.TouchEnabled then
        return;
    end;

    task.spawn(function() -- Line: 549
        -- upvalues: LocalPlayer (ref), tryDoubleJump (ref)
        local v120 = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 10);

        if not v120 then
            return;
        end;

        local TouchGui = v120:WaitForChild("TouchGui", 30);

        if not TouchGui then
            return;
        end;

        local TouchControlFrame = TouchGui:WaitForChild("TouchControlFrame", 10);

        if TouchControlFrame then
            TouchControlFrame = TouchControlFrame:WaitForChild("JumpButton", 10);
        end;

        if not TouchControlFrame then
            return;
        end;

        TouchControlFrame.InputBegan:Connect(function(p121) -- Line: 558
            -- upvalues: tryDoubleJump (ref)
            if p121.UserInputType == Enum.UserInputType.Touch then
                tryDoubleJump();
            end;
        end);
    end);
end;

if UserInputService.TouchEnabled then
    task.spawn(function() -- Line: 549
        -- upvalues: LocalPlayer (copy), tryDoubleJump (copy)
        local v122 = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 10);

        if not v122 then
            return;
        end;

        local TouchGui = v122:WaitForChild("TouchGui", 30);

        if not TouchGui then
            return;
        end;

        local TouchControlFrame = TouchGui:WaitForChild("TouchControlFrame", 10);

        if TouchControlFrame then
            TouchControlFrame = TouchControlFrame:WaitForChild("JumpButton", 10);
        end;

        if not TouchControlFrame then
            return;
        end;

        TouchControlFrame.InputBegan:Connect(function(p123) -- Line: 558
            -- upvalues: tryDoubleJump (ref)
            if p123.UserInputType == Enum.UserInputType.Touch then
                tryDoubleJump();
            end;
        end);
    end);
end;

LocalPlayer:GetAttributeChangedSignal("Active_Class"):Connect(changeClass);
LocalPlayer:GetAttributeChangedSignal("Sprint_Active"):Connect(function() -- Line: 571
    -- upvalues: u8 (ref), onRunning (copy), Humanoid (copy)
    if u8 == "Running" then
        onRunning(Humanoid.WalkSpeed);
    end;
end);
LocalPlayer:GetAttributeChangedSignal("Walk_Active"):Connect(function() -- Line: 578
    -- upvalues: u8 (ref), onRunning (copy), Humanoid (copy)
    if u8 == "Running" then
        onRunning(Humanoid.WalkSpeed);
    end;
end);
script_Parent.ChildAdded:Connect(function(p124) -- Line: 587
    -- upvalues: u7 (copy), u6 (ref), table_clone_ret (ref), u2 (copy), u3 (ref), u12 (ref), u13 (ref), u9 (copy), u11 (copy), u1 (copy)
    if p124:IsA("Tool") and u7[p124.Name] then
        local Name = p124.Name;
        local v125 = u7[Name];

        if not v125 then
            return;
        end;

        u6 = Name;
        table_clone_ret = table.clone(u2);

        if u3 then
            for i, v in u3 do
                table_clone_ret[i] = v;
            end;
        end;

        if u6 and u7[u6] then
            for i, v in u7[u6] do
                table_clone_ret[i] = v;
            end;
        end;

        if v125[u12] then
            local v126 = u12;
            u12 = "";
            local v127 = 0.1 or 0.2;

            if u12 == v126 then
                return;
            end;

            if u13 then
                u13:Stop(v127);
            end;

            local v128 = table_clone_ret[v126];
            local v129;

            if v128 then
                local v130 = v126 .. "_" .. v128;

                if not u9[v130] then
                    local Animation = Instance.new("Animation");
                    Animation.Name = v126;
                    Animation.AnimationId = v128;
                    u9[v130] = Animation;
                end;

                v129 = u9[v130];
            else
                warn("No animation found for: " .. v126);
                v129 = nil;
            end;

            local v131;

            if v129 then
                local v132 = v126 .. "_" .. v129.AnimationId;

                if not u11[v132] then
                    u11[v132] = u1:LoadAnimation(v129);
                end;

                v131 = u11[v132];
            else
                v131 = nil;
            end;

            if v131 then
                v131:Play(v127);
                u12 = v126;
                u13 = v131;
            end;
        end;
    end;
end);
script_Parent.ChildRemoved:Connect(function(p133) -- Line: 595
    -- upvalues: u6 (ref), table_clone_ret (ref), u2 (copy), u3 (ref), u7 (copy), u12 (ref), u13 (ref), u9 (copy), u11 (copy), u1 (copy)
    if p133:IsA("Tool") and p133.Name == u6 then
        u6 = nil;
        table_clone_ret = table.clone(u2);

        if u3 then
            for i, v in u3 do
                table_clone_ret[i] = v;
            end;
        end;

        if u6 and u7[u6] then
            for i, v in u7[u6] do
                table_clone_ret[i] = v;
            end;
        end;

        local v134 = u12;
        u12 = "";
        local v135 = 0.1 or 0.2;

        if u12 == v134 then
            return;
        end;

        if u13 then
            u13:Stop(v135);
        end;

        local v136 = table_clone_ret[v134];
        local v137;

        if v136 then
            local v138 = v134 .. "_" .. v136;

            if not u9[v138] then
                local Animation = Instance.new("Animation");
                Animation.Name = v134;
                Animation.AnimationId = v136;
                u9[v138] = Animation;
            end;

            v137 = u9[v138];
        else
            warn("No animation found for: " .. v134);
            v137 = nil;
        end;

        local v139;

        if v137 then
            local v140 = v134 .. "_" .. v137.AnimationId;

            if not u11[v140] then
                u11[v140] = u1:LoadAnimation(v137);
            end;

            v139 = u11[v140];
        else
            v139 = nil;
        end;

        if v139 then
            v139:Play(v135);
            u12 = v134;
            u13 = v139;
        end;
    end;
end);
LocalPlayer.Chatted:Connect(function(p141) -- Line: 602
    -- upvalues: u8 (ref), u12 (ref), u13 (ref), table_clone_ret (ref), u9 (copy), u11 (copy), u1 (copy)
    local v142 = p141:lower();

    if v142 == "/e dance" then
        if u8 ~= "Standing" then
            return;
        end;

        local v143 = "dance" .. math.random(1, 3);
        local v144 = 0.1 or 0.2;

        if u12 == v143 then
            return;
        end;

        if u13 then
            u13:Stop(v144);
        end;

        local v145 = table_clone_ret[v143];
        local v146;

        if v145 then
            local v147 = v143 .. "_" .. v145;

            if not u9[v147] then
                local Animation = Instance.new("Animation");
                Animation.Name = v143;
                Animation.AnimationId = v145;
                u9[v147] = Animation;
            end;

            v146 = u9[v147];
        else
            warn("No animation found for: " .. v143);
            v146 = nil;
        end;

        local v148;

        if v146 then
            local v149 = v143 .. "_" .. v146.AnimationId;

            if not u11[v149] then
                u11[v149] = u1:LoadAnimation(v146);
            end;

            v148 = u11[v149];
        else
            v148 = nil;
        end;

        if v148 then
            v148:Play(v144);
            u12 = v143;
            u13 = v148;
        end;
    elseif v142 == "/e dance1" then
        if u8 ~= "Standing" then
            return;
        end;

        local v150 = "dance" .. 1;
        local v151 = 0.1 or 0.2;

        if u12 == v150 then
            return;
        end;

        if u13 then
            u13:Stop(v151);
        end;

        local v152 = table_clone_ret[v150];
        local v153;

        if v152 then
            local v154 = v150 .. "_" .. v152;

            if not u9[v154] then
                local Animation = Instance.new("Animation");
                Animation.Name = v150;
                Animation.AnimationId = v152;
                u9[v154] = Animation;
            end;

            v153 = u9[v154];
        else
            warn("No animation found for: " .. v150);
            v153 = nil;
        end;

        local v155;

        if v153 then
            local v156 = v150 .. "_" .. v153.AnimationId;

            if not u11[v156] then
                u11[v156] = u1:LoadAnimation(v153);
            end;

            v155 = u11[v156];
        else
            v155 = nil;
        end;

        if v155 then
            v155:Play(v151);
            u12 = v150;
            u13 = v155;
        end;
    elseif v142 == "/e dance2" then
        if u8 ~= "Standing" then
            return;
        end;

        local v157 = "dance" .. 2;
        local v158 = 0.1 or 0.2;

        if u12 == v157 then
            return;
        end;

        if u13 then
            u13:Stop(v158);
        end;

        local v159 = table_clone_ret[v157];
        local v160;

        if v159 then
            local v161 = v157 .. "_" .. v159;

            if not u9[v161] then
                local Animation = Instance.new("Animation");
                Animation.Name = v157;
                Animation.AnimationId = v159;
                u9[v161] = Animation;
            end;

            v160 = u9[v161];
        else
            warn("No animation found for: " .. v157);
            v160 = nil;
        end;

        local v162;

        if v160 then
            local v163 = v157 .. "_" .. v160.AnimationId;

            if not u11[v163] then
                u11[v163] = u1:LoadAnimation(v160);
            end;

            v162 = u11[v163];
        else
            v162 = nil;
        end;

        if v162 then
            v162:Play(v158);
            u12 = v157;
            u13 = v162;
        end;
    elseif v142 == "/e dance3" then
        if u8 ~= "Standing" then
            return;
        end;

        local v164 = "dance" .. 3;
        local v165 = 0.1 or 0.2;

        if u12 == v164 then
            return;
        end;

        if u13 then
            u13:Stop(v165);
        end;

        local v166 = table_clone_ret[v164];
        local v167;

        if v166 then
            local v168 = v164 .. "_" .. v166;

            if not u9[v168] then
                local Animation = Instance.new("Animation");
                Animation.Name = v164;
                Animation.AnimationId = v166;
                u9[v168] = Animation;
            end;

            v167 = u9[v168];
        else
            warn("No animation found for: " .. v164);
            v167 = nil;
        end;

        local v169;

        if v167 then
            local v170 = v164 .. "_" .. v167.AnimationId;

            if not u11[v170] then
                u11[v170] = u1:LoadAnimation(v167);
            end;

            v169 = u11[v170];
        else
            v169 = nil;
        end;

        if v169 then
            v169:Play(v165);
            u12 = v164;
            u13 = v169;
        end;
    elseif v142 == "/e stop" and u12:match("^dance") then
        local v171 = 0.1 or 0.2;

        if u12 == "idle" then
            return;
        end;

        if u13 then
            u13:Stop(v171);
        end;

        local idle = table_clone_ret.idle;
        local v172;

        if idle then
            local v173 = "idle" .. "_" .. idle;

            if not u9[v173] then
                local Animation = Instance.new("Animation");
                Animation.Name = "idle";
                Animation.AnimationId = idle;
                u9[v173] = Animation;
            end;

            v172 = u9[v173];
        else
            warn("No animation found for: idle");
            v172 = nil;
        end;

        local v174;

        if v172 then
            local v175 = "idle" .. "_" .. v172.AnimationId;

            if not u11[v175] then
                u11[v175] = u1:LoadAnimation(v172);
            end;

            v174 = u11[v175];
        else
            v174 = nil;
        end;

        if v174 then
            v174:Play(v171);
            u12 = "idle";
            u13 = v174;
        end;
    end;
end);
changeClass();
local v176 = 0 or 0.2;

if u12 ~= "idle" then
    if u13 then
        u13:Stop(v176);
    end;

    local idle = table_clone_ret.idle;
    local v177;

    if idle then
        local v178 = "idle" .. "_" .. idle;

        if not u9[v178] then
            local Animation = Instance.new("Animation");
            Animation.Name = "idle";
            Animation.AnimationId = idle;
            u9[v178] = Animation;
        end;

        v177 = u9[v178];
    else
        warn("No animation found for: idle");
        v177 = nil;
    end;

    local v179;

    if v177 then
        local v180 = "idle" .. "_" .. v177.AnimationId;

        if not u11[v180] then
            u11[v180] = u1:LoadAnimation(v177);
        end;

        v179 = u11[v180];
    else
        v179 = nil;
    end;

    if v179 then
        v179:Play(v176);
        u12 = "idle";
        u13 = v179;
    end;
end;

return {
    Play = play,
    Stop = stop,
    Dance = dance,
    StopDance = stopDance,
    EquipWeapon = equipWeapon,
    UnequipWeapon = unequipWeapon,
    RegisterWeaponAnimations = registerWeaponAnimations,
    ChangeClass = changeClass,
    PlayDoubleJump = playDoubleJumpAnim,

    GetCurrentAnim = function() -- Line: 638, Name: GetCurrentAnim
        -- upvalues: u12 (ref)
        return u12;
    end,

    GetPose = function() -- Line: 639, Name: GetPose
        -- upvalues: u8 (ref)
        return u8;
    end
};