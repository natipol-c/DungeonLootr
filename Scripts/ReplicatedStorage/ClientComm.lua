--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClientComm
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_comm@1.0.1.comm.Client.ClientComm
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local script_Parent = require(script.Parent);
require(script.Parent.Parent.Types);
local Util = require(script.Parent.Parent.Util);
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: boolean, p4: string?) -- Line: 46
    -- upvalues: Util (copy), u1 (copy)
    assert(not Util.IsServer, "ClientComm must be constructed from the client");
    local v5 = typeof(p2) == "Instance";
    assert(v5, "Parent must be of type Instance");
    local v6 = p4 or Util.DefaultCommFolderName;
    local v7 = p2:WaitForChild(v6, Util.WaitForChildTimeout);
    assert(v7 ~= nil, "Could not find namespace for ClientComm in parent: " .. v6);
    local v8 = setmetatable({}, u1);
    v8._instancesFolder = v7;
    v8._usePromise = p3;

    return v8;
end;

function u1.GetFunction(p9: table, p10: string, p11: any, p12: any) -- Line: 95
    -- upvalues: script_Parent (copy)
    return script_Parent.GetFunction(p9._instancesFolder, p10, p9._usePromise, p11, p12);
end;

function u1.GetSignal(p13: table, p14: string, p15: any, p16: any) -- Line: 123
    -- upvalues: script_Parent (copy)
    return script_Parent.GetSignal(p13._instancesFolder, p14, p15, p16);
end;

function u1.GetProperty(p17: table, p18: string, p19: any, p20: any) -- Line: 165
    -- upvalues: script_Parent (copy)
    return script_Parent.GetProperty(p17._instancesFolder, p18, p19, p20);
end;

function u1.BuildObject(p21, p22, p23) -- Line: 192
    local v24 = {};
    local RF = p21._instancesFolder:FindFirstChild("RF");
    local RE = p21._instancesFolder:FindFirstChild("RE");
    local RP = p21._instancesFolder:FindFirstChild("RP");

    if RF then
        for _, child in RF:GetChildren() do
            if child:IsA("RemoteFunction") then
                local Function = p21:GetFunction(child.Name, p22, p23);

                v24[child.Name] = function(p25, ...) -- Line: 203
                    -- upvalues: Function (copy)
                    return Function(...);
                end;
            end;
        end;
    end;

    if RE then
        for _, child in RE:GetChildren() do
            if child:IsA("RemoteEvent") or child:IsA("UnreliableRemoteEvent") then
                v24[child.Name] = p21:GetSignal(child.Name, p22, p23);
            end;
        end;
    end;

    if RP then
        for _, child in RP:GetChildren() do
            if child:IsA("RemoteEvent") then
                v24[child.Name] = p21:GetProperty(child.Name, p22, p23);
            end;
        end;
    end;

    return v24;
end;

function u1.Destroy(p26) -- Line: 230
end;

return u1;