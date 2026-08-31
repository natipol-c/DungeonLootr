--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AspectRuntime
  Path:     game.ReplicatedStorage.Modules.AspectRuntime
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local u1 = {
    VFX_TAG = "Aspect_VFX"
};
local u2 = { "Left_Arm", "Right_Arm" };
local u3 = {};

local function LoadDefinition(p4: string) -- Line: 57
    -- upvalues: u3 (copy), ReplicatedStorage (copy)
    local v5 = u3[p4];

    if v5 ~= nil then
        return v5 or nil;
    end;

    local Mutations = ReplicatedStorage:FindFirstChild("Mutations");

    if Mutations then
        Mutations = Mutations:FindFirstChild(p4);
    end;

    if Mutations then
        Mutations = Mutations:FindFirstChild("Definition");
    end;

    if not (Mutations and Mutations:IsA("ModuleScript")) then
        u3[p4] = false;

        return nil;
    end;

    local success, result = pcall(require, Mutations);

    if success and type(result) == "table" then
        u3[p4] = result;

        return result;
    end;

    warn("[AspectRuntime] Failed to load Definition for aspect:", p4, result);
    u3[p4] = false;

    return nil;
end;

function u1.ClearVisual(p6: userdata?) -- Line: 88
    -- upvalues: CollectionService (copy), u1 (copy)
    if not p6 then
        return;
    end;

    for _, descendant in p6:GetDescendants() do
        if CollectionService:HasTag(descendant, u1.VFX_TAG) then
            descendant:Destroy();
        end;
    end;
end;

local function ApplyVisual(p7: any, p8: string) -- Line: 102
    -- upvalues: ReplicatedStorage (copy), u2 (copy), CollectionService (copy), u1 (copy)
    local Character = p7.Character;
    local ClassPrefab = p7.ClassPrefab;

    if not (ClassPrefab and ClassPrefab:FindFirstChild("Left_Arm")) then
        if Character then
            ClassPrefab = Character:FindFirstChild("Holder");
        else
            ClassPrefab = Character;
        end;
    end;

    if not (Character and ClassPrefab) then
        return;
    end;

    local v9 = ReplicatedStorage:FindFirstChild("Mutations") and ReplicatedStorage.Mutations:FindFirstChild(p8);

    if v9 then
        v9 = v9:FindFirstChild("_Effects");
    end;

    if not v9 then
        return;
    end;

    for _, v in u2 do
        local v10 = ClassPrefab:FindFirstChild(v);

        if v10 then
            local v11 = v10:FindFirstChildWhichIsA("MeshPart", true) or (v10:IsA("BasePart") and v10 and v10 or nil);

            if v11 then
                for _, child in v9:GetChildren() do
                    if child:IsA("ParticleEmitter") then
                        local v12 = child:Clone();
                        CollectionService:AddTag(v12, u1.VFX_TAG);
                        v12.Parent = v11;
                    end;
                end;
            end;
        end;
    end;
end;

function u1.Attach(p13) -- Line: 145
    -- upvalues: u1 (copy), LoadDefinition (copy), ApplyVisual (copy)
    local Player = p13.Player;

    if not Player then
        return;
    end;

    u1.ClearVisual(p13.Character);
    local Attribute = Player:GetAttribute("Active_Aspect");

    if not Attribute or Attribute == "" then
        return;
    end;

    local v14 = LoadDefinition(Attribute);

    if not v14 then
        return;
    end;

    p13._activeAspectDef = v14;

    for _, v in v14.Procs or {} do
        local Trigger = v.Trigger;

        if Trigger then
            p13.MasteryPassives[Trigger] = p13.MasteryPassives[Trigger] or {};
            table.insert(p13.MasteryPassives[Trigger], v);

            if v.Init then
                task.spawn(v.Init, p13);
            end;
        end;
    end;

    ApplyVisual(p13, Attribute);
    print((`[AspectRuntime] Attached aspect '{Attribute}' ({#(v14.Procs or {})} proc(s))`));
end;

return u1;