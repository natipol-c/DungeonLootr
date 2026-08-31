--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ProjectileUtil
  Path:     game.ReplicatedStorage.Globals.Modules.ProjectileUtil
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RigUtil = require(ReplicatedStorage.Modules.RigUtil);
local v1 = {};

local function getProjectileFolder() -- Line: 37
    local ActiveProjectiles = workspace:FindFirstChild("ActiveProjectiles");

    if ActiveProjectiles then
        return ActiveProjectiles;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "ActiveProjectiles";
    Folder.Parent = workspace;

    return Folder;
end;

function v1.Launch(u2) -- Line: 66
    -- upvalues: Players (copy), Debris (copy), RigUtil (copy)
    assert(u2.sourcePart, "[ProjectileUtil] sourcePart is required");
    assert(u2.classState, "[ProjectileUtil] classState is required");
    local origin = u2.origin;
    local u3 = u2.direction and (u2.direction.Unit or Vector3.new(0, 0, -1)) or Vector3.new(0, 0, -1);
    local u4 = u2.speed or 30;
    local u5 = u2.lifetime or 3;
    local u6 = u2.hitboxSize or Vector3.new(15, 15, 15);
    local u7 = u2.damageInterval or 0.25;
    local u8 = u2.damageMultiplier or 0.5;
    local classState = u2.classState;
    local u9 = u2.hitOncePerTarget or false;
    local u10 = u2.sourcePart:Clone();

    for _, descendant in u10:GetDescendants() do
        if descendant:IsA("WeldConstraint") or (descendant:IsA("Weld") or descendant:IsA("Motor6D")) then
            descendant:Destroy();
        end;
    end;

    if u10:IsA("BasePart") then
        u10.Anchored = true;
        u10.CanCollide = false;
        u10.CanTouch = false;
        u10.CanQuery = false;
    elseif u10:IsA("Model") then
        local v11 = u10.PrimaryPart or u10:FindFirstChildWhichIsA("BasePart");

        if v11 then
            v11.Anchored = true;
            v11.CanCollide = false;
            v11.CanTouch = false;
            v11.CanQuery = false;
        end;

        for _, descendant in u10:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.CanTouch = false;
                descendant.CanQuery = false;
            end;
        end;
    end;

    if u10:IsA("Model") then
        if u10.PrimaryPart then
            u10:PivotTo(origin);
        end;
    else
        u10.CFrame = origin;
    end;

    if u2.activateFX then
        u10:SetAttribute("Fire", nil);
        u10:SetAttribute("FX_Activate", nil);
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(classState.Character);

    if PlayerFromCharacter then
        u10:SetAttribute("OwnerUserId", PlayerFromCharacter.UserId);
    end;

    local ActiveProjectiles = workspace:FindFirstChild("ActiveProjectiles");

    if not ActiveProjectiles then
        ActiveProjectiles = Instance.new("Folder");
        ActiveProjectiles.Name = "ActiveProjectiles";
        ActiveProjectiles.Parent = workspace;
    end;

    u10.Parent = ActiveProjectiles;
    task.defer(function() -- Line: 147
        -- upvalues: u10 (copy), u2 (copy)
        if not (u10 and u10.Parent) then
            return;
        end;

        if u2.activateFX then
            u10:SetAttribute("FX_Activate", true);
        end;

        if u2.fireFX then
            u10:SetAttribute("Fire", not u10:GetAttribute("Fire"));
        end;
    end);
    Debris:AddItem(u10, u5);
    local u12 = {
        value = true
    };
    task.spawn(function() -- Line: 164
        -- upvalues: classState (copy), u10 (copy), u12 (copy), u5 (copy), u3 (copy), u4 (copy), u7 (copy), u6 (copy), RigUtil (ref), Players (ref), u9 (copy), u8 (copy)
        local OverlapParams_new_ret = OverlapParams.new();
        OverlapParams_new_ret.ExcludeInstances = { classState.Character, u10 };
        local v13 = 0;
        local v14 = 0;
        local v15 = {};

        while u12.value and (u10 and u10.Parent) do
            local task_wait_ret = task.wait();
            v13 = v13 + task_wait_ret;

            if u5 <= v13 then
                break;
            end;

            local v16 = u3 * u4 * task_wait_ret;

            if u10:IsA("Model") and u10.PrimaryPart then
                u10:PivotTo(u10.PrimaryPart.CFrame + v16);
            else
                if not u10:IsA("BasePart") then
                    break;
                end;

                u10.CFrame = u10.CFrame + v16;
            end;

            v14 = v14 + task_wait_ret;

            if u7 <= v14 then
                v14 = v14 - u7;
                local v17 = nil;

                if u10:IsA("Model") and u10.PrimaryPart then
                    v17 = u10.PrimaryPart.CFrame;
                elseif u10:IsA("BasePart") then
                    v17 = u10.CFrame;
                end;

                if v17 then
                    local v18 = {};

                    for _, v in workspace:GetPartBoundsInBox(v17, u6, OverlapParams_new_ret) do
                        local v19 = v:FindFirstAncestorOfClass("Model");

                        if v19 and (not v18[v19] and RigUtil.IsHittableTarget(v19)) then
                            local PlayerFromCharacter2 = Players:GetPlayerFromCharacter(v19);

                            if not PlayerFromCharacter2 or (classState.Player:GetAttribute("PVPEnabled") == true or PlayerFromCharacter2:GetAttribute("PVPEnabled") == true) then
                                v18[v19] = true;
                            end;
                        end;
                    end;

                    for i in v18 do
                        if not i:HasTag("Ignore_Damage") and (not i:GetAttribute("Dead") or i:GetAttribute("Can_Finish")) and not (u9 and v15[i]) then
                            if u9 then
                                v15[i] = true;
                            end;

                            classState:ApplyDamage(i, (classState:ResolveSkillDamage(u8, i)));
                        end;
                    end;
                end;
            end;
        end;

        if u10 and u10.Parent then
            u10:Destroy();
        end;
    end);

    return function() -- Line: 245
        -- upvalues: u12 (copy), u10 (copy)
        u12.value = false;

        if u10 and u10.Parent then
            u10:Destroy();
        end;
    end;
end;

return v1;