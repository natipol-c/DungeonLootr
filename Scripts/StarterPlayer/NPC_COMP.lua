--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     NPC_COMP
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Components.NPC_COMP
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
local LocalPlayer = game.Players.LocalPlayer;
local u1 = {};

local function createHighlight(p2: userdata, p3, p4: any) -- Line: 9
    -- upvalues: u1 (copy)
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 0.85;
    Highlight.FillColor = p3;
    Highlight.DepthMode = p4 and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = p2;
    u1[p2] = Highlight;
end;

function _init(u5: userdata)
    -- upvalues: u1 (copy), LocalPlayer (copy)
    u5:GetAttributeChangedSignal("Owner"):Connect(function() -- Line: 19
        -- upvalues: u5 (copy), u1 (ref), LocalPlayer (ref)
        if u5:GetAttribute("Owner") == "" or not u5:GetAttribute("Owner") then
            if u1[u5] then
                u1[u5]:Destroy();
            end;

            return;
        end;

        if u5:GetAttribute("Owner") ~= LocalPlayer.Name then
            return;
        end;

        local v6 = u5;
        local Color3_fromRGB_ret = Color3.fromRGB(0, 255, 0);
        local Highlight = Instance.new("Highlight");
        Highlight.FillTransparency = 0.85;
        Highlight.FillColor = Color3_fromRGB_ret;
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded;
        Highlight.Parent = v6;
        u1[v6] = Highlight;
    end);
end;

return function() -- Line: 38
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("NPC"):Connect(function(p7) -- Line: 39
        _init(p7);
    end);

    for _, v in ipairs(CollectionService:GetTagged("NPC")) do
        _init(v);
    end;
end;