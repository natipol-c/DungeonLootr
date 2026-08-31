--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     NoticeController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.NoticeController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:15 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require(ReplicatedStorage.Packages.Knit).CreateController({
    Name = "NoticeController"
});
local u2 = {};

function v1.Register(p3: table, p4: string, p5: userdata, p6: function) -- Line: 42
    -- upvalues: u2 (copy)
    if u2[p4] then
        warn("[NoticeController] Overwriting existing registration for:", p4);
    end;

    u2[p4] = {
        icon = p5,
        check = p6
    };
    p3:Update(p4);
end;

function v1.Update(p7: table, p8: string) -- Line: 58
    -- upvalues: u2 (copy)
    local v9 = u2[p8];

    if not v9 then
        return;
    end;

    local success, result = pcall(v9.check);

    if success then
        v9.icon.Visible = result == true;

        return;
    end;

    warn("[NoticeController] Check function error for", p8, ":", result);
    v9.icon.Visible = false;
end;

function v1.UpdateAll(p10) -- Line: 72
    -- upvalues: u2 (copy)
    for i in u2 do
        p10:Update(i);
    end;
end;

function v1.IsActive(p11: table, p12: string) -- Line: 81
    -- upvalues: u2 (copy)
    local v13 = u2[p12];

    if v13 then
        return v13.icon.Visible;
    end;

    return false;
end;

function v1.KnitStart(p14) -- Line: 87
end;

function v1.KnitInit(p15) -- Line: 91
end;

return v1;