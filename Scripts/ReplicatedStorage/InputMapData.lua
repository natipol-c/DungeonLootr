--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     InputMapData
  Path:     game.ReplicatedStorage.Player.Modules.InputMapData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:43 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Actions = {
        Attack = {
            DisplayName = "Attack",
            Description = "Swing your weapon. Hold to auto-attack.",
            Category = "Combat",
            Order = 1,
            Defaults = {
                Keyboard = "MouseButton1",
                Gamepad = "ButtonR2"
            },
            Remappable = {
                Keyboard = false,
                Gamepad = false
            }
        },
        Dodge = {
            DisplayName = "Dodge",
            Description = "Dash in your current movement direction.",
            Category = "Combat",
            Order = 2,
            Defaults = {
                Keyboard = "Q",
                Gamepad = "ButtonB"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        ParryBlock = {
            DisplayName = "Parry / Block",
            Description = "Tap to parry, hold to block.",
            Category = "Combat",
            Order = 3,
            Defaults = {
                Keyboard = "F",
                Gamepad = "ButtonL2"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        Skill1 = {
            DisplayName = "Skill 1",
            Description = "Activate your first combat skill.",
            Category = "Skill",
            Order = 10,
            Defaults = {
                Keyboard = "One",
                Gamepad = "DPadUp"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        Skill2 = {
            DisplayName = "Skill 2",
            Description = "Activate your second combat skill.",
            Category = "Skill",
            Order = 11,
            Defaults = {
                Keyboard = "Two",
                Gamepad = "DPadDown"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        Skill3 = {
            DisplayName = "Skill 3",
            Description = "Activate your third combat skill.",
            Category = "Skill",
            Order = 12,
            Defaults = {
                Keyboard = "Three",
                Gamepad = "DPadLeft"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        Skill4 = {
            DisplayName = "Skill 4",
            Description = "Activate your fourth combat skill.",
            Category = "Skill",
            Order = 13,
            Defaults = {
                Keyboard = "Four",
                Gamepad = "DPadRight"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        SkillE = {
            DisplayName = "Ultimate",
            Description = "Activate your ultimate skill (charges from combat).",
            Category = "Skill",
            Order = 14,
            Defaults = {
                Keyboard = "G",
                Gamepad = "ButtonL2+ButtonR2"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        Potion_Health = {
            DisplayName = "Health Potion",
            Description = "Drink your equipped health potion.",
            Category = "Consumable",
            Order = 20,
            Defaults = {
                Keyboard = "Five",
                Gamepad = "ButtonR1"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        ShiftLock = {
            DisplayName = "Shift Lock",
            Description = "Toggle shift-lock camera mode.",
            Category = "Camera",
            Order = 30,
            Defaults = {
                Keyboard = "LeftControl",
                Gamepad = "ButtonX+ButtonY"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = false
            }
        },
        Sprint = {
            DisplayName = "Sprint",
            Description = "Hold on keyboard, toggle on gamepad.",
            Category = "Movement",
            Order = 40,
            Defaults = {
                Keyboard = "LeftShift",
                Gamepad = "ButtonL3"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        Walk = {
            DisplayName = "Walk",
            Description = "Toggle a walking animation while moving forward.",
            Category = "Movement",
            Order = 41,
            Defaults = {
                Keyboard = "V",
                Gamepad = "ButtonL1"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        Inventory = {
            DisplayName = "Open Inventory",
            Description = "Toggle the inventory window.",
            Category = "Menu",
            Order = 50,
            Defaults = {
                Keyboard = "B",
                Gamepad = ""
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        SettingsMenu = {
            DisplayName = "Open Settings",
            Description = "Toggle the settings window.",
            Category = "Menu",
            Order = 51,
            Defaults = {
                Keyboard = "N",
                Gamepad = ""
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        ClassMenu = {
            DisplayName = "Open Class Menu",
            Description = "Toggle the class info window.",
            Category = "Menu",
            Order = 52,
            Defaults = {
                Keyboard = "K",
                Gamepad = ""
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        },
        Emote = {
            DisplayName = "Emote Wheel",
            Description = "Open the emote wheel.",
            Category = "Menu",
            Order = 53,
            Defaults = {
                Keyboard = "T",
                Gamepad = "ButtonY"
            },
            Remappable = {
                Keyboard = true,
                Gamepad = true
            }
        }
    },
    Categories = { {
            Id = "Combat",
            DisplayName = "Combat",
            Order = 1
        }, {
            Id = "Skill",
            DisplayName = "Skills",
            Order = 2
        }, {
            Id = "Consumable",
            DisplayName = "Consumables",
            Order = 3
        }, {
            Id = "Camera",
            DisplayName = "Camera",
            Order = 4
        }, {
            Id = "Movement",
            DisplayName = "Movement",
            Order = 5
        }, {
            Id = "Menu",
            DisplayName = "Menus",
            Order = 6
        } },
    ReservedKeyboard = {
        W = true,
        A = true,
        S = true,
        D = true,
        Unknown = true,
        Escape = true,
        Return = true,
        Tab = true,
        Backspace = true,
        Slash = true
    },
    ReservedGamepad = {
        Unknown = true,
        ButtonStart = true,
        ButtonSelect = true,
        Thumbstick1 = true,
        Thumbstick2 = true
    }
};

function u1.GetAction(p2: string) -- Line: 233
    -- upvalues: u1 (copy)
    return u1.Actions[p2];
end;

function u1.GetDefault(p3: string, p4: string) -- Line: 237
    -- upvalues: u1 (copy)
    local v5 = u1.Actions[p3];

    return v5 and (v5.Defaults[p4] or "") or "";
end;

function u1.IsRemappable(p6: string, p7: string) -- Line: 243
    -- upvalues: u1 (copy)
    local v8 = u1.Actions[p6];
    local v9;

    if v8 == nil then
        v9 = false;
    else
        v9 = v8.Remappable[p7] == true;
    end;

    return v9;
end;

function u1.AllowsCombo(p10: string, p11: string) -- Line: 252
    -- upvalues: u1 (copy)
    local v12;

    if p11 == "Gamepad" then
        v12 = u1.IsRemappable(p10, p11);
    else
        v12 = false;
    end;

    return v12;
end;

function u1.ParseCombo(p13: string, p14: string) -- Line: 259
    -- upvalues: u1 (copy)
    local string_split_ret = string.split(p14, "+");

    if #string_split_ret ~= 2 then
        return false;
    end;

    local v15 = string_split_ret[1];
    local v16 = string_split_ret[2];

    if v15 == "" or (v16 == "" or v15 == v16) then
        return false;
    end;

    if u1.IsReservedKey(p13, v15) or u1.IsReservedKey(p13, v16) then
        return false;
    end;

    return true, v15, v16;
end;

function u1.IsReservedKey(p17: string, p18: string) -- Line: 270
    -- upvalues: u1 (copy)
    if p17 == "Keyboard" then
        return u1.ReservedKeyboard[p18] == true;
    end;

    if p17 == "Gamepad" then
        return u1.ReservedGamepad[p18] == true;
    end;

    return false;
end;

function u1.GetActionsInCategory(p19: string) -- Line: 280
    -- upvalues: u1 (copy)
    local v20 = {};

    for i, v in u1.Actions do
        if v.Category == p19 then
            table.insert(v20, i);
        end;
    end;

    table.sort(v20, function(p21, p22) -- Line: 287
        -- upvalues: u1 (ref)
        return (u1.Actions[p21].Order or 0) < (u1.Actions[p22].Order or 0);
    end);

    return v20;
end;

function u1.GetAllActions() -- Line: 294
    -- upvalues: u1 (copy)
    local v23 = {};

    for i in u1.Actions do
        table.insert(v23, i);
    end;

    table.sort(v23, function(p24, p25) -- Line: 299
        -- upvalues: u1 (ref)
        return (u1.Actions[p24].Order or 0) < (u1.Actions[p25].Order or 0);
    end);

    return v23;
end;

local u26 = {
    MouseButton1 = "LMB",
    MouseButton2 = "RMB",
    MouseButton3 = "MMB",
    One = "1",
    Two = "2",
    Three = "3",
    Four = "4",
    Five = "5",
    Six = "6",
    Seven = "7",
    Eight = "8",
    Nine = "9",
    Zero = "0",
    LeftShift = "L.Shift",
    RightShift = "R.Shift",
    LeftControl = "L.Ctrl",
    RightControl = "R.Ctrl",
    LeftAlt = "L.Alt",
    RightAlt = "R.Alt",
    ButtonA = "A",
    ButtonB = "B",
    ButtonX = "X",
    ButtonY = "Y",
    ButtonL1 = "L1",
    ButtonL2 = "L2",
    ButtonL3 = "L3",
    ButtonR1 = "R1",
    ButtonR2 = "R2",
    ButtonR3 = "R3",
    DPadUp = "D-Up",
    DPadDown = "D-Down",
    DPadLeft = "D-Left",
    DPadRight = "D-Right",
    ButtonStart = "Start",
    ButtonSelect = "Select",
    [""] = "<unbound>"
};

function u1.PrettyKey(p27: string) -- Line: 328
    -- upvalues: u26 (copy)
    if type(p27) ~= "string" or not string.find(p27, "+", 1, true) then
        return u26[p27] or p27;
    end;

    local string_split_ret = string.split(p27, "+");

    for i, v in ipairs(string_split_ret) do
        string_split_ret[i] = u26[v] or v;
    end;

    return table.concat(string_split_ret, " + ");
end;

return u1;