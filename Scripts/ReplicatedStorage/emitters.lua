--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     emitters
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.emitters
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("./effects/beam");
local u2 = require("./effects/spin");
local u3 = require("./effects/mesh");
local u4 = require("./effects/sound");
local u5 = require("./effects/bezier");
local u6 = require("./effects/screen");
local u7 = require("./effects/particle");
local u8 = require("./effects/lightning");
local u9 = require("./effects/camera_shake");
local u10 = require("./effects/tweener");
local u11 = require("./effects/randomizer");
local u12 = require("./effects/shockwave_ring");
local u13 = require("./effects/shockwave_line");
local u14 = require("./effects/shockwave_debris");
local u15 = require("./mod/attributes");
require("./types");
local u16 = require("./mod/utility");
local u17 = require("./pkg/Promise");
local u18 = {};

local function processRandomizers(p19: userdata, p20: any) -- Line: 24
    -- upvalues: u16 (copy), u11 (copy)
    local v21 = p19:QueryDescendants((`> RayValue.{u16.PROPERTY_RANDOMIZER_TAG}`));
    local v22 = p19:QueryDescendants((`> RayValue.{u16.ATTRIBUTE_RANDOMIZER_TAG}`));

    if p19:IsA("RayValue") then
        if p19:HasTag(u16.PROPERTY_RANDOMIZER_TAG) then
            table.insert(v21, p19);
        elseif p19:HasTag(u16.ATTRIBUTE_RANDOMIZER_TAG) then
            table.insert(v22, p19);
        end;
    end;

    for _, v in v21 do
        u16.try("failed to emit property randomizer with error: %s", u11.emit, v, p20, false);
    end;

    for _, v in v22 do
        u16.try("failed to emit attribute randomizer with error: %s", u11.emit, v, p20, true);
    end;
end;

function u18.particle(p23: userdata, p24: any, u25: table, p26: table, p27: number) -- Line: 46
    -- upvalues: u15 (copy), u16 (copy), u7 (copy)
    local v28 = u15.get(p23, "EmitCount", u16.PLUGIN_CONTEXT and 1 or nil);
    local v29 = u15.get(p23, "EmitDuration", 0, true);

    if not v28 or v28 <= 0 and v29 <= 0 then
        return;
    end;

    if p23:IsDescendantOf(workspace) then
        u16.try("failed to emit particle with error: %s", u7.emit, p23, p23, p24, p27);

        return;
    end;

    local v30, u31 = u16.cloneParticleAncestry(p23, p26);

    if not v30 then
        return;
    end;

    local v32 = p23:Clone();
    v32.Archivable = false;
    v32.Parent = v30;

    if u25[u31] then
        u25[u31] = u25[u31] + 1;
    else
        u31.Parent = workspace.Terrain;
        u25[u31] = 1;
    end;

    table.insert(p24, function() -- Line: 78
        -- upvalues: u25 (copy), u31 (copy)
        local v33 = u25;
        local v34 = u31;
        v33[v34] = v33[v34] - 1;

        if u25[u31] <= 0 then
            u31:Destroy();
        end;
    end);
    u16.try("failed to emit particle with error: %s", u7.emit, p23, v32, p24, p27);
end;

function u18.beam(p35: userdata, p36: any, p37: number) -- Line: 92
    -- upvalues: u15 (copy), u16 (copy), u1 (copy)
    local Attachment0 = p35.Attachment0;
    local Attachment1 = p35.Attachment1;

    if not (Attachment0 and Attachment1) then
        return;
    end;

    local v38 = p35:Clone();
    v38.Archivable = false;
    v38.Parent = workspace.Terrain;
    local NumberRange_new_ret = NumberRange.new(1, 1);

    if u15.get(p35, "Length_Scale_Start", NumberRange_new_ret, true) ~= NumberRange_new_ret or u15.get(p35, "Length_Scale_End", NumberRange_new_ret, true) ~= NumberRange_new_ret then
        local v39 = Attachment0:Clone();
        local v40 = Attachment1:Clone();
        table.insert(p36, v39);
        table.insert(p36, v40);
        v39.Name = "_ForgeTempAttachment";
        v40.Name = "_ForgeTempAttachment";
        v39:AddTag(u16.EMIT_EXCLUDE_TAG);
        v40:AddTag(u16.EMIT_EXCLUDE_TAG);
        v38.Attachment0 = v39;
        v38.Attachment1 = v40;
        v39.Parent = Attachment0.Parent;
        v40.Parent = Attachment1.Parent;
    end;

    table.insert(p36, v38);
    u16.try("failed to emit beam with error: %s", u1.emit, p35, v38, p36, p37);
end;

function u18.trail(p41: userdata) -- Line: 133
    p41.Enabled = true;
end;

function u18.bezier(p42: userdata, p43: any, p44: boolean?) -- Line: 137
    -- upvalues: u16 (copy), u5 (copy)
    local v45 = p42:FindFirstChildOfClass("Part");

    if not v45 then
        return;
    end;

    if not p44 and p42:GetAttribute("Enabled") then
        p42:SetAttribute("Enabled", false);
    end;

    local v46 = v45:Clone();
    v46.Locked = true;
    table.insert(p43, v46);
    u16.try("failed to emit bezier with error: %s", u5.emit, p42, v46, p43, p44);
end;

function u18.lightning(p47: userdata, p48: any, p49: boolean?) -- Line: 156
    -- upvalues: u16 (copy), u8 (copy)
    local v50 = p47:FindFirstChildOfClass("Part");

    if not v50 then
        return;
    end;

    if not p49 and p47:GetAttribute("Enabled") then
        p47:SetAttribute("Enabled", false);
    end;

    local v51 = v50:Clone();
    v51.Locked = true;
    table.insert(p48, v51);
    u16.try("failed to emit lightning with error: %s", u8.emit, p47, v51, p48, p49);
end;

function u18.mesh(u52: userdata, u53: any, u54: any, u55: number, u56: boolean?) -- Line: 175
    -- upvalues: u16 (copy), u15 (copy), u17 (copy), u3 (copy)
    local Start = u52:FindFirstChild("Start");

    if not Start then
        return;
    end;

    if not u56 and u52:GetAttribute("Enabled") then
        u52:SetAttribute("Enabled", false);
    end;

    local v57 = {};
    local _context = u53._context;
    local v58 = u52:HasTag(u16.ENABLED_VFX_TAG) and u15.get(u52, "EmitDuration", 0) > 0;

    for i = 1, v58 and not u56 and 1 or u15.get(u52, "EmitCount", 1) do
        local v60 = u17.new(function(p59) -- Line: 199
            -- upvalues: u16 (ref), u3 (ref), u52 (copy), Start (copy), u53 (copy), u54 (copy), u55 (copy), u56 (copy)
            u16.try("failed to emit mesh with error: %s", u3.emit, u52, u16.assembleMeshVFX(Start, u53, u54), u53, u55, u56);
            p59();
        end);
        table.insert(v57, v60);
        local v61;

        if _context then
            table.insert(_context._promises, v60);
            v61 = i;
        else
            v61 = i;
        end;
    end;

    u17.all(v57):await();
end;

function u18.spin(p62: userdata, p63: any) -- Line: 223
    -- upvalues: u16 (copy), u2 (copy)
    if u16.lock(p62) then
        return;
    end;

    u16.try("failed to emit spinning model with error: %s", u2.emit, p62, p63);
    u16.unlock(p62);
end;

function u18.camera_shake(p64: userdata, p65: any) -- Line: 232
    -- upvalues: u16 (copy), u9 (copy)
    u16.try("failed to emit camera shake with error: %s", u9.emit, p64, p65);
end;

function u18.property_tweener(p66: userdata, p67: any) -- Line: 236
    -- upvalues: u16 (copy), u10 (copy)
    if not p66.Parent or u16.lock(p66) then
        return;
    end;

    u16.try("failed to emit property tweener with error: %s", u10.emit, p66, p67, false);
    u16.unlock(p66);
end;

function u18.attribute_tweener(p68: userdata, p69: any) -- Line: 245
    -- upvalues: u16 (copy), u10 (copy)
    if not p68.Parent or u16.lock(p68) then
        return;
    end;

    u16.try("failed to emit attribute tweener with error: %s", u10.emit, p68.Parent, p68, p69, true);
    u16.unlock(p68);
end;

function u18.screen(p70: userdata, p71: any) -- Line: 254
    -- upvalues: u16 (copy), u6 (copy)
    local v72, v73 = u16.try("failed to emit screen effect with error: %s", u6.emit, p70, p71);

    if v72 then
        return v73;
    end;

    return false;
end;

function u18.shockwave_ring(p74: userdata, p75: userdata, p76: any) -- Line: 260
    -- upvalues: u16 (copy), u12 (copy)
    u16.try("failed to emit shockwave ring with error: %s", u12.emit, p74, p75, p76);
end;

function u18.shockwave_debris(p77: userdata, p78: userdata, p79: any) -- Line: 264
    -- upvalues: u16 (copy), u14 (copy)
    u16.try("failed to emit shockwave debris with error: %s", u14.emit, p77, p78, p79);
end;

function u18.shockwave_line(p80: userdata, p81: userdata, p82: any) -- Line: 268
    -- upvalues: u16 (copy), u13 (copy)
    u16.try("failed to emit shockwave line with error: %s", u13.emit, p80, p81, p82);
end;

function u18.sound(p83: userdata, p84: any) -- Line: 272
    -- upvalues: u15 (copy), u16 (copy), u4 (copy)
    if u15.get(p83, "EmitCount", 1, true) <= 0 then
        return;
    end;

    u16.try("failed to emit sound with error: %s", u4.emit, p83, p84);
end;

function u18.dispatch(p85: any, p86: any, p87: table, p88: table, p89: any, p90: number) -- Line: 283
    -- upvalues: processRandomizers (copy), u18 (copy), u16 (copy)
    local ClassName = p85.ClassName;
    processRandomizers(p85, p86);

    if ClassName == "ParticleEmitter" then
        u18.particle(p85, p86, p87, p88, p90);

        return;
    end;

    if ClassName == "Beam" then
        u18.beam(p85, p86, p90);

        return;
    end;

    if ClassName == "Trail" then
        u18.trail(p85);

        return;
    end;

    if ClassName == "Sound" then
        u18.sound(p85, p86);

        return;
    end;

    if ClassName == "RayValue" then
        if p85:HasTag(u16.SCREENSHAKE_TAG) then
            u18.camera_shake(p85, p86);

            return;
        end;

        if p85:HasTag(u16.ATTRIBUTE_TWEENER_TAG) then
            u18.attribute_tweener(p85, p86);

            return;
        end;

        if not p85:HasTag(u16.PROPERTY_RANDOMIZER_TAG) then
            if p85:HasTag(u16.ATTRIBUTE_RANDOMIZER_TAG) then
                return;
            end;

            u18.property_tweener(p85, p86);
        end;

        return;
    end;

    if p85:HasTag(u16.BEZIER_TAG) then
        u18.bezier(p85, p86);

        return;
    end;

    if p85:HasTag(u16.LIGHTNING_TAG) then
        u18.lightning(p85, p86);

        return;
    end;

    if ClassName == "Model" then
        if u16.isMeshVFX(p85) then
            u18.mesh(p85, p86, p89, p90);

            return;
        end;

        u18.spin(p85, p86);

        return;
    end;

    local v91 = ClassName == "Part" and u16.findFirstClassWithTag(p85, "Attachment", u16.SHOCKWAVE_TAG);

    if v91 then
        local v92 = p85.Parent and (p85.Parent.Name or "") or "";

        if v92 == "Rings" then
            u18.shockwave_ring(v91, p85, p86);

            return;
        end;

        if v92 == "Debris" then
            u18.shockwave_debris(v91, p85, p86);

            return;
        end;

        if v92 == "Lines" then
            u18.shockwave_line(v91, p85, p86);
        end;
    end;
end;

u18.enabled_registry = {
    mesh = {
        check = function(p93: userdata) -- Line: 367, Name: check
            -- upvalues: u16 (copy)
            return u16.isMeshVFX(p93);
        end,

        emit = function(p94: userdata, p95: any, p96: any) -- Line: 370, Name: emit
            -- upvalues: u18 (copy)
            u18.mesh(p94, p95, p96, 1, true);
        end
    },
    bezier = {
        check = function(p97: userdata) -- Line: 376, Name: check
            -- upvalues: u16 (copy)
            return p97:HasTag(u16.BEZIER_TAG);
        end,

        emit = function(p98: userdata, p99: any, p100: any) -- Line: 379, Name: emit
            -- upvalues: u18 (copy)
            u18.bezier(p98, p99, true);
        end
    },
    lightning = {
        check = function(p101: userdata) -- Line: 385, Name: check
            -- upvalues: u16 (copy)
            return p101:HasTag(u16.LIGHTNING_TAG);
        end,

        emit = function(p102: userdata, p103: any, p104: any) -- Line: 388, Name: emit
            -- upvalues: u18 (copy)
            u18.lightning(p102, p103, true);
        end
    }
};

return u18;