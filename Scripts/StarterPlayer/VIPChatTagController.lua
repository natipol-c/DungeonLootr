--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VIPChatTagController
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.VIPChatTagController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:16 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TextChatService = game:GetService("TextChatService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local TitleData = require(ReplicatedStorage.GameInfo.TitleData);
local v1 = Knit.CreateController({
    Name = "VIPChatTagController"
});

local function ToHex(p2) -- Line: 32
    return string.format("#%02X%02X%02X", math.floor(p2.R * 255 + 0.5), math.floor(p2.G * 255 + 0.5), (math.floor(p2.B * 255 + 0.5)));
end;

local function ResolvePrefix(p3: userdata) -- Line: 43
    -- upvalues: TitleData (copy)
    local Attribute = p3:GetAttribute("ChatTagTitle");
    local v4 = typeof(Attribute) == "string" and Attribute ~= "" and TitleData.Titles[Attribute];

    if not v4 then
        return p3:GetAttribute("IsVIP") == true and "<font color=\"#FFD700\">[VIP]</font> " or nil;
    end;

    local v5 = v4.ChatTagColor or v4.Color;
    local Text = v4.Text;
    local Attribute2 = p3:GetAttribute("ChatTagSerial");

    if typeof(Attribute2) == "number" and Attribute2 > 0 then
        Text = `{v4.Text} #{Attribute2}`;
    end;

    return `<font color="{string.format("#%02X%02X%02X", math.floor(v5.R * 255 + 0.5), math.floor(v5.G * 255 + 0.5), (math.floor(v5.B * 255 + 0.5)))}">[{Text}]</font> `;
end;

function v1.KnitStart(p6) -- Line: 71
    -- upvalues: TextChatService (copy), Players (copy), ResolvePrefix (copy)
    function TextChatService.OnIncomingMessage(p7: userdata) -- Line: 72
        -- upvalues: Players (ref), ResolvePrefix (ref)
        local TextSource = p7.TextSource;

        if not TextSource then
            return;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId(TextSource.UserId);

        if not PlayerByUserId then
            return;
        end;

        local v8 = ResolvePrefix(PlayerByUserId);

        if v8 then
            local TextChatMessageProperties = Instance.new("TextChatMessageProperties");
            TextChatMessageProperties.PrefixText = v8 .. p7.PrefixText;

            return TextChatMessageProperties;
        end;
    end;
end;

return v1;