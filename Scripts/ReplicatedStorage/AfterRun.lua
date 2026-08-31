--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AfterRun
  Path:     game.ReplicatedStorage.CmdrClient.Types.AfterRun
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");

return function(p1) -- Line: 22
    -- upvalues: RunService (copy)
    if not RunService:IsServer() then
        return;
    end;

    local ReplicatedStorage = game:GetService("ReplicatedStorage");
    local Knit = require(ReplicatedStorage.Packages.Knit);

    local function extract(p2) -- Line: 34
        local v3 = {};
        local v4 = nil;

        for _, v in p2.Arguments do
            local success, result = pcall(function() -- Line: 38
                -- upvalues: v (copy)
                return v:GetValue();
            end);

            if success then
                if typeof(result) == "Instance" and result:IsA("Player") then
                    local v5 = `{v.Name}: {result.Name}`;
                    table.insert(v3, v5);
                    v4 = v4 or result;
                else
                    local v6 = type(result);

                    if v6 == "string" or (v6 == "number" or v6 == "boolean") then
                        local v7 = `{v.Name}: {tostring(result)}`;
                        table.insert(v3, v7);
                    end;
                end;
            end;
        end;

        return v4, table.concat(v3, "\n");
    end;

    p1:RegisterHook("AfterRun", function(u8) -- Line: 60
        -- upvalues: Knit (copy), extract (copy)
        pcall(function() -- Line: 63
            -- upvalues: u8 (copy), Knit (ref), extract (ref)
            local Executor = u8.Executor;

            if not Executor or (typeof(Executor) ~= "Instance" or not Executor:IsA("Player")) then
                return;
            end;

            local Service = Knit.GetService("WebhookService");

            if not Service then
                return;
            end;

            local v9, v10 = extract(u8);
            local Response = u8.Response;

            if type(Response) ~= "string" then
                Response = nil;
            end;

            local v11 = {
                CommandName = u8.Name,
                Alias = u8.Alias,
                Group = u8.Group,
                RawText = u8.RawText,
                ExecutorName = Executor.Name,
                ExecutorUserId = Executor.UserId
            };
            local v12;

            if v9 then
                v12 = v9.Name or nil;
            else
                v12 = nil;
            end;

            v11.TargetName = v12;
            v11.TargetUserId = v9 and v9.UserId or nil;
            v11.ArgsText = v10;
            v11.Response = Response;
            v11.JobId = game.JobId;
            v11.PlaceVersion = game.PlaceVersion;
            Service:LogCommand(v11);
        end);
    end);
end;