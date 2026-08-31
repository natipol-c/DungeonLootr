--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClassItemData
  Path:     game.ReplicatedStorage.GameInfo.ClassItemData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Items = {
        ["Shadow Monarch\'s Dagger"] = {
            ClassName = "Shadow Vagrant",
            Rarity = "Exotic",
            Description = "A dagger forged from condensed shadow essence. Transforms the wielder into the Shadow Vagrant — a sovereign of shadows who exists beyond classification."
        },
        ["Skull Memory"] = {
            ClassName = "Dark Rider",
            Rarity = "Exotic",
            Description = "A jet-black Gaia Memory pulsing with spectral energy. Transforms the wielder into the Dark Rider — a hardboiled warrior who fights at the boundary between life and death."
        },
        ["Oathbound Lance"] = {
            ClassName = "Oathbreaker",
            Rarity = "Exotic",
            Description = "The battle-scarred polearm of Gilvan, The Oathbound — claimed by force from the depths of the Forgotten Ruins. Transforms the wielder into the Oathbreaker, a warrior of overwhelming might."
        },
        ["Verath\'s Soulspear"] = {
            ClassName = "Lichborn",
            Rarity = "Exotic",
            Description = "The cursed spear of Verath, The Lichborn — torn from the heart of The Catacombs. Its necrotic edge hungers for living souls. Transforms the wielder into the Lichborn, a revenant warrior caught between life and death."
        },
        ["Founder\'s Crest"] = {
            ClassName = "Founder",
            Rarity = "Celestial",
            Description = "A radiant insignia bestowed upon the adventurers who pledge their legacy; an elite vanguard who shaped the world before the rest arrived."
        },
        ["Artemis\'s Arrow"] = {
            ClassName = "Artemis",
            Rarity = "Exotic",
            Description = "A single divine arrow humming with primal energy. Transforms the wielder into Artemis — a huntress whose strikes command the sky itself."
        },
        ["Kage\'s Mask"] = {
            ClassName = "Kage",
            Rarity = "Admin",
            Description = ""
        },
        ["Demons Eye"] = {
            ClassName = "Mooncarver",
            Rarity = "Exotic",
            Description = "Alone at the pinnacle of swordsmanship, the Moon wanes."
        },
        ["Projection Reel"] = {
            ClassName = "Framebreaker",
            Rarity = "Exotic",
            Description = "A fractured strip of film that plays at twenty-four frames per second — each frame a killing blow. Transforms the wielder into the Framebreaker, a reality-warping fighter who bends existence with every strike."
        },
        ["Golden Katana"] = {
            ClassName = "Master Ronin",
            Rarity = "Exotic",
            Description = "A radiant golden blade forged by a swordsmith who had transcended his craft. Transforms the wielder into the Master Ronin — a blade master whose every cut answers the heavens themselves."
        },
        ["Prayer Beads"] = {
            ClassName = "Chaotic Fist",
            Rarity = "Exotic",
            Description = "A strand of ancient prayer beads, each one cracked and humming with unstable ki. Transforms the wielder into the Chaotic Fist — a martial artist whose strikes bend the laws of destruction itself."
        },
        ["Underworld Glaive"] = {
            ClassName = "Dreadlord",
            Rarity = "Exotic",
            Description = "A un-wieldly hunk of blackened Dragon Steel. Impossible to be held by any normal human being..."
        },
        ["Onyx Hand Fans"] = {
            ClassName = "Nightbloom",
            Rarity = "Celestial",
            Description = "A pair of mystical fans. Capable of summoning slashing winds at will."
        },
        ["Prisma Stone"] = {
            ClassName = "Prisma",
            Rarity = "Exotic",
            Description = "A prismatic stone, gleaming with energy. Using it adorns your fists with prismatic claws."
        },
        ["Cybernetic Katana"] = {
            ClassName = "Jetstream",
            Rarity = "Exotic",
            Description = "An overwhelmingly powerful katana. It leaks an immense amount of energy. Are you worthy?"
        },
        ["Anti Magic Claymore"] = {
            ClassName = "Anti Magic",
            Rarity = "Exotic",
            Description = "A mysterious blade that completely nullifies all magic. Holding it seems to drain you of energy, yet you feel an overhwelming power surging through you."
        },
        ["Judgements Edge"] = {
            ClassName = "Awakened Devil EX",
            Rarity = "Exotic",
            Description = "You needed more power? Well now you have it."
        },
        ["Great Mage Staff"] = {
            ClassName = "Demonbane",
            Rarity = "Celestial",
            Description = "The towering staff of a great mage who spent a thousand years hunting demons. Its magic never wavered; neither did she. Transforms the wielder into the Demonbane — a spellcaster whose ordinary-looking spells reduce demons to ash."
        },
        ["Cursed Shrine"] = {
            ClassName = "Cursed King",
            Rarity = "Exotic",
            Description = "A blood-soaked idol humming with malevolent cursed energy. Transforms the wielder into the Cursed King — a sovereign of curses whose very presence is a death sentence."
        },
        ["Infinity Core"] = {
            ClassName = "Honored One",
            Rarity = "Exotic",
            Description = "A radiant sphere of boundless, untouchable power. Transforms the wielder into the Honored One — the strongest, standing alone at a summit none can reach."
        },
        ["Inverted Spear"] = {
            ClassName = "Unrestricted",
            Rarity = "Celestial",
            Description = "The Inverted Spear of Heaven — a cursed relic that severs even the strongest of sorcerers. Transforms the wielder into the Unrestricted, a sorcerer killer born without cursed energy, whose bare physical mastery is a death sentence."
        },
        ["Tidebreaker Katana"] = {
            ClassName = "Streamline",
            Rarity = "Celestial",
            Description = "A flawless blade said to have been quenched in the deepest tides. Its edge never rusts and never stops. Transforms the wielder into the Streamline — a swordsman whose strikes flow like a river unbroken, carving through all who stand in its current."
        },
        ["Black Heart"] = {
            ClassName = "Shadow Monarch",
            Rarity = "Exotic",
            Description = "The Demon King\'s pulse, condensed into a single shard of midnight. It beats only for those strong enough to bear its weight. Transforms the wielder into the Shadow Monarch — sovereign of all that exists between worlds."
        }
    }
};

function u1.Get(p2: string) -- Line: 195
    -- upvalues: u1 (copy)
    return u1.Items[p2];
end;

function u1.GetAll() -- Line: 200
    -- upvalues: u1 (copy)
    return u1.Items;
end;

function u1.GetAllItemIds() -- Line: 205
    -- upvalues: u1 (copy)
    local v3 = {};

    for i in u1.Items do
        table.insert(v3, i);
    end;

    return v3;
end;

function u1.GetItemByClass(p4: string) -- Line: 214
    -- upvalues: u1 (copy)
    for i, v in u1.Items do
        if v.ClassName == p4 then
            return i;
        end;
    end;

    return nil;
end;

return u1;