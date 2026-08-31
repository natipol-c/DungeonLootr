--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PortalFinderClient
  Path:     game.ReplicatedStorage.ClientTools.PortalFinderClient
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:27 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.SharedUtils);
require(ReplicatedStorage.SharedDictionaries:WaitForChild("RarityColors"));
local maid = require(ReplicatedStorage.Packages.maid);
require(ReplicatedStorage.Packages.Knit);
local u2 = {};
local LocalPlayer = game.Players.LocalPlayer;
local Character = LocalPlayer.Character;

local function ArrowTo(p3: userdata, p4: vector) -- Line: 23
    -- upvalues: u2 (copy), Character (ref), LocalPlayer (copy), ReplicatedStorage (copy)
    for _, v in ipairs(u2) do
        if typeof(v) == "Instance" then
            v:Destroy();
        end;
    end;

    if not p3 then
        return;
    end;

    if not Character then
        Character = LocalPlayer.CharacterAdded:Wait();
    end;

    local v5 = Character.PrimaryPart:FindFirstChild("ArrowAttachment") or Instance.new("Attachment");
    v5.Orientation = Vector3.new(0, 0, 90);
    v5.Name = "ArrowAttachment";
    v5.Parent = Character.PrimaryPart;
    local Attachment = Instance.new("Attachment");
    Attachment.Position = p4 or Vector3.new(0, 0, 0);
    Attachment.Orientation = Vector3.new(0, 0, 90);
    Attachment.Name = "ArrowAttachment";
    Attachment.Parent = p3;
    table.insert(u2, Attachment);
    local v6 = ReplicatedStorage.Assets.VFX.PortalFinderBeam:Clone();
    v6.Attachment0 = v5;
    v6.Attachment1 = Attachment;
    v6.Parent = Character.PrimaryPart;
    table.insert(u2, v6);
end;

local function GetClosestPortal(p7) -- Line: 56
    local v8 = (1 / 0);
    local v9 = nil;

    for _, child in workspace.Portals:GetChildren() do
        if (child:GetPivot().Position - p7.Character.PrimaryPart.Position).Magnitude < v8 then
            v8 = (child:GetPivot().Position - p7.Character.PrimaryPart.Position).Magnitude;
            v9 = child;
        end;
    end;

    return v9;
end;

function u1.new(p10: userdata) -- Line: 68
    -- upvalues: u1 (copy), maid (copy), ReplicatedStorage (copy)
    local v11 = setmetatable({}, u1);
    v11.Tool = p10;
    v11._maid = maid.new();

    if not v11.Tool.Handle:FindFirstChild("Equip") then
        ReplicatedStorage.Assets.Sounds.Equip:Clone().Parent = v11.Tool.Handle;
    end;

    v11:Init();

    return v11;
end;

function u1.Use(p12) -- Line: 81
end;

function u1.ShowPortal(p13: table, p14: boolean) -- Line: 83
    -- upvalues: LocalPlayer (copy), GetClosestPortal (copy), ArrowTo (copy), u2 (copy)
    if not LocalPlayer:GetAttribute("InDungeon") then
        return;
    end;

    GetClosestPortal(LocalPlayer);

    while true do
        local v15 = GetClosestPortal(LocalPlayer);

        if v15 then
            ArrowTo(v15.PrimaryPart);
        else
            for _, v in ipairs(u2) do
                if typeof(v) == "Instance" then
                    v:Destroy();
                end;
            end;
        end;

        task.wait(1);

        if not p13.Equipped then
            return;
        end;
    end;
end;

function u1.Init(u16) -- Line: 100
    -- upvalues: u2 (copy)
    u16._maid:GiveTask(u16.Tool.Equipped:Connect(function() -- Line: 101
        -- upvalues: u16 (copy)
        u16.Equipped = true;
        u16:ShowPortal(true);

        if u16.Tool.Handle:FindFirstChild("Equip") then
            u16.Tool.Handle.Equip:Play();
        end;
    end));
    u16._maid:GiveTask(u16.Tool.Unequipped:Connect(function() -- Line: 108
        -- upvalues: u16 (copy), u2 (ref)
        u16.Equipped = false;

        for _, v in ipairs(u2) do
            if typeof(v) == "Instance" then
                v:Destroy();
            end;
        end;
    end));
end;

function u1.Destroy(p17) -- Line: 114
    p17._maid:DoCleaning();
end;

return u1;