--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     WebhookServices
  Path:     game.ReplicatedStorage.ExternalModules.WebhookServices
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:31 2026
]]

-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local u5 = {
    FormatEditor = {},
    Mention = {},
    ThumbnailType = {
        Headshot = "avatar-headshot",
        Bustshot = "avatar-bust",
        Avatar = "avatar"
    },
    ThumbnailSize = {
        Size48x48 = "48x48",
        Size50x50 = "50x50",
        Size60x60 = "60x60",
        Size75x75 = "75x75",
        Size100x100 = "100x100",
        Size150x150 = "150x150",
        Size180x180 = "180x180",
        Size352x352 = "352x352",
        Size420x420 = "420x420",
        Size720x720 = "720x720"
    },

    SupportedThumbnailAsync = function(p1, p2, p3, p4) -- Line: 22, Name: SupportedThumbnailAsync
        -- upvalues: HttpService (copy)
        return HttpService:JSONDecode((HttpService:GetAsync("https://thumbnails.roproxy.com/v1/users/" .. p2 .. "?userIds=" .. p1 .. "&size=" .. p3 .. "&format=Png&isCircular=" .. tostring(p4 or false)))).data[1].imageUrl;
    end
};
u5.__index = u5;

local function ErrorHandler(p6, p7, p8) -- Line: 32
    if p6 == "Variable" then
        assert(p7, "Missing Argument (" .. p8 .. " expected)");

        if typeof(p7) ~= p8 then
            error("Invalid Argument (" .. p8 .. " expected)");
        end;
    end;
end;

local function SendRequest(p9, p10) -- Line: 40
    -- upvalues: HttpService (copy), u5 (copy)
    local v11 = HttpService:RequestAsync({
        Method = "POST",
        Url = p9,
        Body = p10,
        Headers = {
            ["Content-Type"] = "application/json"
        }
    });

    if v11.StatusCode == 204 then
        return true, 204, nil;
    end;

    local Body = v11.Body;

    if v11.Success then
        return true, v11.StatusCode, Body;
    end;

    if v11.StatusCode ~= 500 then
        return false, v11.StatusCode, Body.error;
    end;

    if u5.ErrorPrinting then
        warn("Webhook instance encountered an internal error.");
    end;

    return true, 204, nil;
end;

local function CheckStatusCode(p12, p13, p14, p15) -- Line: 70
    if p12 == 403 then
        if p13.message == "IP Has Been Banned" then
            if p15 then
                warn("This Roblox Server IP Has Been Temporarily Banned Due To Abuse.");
            end;

            return "Error Found";
        end;

        if p13.message ~= "Webhook Has Been Blocked" then
            return nil;
        end;

        if p15 then
            warn(p13.reason);
        end;

        return "Error Found";
    end;

    if p12 == 429 then
        if p15 then
            warn("Hit ratelimit.");
        end;

        return "Error Found";
    end;

    if p12 == 404 then
        if p15 then
            warn("Provided Webhook Is Not Valid.");
        end;

        return "Error Found";
    end;

    if p12 ~= 400 or p14 then
        return nil;
    end;

    if p15 then
        warn("Error Occured: " .. p13.message);
    end;

    return "Error Found";
end;

local function HandleRequest(p16, p17, p18) -- Line: 107
    -- upvalues: SendRequest (copy)
    string.gsub(p16, "discord.com", "hooks.hyra.io");
    local string_gsub_ret = string.gsub(p16, "discord.com", "webhook.newstargeted.com");
    local string_gsub_ret2 = string.gsub(p16, "discord.com", "webhook.lewisakura.moe");
    local v19, _, _ = SendRequest(p16, p17);

    if not v19 then
        if p18 then
            warn("Webhook request failed. Trying backup proxy");
        end;

        local v20, _, _ = SendRequest(string_gsub_ret, p17);

        if not v20 then
            if p18 then
                warn("Backup request failed. Trying last backup proxy");
            end;

            local v21, v22, v23 = SendRequest(string_gsub_ret2, p17);

            if not v21 then
                if p18 then
                    warn("Last backup request failed.");
                end;

                local v24;

                if v22 == 403 then
                    v24 = v23.message == "IP Has Been Banned" and "Error Found" or (v23.message == "Webhook Has Been Blocked" and "Error Found" or nil);
                else
                    v24 = v22 == 429 and "Error Found" or (v22 == 404 and "Error Found" or (v22 == 400 and "Error Found" or nil));
                end;

                if v24 == nil and p18 then
                    warn("Most likely error or all proxys are down");
                end;
            end;
        end;
    end;
end;

function u5.ColorConverter(p25) -- Line: 134
    local math_floor_ret = math.floor(p25.R * 255 + 0.5);
    local math_floor_ret2 = math.floor(p25.G * 255 + 0.5);
    local math_floor_ret3 = math.floor(p25.B * 255 + 0.5);

    return math_floor_ret * 65536 + math_floor_ret2 * 256 + math_floor_ret3;
end;

function u5.Setup(p26, p27) -- Line: 141
    -- upvalues: HandleRequest (copy), HttpService (copy), u5 (copy)
    local u28 = {};
    local u29 = {
        Urls = p26,
        ErrorPrinting = p27
    };

    function u29.CreateMessage() -- Line: 148
        -- upvalues: u29 (copy), HandleRequest (ref), HttpService (ref), u28 (copy)
        local u30 = {};
        local u31 = {};

        function u30.AttachMessage(p32, p33) -- Line: 152
            -- upvalues: u30 (copy)
            assert(p33, "Missing Argument (string expected)");

            if typeof(p33) ~= "string" then
                error("Invalid Argument (string expected)");
            end;

            u30.Content = p33;
        end;

        function u30.AttachEmbed(p34, p35) -- Line: 158
            -- upvalues: u31 (copy)
            assert(p35, "Missing Argument (table expected)");

            if typeof(p35) ~= "table" then
                error("Invalid Argument (table expected)");
            end;

            local Settings = p35.Settings;
            assert(Settings, "Missing Argument (table expected)");

            if typeof(Settings) ~= "table" then
                error("Invalid Argument (table expected)");
            end;

            local Embed = p35.Embed;
            assert(Embed, "Missing Argument (table expected)");

            if typeof(Embed) ~= "table" then
                error("Invalid Argument (table expected)");
            end;

            p34.Embed = {
                Info = {
                    Settings = {},
                    Embed = {}
                }
            };

            for i, v in pairs(p35.Settings) do
                p34.Embed.Info.Settings[i] = v;
            end;

            for i, v in pairs(p35.Embed) do
                p34.Embed.Info.Embed[i] = v;
            end;

            function p34.Embed.Modify(p36, p37) -- Line: 178
                assert(p37, "Missing Argument (table expected)");

                if typeof(p37) ~= "table" then
                    error("Invalid Argument (table expected)");
                end;

                local Settings2 = p37.Settings;
                assert(Settings2, "Missing Argument (table expected)");

                if typeof(Settings2) ~= "table" then
                    error("Invalid Argument (table expected)");
                end;

                local Embed2 = p37.Embed;
                assert(Embed2, "Missing Argument (table expected)");

                if typeof(Embed2) ~= "table" then
                    error("Invalid Argument (table expected)");
                end;

                for i, v in pairs(p37.Settings) do
                    p36.Info.Settings[i] = v;
                end;

                for i, v in pairs(p37.Embed) do
                    p36.Info.Embed[i] = v;
                end;
            end;

            return setmetatable(p34.Embed, u31);
        end;

        function u30.Send(p38) -- Line: 195
            -- upvalues: u29 (ref), HandleRequest (ref), HttpService (ref)
            local v39 = p38.Embed or nil;
            local v40 = {
                content = p38.Content or "",
                embeds = {}
            };

            if v39 ~= nil then
                v40.embeds[1] = {
                    title = v39.Info.Embed.Title or "No Title Provided",
                    description = v39.Info.Embed.Description or "",
                    type = v39.Info.Settings.Type or "rich",
                    color = v39.Info.Settings.Color or "",
                    fields = v39.Info.Embed.Fields or nil,
                    image = {
                        url = v39.Info.Embed.Image or ""
                    },
                    thumbnail = {
                        url = v39.Info.Embed.Thumbnail or ""
                    },
                    timestamp = os.date("!%Y-%m-%dT%H:%M:%S", os.time(v39.Info.Embed.TimeStamp)) or "",
                    footer = {
                        text = v39.Info.Embed.Footer or "",
                        icon_url = v39.Info.Embed.FooterIcon or ""
                    }
                };
            end;

            for _, v in ipairs(u29.Urls) do
                HandleRequest(v, HttpService:JSONEncode(v40));
            end;
        end;

        return setmetatable(u30, u28);
    end;

    function u29.SetErrorPrinting(p41, p42) -- Line: 233
        p41.ErrorPrinting = p42;
    end;

    function u29.ModifyURLS(p43, p44) -- Line: 237
        assert(p44, "Missing Argument (table expected)");

        if typeof(p44) ~= "table" then
            error("Invalid Argument (table expected)");
        end;

        p43.Urls = p44;
    end;

    return setmetatable(u29, u5);
end;

function u5.FormatEditor.Italic(p45) -- Line: 248
    return "*" .. p45 .. "*";
end;

function u5.FormatEditor.Bold(p46) -- Line: 252
    return "**" .. p46 .. "**";
end;

function u5.FormatEditor.Underline(p47) -- Line: 256
    return "__" .. p47 .. "__";
end;

function u5.FormatEditor.Strikethrough(p48) -- Line: 260
    return "~~" .. p48 .. "~~";
end;

function u5.FormatEditor.Codeblock(p49, p50) -- Line: 264
    return "```" .. (p50 or "") .. "\n" .. p49 .. "\n```";
end;

function u5.FormatEditor.Spoiler(p51) -- Line: 270
    return "||" .. p51 .. "||";
end;

function u5.FormatEditor.Url(p52, p53) -- Line: 274
    return "[" .. p53 .. "](" .. p52 .. ")";
end;

function u5.FormatEditor.Blockquote(p54) -- Line: 278
    return "> " .. p54;
end;

function u5.Mention.User(p55) -- Line: 283
    return "<@" .. p55 .. ">";
end;

function u5.Mention.Role(p56) -- Line: 287
    return "<@&" .. p56 .. ">";
end;

function u5.Mention.Channel(p57) -- Line: 291
    return "<#" .. p57 .. ">";
end;

function u5.Mention.Everyone() -- Line: 295
    return "@everyone";
end;

function u5.Mention.Here() -- Line: 299
    return "@here";
end;

return u5;