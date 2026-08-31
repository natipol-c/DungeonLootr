--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ServerComm
  Path:     game.ReplicatedStorage.Packages._Index.sleitnick_comm@1.0.1.comm.Server.ServerComm
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:42 2026
]]

-- Decompiled with Potassium's decompiler.

local script_Parent = require(script.Parent);
require(script.Parent.Parent.Types);
local Util = require(script.Parent.Parent.Util);
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: string?) -- Line: 44
    -- upvalues: Util (copy), u1 (copy)
    assert(Util.IsServer, "ServerComm must be constructed from the server");
    local v4 = typeof(p2) == "Instance";
    assert(v4, "Parent must be of type Instance");
    local v5 = p3 or Util.DefaultCommFolderName;
    local v6 = not p2:FindFirstChild(v5);
    assert(v6, "Parent already has another ServerComm bound to namespace " .. v5);
    local v7 = setmetatable({}, u1);
    v7._instancesFolder = Instance.new("Folder");
    v7._instancesFolder.Name = v5;
    v7._instancesFolder.Parent = p2;

    return v7;
end;

function u1.BindFunction(p8: table, p9: string, p10: any, p11: any, p12: any) -- Line: 76
    -- upvalues: script_Parent (copy)
    return script_Parent.BindFunction(p8._instancesFolder, p9, p10, p11, p12);
end;

function u1.WrapMethod(p13: table, p14: table, p15: string, p16: any, p17: any) -- Line: 108
    -- upvalues: script_Parent (copy)
    return script_Parent.WrapMethod(p13._instancesFolder, p14, p15, p16, p17);
end;

function u1.CreateSignal(p18: table, p19: string, p20: boolean?, p21: any, p22: any) -- Line: 146
    -- upvalues: script_Parent (copy)
    return script_Parent.CreateSignal(p18._instancesFolder, p19, p20, p21, p22);
end;

function u1.CreateProperty(p23: table, p24: string, p25: any, p26: any, p27: any) -- Line: 195
    -- upvalues: script_Parent (copy)
    return script_Parent.CreateProperty(p23._instancesFolder, p24, p25, p26, p27);
end;

function u1.Destroy(p28) -- Line: 207
    p28._instancesFolder:Destroy();
end;

return u1;