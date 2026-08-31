--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Weapon_Callbacks
  Path:     game.ReplicatedStorage.Weapons.Weapon_Callbacks
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:07 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Katana = {
        OnHit = function(p1, p2, p3) -- Line: 4, Name: OnHit
        end,

        OnSwing = function(p4, p5) -- Line: 8, Name: OnSwing
        end
    },
    Inverted_Spear = {
        OnHit = function(p6, p7, p8) -- Line: 14, Name: OnHit
        end
    },
    Yamato = {
        OnHit = function(p9, p10, p11) -- Line: 20, Name: OnHit
        end,

        OnSwing = function(p12, p13) -- Line: 24, Name: OnSwing
            local Character = p12.Player.Character;
            local Right_Arm = Character:FindFirstChild("Right_Arm", true);
            local Left_Arm = Character:FindFirstChild("Left_Arm", true);
            Right_Arm.SwordMain.Transparency = 0;

            for _, child in pairs(Right_Arm.SwordMain:GetChildren()) do
                if child:IsA("MeshPart") then
                    child.Transparency = 0;
                end;
            end;

            Left_Arm.SwordMain.Transparency = 1;

            for _, child in pairs(Left_Arm.SwordMain:GetChildren()) do
                if child:IsA("MeshPart") then
                    child.Transparency = 1;
                end;
            end;
        end,

        OnSwingEnd = function(p14, p15) -- Line: 44, Name: OnSwingEnd
            local Character = p14.Player.Character;
            local Right_Arm = Character:FindFirstChild("Right_Arm", true);
            local Left_Arm = Character:FindFirstChild("Left_Arm", true);
            Right_Arm.SwordMain.Transparency = 1;

            for _, child in pairs(Right_Arm.SwordMain:GetChildren()) do
                if child:IsA("MeshPart") then
                    child.Transparency = 1;
                end;
            end;

            Left_Arm.SwordMain.Transparency = 0;

            for _, child in pairs(Left_Arm.SwordMain:GetChildren()) do
                if child:IsA("MeshPart") then
                    child.Transparency = 0;
                end;
            end;
        end
    }
};