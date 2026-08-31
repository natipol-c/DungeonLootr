--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Weapon_Input
  Path:     game.ReplicatedStorage.Player.Modules.Weapon_Input
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GamepadService = game:GetService("GamepadService");
local GuiService = game:GetService("GuiService");
local Attack = ReplicatedStorage:WaitForChild("Player").Remotes.Inputs.Attack;
local Dash = ReplicatedStorage:WaitForChild("Player").Remotes.Inputs.Dash;
local Parry = ReplicatedStorage:WaitForChild("Player").Remotes.Inputs.Parry;
local Skill = ReplicatedStorage:WaitForChild("Player").Remotes.Inputs.Skill;
local Block = ReplicatedStorage:WaitForChild("Player").Remotes.Inputs.Block;
local Sprint = ReplicatedStorage:WaitForChild("Player").Remotes.Inputs.Sprint;
local Knit = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"));

local function GetMoveDirection() -- Line: 25
    -- upvalues: UserInputService (copy)
    local v2 = Vector3.new(0, 0, 0);

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        v2 = v2 + Vector3.new(0, 0, -1);
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        v2 = v2 + Vector3.new(0, 0, 1);
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        v2 = v2 + Vector3.new(-1, 0, 0);
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        v2 = v2 + Vector3.new(1, 0, 0);
    end;

    if v2.Magnitude > 0 then
        return v2.Unit;
    end;

    return v2;
end;

local function GetCameraRelativeMoveDir() -- Line: 50
    -- upvalues: GetMoveDirection (copy)
    local v3 = GetMoveDirection();

    if v3.Magnitude == 0 then
        return Vector3.new(0, 0, 0);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return Vector3.new(0, 0, 0);
    end;

    local CFrame = workspace_CurrentCamera.CFrame;
    local Unit = Vector3.new(CFrame.LookVector.X, 0, CFrame.LookVector.Z).Unit;
    local v4 = Vector3.new(CFrame.RightVector.X, 0, CFrame.RightVector.Z).Unit * v3.X + Unit * -v3.Z;

    return v4.Magnitude <= 0 and Vector3.new(0, 0, 0) or v4.Unit;
end;

local function GetCurrentMoveDir() -- Line: 66
    -- upvalues: GetCameraRelativeMoveDir (copy)
    local v5 = GetCameraRelativeMoveDir();

    if v5.Magnitude > 0 then
        return v5;
    end;

    local v6 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

    if v6 then
        v6 = v6:FindFirstChildOfClass("Humanoid");
    end;

    return (not v6 or v6.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v6.MoveDirection.Unit;
end;

local u7 = nil;

local function GetSettingsController() -- Line: 81
    -- upvalues: u7 (ref), Knit (copy)
    if u7 then
        return u7;
    end;

    local success, result = pcall(function() -- Line: 83
        -- upvalues: Knit (ref)
        return Knit.GetController("SettingsController");
    end);

    if success then
        u7 = result;
    end;

    return u7;
end;

local u8 = nil;

local function GetNotificationController() -- Line: 92
    -- upvalues: u8 (ref), Knit (copy)
    if u8 then
        return u8;
    end;

    local success, result = pcall(function() -- Line: 94
        -- upvalues: Knit (ref)
        return Knit.GetController("NotificationController");
    end);

    if success then
        u8 = result;
    end;

    return u8;
end;

local function GetMovementDots() -- Line: 102
    local v9 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if not v9 or v9.MoveDirection.Magnitude < 0.1 then
        return nil, nil;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return nil, nil;
    end;

    local Vector3_new_ret = Vector3.new(workspace_CurrentCamera.CFrame.LookVector.X, 0, workspace_CurrentCamera.CFrame.LookVector.Z);

    if Vector3_new_ret.Magnitude < 0.01 then
        return nil, nil;
    end;

    local Unit = Vector3_new_ret.Unit;
    local Unit2 = Vector3.new(workspace_CurrentCamera.CFrame.RightVector.X, 0, workspace_CurrentCamera.CFrame.RightVector.Z).Unit;
    local Vector3_new_ret2 = Vector3.new(v9.MoveDirection.X, 0, v9.MoveDirection.Z);

    if Vector3_new_ret2.Magnitude < 0.1 then
        return nil, nil;
    end;

    local Unit3 = Vector3_new_ret2.Unit;
    local v10 = Unit3:Dot(Unit);
    local v11 = Unit3:Dot(Unit2);

    return v10, math.abs(v11);
end;

local function IsMovingForwardStrict() -- Line: 126
    -- upvalues: GetMovementDots (copy)
    local v12, v13 = GetMovementDots();

    if not v12 then
        return false;
    end;

    local v14;

    if v12 > 0.5 then
        v14 = v13 < 0.45;
    else
        v14 = false;
    end;

    return v14;
end;

local function IsStillMovingForward() -- Line: 133
    -- upvalues: GetMovementDots (copy)
    local v15, _ = GetMovementDots();

    if v15 then
        return v15 > 0.3;
    end;

    return false;
end;

local u16 = nil;

local function GetIBC() -- Line: 142
    -- upvalues: u16 (ref), Knit (copy)
    if u16 then
        return u16;
    end;

    local success, result = pcall(function() -- Line: 144
        -- upvalues: Knit (ref)
        return Knit.GetController("InputBindingController");
    end);

    if success then
        u16 = result;
    end;

    return u16;
end;

local u17 = {
    Skill1 = 1,
    Skill2 = 2,
    Skill3 = 3,
    Skill4 = 4,
    SkillE = "E"
};

function u1.new() -- Line: 162
    -- upvalues: u1 (copy), Attack (copy), GetCameraRelativeMoveDir (copy), Skill (copy), Parry (copy), Block (copy), u16 (ref), Knit (copy), u17 (copy), UserInputService (copy), u8 (ref), GamepadService (copy), Dash (copy), Sprint (copy), u7 (ref), GetMovementDots (copy), GuiService (copy), ReplicatedStorage (copy)
    local u18 = setmetatable({}, u1);
    u18.Connections = {};
    u18.Player = game.Players.LocalPlayer;
    local u19 = false;
    local u20 = nil;

    local function fireAutoAttack() -- Line: 189
        -- upvalues: u19 (ref), u18 (copy), Attack (ref), GetCameraRelativeMoveDir (ref)
        if not u19 then
            return;
        end;

        if u18.Player:GetAttribute("Dead") then
            return;
        end;

        if not u18.Player:GetAttribute("Weapon_Equipped") then
            return;
        end;

        if u18.Player.Character and u18.Player.Character:GetAttribute("Blocking") then
            return;
        end;

        local v21 = GetCameraRelativeMoveDir();

        if v21.Magnitude <= 0 then
            local v22 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

            if v22 then
                v22 = v22:FindFirstChildOfClass("Humanoid");
            end;

            v21 = (not v22 or v22.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v22.MoveDirection.Unit;
        end;

        Attack:FireServer(v21);
    end;

    local function startAutoAttack() -- Line: 197
        -- upvalues: u20 (ref), u19 (ref), fireAutoAttack (copy)
        if u20 then
            return;
        end;

        u20 = task.spawn(function() -- Line: 200
            -- upvalues: u19 (ref), fireAutoAttack (ref)
            while u19 do
                task.wait(0.1);
                fireAutoAttack();
            end;
        end);
    end;

    local function stopAutoAttack() -- Line: 208
        -- upvalues: u19 (ref), u20 (ref)
        u19 = false;
        u20 = nil;
    end;

    local function hookAttackCadence(p23) -- Line: 219
        -- upvalues: u18 (copy), u19 (ref), fireAutoAttack (copy)
        if u18.Connections.AttackCadence then
            u18.Connections.AttackCadence:Disconnect();
            u18.Connections.AttackCadence = nil;
        end;

        local v24 = p23:FindFirstChildOfClass("Humanoid") or p23:WaitForChild("Humanoid", 10);

        if v24 then
            v24 = v24:FindFirstChildOfClass("Animator") or v24:WaitForChild("Animator", 10);
        end;

        if not v24 then
            return;
        end;

        u18.Connections.AttackCadence = v24.AnimationPlayed:Connect(function(p25) -- Line: 231
            -- upvalues: u19 (ref), fireAutoAttack (ref)
            local u26 = p25:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 233
                -- upvalues: u19 (ref), fireAutoAttack (ref)
                if u19 then
                    fireAutoAttack();
                end;
            end);
            p25.Stopped:Once(function() -- Line: 238
                -- upvalues: u26 (ref)
                u26:Disconnect();
            end);
        end);
    end;

    if u18.Player.Character then
        task.spawn(hookAttackCadence, u18.Player.Character);
    end;

    u18.Connections.CharacterAdded = u18.Player.CharacterAdded:Connect(function(p27) -- Line: 247
        -- upvalues: hookAttackCadence (copy)
        task.spawn(hookAttackCadence, p27);
    end);
    local u28 = nil;
    local u29 = false;
    local u30 = {};

    local function fireSkillBegan(u31) -- Line: 259
        -- upvalues: u18 (copy), u30 (copy), Skill (ref), GetCameraRelativeMoveDir (ref)
        local v32 = u31 == "E" and "SkillE" or "Skill" .. u31;

        if u31 == "E" and u18.Player:GetAttribute("HasUltimate") then
            if not u18.Player:GetAttribute("UltimateReady") then
                return;
            end;
        else
            local Attribute = u18.Player:GetAttribute(v32 .. "_Charges");
            local Attribute2 = u18.Player:GetAttribute(v32 .. "_MaxCharges");

            if Attribute and (Attribute2 and Attribute2 > 1) then
                if Attribute <= 0 then
                    return;
                end;
            elseif u18.Player:GetAttribute(v32 .. "_OnCooldown") then
                return;
            end;
        end;

        if u18.Player:GetAttribute(v32 .. "_HasHold") then
            u30[u31] = os.clock();
            task.delay(0.25, function() -- Line: 278
                -- upvalues: u30 (ref), u31 (copy), Skill (ref), GetCameraRelativeMoveDir (ref)
                if u30[u31] then
                    u30[u31] = nil;
                    local v33 = GetCameraRelativeMoveDir();

                    if v33.Magnitude <= 0 then
                        local v34 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

                        if v34 then
                            v34 = v34:FindFirstChildOfClass("Humanoid");
                        end;

                        v33 = (not v34 or v34.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v34.MoveDirection.Unit;
                    end;

                    Skill:FireServer(u31, "hold", v33);
                end;
            end);

            return;
        end;

        local v35 = GetCameraRelativeMoveDir();

        if v35.Magnitude <= 0 then
            local v36 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

            if v36 then
                v36 = v36:FindFirstChildOfClass("Humanoid");
            end;

            v35 = (not v36 or v36.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v36.MoveDirection.Unit;
        end;

        Skill:FireServer(u31, "tap", v35);
    end;

    local function fireSkillEnded(p37) -- Line: 289
        -- upvalues: u30 (copy), Skill (ref), GetCameraRelativeMoveDir (ref)
        if u30[p37] then
            u30[p37] = nil;
            local v38 = GetCameraRelativeMoveDir();

            if v38.Magnitude <= 0 then
                local v39 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

                if v39 then
                    v39 = v39:FindFirstChildOfClass("Humanoid");
                end;

                v38 = (not v39 or v39.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v39.MoveDirection.Unit;
            end;

            Skill:FireServer(p37, "tap", v38);
        end;
    end;

    local function beginAttack(p40) -- Line: 303
        -- upvalues: u18 (copy), u19 (ref), fireAutoAttack (copy), u20 (ref)
        if u18.Player.Character and u18.Player.Character:GetAttribute("Blocking") then
            return;
        end;

        u19 = true;
        fireAutoAttack();

        if not p40 then
            u19 = false;

            return;
        end;

        if u20 then
            return;
        end;

        u20 = task.spawn(function() -- Line: 200
            -- upvalues: u19 (ref), fireAutoAttack (ref)
            while u19 do
                task.wait(0.1);
                fireAutoAttack();
            end;
        end);
    end;

    local function beginParry(p41) -- Line: 314
        -- upvalues: Parry (ref), u28 (ref), u29 (ref), Block (ref)
        if not p41 then
            Parry:FireServer();

            return;
        end;

        u28 = os.clock();
        task.delay(0.15, function() -- Line: 321
            -- upvalues: u28 (ref), u29 (ref), Block (ref)
            if u28 then
                u28 = nil;
                u29 = true;
                Block:FireServer("start");
            end;
        end);
    end;

    local u42 = {};

    local function isGamepadInput(p43) -- Line: 343
        local UserInputType = p43.UserInputType;

        return (UserInputType == Enum.UserInputType.Gamepad1 or (UserInputType == Enum.UserInputType.Gamepad2 or UserInputType == Enum.UserInputType.Gamepad3)) and true or UserInputType == Enum.UserInputType.Gamepad4;
    end;

    local function ultComboParts() -- Line: 352
        -- upvalues: u16 (ref), Knit (ref)
        local v44;

        if u16 then
            v44 = u16;
        else
            local success, result = pcall(function() -- Line: 144
                -- upvalues: Knit (ref)
                return Knit.GetController("InputBindingController");
            end);

            if success then
                u16 = result;
            end;

            v44 = u16;
        end;

        local v45 = v44 and v44:GetKey("SkillE", "Gamepad") or "";

        if v45 == "" or not string.find(v45, "+", 1, true) then
            return nil;
        end;

        return string.split(v45, "+");
    end;

    local function replayFor(p46) -- Line: 363
        -- upvalues: u18 (copy), u19 (ref), fireAutoAttack (copy), u20 (ref), Parry (ref), u28 (ref), u29 (ref), Block (ref), u17 (ref), fireSkillBegan (copy)
        if p46 == "Attack" then
            return function(p47) -- Line: 365
                -- upvalues: u18 (ref), u19 (ref), fireAutoAttack (ref), u20 (ref)
                if u18.Player.Character and u18.Player.Character:GetAttribute("Blocking") then
                    return;
                end;

                u19 = true;
                fireAutoAttack();

                if not p47 then
                    u19 = false;

                    return;
                end;

                if u20 then
                    return;
                end;

                u20 = task.spawn(function() -- Line: 200
                    -- upvalues: u19 (ref), fireAutoAttack (ref)
                    while u19 do
                        task.wait(0.1);
                        fireAutoAttack();
                    end;
                end);
            end;
        end;

        if p46 == "ParryBlock" then
            return function(p48) -- Line: 367
                -- upvalues: Parry (ref), u28 (ref), u29 (ref), Block (ref)
                if not p48 then
                    Parry:FireServer();

                    return;
                end;

                u28 = os.clock();
                task.delay(0.15, function() -- Line: 321
                    -- upvalues: u28 (ref), u29 (ref), Block (ref)
                    if u28 then
                        u28 = nil;
                        u29 = true;
                        Block:FireServer("start");
                    end;
                end);
            end;
        end;

        if p46 == "SkillE" or not u17[p46] then
            return nil;
        end;

        local u49 = u17[p46];

        return function() -- Line: 370
            -- upvalues: fireSkillBegan (ref), u49 (copy)
            fireSkillBegan(u49);
        end;
    end;

    local function tryUltCombo(u50) -- Line: 386
        -- upvalues: u18 (copy), ultComboParts (copy), UserInputService (ref), u42 (copy), fireSkillBegan (copy), u16 (ref), Knit (ref), replayFor (copy)
        local UserInputType = u50.UserInputType;

        if UserInputType ~= Enum.UserInputType.Gamepad1 and (UserInputType ~= Enum.UserInputType.Gamepad2 and UserInputType ~= Enum.UserInputType.Gamepad3) and UserInputType ~= Enum.UserInputType.Gamepad4 then
            return false;
        end;

        if not u18.Player:GetAttribute("HasUltimate") then
            return false;
        end;

        if not u18.Player:GetAttribute("UltimateReady") then
            return false;
        end;

        local v51 = ultComboParts();

        if not v51 then
            return false;
        end;

        local Name = u50.KeyCode.Name;
        local v52 = false;
        local v53 = nil;

        for _, v in v51 do
            if v == Name then
                v52 = true;
            else
                v53 = v;
            end;
        end;

        if not (v52 and v53) then
            return false;
        end;

        local v54 = Enum.KeyCode[v53];

        if v54 and UserInputService:IsGamepadButtonDown(u50.UserInputType, v54) then
            local v55 = u42[v53];

            if v55 then
                v55.cancelled = true;
                u42[v53] = nil;
            end;

            fireSkillBegan("E");

            return true;
        end;

        local v56;

        if u16 then
            v56 = u16;
        else
            local success, result = pcall(function() -- Line: 144
                -- upvalues: Knit (ref)
                return Knit.GetController("InputBindingController");
            end);

            if success then
                u16 = result;
            end;

            v56 = u16;
        end;

        if v56 then
            v56 = v56:GetActionForInput(u50);
        end;

        local u57 = replayFor(v56);

        if v56 and not u57 then
            return false;
        end;

        local u58 = {
            cancelled = false
        };
        u42[Name] = u58;
        task.delay(0.08, function() -- Line: 427
            -- upvalues: u58 (copy), u42 (ref), Name (copy), u18 (ref), u57 (copy), UserInputService (ref), u50 (copy)
            if u58.cancelled then
                return;
            end;

            if u42[Name] == u58 then
                u42[Name] = nil;
            end;

            if u18.Player:GetAttribute("Dead") then
                return;
            end;

            if not u18.Player:GetAttribute("Weapon_Equipped") then
                return;
            end;

            if u57 then
                local v59 = Enum.KeyCode[Name];
                local v60;

                if v59 == nil then
                    v60 = false;
                else
                    v60 = UserInputService:IsGamepadButtonDown(u50.UserInputType, v59);
                end;

                u57(v60);
            end;
        end);

        return true;
    end;

    local u61 = false;
    local u62 = false;

    local function SetWalkActive(p63: boolean) -- Line: 454
        -- upvalues: u62 (ref), u18 (copy), u8 (ref), Knit (ref)
        local v64 = p63 == true;

        if u62 == v64 then
            return;
        end;

        u62 = v64;
        u18.Player:SetAttribute("Walk_Active", v64);
        local v65;

        if u8 then
            v65 = u8;
        else
            local success, result = pcall(function() -- Line: 94
                -- upvalues: Knit (ref)
                return Knit.GetController("NotificationController");
            end);

            if success then
                u8 = result;
            end;

            v65 = u8;
        end;

        if v65 then
            if v64 then
                v65:Show("Custom", "🚶 Walk enabled", 2, Color3.fromRGB(150, 220, 255), Color3.fromRGB(25, 55, 80), "Ting");

                return;
            end;

            v65:Show("Custom", "🏃 Walk disabled", 2, Color3.fromRGB(210, 210, 210), Color3.fromRGB(50, 50, 50), "Ting");
        end;
    end;

    u18.Connections.InputBegan = UserInputService.InputBegan:Connect(function(p66, p67) -- Line: 481
        -- upvalues: u16 (ref), Knit (ref), u18 (copy), tryUltCombo (copy), u19 (ref), fireAutoAttack (copy), u20 (ref), GamepadService (ref), GetCameraRelativeMoveDir (ref), Dash (ref), u28 (ref), u29 (ref), Block (ref), u17 (ref), fireSkillBegan (copy), u61 (ref), Sprint (ref), SetWalkActive (copy), u62 (ref)
        if p67 then
            local v68;

            if u16 then
                v68 = u16;
            else
                local success, result = pcall(function() -- Line: 144
                    -- upvalues: Knit (ref)
                    return Knit.GetController("InputBindingController");
                end);

                if success then
                    u16 = result;
                end;

                v68 = u16;
            end;

            if not v68 or (u18.Player:GetAttribute("OpenWindow") or not v68:CompletesAnyCombo(p66)) then
                return;
            end;
        end;

        if u18.Player:GetAttribute("InTheft") then
            return;
        end;

        if not u18.Player:GetAttribute("Dead") and (u18.Player:GetAttribute("Weapon_Equipped") and tryUltCombo(p66)) then
            return;
        end;

        local v69;

        if u16 then
            v69 = u16;
        else
            local success, result = pcall(function() -- Line: 144
                -- upvalues: Knit (ref)
                return Knit.GetController("InputBindingController");
            end);

            if success then
                u16 = result;
            end;

            v69 = u16;
        end;

        if v69 then
            v69 = v69:GetActionForInput(p66);
        end;

        if not v69 then
            return;
        end;

        if u18.Player:GetAttribute("Dead") then
            return;
        end;

        if not u18.Player:GetAttribute("Weapon_Equipped") then
            return;
        end;

        if v69 == "Attack" then
            if u18.Player.Character and u18.Player.Character:GetAttribute("Blocking") then
                return;
            end;

            u19 = true;
            fireAutoAttack();

            if u20 then
                return;
            end;

            u20 = task.spawn(function() -- Line: 200
                -- upvalues: u19 (ref), fireAutoAttack (ref)
                while u19 do
                    task.wait(0.1);
                    fireAutoAttack();
                end;
            end);

            return;
        end;

        if v69 ~= "Dodge" then
            if v69 == "ParryBlock" then
                u28 = os.clock();
                task.delay(0.15, function() -- Line: 321
                    -- upvalues: u28 (ref), u29 (ref), Block (ref)
                    if u28 then
                        u28 = nil;
                        u29 = true;
                        Block:FireServer("start");
                    end;
                end);

                return;
            end;

            if u17[v69] then
                fireSkillBegan(u17[v69]);

                return;
            end;

            if v69 == "Sprint" then
                if p66.UserInputType == Enum.UserInputType.Keyboard then
                    if not u61 then
                        u61 = true;
                        Sprint:FireServer("start");

                        return;
                    end;
                elseif p66.UserInputType == Enum.UserInputType.Gamepad1 then
                    u61 = not u61;
                    Sprint:FireServer(u61 and "start" or "stop");

                    return;
                end;
            elseif v69 == "Walk" then
                SetWalkActive(not u62);
            end;

            return;
        end;

        if p66.UserInputType == Enum.UserInputType.Gamepad1 and (GamepadService.GamepadCursorEnabled and not u18.Player:GetAttribute("OpenWindow")) then
            GamepadService:DisableGamepadCursor();

            return;
        end;

        local v70 = GetCameraRelativeMoveDir();

        if v70.Magnitude <= 0 then
            local v71 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

            if v71 then
                v71 = v71:FindFirstChildOfClass("Humanoid");
            end;

            v70 = (not v71 or v71.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v71.MoveDirection.Unit;
        end;

        if v70.Magnitude > 0 then
            Dash:FireServer(v70);

            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;
        Dash:FireServer(workspace_CurrentCamera and Vector3.new(workspace_CurrentCamera.CFrame.LookVector.X, 0, workspace_CurrentCamera.CFrame.LookVector.Z).Unit or Vector3.new(0, 0, 0));
    end);
    u18.Connections.InputEnded = UserInputService.InputEnded:Connect(function(p72, p73) -- Line: 568
        -- upvalues: u16 (ref), Knit (ref), u19 (ref), u20 (ref), u28 (ref), Parry (ref), u29 (ref), Block (ref), u17 (ref), u30 (copy), Skill (ref), GetCameraRelativeMoveDir (ref), u61 (ref), Sprint (ref)
        local v74;

        if u16 then
            v74 = u16;
        else
            local success, result = pcall(function() -- Line: 144
                -- upvalues: Knit (ref)
                return Knit.GetController("InputBindingController");
            end);

            if success then
                u16 = result;
            end;

            v74 = u16;
        end;

        if v74 then
            v74 = v74:GetActionForInput(p72);
        end;

        if not v74 then
            return;
        end;

        if v74 ~= "Attack" then
            if v74 == "ParryBlock" then
                if u28 then
                    u28 = nil;
                    Parry:FireServer();

                    return;
                end;

                if u29 then
                    u29 = false;
                    Block:FireServer("stop");

                    return;
                end;
            elseif u17[v74] then
                local v75 = u17[v74];

                if u30[v75] then
                    u30[v75] = nil;
                    local v76 = GetCameraRelativeMoveDir();

                    if v76.Magnitude <= 0 then
                        local v77 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

                        if v77 then
                            v77 = v77:FindFirstChildOfClass("Humanoid");
                        end;

                        v76 = (not v77 or v77.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v77.MoveDirection.Unit;
                    end;

                    Skill:FireServer(v75, "tap", v76);

                    return;
                end;
            elseif v74 == "Sprint" and (p72.UserInputType == Enum.UserInputType.Keyboard and u61) then
                u61 = false;
                Sprint:FireServer("stop");
            end;

            return;
        end;

        u19 = false;
        u20 = nil;
    end);
    u18.Connections.Sprint_Dead = u18.Player:GetAttributeChangedSignal("Dead"):Connect(function() -- Line: 602
        -- upvalues: u18 (copy), u61 (ref), Sprint (ref)
        if u18.Player:GetAttribute("Dead") and u61 then
            u61 = false;
            Sprint:FireServer("stop");
        end;
    end);
    u18.Connections.Walk_SprintWatch = u18.Player:GetAttributeChangedSignal("Sprint_Active"):Connect(function() -- Line: 612
        -- upvalues: u18 (copy), u62 (ref), SetWalkActive (copy)
        if u18.Player:GetAttribute("Sprint_Active") and u62 then
            SetWalkActive(false);
        end;
    end);
    local u78 = 0;
    local u79 = false;
    u18.Connections.AutoSprint = game:GetService("RunService").Heartbeat:Connect(function(p80) -- Line: 622
        -- upvalues: u7 (ref), Knit (ref), u79 (ref), u78 (ref), u61 (ref), Sprint (ref), u18 (copy), GetMovementDots (ref)
        local v81;

        if u7 then
            v81 = u7;
        else
            local success, result = pcall(function() -- Line: 83
                -- upvalues: Knit (ref)
                return Knit.GetController("SettingsController");
            end);

            if success then
                u7 = result;
            end;

            v81 = u7;
        end;

        if not (v81 and v81:IsEnabled("AutoSprint")) then
            if u79 then
                u79 = false;
                u78 = 0;

                if not u61 then
                    Sprint:FireServer("stop");
                end;
            end;

            return;
        end;

        if u18.Player:GetAttribute("Dead") or (not u18.Player:GetAttribute("Weapon_Equipped") or (u18.Player:GetAttribute("InTheft") or u18.Player:GetAttribute("Sprint_Locked"))) then
            if u79 then
                u79 = false;
                u78 = 0;
            end;

            return;
        end;

        if not u61 then
            if u79 then
                local v82, _ = GetMovementDots();
                local v83;

                if v82 then
                    v83 = v82 > 0.3;
                else
                    v83 = false;
                end;

                if not v83 then
                    u79 = false;
                    u78 = 0;
                    Sprint:FireServer("stop");

                    return;
                end;
            else
                local v84, v85 = GetMovementDots();
                local v86;

                if v84 and v84 > 0.5 then
                    v86 = v85 < 0.45;
                else
                    v86 = false;
                end;

                if v86 then
                    u78 = u78 + p80;

                    if u78 >= 0.2 then
                        u79 = true;
                        Sprint:FireServer("start");

                        return;
                    end;
                else
                    u78 = 0;
                end;
            end;

            return;
        end;

        u78 = 0;
        u79 = false;
    end);
    GuiService.AutoSelectGuiEnabled = false;
    u18.Connections.GamepadCursor = UserInputService.InputBegan:Connect(function(p87, p88) -- Line: 692
        -- upvalues: GamepadService (ref), GuiService (ref)
        if p87.UserInputType ~= Enum.UserInputType.Gamepad1 then
            return;
        end;

        if p87.KeyCode ~= Enum.KeyCode.ButtonSelect then
            return;
        end;

        if GamepadService.GamepadCursorEnabled then
            GamepadService:DisableGamepadCursor();

            return;
        end;

        GuiService.SelectedObject = nil;
        GamepadService:EnableGamepadCursor(nil);
    end);

    if UserInputService.TouchEnabled then
        local MobileActions = u18.Player:WaitForChild("PlayerGui"):WaitForChild("Main"):WaitForChild("HUD"):FindFirstChild("MobileActions");

        if MobileActions then
            local u89 = nil;

            local function isEditMode() -- Line: 717
                -- upvalues: u89 (ref), ReplicatedStorage (ref)
                if not u89 then
                    local success, result = pcall(function() -- Line: 719
                        -- upvalues: ReplicatedStorage (ref)
                        return require(ReplicatedStorage.Packages.Knit).GetController("SettingsController");
                    end);

                    if success then
                        u89 = result;
                    end;
                end;

                local v90 = u89 and u89:IsEditMode();

                return v90;
            end;

            local Attack2 = MobileActions:FindFirstChild("Attack");

            if Attack2 then
                u18.Connections.Mobile_Attack = Attack2.InputBegan:Connect(function(p91) -- Line: 730
                    -- upvalues: u89 (ref), ReplicatedStorage (ref), u18 (copy), u19 (ref), fireAutoAttack (copy), u20 (ref)
                    if not u89 then
                        local success, result = pcall(function() -- Line: 719
                            -- upvalues: ReplicatedStorage (ref)
                            return require(ReplicatedStorage.Packages.Knit).GetController("SettingsController");
                        end);

                        if success then
                            u89 = result;
                        end;
                    end;

                    local v92 = u89 and u89:IsEditMode();

                    if v92 then
                        return;
                    end;

                    if u18.Player:GetAttribute("InTheft") then
                        return;
                    end;

                    if p91.UserInputType ~= Enum.UserInputType.Touch then
                        return;
                    end;

                    if u18.Player:GetAttribute("Dead") then
                        return;
                    end;

                    if not u18.Player:GetAttribute("Weapon_Equipped") then
                        return;
                    end;

                    if u18.Player.Character and u18.Player.Character:GetAttribute("Blocking") then
                        return;
                    end;

                    u19 = true;
                    fireAutoAttack();

                    if u20 then
                        return;
                    end;

                    u20 = task.spawn(function() -- Line: 200
                        -- upvalues: u19 (ref), fireAutoAttack (ref)
                        while u19 do
                            task.wait(0.1);
                            fireAutoAttack();
                        end;
                    end);
                end);
                u18.Connections.Mobile_Attack_End = Attack2.InputEnded:Connect(function(p93) -- Line: 743
                    -- upvalues: u19 (ref), u20 (ref)
                    if p93.UserInputType == Enum.UserInputType.Touch then
                        u19 = false;
                        u20 = nil;
                    end;
                end);
            end;

            local Dodge = MobileActions:FindFirstChild("Dodge");

            if Dodge then
                u18.Connections.Mobile_Dodge = Dodge.Activated:Connect(function() -- Line: 753
                    -- upvalues: u89 (ref), ReplicatedStorage (ref), u18 (copy), GetCameraRelativeMoveDir (ref), Dash (ref)
                    if not u89 then
                        local success, result = pcall(function() -- Line: 719
                            -- upvalues: ReplicatedStorage (ref)
                            return require(ReplicatedStorage.Packages.Knit).GetController("SettingsController");
                        end);

                        if success then
                            u89 = result;
                        end;
                    end;

                    local v94 = u89 and u89:IsEditMode();

                    if v94 then
                        return;
                    end;

                    if u18.Player:GetAttribute("InTheft") then
                        return;
                    end;

                    if u18.Player:GetAttribute("Dead") then
                        return;
                    end;

                    if not u18.Player:GetAttribute("Weapon_Equipped") then
                        return;
                    end;

                    local v95 = GetCameraRelativeMoveDir();

                    if v95.Magnitude <= 0 then
                        local v96 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

                        if v96 then
                            v96 = v96:FindFirstChildOfClass("Humanoid");
                        end;

                        v95 = (not v96 or v96.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v96.MoveDirection.Unit;
                    end;

                    if v95.Magnitude > 0 then
                        Dash:FireServer(v95);

                        return;
                    end;

                    local workspace_CurrentCamera = workspace.CurrentCamera;
                    Dash:FireServer(workspace_CurrentCamera and Vector3.new(workspace_CurrentCamera.CFrame.LookVector.X, 0, workspace_CurrentCamera.CFrame.LookVector.Z).Unit or Vector3.new(0, 0, 0));
                end);
            end;

            local Parry2 = MobileActions:FindFirstChild("Parry");

            if Parry2 then
                u18.Connections.Mobile_Parry = Parry2.InputBegan:Connect(function(p97) -- Line: 778
                    -- upvalues: u89 (ref), ReplicatedStorage (ref), u18 (copy), u28 (ref), u29 (ref), Block (ref)
                    if p97.UserInputType ~= Enum.UserInputType.Touch then
                        return;
                    end;

                    if not u89 then
                        local success, result = pcall(function() -- Line: 719
                            -- upvalues: ReplicatedStorage (ref)
                            return require(ReplicatedStorage.Packages.Knit).GetController("SettingsController");
                        end);

                        if success then
                            u89 = result;
                        end;
                    end;

                    local v98 = u89 and u89:IsEditMode();

                    if v98 then
                        return;
                    end;

                    if u18.Player:GetAttribute("InTheft") then
                        return;
                    end;

                    if u18.Player:GetAttribute("Dead") then
                        return;
                    end;

                    if not u18.Player:GetAttribute("Weapon_Equipped") then
                        return;
                    end;

                    u28 = os.clock();
                    task.delay(0.15, function() -- Line: 321
                        -- upvalues: u28 (ref), u29 (ref), Block (ref)
                        if u28 then
                            u28 = nil;
                            u29 = true;
                            Block:FireServer("start");
                        end;
                    end);
                end);
                u18.Connections.Mobile_Parry_End = Parry2.InputEnded:Connect(function(p99) -- Line: 787
                    -- upvalues: u28 (ref), Parry (ref), u29 (ref), Block (ref)
                    if p99.UserInputType ~= Enum.UserInputType.Touch then
                        return;
                    end;

                    if not u28 then
                        if u29 then
                            u29 = false;
                            Block:FireServer("stop");
                        end;

                        return;
                    end;

                    u28 = nil;
                    Parry:FireServer();
                end);
            end;

            local u100 = {};

            for _, v in { {
                    name = "Skill_1",
                    slot = 1
                }, {
                    name = "Skill_2",
                    slot = 2
                }, {
                    name = "Skill_3",
                    slot = 3
                }, {
                    name = "Skill_4",
                    slot = 4
                }, {
                    name = "SkillE",
                    slot = "E"
                }, {
                    name = "Skill",
                    slot = 1
                } } do
                local v101 = MobileActions:FindFirstChild(v.name);

                if v101 then
                    local slot = v.slot;
                    local u102 = slot == "E" and "SkillE" or "Skill" .. slot;
                    u18.Connections["Mobile_" .. v.name .. "_Began"] = v101.InputBegan:Connect(function(p103) -- Line: 820
                        -- upvalues: u89 (ref), ReplicatedStorage (ref), u18 (copy), slot (copy), u102 (copy), u100 (copy), Skill (ref), GetCameraRelativeMoveDir (ref)
                        if p103.UserInputType ~= Enum.UserInputType.Touch then
                            return;
                        end;

                        if not u89 then
                            local success, result = pcall(function() -- Line: 719
                                -- upvalues: ReplicatedStorage (ref)
                                return require(ReplicatedStorage.Packages.Knit).GetController("SettingsController");
                            end);

                            if success then
                                u89 = result;
                            end;
                        end;

                        local v104 = u89 and u89:IsEditMode();

                        if v104 then
                            return;
                        end;

                        if u18.Player:GetAttribute("InTheft") then
                            return;
                        end;

                        if u18.Player:GetAttribute("Dead") then
                            return;
                        end;

                        if not u18.Player:GetAttribute("Weapon_Equipped") then
                            return;
                        end;

                        if slot == "E" and u18.Player:GetAttribute("HasUltimate") then
                            if not u18.Player:GetAttribute("UltimateReady") then
                                return;
                            end;
                        else
                            local Attribute = u18.Player:GetAttribute(u102 .. "_Charges");
                            local Attribute2 = u18.Player:GetAttribute(u102 .. "_MaxCharges");

                            if Attribute and (Attribute2 and Attribute2 > 1) then
                                if Attribute <= 0 then
                                    return;
                                end;
                            elseif u18.Player:GetAttribute(u102 .. "_OnCooldown") then
                                return;
                            end;
                        end;

                        if u18.Player:GetAttribute(u102 .. "_HasHold") then
                            u100[slot] = os.clock();
                            task.delay(0.25, function() -- Line: 845
                                -- upvalues: u100 (ref), slot (ref), Skill (ref), GetCameraRelativeMoveDir (ref)
                                if u100[slot] then
                                    u100[slot] = nil;
                                    local v105 = GetCameraRelativeMoveDir();

                                    if v105.Magnitude <= 0 then
                                        local v106 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

                                        if v106 then
                                            v106 = v106:FindFirstChildOfClass("Humanoid");
                                        end;

                                        v105 = (not v106 or v106.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v106.MoveDirection.Unit;
                                    end;

                                    Skill:FireServer(slot, "hold", v105);
                                end;
                            end);

                            return;
                        end;

                        local v107 = GetCameraRelativeMoveDir();

                        if v107.Magnitude <= 0 then
                            local v108 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

                            if v108 then
                                v108 = v108:FindFirstChildOfClass("Humanoid");
                            end;

                            v107 = (not v108 or v108.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v108.MoveDirection.Unit;
                        end;

                        Skill:FireServer(slot, "tap", v107);
                    end);
                    u18.Connections["Mobile_" .. v.name .. "_Ended"] = v101.InputEnded:Connect(function(p109) -- Line: 857
                        -- upvalues: u100 (copy), slot (copy), Skill (ref), GetCameraRelativeMoveDir (ref)
                        if p109.UserInputType ~= Enum.UserInputType.Touch then
                            return;
                        end;

                        if u100[slot] then
                            u100[slot] = nil;
                            local v110 = GetCameraRelativeMoveDir();

                            if v110.Magnitude <= 0 then
                                local v111 = game.Players.LocalPlayer and game.Players.LocalPlayer.Character;

                                if v111 then
                                    v111 = v111:FindFirstChildOfClass("Humanoid");
                                end;

                                v110 = (not v111 or v111.MoveDirection.Magnitude <= 0) and Vector3.new(0, 0, 0) or v111.MoveDirection.Unit;
                            end;

                            Skill:FireServer(slot, "tap", v110);
                        end;
                    end);
                end;
            end;

            local Sprint2 = MobileActions:FindFirstChild("Sprint");

            if Sprint2 then
                local u112 = false;
                u18.Connections.Mobile_Sprint = Sprint2.Activated:Connect(function() -- Line: 873
                    -- upvalues: u89 (ref), ReplicatedStorage (ref), u18 (copy), u112 (ref), Sprint (ref)
                    if not u89 then
                        local success, result = pcall(function() -- Line: 719
                            -- upvalues: ReplicatedStorage (ref)
                            return require(ReplicatedStorage.Packages.Knit).GetController("SettingsController");
                        end);

                        if success then
                            u89 = result;
                        end;
                    end;

                    local v113 = u89 and u89:IsEditMode();

                    if v113 then
                        return;
                    end;

                    if u18.Player:GetAttribute("InTheft") then
                        return;
                    end;

                    if u18.Player:GetAttribute("Dead") then
                        return;
                    end;

                    if not u18.Player:GetAttribute("Weapon_Equipped") then
                        return;
                    end;

                    u112 = not u112;
                    Sprint:FireServer(u112 and "start" or "stop");
                end);
                u18.Connections.Mobile_Sprint_Dead = u18.Player:GetAttributeChangedSignal("Dead"):Connect(function() -- Line: 884
                    -- upvalues: u18 (copy), u112 (ref), Sprint (ref)
                    if u18.Player:GetAttribute("Dead") and u112 then
                        u112 = false;
                        Sprint:FireServer("stop");
                    end;
                end);
            end;

            local Walk = MobileActions:FindFirstChild("Walk");

            if Walk then
                u18.Connections.Mobile_Walk = Walk.Activated:Connect(function() -- Line: 897
                    -- upvalues: u89 (ref), ReplicatedStorage (ref), u18 (copy), SetWalkActive (copy), u62 (ref)
                    if not u89 then
                        local success, result = pcall(function() -- Line: 719
                            -- upvalues: ReplicatedStorage (ref)
                            return require(ReplicatedStorage.Packages.Knit).GetController("SettingsController");
                        end);

                        if success then
                            u89 = result;
                        end;
                    end;

                    local v114 = u89 and u89:IsEditMode();

                    if v114 then
                        return;
                    end;

                    if u18.Player:GetAttribute("InTheft") then
                        return;
                    end;

                    if u18.Player:GetAttribute("Dead") then
                        return;
                    end;

                    if not u18.Player:GetAttribute("Weapon_Equipped") then
                        return;
                    end;

                    SetWalkActive(not u62);
                end);
            end;
        end;
    end;

    return u18;
end;

function u1.Destroy(p115) -- Line: 911
    for _, v in p115.Connections do
        v:Disconnect();
    end;

    table.clear(p115.Connections);
end;

return u1;