--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DropSpawner
  Path:     game.ReplicatedStorage.Modules.DropSpawner
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Packages = ReplicatedStorage:WaitForChild("Packages");
local Knit = require(Packages.Knit);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {};
local Drops = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Models"):WaitForChild("Drops");
local Configuration = ReplicatedStorage:WaitForChild("Configuration");
local v2 = (Configuration:FindFirstChild("DEFAULT_WALK_SPEED") and Configuration.DEFAULT_WALK_SPEED.Value or 16) * 1.8;
local u3 = 15;
local u4 = v2 - 3;
local u5 = v2 + 18;
local u6 = 1;
local u7 = 2;
local u8 = 40;
local u9 = {};
local LocalPlayer = Players.LocalPlayer;
local u10 = false;
local u11 = 0;
local u12 = nil;

local function GetDropService() -- Line: 99
    -- upvalues: u12 (ref), Knit (copy)
    if not u12 then
        local success, result = pcall(function() -- Line: 101
            -- upvalues: Knit (ref)
            return Knit.GetService("DropService");
        end);

        if success then
            u12 = result;
        end;
    end;

    return u12;
end;

local function GenerateDropId() -- Line: 112
    -- upvalues: u11 (ref), LocalPlayer (copy)
    u11 = u11 + 1;

    return `{LocalPlayer.UserId}_{tick()}_{u11}`;
end;

function u1.Spawn(u13: vector, p14: table?) -- Line: 118
    -- upvalues: u6 (ref), Drops (copy), u10 (ref), u1 (copy), u11 (ref), LocalPlayer (copy), u9 (copy), RunService (copy)
    local u15 = p14 or {};
    local u16 = u15.Count or 5;
    local u17 = u15.MinForce or 20;
    local u18 = u15.MaxForce or 35;
    local u19 = u15.UpwardBias or 0.6;
    local u20 = u15.Spread or 360;
    local u21 = u15.Value or 1;
    local u22 = u15.DropType or "Coin";
    local SourceId = u15.SourceId;
    local u23 = u15.FollowDelay or u6;
    local u24 = u15.NoAward or false;
    local u25 = u15.AlwaysHome or false;
    local u26 = Drops:FindFirstChild(u22);

    if not u26 then
        warn((`[DropSpawner] Template not found for drop type: {u22}`));

        return;
    end;

    if not u10 then
        u1._startUpdateLoop();
    end;

    task.spawn(function() -- Line: 147
        -- upvalues: u16 (copy), u26 (copy), u11 (ref), LocalPlayer (ref), u21 (copy), u22 (copy), u13 (copy), u15 (ref), u20 (copy), u17 (copy), u18 (copy), u19 (copy), u9 (ref), SourceId (copy), u23 (copy), u24 (copy), u25 (copy), RunService (ref)
        for i = 1, u16 do
            local v27 = u26:Clone();
            u11 = u11 + 1;
            local v28 = `{LocalPlayer.UserId}_{tick()}_{u11}`;
            v27:SetAttribute("Value", u21);
            v27:SetAttribute("DropType", u22);
            v27:SetAttribute("DropId", v28);
            local v29 = math.random(-10, 10) / 10;
            local v30 = math.random(0, 5) / 10;
            local v31 = math.random(-10, 10) / 10;
            local Vector3_new_ret = Vector3.new(v29, v30, v31);
            local v32;

            if v27:IsA("Model") then
                v32 = v27.PrimaryPart or v27:FindFirstChildWhichIsA("BasePart");

                if v32 then
                    v27:PivotTo(CFrame.new(u13 + Vector3_new_ret));
                end;
            else
                v27.Position = u13 + Vector3_new_ret;
                v32 = v27;
            end;

            local v33;

            if v32 then
                if u22 == "Item" and u15.MaterialId then
                    local Attachment = v27:FindFirstChild("Attachment", true);

                    if Attachment then
                        Attachment = Attachment:FindFirstChild("BillboardGui");
                    end;

                    if Attachment then
                        Attachment = Attachment:FindFirstChild("ImageLabel");
                    end;

                    if Attachment then
                        Attachment = Attachment:FindFirstChildOfClass("UIStroke");
                    end;

                    if Attachment then
                        v33 = i;

                        for _, child in Attachment:GetChildren() do
                            if child:IsA("UIGradient") then
                                child.Enabled = child.Name == u15.MaterialId;
                            end;
                        end;
                    else
                        v33 = i;
                    end;
                else
                    v33 = i;
                end;

                v32.Anchored = true;
                v32.CanCollide = false;
                v32.CanQuery = false;
                v32.CanTouch = false;
                local math_random_ret = math.random(0, u20);
                local math_rad_ret = math.rad(math_random_ret);
                local v34 = math.random(u17 * 100, u18 * 100) / 100;
                local math_cos_ret = math.cos(math_rad_ret);
                local math_sin_ret = math.sin(math_rad_ret);
                local Unit = Vector3.new(math_cos_ret, 0, math_sin_ret).Unit;
                local v35 = Unit.X * v34 * (1 - u19);
                local v36 = v34 * u19 + math.random(5, 15);
                u9[v32] = {
                    Collected = false,
                    MagnetSpeed = 0,
                    Magnetized = false,
                    Velocity = Vector3.new(v35, v36, Unit.Z * v34 * (1 - u19)),
                    SpawnTime = tick(),
                    Value = u21,
                    DropType = u22,
                    DropId = v28,
                    BatchId = u15.BatchId,
                    SourceId = SourceId,
                    MaterialId = u15.MaterialId,
                    FollowDelay = u23,
                    NoAward = u24,
                    AlwaysHome = u25
                };
                v27.Parent = workspace:FindFirstChild("Debris") or workspace;

                if v33 < u16 then
                    RunService.RenderStepped:Wait();
                end;
            else
                warn((`[DropSpawner] No valid part found in template: {u22}`));
                v27:Destroy();
                v33 = i;
            end;
        end;
    end);
end;

function u1.SpawnCoins(p37: vector, p38: number?, p39: number?, p40: string?, p41: string?) -- Line: 248
    -- upvalues: u1 (copy)
    u1.Spawn(p37, {
        DropType = "Coin",
        Count = p38 or 5,
        Value = p39 or 1,
        SourceId = p40,
        BatchId = p41
    });
end;

function u1.SpawnGems(p42: vector, p43: number?, p44: number?, p45: string?, p46: string?) -- Line: 259
    -- upvalues: u1 (copy)
    u1.Spawn(p42, {
        DropType = "Gem",
        MinForce = 15,
        MaxForce = 25,
        Count = p43 or 1,
        Value = p44 or 1,
        SourceId = p45,
        BatchId = p46
    });
end;

function u1.SpawnCoinBurst(p47: vector, p48: number?) -- Line: 275
    -- upvalues: u1 (copy)
    u1.Spawn(p47, {
        Value = 0,
        DropType = "Coin",
        NoAward = true,
        AlwaysHome = true,
        FollowDelay = 0.7,
        MinForce = 28,
        MaxForce = 45,
        UpwardBias = 0.7,
        Spread = 360,
        Count = p48 or 10
    });
end;

function u1._startUpdateLoop() -- Line: 292
    -- upvalues: u10 (ref), RunService (copy), LocalPlayer (copy), u9 (copy), u8 (ref), u1 (copy), u7 (ref), u3 (ref), u5 (copy), u4 (ref)
    if u10 then
        return;
    end;

    u10 = true;
    RunService.RenderStepped:Connect(function(p49) -- Line: 296
        -- upvalues: LocalPlayer (ref), u9 (ref), u8 (ref), u1 (ref), u7 (ref), u3 (ref), u5 (ref), u4 (ref)
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if Character then
            Character = Character.Position;
        end;

        for i, v in u9 do
            if i and i.Parent then
                if not v.Collected then
                    if u8 < tick() - v.SpawnTime then
                        u1._destroyDrop(i, false);
                    else
                        local Position = i.Position;
                        local v50, v51, v52, v53;

                        if Character and tick() - v.SpawnTime >= v.FollowDelay then
                            local v54 = Character - Position;
                            local Magnitude = v54.Magnitude;

                            if Magnitude < u7 then
                                u1._collectDrop(i, v);
                            elseif v.Magnetized or (v.AlwaysHome or Magnitude < u3) then
                                v.Magnetized = true;
                                v.MagnetSpeed = math.min(v.MagnetSpeed + 120 * p49, v.AlwaysHome and u5 or u4);
                                i.Position = Position + v54.Unit * v.MagnetSpeed * p49;
                                i.CFrame = i.CFrame * CFrame.Angles(0, p49 * 15, 0);
                            else
                                v.Velocity = v.Velocity + Vector3.new(0, -50, 0) * p49;
                                v50 = Position + v.Velocity * p49;
                                v51 = workspace:Raycast(Position, Vector3.new(0, -1.5, 0), RaycastParams.new());

                                if v51 and v.Velocity.Y < 0 then
                                    v50 = Vector3.new(v50.X, v51.Position.Y + 0.5, v50.Z);
                                    v52 = v.Velocity.X * 0.8;
                                    v53 = math.abs(v.Velocity.Y) * 0.3;
                                    v.Velocity = Vector3.new(v52, v53, v.Velocity.Z * 0.8);

                                    if math.abs(v.Velocity.Y) < 2 then
                                        v.Velocity = Vector3.new(v.Velocity.X * 0.9, 0, v.Velocity.Z * 0.9);
                                    end;
                                end;

                                i.Position = v50;
                                i.CFrame = i.CFrame * CFrame.Angles(0, p49 * 5, p49 * 2);
                            end;
                        elseif Character and (Character - Position).Magnitude < u7 then
                            u1._collectDrop(i, v);
                        else
                            v.Velocity = v.Velocity + Vector3.new(0, -50, 0) * p49;
                            v50 = Position + v.Velocity * p49;
                            v51 = workspace:Raycast(Position, Vector3.new(0, -1.5, 0), RaycastParams.new());

                            if v51 and v.Velocity.Y < 0 then
                                v50 = Vector3.new(v50.X, v51.Position.Y + 0.5, v50.Z);
                                v52 = v.Velocity.X * 0.8;
                                v53 = math.abs(v.Velocity.Y) * 0.3;
                                v.Velocity = Vector3.new(v52, v53, v.Velocity.Z * 0.8);

                                if math.abs(v.Velocity.Y) < 2 then
                                    v.Velocity = Vector3.new(v.Velocity.X * 0.9, 0, v.Velocity.Z * 0.9);
                                end;
                            end;

                            i.Position = v50;
                            i.CFrame = i.CFrame * CFrame.Angles(0, p49 * 5, p49 * 2);
                        end;
                    end;
                end;
            else
                u9[i] = nil;
            end;
        end;
    end);
end;

function u1._collectDrop(u55: userdata, u56: table) -- Line: 402
    -- upvalues: u12 (ref), Knit (copy), TweenService (copy), u1 (copy)
    if u56.Collected then
        return;
    end;

    u56.Collected = true;

    if not u56.NoAward then
        if not u12 then
            local success, result = pcall(function() -- Line: 101
                -- upvalues: Knit (ref)
                return Knit.GetService("DropService");
            end);

            if success then
                u12 = result;
            end;
        end;

        local u57 = u12;

        if u57 then
            local u58 = u56.BatchId or u56.DropId;
            task.spawn(function() -- Line: 414
                -- upvalues: u57 (copy), u58 (copy), u56 (copy)
                local v59, v60 = u57:CollectDrop(u58, u56.DropType, u56.Value, u56.SourceId, u56.MaterialId):await();

                if not (v59 and v60) then
                    warn((`[DropSpawner] Server rejected drop collection: {u58}`));
                end;
            end);
        end;
    end;

    local v61 = TweenService:Create(u55, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = Vector3.new(0, 0, 0),
        Transparency = 1
    });
    v61:Play();
    v61.Completed:Once(function() -- Line: 431
        -- upvalues: u1 (ref), u55 (copy)
        u1._destroyDrop(u55, true);
    end);
end;

function u1._destroyDrop(u62: userdata, p63: boolean) -- Line: 436
    -- upvalues: u9 (copy), SharedUtils (copy)
    u9[u62] = nil;

    if u62 and u62.Parent then
        if p63 then
            pcall(function() -- Line: 443
                -- upvalues: SharedUtils (ref), u62 (copy)
                SharedUtils.PlaySoundAt(u62, "Collect", 0.5);
            end);
        end;

        if u62:FindFirstChild("Flick") then
            u62:SetAttribute("Fire", true);
        end;

        u62.Transparency = 1;
        u62:SetAttribute("FX_Activate", false);
        local Parent = u62.Parent;

        if Parent:IsA("Model") and not Parent:IsA("Workspace") then
            game.Debris:AddItem(Parent, 1);

            return;
        end;

        game.Debris:AddItem(u62, 1);
    end;
end;

function u1.GetActiveCount() -- Line: 468
    -- upvalues: u9 (copy)
    local v64 = 0;

    for _ in u9 do
        v64 = v64 + 1;
    end;

    return v64;
end;

function u1.SetMagneticRange(p65: number) -- Line: 476
    -- upvalues: u3 (ref)
    u3 = p65;
end;

function u1.SetMagneticSpeed(p66: number) -- Line: 480
    -- upvalues: u4 (ref)
    u4 = p66;
end;

function u1.SetCollectDistance(p67: number) -- Line: 484
    -- upvalues: u7 (ref)
    u7 = p67;
end;

function u1.SetMagneticDelay(p68: number) -- Line: 488
    -- upvalues: u6 (ref)
    u6 = p68;
end;

function u1.SetLifetime(p69: number) -- Line: 492
    -- upvalues: u8 (ref)
    u8 = p69;
end;

function u1.ClearAll() -- Line: 496
    -- upvalues: u9 (copy)
    for i in u9 do
        if i and i.Parent then
            local Parent = i.Parent;

            if Parent:IsA("Model") and not Parent:IsA("Workspace") then
                Parent:Destroy();
            else
                i:Destroy();
            end;
        end;
    end;

    table.clear(u9);
end;

return u1;