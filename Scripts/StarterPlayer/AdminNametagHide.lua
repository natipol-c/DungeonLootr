--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AdminNametagHide
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.AdminNametagHide
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");

return function() -- Line: 24
    -- upvalues: Players (copy)
    local u1 = {};

    local function hideBillboard(p2: any, u3: userdata) -- Line: 36
        if not u3:IsA("BillboardGui") then
            return;
        end;

        if p2.holds[u3] then
            return;
        end;

        p2.originals[u3] = u3.Enabled;
        u3.Enabled = false;
        p2.holds[u3] = u3:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 43
            -- upvalues: u3 (copy)
            if u3.Enabled then
                u3.Enabled = false;
            end;
        end);
    end;

    local function clearBillboards(p4) -- Line: 51
        for _, v in p4.holds do
            v:Disconnect();
        end;

        table.clear(p4.holds);
        table.clear(p4.originals);
    end;

    local function bindCharacter(u5: any, p6: userdata) -- Line: 59
        -- upvalues: hideBillboard (copy)
        if u5.descendantConn then
            u5.descendantConn:Disconnect();
        end;

        for _, descendant in p6:GetDescendants() do
            hideBillboard(u5, descendant);
        end;

        u5.descendantConn = p6.DescendantAdded:Connect(function(p7) -- Line: 68
            -- upvalues: hideBillboard (ref), u5 (copy)
            hideBillboard(u5, p7);
        end);
    end;

    local function activate(p8: userdata) -- Line: 73
        -- upvalues: u1 (copy), bindCharacter (copy), clearBillboards (copy)
        local v9 = u1[p8];

        if v9 and v9.active then
            return;
        end;

        local u10 = v9 or {
            originals = {},
            holds = {}
        };
        u10.active = true;
        u1[p8] = u10;

        if p8.Character then
            bindCharacter(u10, p8.Character);
        end;

        u10.characterConn = p8.CharacterAdded:Connect(function(p11) -- Line: 85
            -- upvalues: clearBillboards (ref), u10 (ref), bindCharacter (ref)
            clearBillboards(u10);
            bindCharacter(u10, p11);
        end);
    end;

    local function deactivate(p12: userdata) -- Line: 92
        -- upvalues: u1 (copy)
        local v13 = u1[p12];

        if not v13 then
            return;
        end;

        v13.active = false;

        if v13.descendantConn then
            v13.descendantConn:Disconnect();
        end;

        if v13.characterConn then
            v13.characterConn:Disconnect();
        end;

        v13.descendantConn = nil;
        v13.characterConn = nil;

        for _, v in v13.holds do
            v:Disconnect();
        end;

        table.clear(v13.holds);

        for i, v in v13.originals do
            if i.Parent then
                i.Enabled = v;
            end;
        end;

        table.clear(v13.originals);
        u1[p12] = nil;
    end;

    local function apply(p14: userdata) -- Line: 117
        -- upvalues: activate (copy), deactivate (copy)
        if p14:GetAttribute("AdminHideNametag") == true then
            activate(p14);

            return;
        end;

        deactivate(p14);
    end;

    local function watchPlayer(u15: userdata) -- Line: 125
        -- upvalues: activate (copy), deactivate (copy)
        if u15:GetAttribute("AdminHideNametag") == true then
            activate(u15);
        else
            deactivate(u15);
        end;

        u15:GetAttributeChangedSignal("AdminHideNametag"):Connect(function() -- Line: 127
            -- upvalues: u15 (copy), activate (ref), deactivate (ref)
            local v16 = u15;

            if v16:GetAttribute("AdminHideNametag") == true then
                activate(v16);

                return;
            end;

            deactivate(v16);
        end);
    end;

    for _, v in Players:GetPlayers() do
        if v:GetAttribute("AdminHideNametag") == true then
            activate(v);
        else
            deactivate(v);
        end;

        v:GetAttributeChangedSignal("AdminHideNametag"):Connect(function() -- Line: 127
            -- upvalues: v (copy), activate (copy), deactivate (copy)
            local v17 = v;

            if v17:GetAttribute("AdminHideNametag") == true then
                activate(v17);

                return;
            end;

            deactivate(v17);
        end);
    end;

    Players.PlayerAdded:Connect(watchPlayer);
    Players.PlayerRemoving:Connect(function(p18) -- Line: 137
        -- upvalues: u1 (copy)
        local v19 = u1[p18];

        if not v19 then
            return;
        end;

        if v19.descendantConn then
            v19.descendantConn:Disconnect();
        end;

        if v19.characterConn then
            v19.characterConn:Disconnect();
        end;

        for _, v in v19.holds do
            v:Disconnect();
        end;

        u1[p18] = nil;
    end);
end;