--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     shockwave_debris
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.effects.shockwave_debris
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../pkg/Promise");
require("../obj/ObjectCache");
local Random_new_ret = Random.new();
local v5 = {};
local u6 = {};
local u7 = nil;
local u8 = nil;

function v5.init(p9) -- Line: 20
    -- upvalues: u8 (ref), u7 (ref), u3 (copy), RunService (copy), u6 (copy)
    if u8 then
        return;
    end;

    u7 = p9;

    if u3.PLUGIN_CONTEXT then
        u8 = RunService.RenderStepped:Connect(function(p10) -- Line: 28
            -- upvalues: u6 (ref)
            if #u6 == 0 then
                return;
            end;

            workspace:StepPhysics(p10, u6);
        end);
    end;
end;

function v5.deinit() -- Line: 38
    -- upvalues: u8 (ref), u7 (ref), u6 (copy)
    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    u7 = nil;

    for _, v in u6 do
        v:Destroy();
    end;

    table.clear(u6);
end;

function v5.emit(p11: userdata, p12: userdata, u13: any) -- Line: 53
    -- upvalues: u7 (ref), u1 (copy), CollectionService (copy), Random_new_ret (copy), u3 (copy), u6 (copy), u2 (copy), u4 (copy)
    if not u7 then
        return;
    end;

    local v14 = u1.get(p12, "InheritanceEnabled", true);
    local v15 = u1.get(p12, "InheritanceRadius", 5);
    local v16 = u1.get(p11, "RayCollisionGroup", "Default");
    local u17 = u1.get(p11, "FilterTag", "");
    local u18 = u1.get(p11, "FilterType", "Exclude");
    local u19 = u1.get(p11, "IgnoreCanCollide", false);
    local v20;

    if v14 then
        local v21 = u1.get(p12, "InheritanceMaxResults", 5);
        v20 = OverlapParams.new();
        v20.MaxParts = v21;
        v20.CollisionGroup = v16;
        v20.RespectCanCollide = not u19;
        v20.FilterType = Enum.RaycastFilterType[u18];
        v20.FilterDescendantsInstances = CollectionService:GetTagged(u17);

        if u18 == "Exclude" then
            v20:AddToFilter({ workspace.Terrain });
        end;
    else
        v20 = nil;
    end;

    local v22 = u1.get(p12, "EmitDelay", 0);
    local Range = u1.getRange(p12, "Amount", NumberRange.new(5, 10), NumberRange.new(0, (1 / 0)));
    local Range2 = u1.getRange(p12, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)));
    local Range3 = u1.getRange(p12, "Airtime", NumberRange.new(0.5, 0.5), NumberRange.new(0, (1 / 0)));
    local Range4 = u1.getRange(p12, "LinearMagnitude", NumberRange.new(15, 25));
    local Range5 = u1.getRange(p12, "AngularMagnitude", NumberRange.new(5, 15));
    local u23 = u1.get(p12, "SizeScaleEnd", Vector3.new(0, 0, 0));
    local v24 = u1.get(p12, "MinSize", Vector3.new(2, 1, 2));
    local v25 = u1.get(p12, "MaxSize", Vector3.new(3, 2, 3));
    local v26 = u1.get(p12, "MinDirection", Vector3.new(-1, -1, -1));
    local v27 = u1.get(p12, "MaxDirection", Vector3.new(1, 1, 1));
    local v28 = Random_new_ret:NextInteger(Range.Min, Range.Max);
    local u29 = u1.get(p12, "Size_Curve", u3.default_bezier);
    local u30 = u1.get(p12, "Transparency_Curve", u3.default_bezier);
    local u31 = u1.get(p12, "Transparency_Duration", 0.5);
    local u32 = u1.get(p12, "Size_Duration", 0.5);
    local v33 = u1.get(p12, "Transparency_Start", 0);
    local u34 = u1.get(p12, "Transparency_End", 1);
    local v35 = {};
    local u36 = {};
    p12.CanCollide = false;
    local TransformedOriginExtents = u3.getTransformedOriginExtents(p11);
    local Position = TransformedOriginExtents.Position;

    if v20 then
        for _, v in workspace:GetPartBoundsInRadius(Position, v15, v20) do
            if v.Transparency ~= 1 then
                table.insert(v35, v);
            end;
        end;
    end;

    task.wait(v22);

    for i = 1, v28 do
        local v37;

        if #v35 == 0 then
            v37 = false;
        else
            v37 = v35[Random_new_ret:NextInteger(1, #v35)];
        end;

        local RandomId = u3.getRandomId();
        local u38 = u7:get(RandomId);
        local u39 = u38._getReal();
        u3.copyProperties(p12, u39, u3.COPY_PART_PROPERTIES);
        u3.copyProperties(p12, u39, u3.COPY_EXTENDED_PART_PROPERTIES);
        local v40;

        if #p12:GetChildren() == 0 then
            v40 = i;
        else
            local v41 = p12:Clone();
            v40 = i;

            for _, child in v41:GetChildren() do
                child.Parent = u39;
            end;

            v41:Destroy();
        end;

        local u42 = u13.effects.prepareEmitOnFinish(u39, u13);
        local u43 = u13.effects.prepareEmitFolder(u39, "EmitOnImpact", u13);

        if u43 and #u43:GetChildren() > 0 then
            local u44 = nil;
            u44 = u39.Touched:Connect(function(p45) -- Line: 162
                -- upvalues: u19 (copy), u39 (copy), u18 (copy), u17 (copy), u44 (ref), u13 (copy), u43 (copy), u36 (copy)
                if not (u19 or p45:CanCollideWith(u39)) or (p45:IsDescendantOf(workspace.Terrain) or u18 == "Exclude" and p45:HasTag(u17)) then
                    return;
                end;

                u44:Disconnect();
                local Finished = u13.effects.emitFromFolder(u43, u39, u13.depth + 1, u13).Finished;
                table.insert(u36, Finished);
            end);
            table.insert(u13, function() -- Line: 177
                -- upvalues: u44 (ref)
                if u44 then
                    u44:Disconnect();
                    u44 = nil;
                end;
            end);
        end;

        u38.Anchored = false;
        u38.CanCollide = true;

        if u38.CollisionGroup == "Default" then
            u38.CollisionGroup = "ForgeDebris";
        end;

        u38.CFrame = CFrame.new(Position);
        local v46 = Random_new_ret:NextNumber(v24.X, v25.X);
        local v47 = Random_new_ret:NextNumber(v24.Y, v25.Y);
        local Vector3_new_ret = Vector3.new(v46, v47, Random_new_ret:NextNumber(v24.Z, v25.Z));
        u38.Size = Vector3_new_ret;

        if v37 then
            u38.Material = v37.Material;
            u38.Color = v37.Color;
            u38.Transparency = v37.Transparency;
        else
            u38.Transparency = v33;
        end;

        table.insert(u13, function() -- Line: 210
            -- upvalues: u6 (ref), u39 (copy), u7 (ref), RandomId (copy)
            local table_find_ret = table.find(u6, u39);

            if table_find_ret then
                table.remove(u6, table_find_ret);
            end;

            if u7 then
                u7:free(RandomId);
            end;
        end);
        table.insert(u6, u39);
        u38.AssemblyLinearVelocity = TransformedOriginExtents:VectorToWorldSpace(u38.AssemblyLinearVelocity);
        local v48 = TransformedOriginExtents:VectorToWorldSpace((u3.randomUnitVector(v26, v27)));
        u38:ApplyImpulse(u38.AssemblyMass * u3.getImpulseForce(Position, Position + v48.Unit * Random_new_ret:NextNumber(Range4.Min, Range4.Max), Random_new_ret:NextNumber(Range3.Min, Range3.Max)));
        u38:ApplyAngularImpulse(u38.AssemblyMass * Random_new_ret:NextUnitVector() * Random_new_ret:NextNumber(Range5.Min, Range5.Max));
        local Finished = u13.effects.emitNested(u39, u13.depth + 1, u13).Finished;
        table.insert(u36, Finished);
        task.delay(Random_new_ret:NextNumber(Range2.Min, Range2.Max), function() -- Line: 243
            -- upvalues: u38 (copy), Vector3_new_ret (copy), u23 (copy), u13 (copy), u2 (ref), u29 (copy), u32 (copy), u34 (copy), u30 (copy), u31 (copy), u3 (ref), u42 (copy), u39 (copy), u36 (copy)
            local Size = u38.Size;
            local Transparency = u38.Transparency;

            if Size ~= Vector3_new_ret * u23 then
                table.insert(u13, u2.fromParams(u29, u32, function(p49, p50) -- Line: 250
                    -- upvalues: u38 (ref), Size (copy), Vector3_new_ret (ref), u23 (ref)
                    u38.Size = Size:Lerp(Vector3_new_ret * u23, p49);

                    return p50;
                end));
            end;

            if Transparency ~= u34 then
                table.insert(u13, u2.fromParams(u30, u31, function(p51, p52) -- Line: 260
                    -- upvalues: u38 (ref), u3 (ref), Transparency (copy), u34 (ref)
                    u38.Transparency = u3.lerp(Transparency, u34, p51);

                    return p52;
                end));
            end;

            local Finished2 = u13.effects.emitOnFinish(u42, u39, u13.depth + 1, u13).Finished;
            table.insert(u36, Finished2);
        end);
    end;

    task.wait(Range2.Max + math.max(u31, u32));
    u4.all(u36):await();
end;

return v5;