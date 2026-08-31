--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TabStyles
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.TabStyles
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:18 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    setGradientTabActive = function(p1: userdata?, p2: boolean) -- Line: 26, Name: setGradientTabActive
        if not p1 then
            return;
        end;

        for _, v in { "Background", "Outline" } do
            local v3 = p1:FindFirstChild(v);

            if v3 then
                local Active = v3:FindFirstChild("Active");
                local Inactive = v3:FindFirstChild("Inactive");

                if Active then
                    Active.Enabled = p2;
                end;

                if Inactive then
                    Inactive.Enabled = not p2;
                end;
            end;
        end;
    end,

    setStateActive = function(p4: userdata?, p5: boolean) -- Line: 41, Name: setStateActive
        if not p4 then
            return;
        end;

        local Active = p4:FindFirstChild("Active");
        local Inactive = p4:FindFirstChild("Inactive");

        if Active then
            Active.Visible = p5;
        end;

        if Inactive then
            Inactive.Visible = not p5;
        end;
    end
};