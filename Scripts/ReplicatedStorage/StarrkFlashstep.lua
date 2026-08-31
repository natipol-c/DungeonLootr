--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     StarrkFlashstep
  Path:     game.ReplicatedStorage.Classes.Coyote.Skill_Modules.StarrkFlashstep
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;

local function InvisOn(p2) -- Line: 9
end;

local function InvisOff(p3) -- Line: 13
end;

return {
    init = function(p4) -- Line: 21, Name: init
        -- upvalues: u1 (ref)
        u1 = p4;
    end,

    On = function(p5, p6) -- Line: 25, Name: On
        -- upvalues: u1 (ref)
        u1.Invis.Invisible(p5);
        local v7 = script["Flashstep VFX emit"]:Clone();
        v7.CFrame = p5.HumanoidRootPart.CFrame;
        v7.Parent = workspace.Effects[p5.Name];
        u1.Effects:AutoEmit(v7);
        local v8 = script["Flashstep VFX enable"]:Clone();
        v8.Anchored = false;
        v8.Parent = workspace.Effects[p5.Name];
        u1.Effects:GetLifetime(v8);
        local Weld = Instance.new("Weld");
        Weld.Part0 = v8;
        Weld.Part1 = p5.HumanoidRootPart;
        Weld.Parent = v8;
        u1.Effects:EnableParticles(v8);
        u1.Effects:Emit(v8);
        local v9 = script.Sonido:Clone();
        v9.PlayOnRemove = true;
        v9.Parent = nil;
        v9:Destroy();

        if not p6 then
            return;
        end;

        task.wait(p6);
        u1.Invis.Visible(p5);
        u1.Effects:DisableParticles(v8);
        local v10 = script.Sonido:Clone();
        v10.PlayOnRemove = true;
        v10.Parent = p5.HumanoidRootPart;
        v10:Destroy();
        local Lifetime = u1.Effects:GetLifetime(v8);
        task.wait(Lifetime);
        v8:Destroy();
    end,

    TP = function(p11, p12) -- Line: 74, Name: TP
        -- upvalues: u1 (ref)
        local v13 = script["Flashstep VFX emit"]:Clone();
        v13.CFrame = p11.Torso.CFrame;
        v13.Parent = workspace.Effects[p11.Name];
        u1.Effects:AutoEmit(v13);
        local v14 = script["Flashstep VFX enable"]:Clone();
        v14.Anchored = true;
        v14.CFrame = p11.Torso.CFrame;
        v14.Parent = workspace.Effects[p11.Name];
        u1.Effects:AutoEmit(v14);
        local v15 = script.Sonido:Clone();
        v15.PlayOnRemove = true;
        v15.Parent = nil;
        v15:Destroy();

        if not p12 then
            return;
        end;

        local v16 = script["Flashstep VFX emit"]:Clone();
        v16.Position = p12;
        v16.Parent = workspace.Effects[p11.Name];
        u1.Effects:AutoEmit(v16);
        local v17 = script["Flashstep VFX enable"]:Clone();
        v17.Anchored = true;
        v17.Position = p12;
        v17.Parent = workspace.Effects[p11.Name];
        u1.Effects:AutoEmit(v17);
        local v18 = script.Sonido:Clone();
        v18.PlayOnRemove = true;
        v18.Parent = nil;
        v18:Destroy();
    end,

    Flash = function(p19, p20) -- Line: 116, Name: Flash
        -- upvalues: u1 (ref)
        local v21 = workspace.Effects[p19.Name];
        local v22 = script["Flashstep VFX emit"]:Clone();
        v22.CFrame = p20;
        v22.Parent = v21;
        u1.Effects:FireOnce(v22);
        local u23 = script["Flashstep VFX enable"]:Clone();
        u23.Anchored = true;
        u23.CFrame = p20;
        u23:SetAttribute("Bypass_FX", true);
        u23:SetAttribute("Fire", nil);
        u23.Parent = v21;
        u23:SetAttribute("FX_Activate", true);
        task.delay(u1.Effects:GetLifetime(u23), function() -- Line: 134
            -- upvalues: u23 (copy)
            if u23.Parent then
                u23:SetAttribute("FX_Activate", false);
                u23:Destroy();
            end;
        end);
        local v24 = script.Sonido:Clone();
        v24.PlayOnRemove = true;
        v24.Parent = v22;
        v24:Destroy();
    end,

    Enable = function(p25) -- Line: 148, Name: Enable
        -- upvalues: u1 (ref)
        if p25:GetAttribute("StarrkFlashstep") then
            return;
        end;

        p25:SetAttribute("StarrkFlashstep", true);
        u1.Invis.Invisible(p25);
        local v26 = script.Flashstep:Clone();
        v26.Name = "VFX_FLASHSTEP";
        v26.Weld.Part1 = p25.HumanoidRootPart;
        v26.Parent = workspace.Effects[p25.Name];
        u1.Effects:FireOnce(v26, true);
        local v27 = script.FlashstepStart:Clone();
        v27.Position = p25.HumanoidRootPart.Position;
        v27.Parent = workspace.Effects[p25.Name];
        u1.Effects:FireOnce(v27);
        local v28 = script.Sonido:Clone();
        v28.PlayOnRemove = true;
        v28.Parent = p25.HumanoidRootPart;
        v28:Destroy();
    end,

    Disable = function(p29) -- Line: 177, Name: Disable
        -- upvalues: u1 (ref)
        if not p29:GetAttribute("StarrkFlashstep") then
            return;
        end;

        p29:SetAttribute("StarrkFlashstep", false);
        local v30 = script.Sonido:Clone();
        v30.PlayOnRemove = true;
        v30.Parent = p29.HumanoidRootPart;
        v30:Destroy();
        u1.Invis.Visible(p29);

        for _, child in ipairs(workspace.Effects[p29.Name]:GetChildren()) do
            if child.Name == "VFX_FLASHSTEP" then
                child.Name = "vfx_destroyed";
                child.Weld:Destroy();
                child.Anchored = true;
                u1.Effects:DisableParticles(child);
                u1.Debris:AddItem(child, u1.Effects:GetLifetime(child));
                local v31 = script.FlashstepEnd:Clone();
                v31.Position = p29.HumanoidRootPart.Position;
                v31.Parent = workspace.Effects[p29.Name];
                u1.Effects:FireOnce(v31);
            end;
        end;
    end
};