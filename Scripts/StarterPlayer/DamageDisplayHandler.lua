--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DamageDisplayHandler
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.DamageDisplayHandler
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DamageDisplay = require(ReplicatedStorage.Modules.DamageDisplay);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local DamageDisplay2 = ReplicatedStorage:WaitForChild("Player").Remotes:WaitForChild("DamageDisplay");
local Color3_fromRGB_ret = Color3.fromRGB(255, 50, 50);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 215, 0);
local u1 = setmetatable({}, {
    __mode = "k"
});

local function render(p2: vector, p3: number, p4: boolean) -- Line: 47
    -- upvalues: Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), DamageDisplay (copy), SharedUtils (copy)
    local v5;

    if p4 then
        v5 = Color3_fromRGB_ret2;
    else
        v5 = Color3_fromRGB_ret;
    end;

    DamageDisplay.DisplayDamage(p2, (p4 and "CRIT -" or "-") .. SharedUtils.FormatNumber(p3), v5, {
        IsCrit = p4
    });
end;

return function(p6, p7) -- Line: 53
    -- upvalues: DamageDisplay (copy), Players (copy), DamageDisplay2 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), SharedUtils (copy), u1 (copy)
    DamageDisplay.Init();
    local LocalPlayer = Players.LocalPlayer;

    local function applyAnimation() -- Line: 61
        -- upvalues: DamageDisplay (ref), LocalPlayer (copy)
        DamageDisplay.SetAnimation(LocalPlayer:GetAttribute("DamageNumberAnimation"));
    end;

    DamageDisplay.SetAnimation(LocalPlayer:GetAttribute("DamageNumberAnimation"));
    LocalPlayer:GetAttributeChangedSignal("DamageNumberAnimation"):Connect(applyAnimation);
    DamageDisplay2.OnClientEvent:Connect(function(p8, p9, p10, u11) -- Line: 67
        -- upvalues: Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret (ref), DamageDisplay (ref), SharedUtils (ref), u1 (ref)
        if typeof(p9) ~= "number" then
            return;
        end;

        local u12 = p10 == true;

        if typeof(u11) ~= "Instance" then
            local v13 = u12;
            local v14;

            if v13 then
                v14 = Color3_fromRGB_ret2;
            else
                v14 = Color3_fromRGB_ret;
            end;

            DamageDisplay.DisplayDamage(p8, (v13 and "CRIT -" or "-") .. SharedUtils.FormatNumber(p9), v14, {
                IsCrit = v13
            });

            return;
        end;

        local v15 = u1[u11];

        if not v15 then
            v15 = {};
            u1[u11] = v15;
        end;

        local v16 = v15[u12];

        if v16 then
            v16.total = v16.total + p9;
            v16.pos = p8;

            return;
        end;

        v15[u12] = {
            total = p9,
            pos = p8
        };
        task.delay(0.08, function() -- Line: 93
            -- upvalues: u1 (ref), u11 (copy), u12 (ref), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret (ref), DamageDisplay (ref), SharedUtils (ref)
            local v17 = u1[u11];
            local v18;

            if v17 then
                v18 = v17[u12];
            else
                v18 = v17;
            end;

            if not v18 then
                return;
            end;

            v17[u12] = nil;
            local v19 = u12;
            local v20;

            if v19 then
                v20 = Color3_fromRGB_ret2;
            else
                v20 = Color3_fromRGB_ret;
            end;

            DamageDisplay.DisplayDamage(v18.pos, (v19 and "CRIT -" or "-") .. SharedUtils.FormatNumber(v18.total), v20, {
                IsCrit = v19
            });
        end);
    end);
end;