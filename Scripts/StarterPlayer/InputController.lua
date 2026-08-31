--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     InputController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.InputController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");

return {
    LastInput = nil,
    Connections = {},

    Bind = function(p1, p2, u3, ...) -- Line: 11, Name: Bind
        -- upvalues: UserInputService (copy)
        p1.Connections[p2] = {};

        for _, v in ipairs({ ... }) do
            local u4 = tostring(v.EnumType);
            p1.Connections[p2][v] = { UserInputService.InputBegan:Connect(function(p5, p6) -- Line: 18
                    -- upvalues: u4 (copy), v (copy), u3 (copy)
                    if p5[u4] == v then
                        u3(p5, p5.UserInputState, p6);
                    end;
                end), UserInputService.InputChanged:Connect(function(p7, p8) -- Line: 24
                    -- upvalues: u4 (copy), v (copy), u3 (copy)
                    if p7[u4] == v then
                        u3(p7, p7.UserInputState, p8);
                    end;
                end), UserInputService.InputEnded:Connect(function(p9, p10) -- Line: 30
                    -- upvalues: u4 (copy), v (copy), u3 (copy)
                    if p9[u4] == v then
                        u3(p9, p9.UserInputState, p10);
                    end;
                end) };
        end;
    end,

    Mass = function(p11, p12, ...) -- Line: 39, Name: Mass
        for i, v in pairs(#{ ... } > 1 and { ... } or ({ ... })[1]) do
            local v13 = p11[p12];
            local v14 = typeof(v) == "table" and v and v or {};
            v13(p11, i, unpack(v14));
        end;
    end,

    SortPressed = function(p15: table, p16: userdata, p17: userdata?, p18: number?) -- Line: 45, Name: SortPressed
        -- upvalues: UserInputService (copy)
        local KeysPressed = UserInputService:GetKeysPressed();
        local v19 = {};

        for _, v in ipairs(KeysPressed) do
            local Name = v.KeyCode.Name;

            if p16[Name] then
                table.insert(v19, Name);
            end;
        end;

        if p18 and p18 < #v19 then
            return {};
        end;

        if p17 then
            for _, v in ipairs(v19) do
                local v20 = v;

                for _, v2 in ipairs(v19) do
                    if v2 ~= v20 and p17[`{v20 .. v2}`] then
                        return v19, true;
                    end;
                end;
            end;
        end;

        return v19, false;
    end,

    Unbind = function(p21, p22) -- Line: 74, Name: Unbind
        if not p22 then
            for _, v in pairs(p21.Connections) do
                for _, v2 in pairs(v) do
                    v2:Disconnect();
                end;
            end;

            return;
        end;

        for _, v in pairs(p21.Connections[p22]) do
            v:Disconnect();
        end;

        p21.Connections[p22] = nil;
    end
};