--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TitleData
  Path:     game.ReplicatedStorage.GameInfo.TitleData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u3 = {
    Titles = {
        VIP = {
            Text = "VIP",
            Rarity = "Mythic",
            StrokeTransparency = 0,
            HowToObtain = "Gamepass from the premium shop",
            Color = Color3.fromRGB(255, 215, 0),
            StrokeColor = Color3.fromRGB(100, 70, 0)
        },
        Supporter = {
            Text = "Supporter",
            ChatTag = true,
            Rarity = "Epic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Purchase the Supporter Bundle",
            ChatTagColor = Color3.fromRGB(140, 240, 180),
            Color = Color3.fromRGB(120, 220, 160),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 120, 90)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 240, 180)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 120, 90)) }),
            StrokeColor = Color3.fromRGB(10, 40, 25),
            StatBuffs = {
                STR = 1,
                DEX = 1,
                VIT = 1,
                INT = 1,
                LCK = 1
            }
        },
        Founder = {
            Text = "Founder",
            IndexHidden = true,
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            Dynamic = "FounderSerial",
            HowToObtain = "Exclusive to the first 100 buyers of the Founders Pack",
            ChatTagColor = Color3.fromRGB(255, 200, 70),
            Color = Color3.fromRGB(255, 255, 255),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 85, 0)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0)
        },
        ["Grand Founder"] = {
            Text = "Grand Founder",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            Dynamic = "GrandFounderSerial",
            HowToObtain = "Purchase the Grand Founders Pack",
            ChatTagColor = Color3.fromRGB(255, 210, 90),
            Color = Color3.fromRGB(255, 235, 150),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 95, 20)),
                ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 200, 70)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 245, 200)),
                ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 200, 70)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 95, 20))
            }),
            StrokeColor = Color3.fromRGB(60, 35, 0)
        },
        Kingmaker = {
            Text = "Kingmaker",
            IndexHidden = true,
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "You can\'t",
            ChatTagColor = Color3.fromRGB(255, 210, 90),
            Color = Color3.fromRGB(255, 235, 150),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 95, 20)),
                ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 200, 70)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 245, 200)),
                ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 200, 70)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 95, 20))
            }),
            StrokeColor = Color3.fromRGB(60, 35, 0),
            StatBuffs = {
                STR = 15,
                DEX = 15,
                INT = 15,
                VIT = 15,
                LCK = 15
            }
        },
        ["Grand Sovereign"] = {
            Text = "Grand Sovereign",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            Dynamic = "GrandSovereignSerial",
            HowToObtain = "Purchase the Grand Sovereign Pack",
            ChatTagColor = Color3.fromRGB(200, 165, 255),
            Color = Color3.fromRGB(235, 220, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 40, 140)),
                ColorSequenceKeypoint.new(0.25, Color3.fromRGB(175, 130, 245)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(245, 240, 255)),
                ColorSequenceKeypoint.new(0.75, Color3.fromRGB(175, 130, 245)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 40, 140))
            }),
            StrokeColor = Color3.fromRGB(35, 15, 60),
            StatBuffs = {
                STR = 15,
                DEX = 10,
                VIT = 5
            }
        },
        ["Shadow Monarch"] = {
            Text = "Shadow Monarch",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            Dynamic = "DeveloperSerial",
            HowToObtain = "Exclusive to the first 10 buyers of the Developers Pack",
            ChatTagColor = Color3.fromRGB(160, 80, 230),
            Color = Color3.fromRGB(255, 255, 255),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 180)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 0, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 180)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0)
        },
        ["Lord of Death"] = {
            Text = "Lord of Death",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Purchase the Shadow Monarch Bundle",
            ChatTagColor = Color3.fromRGB(150, 110, 255),
            Color = Color3.fromRGB(170, 130, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 5, 45)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(90, 40, 190)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(215, 195, 255)),
                ColorSequenceKeypoint.new(0.7, Color3.fromRGB(90, 40, 190)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 5, 45))
            }),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StatBuffs = {
                STR = 12,
                DEX = 10,
                INT = 5
            }
        },
        ["The Minuano"] = {
            Text = "The Minuano",
            ChatTag = true,
            Rarity = "Celestial",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Level 50 with the Jetstream class",
            ChatTagColor = Color3.fromRGB(235, 50, 50),
            Color = Color3.fromRGB(220, 30, 30),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 0, 0)),
                ColorSequenceKeypoint.new(0.25, Color3.fromRGB(130, 10, 10)),
                ColorSequenceKeypoint.new(0.48, Color3.fromRGB(230, 40, 40)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.52, Color3.fromRGB(230, 40, 40)),
                ColorSequenceKeypoint.new(0.75, Color3.fromRGB(130, 10, 10)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 0, 0))
            }),
            StrokeColor = Color3.fromRGB(0, 0, 0)
        },
        ["LOVE THIS GAME"] = {
            Text = "LOVE THIS GAME",
            IndexHidden = true,
            ChatTag = true,
            Rarity = "Celestial",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Purchase the Goodbye Bundle",
            ChatTagColor = Color3.fromRGB(135, 206, 250),
            Color = Color3.fromRGB(135, 206, 250),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 180, 230)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 240, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 180, 230)) }),
            StrokeColor = Color3.fromRGB(20, 50, 100),
            StatBuffs = {
                STR = 10,
                DEX = 10,
                VIT = 10,
                INT = 10,
                LCK = 10
            }
        },
        Coyote = {
            Text = "Coyote",
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Completing the hidden NPC Coyote\'s quest",
            Color = Color3.fromRGB(255, 255, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(180, 255, 255)),
                ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
            }),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StatBuffs = {
                STR = 3,
                DEX = 10
            }
        },
        Motivated = {
            Text = "MOTIVATED",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Azure Devil Class Mastery Level 50, then speak to Valen",
            ChatTagColor = Color3.fromRGB(150, 230, 255),
            Color = Color3.fromRGB(255, 255, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(180, 255, 255)),
                ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
            }),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StatBuffs = {
                STR = 8,
                DEX = 8,
                VIT = 8,
                INT = 8,
                LCK = 8
            }
        },
        Unchained = {
            Text = "UNCHAINED",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Unrestricted Class Mastery Level 50, then pay the Unrestricted NPC 1,000,000 coins",
            ChatTagColor = Color3.fromRGB(255, 60, 60),
            Color = Color3.fromRGB(255, 40, 40),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 45, 45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 0, 0)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StatBuffs = {
                STR = 18
            }
        },
        ["Devil Hunter"] = {
            Text = "DEVIL HUNTER",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Sinister Trigger Class Mastery Level 50, then pay the Devil Hunter NPC 2,000,000 coins, 5 Devil Hearts, and 2 Exotic Ingots",
            ChatTagColor = Color3.fromRGB(255, 60, 60),
            Color = Color3.fromRGB(255, 40, 40),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 45, 45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 0, 0)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StatBuffs = {
                STR = 5,
                DEX = 19,
                INT = 5,
                VIT = 5
            }
        },
        Owner = {
            Text = "Owner",
            IndexHidden = true,
            ChatTag = true,
            Rarity = "Impossible",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "You can\'t",
            Color = Color3.fromRGB(255, 0, 0),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0)
        },
        GM = {
            Text = "GM",
            IndexHidden = true,
            Rarity = "Impossible",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "You can\'t",
            Color = Color3.fromRGB(255, 0, 0),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StatBuffs = {
                STR = 10,
                DEX = 10,
                INT = 10,
                VIT = 10,
                LUCK = 10
            }
        },
        Admin = {
            Text = "Admin",
            IndexHidden = true,
            Rarity = "Impossible",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "You can\'t",
            Color = Color3.fromRGB(255, 0, 0),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0)
        },
        Testing = {
            Text = "Testing",
            IndexHidden = true,
            Rarity = "Impossible",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "this is just so I can be lazy and kill things instantly for testing :)",
            Color = Color3.fromRGB(255, 0, 0),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StatBuffs = {
                STR = 99999,
                DEX = 99999,
                INT = 99999,
                VIT = 99999,
                LUCK = 1
            }
        },
        ["Content Creator"] = {
            Text = "Content Creator",
            IndexHidden = true,
            Rarity = "Impossible",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Manually given to creators who have made video content on Dungeon Lootr.",
            Color = Color3.fromRGB(255, 0, 0),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0)
        },
        ["Early Access"] = {
            Text = "Early Access",
            Rarity = "Impossible",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Held by members of the Early Access group role, or earned in the Early Access AFK Chamber.",
            Color = Color3.fromRGB(0, 170, 255),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 200)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 200, 255)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0)
        },
        ["Early Access+"] = {
            Text = "Early Access+",
            Rarity = "Impossible",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Held by members of the Early Access+ group role.",
            Color = Color3.fromRGB(255, 200, 50),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 140, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 230, 120)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0)
        },
        S1Fighter = {
            Text = "S1. Fighter",
            IndexHidden = true,
            Rarity = "Rare",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Tier 20 of the Season 1 Battlepass free track",
            Color = Color3.fromRGB(253, 29, 29),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(105, 37, 37)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(253, 29, 29)), ColorSequenceKeypoint.new(1, Color3.fromRGB(252, 176, 69)) }),
            StrokeColor = Color3.fromRGB(50, 10, 10),
            StatBuffs = {
                STR = 2,
                DEX = 2,
                INT = 2
            }
        },
        S1Hero = {
            Text = "S1. Hero",
            IndexHidden = true,
            Rarity = "Legendary",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Tier 50 of the Season 1 Battlepass free track",
            Color = Color3.fromRGB(255, 194, 71),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 194, 71)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 250, 156)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 238, 87)) }),
            StrokeColor = Color3.fromRGB(100, 70, 0),
            StatBuffs = {
                STR = 4,
                DEX = 4,
                INT = 4
            }
        },
        S1Lord = {
            Text = "S1. Lord",
            IndexHidden = true,
            Rarity = "Mythic",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Tier 50 of the Season 1 Battlepass paid track",
            Color = Color3.fromRGB(0, 212, 255),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 145, 145)), ColorSequenceKeypoint.new(0.35, Color3.fromRGB(9, 9, 121)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 212, 255)) }),
            StrokeColor = Color3.fromRGB(0, 5, 40),
            StatBuffs = {
                STR = 5,
                DEX = 5,
                INT = 5
            }
        },
        S2Grinder = {
            Text = "S2. Grinder",
            IndexHidden = true,
            Rarity = "Epic",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Tier 50 of the Season 2 Battlepass free track",
            Color = Color3.fromRGB(210, 180, 90),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 70, 40)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(230, 190, 90)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 70, 40)) }),
            StrokeColor = Color3.fromRGB(30, 20, 0),
            StatBuffs = {
                STR = 5,
                DEX = 5,
                VIT = 5,
                INT = 5,
                LCK = 5
            }
        },
        S2Lightbringer = {
            Text = "S2. Lightbringer",
            IndexHidden = true,
            Rarity = "Mythic",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Tier 100 of the Season 2 Battlepass free track",
            Color = Color3.fromRGB(180, 130, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(170, 255, 255)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(255, 220, 120)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
            }),
            StrokeColor = Color3.fromRGB(20, 0, 40),
            StatBuffs = {
                STR = 6,
                DEX = 6,
                VIT = 7,
                INT = 6,
                LCK = 7
            }
        },
        S2Sovereign = {
            Text = "S2. Sovereign",
            IndexHidden = true,
            Rarity = "Celestial",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Tier 100 of the Season 2 Battlepass paid track",
            Color = Color3.fromRGB(180, 130, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 30, 150)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(180, 130, 255)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(255, 220, 120)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 30, 150))
            }),
            StrokeColor = Color3.fromRGB(20, 0, 40),
            StatBuffs = {
                STR = 8,
                DEX = 8,
                VIT = 8,
                INT = 8,
                LCK = 8
            }
        },
        S3Artisan = {
            Text = "S3. Artisan",
            Rarity = "Mythic",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Tier 30 of the Season 3 Battlepass free track",
            Color = Color3.fromRGB(230, 140, 60),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 60, 20)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 170, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 60, 20)) }),
            StrokeColor = Color3.fromRGB(40, 15, 0),
            StatBuffs = {
                STR = 6,
                DEX = 6,
                VIT = 6,
                INT = 6,
                LCK = 6
            }
        },
        S3Warsmith = {
            Text = "S3. Warsmith",
            Rarity = "Mythic",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Tier 30 of the Season 3 Battlepass paid track",
            Color = Color3.fromRGB(220, 80, 60),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 90, 100)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 90, 100)) }),
            StrokeColor = Color3.fromRGB(35, 5, 0),
            StatBuffs = {
                STR = 8,
                DEX = 8,
                VIT = 8,
                INT = 8,
                LCK = 8
            }
        },
        S3Paragon = {
            Text = "S3. Paragon",
            Rarity = "Celestial",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Tier 100 of the Season 3 Battlepass paid track",
            Color = Color3.fromRGB(255, 230, 150),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(255, 220, 120)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(255, 160, 60)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
            }),
            StrokeColor = Color3.fromRGB(50, 25, 0),
            StatBuffs = {
                STR = 10,
                DEX = 10,
                VIT = 10,
                INT = 10,
                LCK = 10
            }
        },
        Darkrider = {
            Text = "Darkrider",
            IndexHidden = true,
            Rarity = "Exotic",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Completing the Aura Farmer NPC\'s quest",
            Color = Color3.fromRGB(120, 0, 180),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 0, 80)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 0, 180)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 0, 80)) }),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StatBuffs = {
                STR = 8,
                VIT = 3
            }
        },
        ["Iron Sights"] = {
            Text = "Iron Sights",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Witch Gunner Class Mastery Level 50, then sacrifice 67 Celestial Ingots and 1,000,000 coins to Aura",
            ChatTagColor = Color3.fromRGB(255, 190, 90),
            Color = Color3.fromRGB(220, 225, 235),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 45, 55)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(150, 160, 175)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 210, 130)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(150, 160, 175)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 45, 55))
            }),
            StrokeColor = Color3.fromRGB(10, 12, 18),
            StatBuffs = {
                DEX = 17
            }
        },
        Huntress = {
            Text = "Huntress",
            IndexHidden = true,
            Rarity = "Exotic",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Completing Artemis\' NPC quest",
            Color = Color3.fromRGB(60, 200, 120),
            ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 160, 80)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 255, 170)), ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 160, 80)) }),
            StrokeColor = Color3.fromRGB(0, 40, 20),
            StatBuffs = {
                DEX = 8,
                LCK = 3
            }
        },
        ["God Hunter"] = {
            Text = "God Hunter",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Artemis Class Mastery Level 50, then speak to Artemis",
            ChatTagColor = Color3.fromRGB(255, 215, 110),
            Color = Color3.fromRGB(255, 220, 120),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 100, 25)),
                ColorSequenceKeypoint.new(0.22, Color3.fromRGB(255, 200, 80)),
                ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 230, 150)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 250, 220)),
                ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 240, 180)),
                ColorSequenceKeypoint.new(0.78, Color3.fromRGB(255, 210, 100)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 80, 20))
            }),
            StrokeColor = Color3.fromRGB(60, 35, 0),
            StatBuffs = {
                DEX = 15,
                STR = 5,
                VIT = 5,
                INT = 5,
                LCK = 5
            }
        },
        ["Black Falcon"] = {
            Text = "Black Falcon",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Kage Class Mastery Level 50, then speak to Kage",
            ChatTagColor = Color3.fromRGB(120, 200, 255),
            Color = Color3.fromRGB(120, 190, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 12, 20)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(40, 90, 150)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 220, 255)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(40, 90, 150)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 20))
            }),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StatBuffs = {
                DEX = 12,
                STR = 8,
                INT = 8,
                VIT = 6,
                LCK = 4
            }
        },
        ["Infinite Blade Works"] = {
            Text = "Infinite Blade Works",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Forge Archon Class Mastery Level 50, then speak to the Forge Archon",
            ChatTagColor = Color3.fromRGB(255, 205, 110),
            Color = Color3.fromRGB(255, 200, 90),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 70, 55)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(210, 160, 90)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 235, 170)),
                ColorSequenceKeypoint.new(0.7, Color3.fromRGB(230, 130, 60)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 55, 40))
            }),
            StrokeColor = Color3.fromRGB(35, 20, 5),
            StatBuffs = {
                STR = 10,
                DEX = 10,
                INT = 8,
                VIT = 6,
                LCK = 4
            }
        },
        ["King of Curses"] = {
            Text = "King of Curses",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Cursed King Class Mastery Level 50, then speak to the Cursed King",
            ChatTagColor = Color3.fromRGB(255, 75, 65),
            Color = Color3.fromRGB(255, 70, 60),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 0, 0)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(140, 15, 15)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 60, 55)),
                ColorSequenceKeypoint.new(0.7, Color3.fromRGB(140, 15, 15)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 0, 0))
            }),
            StrokeColor = Color3.fromRGB(0, 0, 0),
            StatBuffs = {
                STR = 12,
                VIT = 12,
                DEX = 6,
                INT = 6,
                LCK = 4
            }
        },
        ["The Slayer"] = {
            Text = "The Slayer",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Demonbane Class Mastery Level 50, then pay the Great Mage 1,000,000 coins",
            ChatTagColor = Color3.fromRGB(190, 205, 255),
            Color = Color3.fromRGB(215, 225, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 100, 190)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(180, 200, 255)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(245, 250, 255)),
                ColorSequenceKeypoint.new(0.7, Color3.fromRGB(180, 200, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 100, 190))
            }),
            StrokeColor = Color3.fromRGB(25, 20, 55),
            StatBuffs = {
                INT = 15,
                DEX = 6,
                VIT = 6,
                STR = 4,
                LCK = 4
            }
        },
        ["The Storm"] = {
            Text = "The Storm",
            ChatTag = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Awakened Devil EX Class Mastery Level 50, then speak to Valen",
            ChatTagColor = Color3.fromRGB(120, 200, 255),
            Color = Color3.fromRGB(120, 200, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 10, 70)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(50, 120, 230)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 240, 255)),
                ColorSequenceKeypoint.new(0.7, Color3.fromRGB(50, 120, 230)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 10, 70))
            }),
            StrokeColor = Color3.fromRGB(5, 0, 25),
            StatBuffs = {
                STR = 10,
                DEX = 10,
                INT = 10,
                VIT = 8,
                LCK = 6
            }
        },
        ["Supreme Being"] = {
            Text = "Supreme Being",
            IndexHidden = true,
            Rarity = "Exotic",
            GradientRotation = 0,
            StrokeTransparency = 0,
            HowToObtain = "Reach 1,500 PVP kills and earn it from Broly",
            Color = Color3.fromRGB(180, 255, 60),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 90, 20)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(150, 255, 60)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 120)),
                ColorSequenceKeypoint.new(0.7, Color3.fromRGB(150, 255, 60)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 90, 20))
            }),
            StrokeColor = Color3.fromRGB(0, 30, 0),
            StatBuffs = {
                STR = 17,
                VIT = 17
            }
        },
        Centurion = {
            Text = "Centurion",
            Rarity = "Mythic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Clear Floor 100 of Boss Rush",
            Color = Color3.fromRGB(200, 50, 40),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 15, 10)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(200, 50, 40)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 80)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(200, 50, 40)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 15, 10))
            }),
            StrokeColor = Color3.fromRGB(40, 10, 0),
            StatBuffs = {
                STR = 8,
                DEX = 8,
                INT = 8,
                VIT = 15
            }
        },
        Boss_Slayer = {
            Text = "Boss Slayer",
            Rarity = "Legendary",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Floor 50 in Boss Rush",
            Color = Color3.fromRGB(180, 90, 60),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 20, 10)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(180, 90, 60)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(230, 130, 80)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(180, 90, 60)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 20, 10))
            }),
            StrokeColor = Color3.fromRGB(30, 10, 0),
            StatBuffs = {
                STR = 3,
                DEX = 3,
                INT = 3,
                VIT = 5
            }
        },
        Floor_Master = {
            Text = "Floor Master",
            Rarity = "Mythic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Floor 95 in Boss Rush",
            Color = Color3.fromRGB(190, 200, 220),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 70, 85)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(190, 200, 220)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(240, 245, 255)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(190, 200, 220)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 70, 85))
            }),
            StrokeColor = Color3.fromRGB(20, 25, 40),
            StatBuffs = {
                STR = 5,
                DEX = 5,
                INT = 5,
                VIT = 8
            }
        },
        Rush_Champion = {
            Text = "Rush Champion",
            IndexHidden = true,
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Reach Floor 100 in Boss Rush",
            Color = Color3.fromRGB(255, 215, 0),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 60, 0)),
                ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 215, 0)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 220)),
                ColorSequenceKeypoint.new(0.75, Color3.fromRGB(220, 40, 40)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 20, 0))
            }),
            StrokeColor = Color3.fromRGB(40, 20, 0),
            StatBuffs = {
                STR = 6,
                DEX = 6,
                INT = 6,
                VIT = 10
            }
        },
        Cursed_King = {
            Text = "Cursed King",
            Rarity = "Exotic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Open the Vessel from the Boss Rush Floor 100 milestone",
            Color = Color3.fromRGB(220, 40, 40),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 0, 0)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(160, 20, 20)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 60, 60)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(160, 20, 20)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 0, 0))
            }),
            StrokeColor = Color3.fromRGB(15, 0, 0),
            StatBuffs = {
                STR = 8,
                DEX = 8,
                INT = 8,
                VIT = 12,
                LCK = 5
            }
        },
        Arisen = {
            Text = "Arisen",
            IndexHidden = true,
            Rarity = "Legendary",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Redeem the FIRST_50 code (limited to first 50 players)",
            Color = Color3.fromRGB(180, 130, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 0, 100)),
                ColorSequenceKeypoint.new(0.4, Color3.fromRGB(130, 50, 200)),
                ColorSequenceKeypoint.new(0.7, Color3.fromRGB(80, 120, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 180, 255))
            }),
            StrokeColor = Color3.fromRGB(20, 0, 40)
        },
        Valorous = {
            Text = "Valorous",
            IndexHidden = true,
            Rarity = "Mythic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Redeem the EARLY_BIRD code (limited to first 100 players)",
            Color = Color3.fromRGB(255, 215, 0),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 130, 0)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 215, 50)),
                ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 245, 150)),
                ColorSequenceKeypoint.new(0.85, Color3.fromRGB(255, 200, 30)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 110, 0))
            }),
            StrokeColor = Color3.fromRGB(60, 40, 0)
        },
        Dauntless = {
            Text = "Dauntless",
            IndexHidden = true,
            Rarity = "Mythic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Redeem the FIRST_100 code (limited to first 100 players)",
            Color = Color3.fromRGB(220, 60, 60),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 0, 0)),
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(160, 20, 20)),
                ColorSequenceKeypoint.new(0.6, Color3.fromRGB(220, 60, 40)),
                ColorSequenceKeypoint.new(0.85, Color3.fromRGB(80, 10, 10)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 0, 0))
            }),
            StrokeColor = Color3.fromRGB(10, 0, 0)
        },
        Trailblazer = {
            Text = "Trailblazer",
            IndexHidden = true,
            Rarity = "Impossible",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Redeem an exclusive Trailblazer code given to up-and-coming creators making video content on Dungeon Lootr.",
            Color = Color3.fromRGB(255, 165, 30),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 30)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(255, 165, 30)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(255, 230, 100)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 200, 255))
            }),
            StrokeColor = Color3.fromRGB(40, 10, 0)
        },
        ["Drip Lord"] = {
            Text = "Drip Lord",
            IndexHidden = true,
            Rarity = "Celestial",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Awarded to the 1st place winner of the Community outfit contest",
            Color = Color3.fromRGB(255, 215, 0),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
                ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 105, 200)),
                ColorSequenceKeypoint.new(0.45, Color3.fromRGB(120, 220, 255)),
                ColorSequenceKeypoint.new(0.7, Color3.fromRGB(180, 110, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 215, 0))
            }),
            StrokeColor = Color3.fromRGB(40, 0, 60)
        },
        Drippy = {
            Text = "Drippy",
            IndexHidden = true,
            Rarity = "Mythic",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Awarded to the 2nd and 3rd place winners of the Community outfit contest",
            Color = Color3.fromRGB(200, 215, 240),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 100, 130)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(180, 200, 230)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(180, 200, 230)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 100, 130))
            }),
            StrokeColor = Color3.fromRGB(20, 30, 50)
        },
        KindredBooster = {
            Text = "Kindred Booster",
            IndexHidden = true,
            Rarity = "Celestial",
            GradientRotation = 90,
            StrokeTransparency = 0,
            HowToObtain = "Provide at least 1 Boost to the Community Server. Thanks for your support!",
            Color = Color3.fromRGB(180, 130, 255),
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 30, 150)),
                ColorSequenceKeypoint.new(0.35, Color3.fromRGB(180, 130, 255)),
                ColorSequenceKeypoint.new(0.65, Color3.fromRGB(255, 220, 120)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 30, 150))
            }),
            StrokeColor = Color3.fromRGB(20, 0, 40),
            StatBuffs = {
                STR = 7,
                DEX = 7,
                INT = 7
            }
        }
    },

    IsChatTagEligible = function(p1) -- Line: 1068, Name: IsChatTagEligible
        local v2;

        if p1 == nil then
            v2 = false;
        else
            v2 = p1.ChatTag ~= false;
        end;

        return v2;
    end
};

function u3.IsIndexVisible(p4: string, p5: boolean) -- Line: 1076
    -- upvalues: u3 (copy)
    local v6 = u3.Titles[p4];

    if v6 then
        return (not v6.IndexHidden or p5) and true or false;
    end;

    return false;
end;

return u3;