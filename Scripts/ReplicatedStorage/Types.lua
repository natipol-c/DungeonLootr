--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Types
  Path:     game.ReplicatedStorage.MainModule.Types
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:20 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local v7 = {};
local v8 = {};
local v9 = {};
local u10 = {};
local u11 = {};

local function Allocate(p12: number) -- Line: 47
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v13 = u4 + p12;

    if u3 < v13 then
        while u3 < v13 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;
end;

local function ReadS8() -- Line: 58
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readi8_ret = buffer.readi8(u2, u4);
    u4 = u4 + 1;

    return buffer_readi8_ret;
end;

local function WriteS8(p14: number) -- Line: 59
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writei8(u2, u4, p14);
    u4 = u4 + 1;
end;

local function ReadS16() -- Line: 60
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readi16_ret = buffer.readi16(u2, u4);
    u4 = u4 + 2;

    return buffer_readi16_ret;
end;

local function WriteS16(p15: number) -- Line: 61
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writei16(u2, u4, p15);
    u4 = u4 + 2;
end;

local function ReadS24() -- Line: 62
    -- upvalues: u2 (ref), u4 (ref)
    local v16 = buffer.readbits(u2, u4 * 8, 24) - 8388608;
    u4 = u4 + 3;

    return v16;
end;

local function WriteS24(p17: number) -- Line: 63
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writebits(u2, u4 * 8, 24, p17 + 8388608);
    u4 = u4 + 3;
end;

local function ReadS32() -- Line: 64
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readi32_ret = buffer.readi32(u2, u4);
    u4 = u4 + 4;

    return buffer_readi32_ret;
end;

local function WriteS32(p18: number) -- Line: 65
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writei32(u2, u4, p18);
    u4 = u4 + 4;
end;

local function ReadU8() -- Line: 66
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return buffer_readu8_ret;
end;

local function WriteU8(p19: number) -- Line: 67
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writeu8(u2, u4, p19);
    u4 = u4 + 1;
end;

local function ReadU16() -- Line: 68
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;

    return buffer_readu16_ret;
end;

local function WriteU16(p20: number) -- Line: 69
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writeu16(u2, u4, p20);
    u4 = u4 + 2;
end;

local function ReadU24() -- Line: 70
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readbits_ret = buffer.readbits(u2, u4 * 8, 24);
    u4 = u4 + 3;

    return buffer_readbits_ret;
end;

local function WriteU24(p21: number) -- Line: 71
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writebits(u2, u4 * 8, 24, p21);
    u4 = u4 + 3;
end;

local function ReadU32() -- Line: 72
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu32_ret = buffer.readu32(u2, u4);
    u4 = u4 + 4;

    return buffer_readu32_ret;
end;

local function WriteU32(p22: number) -- Line: 73
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writeu32(u2, u4, p22);
    u4 = u4 + 4;
end;

local function ReadF32() -- Line: 74
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return buffer_readf32_ret;
end;

local function WriteF32(p23: number) -- Line: 75
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writef32(u2, u4, p23);
    u4 = u4 + 4;
end;

local function ReadF64() -- Line: 76
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readf64_ret = buffer.readf64(u2, u4);
    u4 = u4 + 8;

    return buffer_readf64_ret;
end;

local function WriteF64(p24: number) -- Line: 77
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writef64(u2, u4, p24);
    u4 = u4 + 8;
end;

local function ReadString(p25: number) -- Line: 78
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readstring_ret = buffer.readstring(u2, u4, p25);
    u4 = u4 + p25;

    return buffer_readstring_ret;
end;

local function WriteString(p26: string) -- Line: 79
    -- upvalues: u2 (ref), u4 (ref)
    buffer.writestring(u2, u4, p26);
    u4 = u4 + #p26;
end;

local function ReadBuffer(p27: number) -- Line: 80
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_create_ret = buffer.create(p27);
    buffer.copy(buffer_create_ret, 0, u2, u4, p27);
    u4 = u4 + p27;

    return buffer_create_ret;
end;

local function WriteBuffer(p28: buffer) -- Line: 81
    -- upvalues: u2 (ref), u4 (ref)
    buffer.copy(u2, u4, p28);
    u4 = u4 + buffer.len(p28);
end;

local function ReadInstance() -- Line: 82
    -- upvalues: u6 (ref), u5 (ref)
    u6 = u6 + 1;

    return u5[u6];
end;

local function WriteInstance(p29) -- Line: 83
    -- upvalues: u6 (ref), u5 (ref)
    u6 = u6 + 1;
    u5[u6] = p29;
end;

local function ReadF16() -- Line: 85
    -- upvalues: u4 (ref), u2 (ref)
    local v30 = u4 * 8;
    u4 = u4 + 2;
    local buffer_readbits_ret = buffer.readbits(u2, v30 + 0, 10);
    local buffer_readbits_ret2 = buffer.readbits(u2, v30 + 10, 5);
    local buffer_readbits_ret3 = buffer.readbits(u2, v30 + 15, 1);

    if buffer_readbits_ret == 0 then
        if buffer_readbits_ret2 == 0 then
            return 0;
        end;

        if buffer_readbits_ret2 == 31 then
            return buffer_readbits_ret3 == 0 and (1 / 0) or (-1 / 0);
        end;
    elseif buffer_readbits_ret2 == 31 then
        return (0 / 0);
    end;

    if buffer_readbits_ret3 == 0 then
        return (buffer_readbits_ret / 1024 + 1) * 2 ^ (buffer_readbits_ret2 - 15);
    end;

    return -(buffer_readbits_ret / 1024 + 1) * 2 ^ (buffer_readbits_ret2 - 15);
end;

local function WriteF16(p31: number) -- Line: 101
    -- upvalues: u4 (ref), u2 (ref)
    local v32 = u4 * 8;
    u4 = u4 + 2;

    if p31 == 0 then
        buffer.writebits(u2, v32, 16, 0);

        return;
    end;

    if p31 >= 65520 then
        buffer.writebits(u2, v32, 16, 31744);

        return;
    end;

    if p31 <= -65520 then
        buffer.writebits(u2, v32, 16, 64512);

        return;
    end;

    if p31 ~= p31 then
        buffer.writebits(u2, v32, 16, 31745);

        return;
    end;

    local v33;

    if p31 < 0 then
        p31 = -p31;
        v33 = 1;
    else
        v33 = 0;
    end;

    local math_frexp_ret, v34 = math.frexp(p31);
    buffer.writebits(u2, v32 + 0, 10, math_frexp_ret * 2048 - 1023.5);
    buffer.writebits(u2, v32 + 10, 5, v34 + 14);
    buffer.writebits(u2, v32 + 15, 1, v33);
end;

local function ReadF24() -- Line: 122
    -- upvalues: u4 (ref), u2 (ref)
    local v35 = u4 * 8;
    u4 = u4 + 3;
    local buffer_readbits_ret = buffer.readbits(u2, v35 + 0, 17);
    local buffer_readbits_ret2 = buffer.readbits(u2, v35 + 17, 6);
    local buffer_readbits_ret3 = buffer.readbits(u2, v35 + 23, 1);

    if buffer_readbits_ret == 0 then
        if buffer_readbits_ret2 == 0 then
            return 0;
        end;

        if buffer_readbits_ret2 == 63 then
            return buffer_readbits_ret3 == 0 and (1 / 0) or (-1 / 0);
        end;
    elseif buffer_readbits_ret2 == 63 then
        return (0 / 0);
    end;

    if buffer_readbits_ret3 == 0 then
        return (buffer_readbits_ret / 131072 + 1) * 2 ^ (buffer_readbits_ret2 - 31);
    end;

    return -(buffer_readbits_ret / 131072 + 1) * 2 ^ (buffer_readbits_ret2 - 31);
end;

local function WriteF24(p36: number) -- Line: 138
    -- upvalues: u4 (ref), u2 (ref)
    local v37 = u4 * 8;
    u4 = u4 + 3;

    if p36 == 0 then
        buffer.writebits(u2, v37, 24, 0);

        return;
    end;

    if p36 >= 4294959104 then
        buffer.writebits(u2, v37, 24, 8257536);

        return;
    end;

    if p36 <= -4294959104 then
        buffer.writebits(u2, v37, 24, 16646144);

        return;
    end;

    if p36 ~= p36 then
        buffer.writebits(u2, v37, 24, 8257537);

        return;
    end;

    local v38;

    if p36 < 0 then
        p36 = -p36;
        v38 = 1;
    else
        v38 = 0;
    end;

    local math_frexp_ret, v39 = math.frexp(p36);
    buffer.writebits(u2, v37 + 0, 17, math_frexp_ret * 262144 - 131071.5);
    buffer.writebits(u2, v37 + 17, 6, v39 + 30);
    buffer.writebits(u2, v37 + 23, 1, v38);
end;

v7.Any = "Any";

function v8.Any() -- Line: 162
    -- upvalues: u10 (copy), u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return u10[buffer_readu8_ret]();
end;

function v9.Any(p40) -- Line: 163
    -- upvalues: u11 (copy)
    u11[typeof(p40)](p40);
end;

v7.Nil = "Nil";

function v8.Nil() -- Line: 166
    return nil;
end;

function v9.Nil(p41: nil) -- Line: 167
end;

v7.NumberS8 = "NumberS8";

function v8.NumberS8() -- Line: 170
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readi8_ret = buffer.readi8(u2, u4);
    u4 = u4 + 1;

    return buffer_readi8_ret;
end;

function v9.NumberS8(p42: number) -- Line: 171
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v43 = u4 + 1;

    if u3 < v43 then
        while u3 < v43 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writei8(u2, u4, p42);
    u4 = u4 + 1;
end;

v7.NumberS16 = "NumberS16";

function v8.NumberS16() -- Line: 174
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readi16_ret = buffer.readi16(u2, u4);
    u4 = u4 + 2;

    return buffer_readi16_ret;
end;

function v9.NumberS16(p44: number) -- Line: 175
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v45 = u4 + 2;

    if u3 < v45 then
        while u3 < v45 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writei16(u2, u4, p44);
    u4 = u4 + 2;
end;

v7.NumberS24 = "NumberS24";

function v8.NumberS24() -- Line: 178
    -- upvalues: u2 (ref), u4 (ref)
    local v46 = buffer.readbits(u2, u4 * 8, 24) - 8388608;
    u4 = u4 + 3;

    return v46;
end;

function v9.NumberS24(p47: number) -- Line: 179
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v48 = u4 + 3;

    if u3 < v48 then
        while u3 < v48 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writebits(u2, u4 * 8, 24, p47 + 8388608);
    u4 = u4 + 3;
end;

v7.NumberS32 = "NumberS32";

function v8.NumberS32() -- Line: 182
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readi32_ret = buffer.readi32(u2, u4);
    u4 = u4 + 4;

    return buffer_readi32_ret;
end;

function v9.NumberS32(p49: number) -- Line: 183
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v50 = u4 + 4;

    if u3 < v50 then
        while u3 < v50 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writei32(u2, u4, p49);
    u4 = u4 + 4;
end;

v7.NumberU8 = "NumberU8";

function v8.NumberU8() -- Line: 186
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return buffer_readu8_ret;
end;

function v9.NumberU8(p51: number) -- Line: 187
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v52 = u4 + 1;

    if u3 < v52 then
        while u3 < v52 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, p51);
    u4 = u4 + 1;
end;

v7.NumberU16 = "NumberU16";

function v8.NumberU16() -- Line: 190
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;

    return buffer_readu16_ret;
end;

function v9.NumberU16(p53: number) -- Line: 191
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v54 = u4 + 2;

    if u3 < v54 then
        while u3 < v54 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu16(u2, u4, p53);
    u4 = u4 + 2;
end;

v7.NumberU24 = "NumberU24";

function v8.NumberU24() -- Line: 194
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readbits_ret = buffer.readbits(u2, u4 * 8, 24);
    u4 = u4 + 3;

    return buffer_readbits_ret;
end;

function v9.NumberU24(p55: number) -- Line: 195
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v56 = u4 + 3;

    if u3 < v56 then
        while u3 < v56 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writebits(u2, u4 * 8, 24, p55);
    u4 = u4 + 3;
end;

v7.NumberU32 = "NumberU32";

function v8.NumberU32() -- Line: 198
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu32_ret = buffer.readu32(u2, u4);
    u4 = u4 + 4;

    return buffer_readu32_ret;
end;

function v9.NumberU32(p57: number) -- Line: 199
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v58 = u4 + 4;

    if u3 < v58 then
        while u3 < v58 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu32(u2, u4, p57);
    u4 = u4 + 4;
end;

v7.NumberF16 = "NumberF16";

function v8.NumberF16() -- Line: 202
    -- upvalues: ReadF16 (copy)
    return ReadF16();
end;

function v9.NumberF16(p59: number) -- Line: 203
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), WriteF16 (copy)
    local v60 = u4 + 2;

    if u3 < v60 then
        while u3 < v60 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    WriteF16(p59);
end;

v7.NumberF24 = "NumberF24";

function v8.NumberF24() -- Line: 206
    -- upvalues: ReadF24 (copy)
    return ReadF24();
end;

function v9.NumberF24(p61: number) -- Line: 207
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), WriteF24 (copy)
    local v62 = u4 + 3;

    if u3 < v62 then
        while u3 < v62 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    WriteF24(p61);
end;

v7.NumberF32 = "NumberF32";

function v8.NumberF32() -- Line: 210
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return buffer_readf32_ret;
end;

function v9.NumberF32(p63: number) -- Line: 211
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v64 = u4 + 4;

    if u3 < v64 then
        while u3 < v64 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writef32(u2, u4, p63);
    u4 = u4 + 4;
end;

v7.NumberF64 = "NumberF64";

function v8.NumberF64() -- Line: 214
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readf64_ret = buffer.readf64(u2, u4);
    u4 = u4 + 8;

    return buffer_readf64_ret;
end;

function v9.NumberF64(p65: number) -- Line: 215
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v66 = u4 + 8;

    if u3 < v66 then
        while u3 < v66 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writef64(u2, u4, p65);
    u4 = u4 + 8;
end;

v7.String = "String";

function v8.String() -- Line: 218
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_readstring_ret = buffer.readstring(u2, u4, buffer_readu8_ret);
    u4 = u4 + buffer_readu8_ret;

    return buffer_readstring_ret;
end;

function v9.String(p67: string) -- Line: 219
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v68 = #p67;
    local v69 = u4 + (v68 + 1);

    if u3 < v69 then
        while u3 < v69 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, v68);
    u4 = u4 + 1;
    buffer.writestring(u2, u4, p67);
    u4 = u4 + #p67;
end;

v7.StringLong = "StringLong";

function v8.StringLong() -- Line: 222
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local buffer_readstring_ret = buffer.readstring(u2, u4, buffer_readu16_ret);
    u4 = u4 + buffer_readu16_ret;

    return buffer_readstring_ret;
end;

function v9.StringLong(p70: string) -- Line: 223
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v71 = #p70;
    local v72 = u4 + (v71 + 2);

    if u3 < v72 then
        while u3 < v72 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu16(u2, u4, v71);
    u4 = u4 + 2;
    buffer.writestring(u2, u4, p70);
    u4 = u4 + #p70;
end;

v7.Buffer = "Buffer";

function v8.Buffer() -- Line: 226
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_create_ret = buffer.create(buffer_readu8_ret);
    buffer.copy(buffer_create_ret, 0, u2, u4, buffer_readu8_ret);
    u4 = u4 + buffer_readu8_ret;

    return buffer_create_ret;
end;

function v9.Buffer(p73: buffer) -- Line: 227
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local buffer_len_ret = buffer.len(p73);
    local v74 = u4 + (1 + buffer_len_ret);

    if u3 < v74 then
        while u3 < v74 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, buffer_len_ret);
    u4 = u4 + 1;
    buffer.copy(u2, u4, p73);
    u4 = u4 + buffer.len(p73);
end;

v7.BufferLong = "BufferLong";

function v8.BufferLong() -- Line: 230
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local buffer_create_ret = buffer.create(buffer_readu16_ret);
    buffer.copy(buffer_create_ret, 0, u2, u4, buffer_readu16_ret);
    u4 = u4 + buffer_readu16_ret;

    return buffer_create_ret;
end;

function v9.BufferLong(p75: buffer) -- Line: 231
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local buffer_len_ret = buffer.len(p75);
    local v76 = u4 + (2 + buffer_len_ret);

    if u3 < v76 then
        while u3 < v76 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu16(u2, u4, buffer_len_ret);
    u4 = u4 + 2;
    buffer.copy(u2, u4, p75);
    u4 = u4 + buffer.len(p75);
end;

v7.Instance = "Instance";

function v8.Instance() -- Line: 234
    -- upvalues: u6 (ref), u5 (ref)
    u6 = u6 + 1;

    return u5[u6];
end;

function v9.Instance(p77: userdata) -- Line: 235
    -- upvalues: u6 (ref), u5 (ref)
    u6 = u6 + 1;
    u5[u6] = p77;
end;

v7.Boolean8 = "Boolean8";

function v8.Boolean8() -- Line: 238
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return buffer_readu8_ret == 1;
end;

function v9.Boolean8(p78: boolean) -- Line: 239
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v79 = u4 + 1;

    if u3 < v79 then
        while u3 < v79 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, p78 and 1 or 0);
    u4 = u4 + 1;
end;

v7.NumberRange = "NumberRange";

function v8.NumberRange() -- Line: 242
    -- upvalues: u2 (ref), u4 (ref)
    local NumberRange_new = NumberRange.new;
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return NumberRange_new(buffer_readf32_ret, buffer_readf32_ret2);
end;

function v9.NumberRange(p80) -- Line: 243
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v81 = u4 + 8;

    if u3 < v81 then
        while u3 < v81 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writef32(u2, u4, p80.Min);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p80.Max);
    u4 = u4 + 4;
end;

v7.BrickColor = "BrickColor";

function v8.BrickColor() -- Line: 246
    -- upvalues: u2 (ref), u4 (ref)
    local BrickColor_new = BrickColor.new;
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;

    return BrickColor_new(buffer_readu16_ret);
end;

function v9.BrickColor(p82: userdata) -- Line: 247
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v83 = u4 + 2;

    if u3 < v83 then
        while u3 < v83 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu16(u2, u4, p82.Number);
    u4 = u4 + 2;
end;

v7.Color3 = "Color3";

function v8.Color3() -- Line: 250
    -- upvalues: u2 (ref), u4 (ref)
    local Color3_fromRGB = Color3.fromRGB;
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_readu8_ret2 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_readu8_ret3 = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return Color3_fromRGB(buffer_readu8_ret, buffer_readu8_ret2, buffer_readu8_ret3);
end;

function v9.Color3(p84) -- Line: 251
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v85 = u4 + 3;

    if u3 < v85 then
        while u3 < v85 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, p84.R * 255 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, p84.G * 255 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, p84.B * 255 + 0.5);
    u4 = u4 + 1;
end;

v7.UDim = "UDim";

function v8.UDim() -- Line: 254
    -- upvalues: u2 (ref), u4 (ref)
    local UDim_new = UDim.new;
    local buffer_readi16_ret = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u2, u4);
    u4 = u4 + 2;

    return UDim_new(buffer_readi16_ret / 1000, buffer_readi16_ret2);
end;

function v9.UDim(p86) -- Line: 255
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v87 = u4 + 4;

    if u3 < v87 then
        while u3 < v87 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writei16(u2, u4, p86.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p86.Offset);
    u4 = u4 + 2;
end;

v7.UDim2 = "UDim2";

function v8.UDim2() -- Line: 258
    -- upvalues: u2 (ref), u4 (ref)
    local UDim2_new = UDim2.new;
    local buffer_readi16_ret = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret3 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret4 = buffer.readi16(u2, u4);
    u4 = u4 + 2;

    return UDim2_new(buffer_readi16_ret / 1000, buffer_readi16_ret2, buffer_readi16_ret3 / 1000, buffer_readi16_ret4);
end;

function v9.UDim2(p88) -- Line: 259
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v89 = u4 + 8;

    if u3 < v89 then
        while u3 < v89 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writei16(u2, u4, p88.X.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p88.X.Offset);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p88.Y.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p88.Y.Offset);
    u4 = u4 + 2;
end;

v7.Rect = "Rect";

function v8.Rect() -- Line: 262
    -- upvalues: u2 (ref), u4 (ref)
    local Rect_new = Rect.new;
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret4 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return Rect_new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3, buffer_readf32_ret4);
end;

function v9.Rect(p90) -- Line: 263
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v91 = u4 + 16;

    if u3 < v91 then
        while u3 < v91 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writef32(u2, u4, p90.Min.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p90.Min.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p90.Max.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p90.Max.Y);
    u4 = u4 + 4;
end;

v7.Vector2S16 = "Vector2S16";

function v8.Vector2S16() -- Line: 266
    -- upvalues: u2 (ref), u4 (ref)
    local Vector2_new = Vector2.new;
    local buffer_readi16_ret = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u2, u4);
    u4 = u4 + 2;

    return Vector2_new(buffer_readi16_ret, buffer_readi16_ret2);
end;

function v9.Vector2S16(p92) -- Line: 267
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v93 = u4 + 4;

    if u3 < v93 then
        while u3 < v93 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writei16(u2, u4, p92.X);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p92.Y);
    u4 = u4 + 2;
end;

v7.Vector2F24 = "Vector2F24";

function v8.Vector2F24() -- Line: 270
    -- upvalues: ReadF24 (copy)
    return Vector2.new(ReadF24(), (ReadF24()));
end;

function v9.Vector2F24(p94) -- Line: 271
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), WriteF24 (copy)
    local v95 = u4 + 6;

    if u3 < v95 then
        while u3 < v95 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    WriteF24(p94.X);
    WriteF24(p94.Y);
end;

v7.Vector2F32 = "Vector2F32";

function v8.Vector2F32() -- Line: 274
    -- upvalues: u2 (ref), u4 (ref)
    local Vector2_new = Vector2.new;
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return Vector2_new(buffer_readf32_ret, buffer_readf32_ret2);
end;

function v9.Vector2F32(p96) -- Line: 275
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v97 = u4 + 8;

    if u3 < v97 then
        while u3 < v97 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writef32(u2, u4, p96.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p96.Y);
    u4 = u4 + 4;
end;

v7.Vector3S16 = "Vector3S16";

function v8.Vector3S16() -- Line: 278
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readi16_ret = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret3 = buffer.readi16(u2, u4);
    u4 = u4 + 2;

    return Vector3.new(buffer_readi16_ret, buffer_readi16_ret2, buffer_readi16_ret3);
end;

function v9.Vector3S16(p98: vector) -- Line: 279
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v99 = u4 + 6;

    if u3 < v99 then
        while u3 < v99 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writei16(u2, u4, p98.X);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p98.Y);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p98.Z);
    u4 = u4 + 2;
end;

v7.Vector3F24 = "Vector3F24";

function v8.Vector3F24() -- Line: 282
    -- upvalues: ReadF24 (copy)
    local v100 = ReadF24();
    local v101 = ReadF24();
    local v102 = ReadF24();

    return Vector3.new(v100, v101, v102);
end;

function v9.Vector3F24(p103: vector) -- Line: 283
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), WriteF24 (copy)
    local v104 = u4 + 9;

    if u3 < v104 then
        while u3 < v104 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    WriteF24(p103.X);
    WriteF24(p103.Y);
    WriteF24(p103.Z);
end;

v7.Vector3F32 = "Vector3F32";

function v8.Vector3F32() -- Line: 286
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function v9.Vector3F32(p105: vector) -- Line: 287
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v106 = u4 + 12;

    if u3 < v106 then
        while u3 < v106 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writef32(u2, u4, p105.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p105.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p105.Z);
    u4 = u4 + 4;
end;

v7.NumberU4 = "NumberU4";

function v8.NumberU4() -- Line: 290
    -- upvalues: u4 (ref), u2 (ref)
    local v107 = u4 * 8;
    u4 = u4 + 1;

    return { buffer.readbits(u2, v107 + 0, 4), buffer.readbits(u2, v107 + 4, 4) };
end;

function v9.NumberU4(p108: table) -- Line: 298
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v109 = u4 + 1;

    if u3 < v109 then
        while u3 < v109 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    local v110 = u4 * 8;
    u4 = u4 + 1;
    buffer.writebits(u2, v110 + 0, 4, p108[1]);
    buffer.writebits(u2, v110 + 4, 4, p108[2]);
end;

v7.BooleanNumber = "BooleanNumber";

function v8.BooleanNumber() -- Line: 307
    -- upvalues: u4 (ref), u2 (ref)
    local v111 = u4 * 8;
    u4 = u4 + 1;

    return {
        Boolean = buffer.readbits(u2, v111 + 0, 1) == 1,
        Number = buffer.readbits(u2, v111 + 1, 7)
    };
end;

function v9.BooleanNumber(p112: table) -- Line: 315
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v113 = u4 + 1;

    if u3 < v113 then
        while u3 < v113 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    local v114 = u4 * 8;
    u4 = u4 + 1;
    buffer.writebits(u2, v114 + 0, 1, p112.Boolean and 1 or 0);
    buffer.writebits(u2, v114 + 1, 7, p112.Number);
end;

v7.Boolean1 = "Boolean1";

function v8.Boolean1() -- Line: 324
    -- upvalues: u4 (ref), u2 (ref)
    local v115 = u4 * 8;
    u4 = u4 + 1;

    return {
        buffer.readbits(u2, v115 + 0, 1) == 1,
        buffer.readbits(u2, v115 + 1, 1) == 1,
        buffer.readbits(u2, v115 + 2, 1) == 1,
        buffer.readbits(u2, v115 + 3, 1) == 1,
        buffer.readbits(u2, v115 + 4, 1) == 1,
        buffer.readbits(u2, v115 + 5, 1) == 1,
        buffer.readbits(u2, v115 + 6, 1) == 1,
        buffer.readbits(u2, v115 + 7, 1) == 1
    };
end;

function v9.Boolean1(p116: table) -- Line: 338
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v117 = u4 + 1;

    if u3 < v117 then
        while u3 < v117 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    local v118 = u4 * 8;
    u4 = u4 + 1;
    buffer.writebits(u2, v118 + 0, 1, p116[1] and 1 or 0);
    buffer.writebits(u2, v118 + 1, 1, p116[2] and 1 or 0);
    buffer.writebits(u2, v118 + 2, 1, p116[3] and 1 or 0);
    buffer.writebits(u2, v118 + 3, 1, p116[4] and 1 or 0);
    buffer.writebits(u2, v118 + 4, 1, p116[5] and 1 or 0);
    buffer.writebits(u2, v118 + 5, 1, p116[6] and 1 or 0);
    buffer.writebits(u2, v118 + 6, 1, p116[7] and 1 or 0);
    buffer.writebits(u2, v118 + 7, 1, p116[8] and 1 or 0);
end;

v7.CFrameF24U8 = "CFrameF24U8";

function v8.CFrameF24U8() -- Line: 353
    -- upvalues: u2 (ref), u4 (ref), ReadF24 (copy)
    local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_readu8_ret2 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_readu8_ret3 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v119 = CFrame_fromEulerAnglesXYZ(buffer_readu8_ret / 40.58451048843331, buffer_readu8_ret2 / 40.58451048843331, buffer_readu8_ret3 / 40.58451048843331);
    local v120 = ReadF24();
    local v121 = ReadF24();
    local v122 = ReadF24();

    return v119 + Vector3.new(v120, v121, v122);
end;

function v9.CFrameF24U8(p123) -- Line: 357
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), WriteF24 (copy)
    local v124, v125, v126 = p123:ToEulerAnglesXYZ();
    local v127 = u4 + 12;

    if u3 < v127 then
        while u3 < v127 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, v124 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v125 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v126 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    WriteF24(p123.X);
    WriteF24(p123.Y);
    WriteF24(p123.Z);
end;

v7.CFrameF32U8 = "CFrameF32U8";

function v8.CFrameF32U8() -- Line: 365
    -- upvalues: u2 (ref), u4 (ref)
    local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_readu8_ret2 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_readu8_ret3 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v128 = CFrame_fromEulerAnglesXYZ(buffer_readu8_ret / 40.58451048843331, buffer_readu8_ret2 / 40.58451048843331, buffer_readu8_ret3 / 40.58451048843331);
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return v128 + Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function v9.CFrameF32U8(p129) -- Line: 369
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v130, v131, v132 = p129:ToEulerAnglesXYZ();
    local v133 = u4 + 15;

    if u3 < v133 then
        while u3 < v133 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, v130 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v131 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v132 * 40.58451048843331 + 0.5);
    u4 = u4 + 1;
    buffer.writef32(u2, u4, p129.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p129.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p129.Z);
    u4 = u4 + 4;
end;

v7.CFrameF32U16 = "CFrameF32U16";

function v8.CFrameF32U16() -- Line: 377
    -- upvalues: u2 (ref), u4 (ref)
    local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local buffer_readu16_ret2 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local buffer_readu16_ret3 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v134 = CFrame_fromEulerAnglesXYZ(buffer_readu16_ret / 10430.219195527361, buffer_readu16_ret2 / 10430.219195527361, buffer_readu16_ret3 / 10430.219195527361);
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return v134 + Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function v9.CFrameF32U16(p135) -- Line: 381
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v136, v137, v138 = p135:ToEulerAnglesXYZ();
    local v139 = u4 + 18;

    if u3 < v139 then
        while u3 < v139 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu16(u2, u4, v136 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writeu16(u2, u4, v137 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writeu16(u2, u4, v138 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writef32(u2, u4, p135.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p135.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p135.Z);
    u4 = u4 + 4;
end;

v7.Region3 = "Region3";

function v8.Region3() -- Line: 389
    -- upvalues: u2 (ref), u4 (ref)
    local Region3_new = Region3.new;
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local Vector3_new_ret = Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
    local buffer_readf32_ret4 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret5 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret6 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return Region3_new(Vector3_new_ret, (Vector3.new(buffer_readf32_ret4, buffer_readf32_ret5, buffer_readf32_ret6)));
end;

function v9.Region3(p140: userdata) -- Line: 395
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v141 = p140.Size / 2;
    local v142 = p140.CFrame.Position - v141;
    local v143 = p140.CFrame.Position + v141;
    local v144 = u4 + 24;

    if u3 < v144 then
        while u3 < v144 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writef32(u2, u4, v142.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v142.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v142.Z);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v143.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v143.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v143.Z);
    u4 = u4 + 4;
end;

v7.NumberSequence = "NumberSequence";

function v8.NumberSequence() -- Line: 405
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local table_create_ret = table.create(buffer_readu8_ret);

    for i = 1, buffer_readu8_ret do
        local NumberSequenceKeypoint_new = NumberSequenceKeypoint.new;
        local buffer_readu8_ret2 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local buffer_readu8_ret3 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local buffer_readu8_ret4 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        table.insert(table_create_ret, NumberSequenceKeypoint_new(buffer_readu8_ret2 / 255, buffer_readu8_ret3 / 255, buffer_readu8_ret4 / 255));
        local _ = i;
    end;

    return NumberSequence.new(table_create_ret);
end;

function v9.NumberSequence(p145: userdata) -- Line: 413
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v146 = #p145.Keypoints;
    local v147 = u4 + (v146 * 3 + 1);

    if u3 < v147 then
        while u3 < v147 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, v146);
    u4 = u4 + 1;

    for _, v in p145.Keypoints do
        buffer.writeu8(u2, u4, v.Time * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v.Value * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v.Envelope * 255 + 0.5);
        u4 = u4 + 1;
    end;
end;

v7.ColorSequence = "ColorSequence";

function v8.ColorSequence() -- Line: 423
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local table_create_ret = table.create(buffer_readu8_ret);

    for i = 1, buffer_readu8_ret do
        local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
        local buffer_readu8_ret2 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local Color3_fromRGB = Color3.fromRGB;
        local buffer_readu8_ret3 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local buffer_readu8_ret4 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local buffer_readu8_ret5 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        table.insert(table_create_ret, ColorSequenceKeypoint_new(buffer_readu8_ret2 / 255, Color3_fromRGB(buffer_readu8_ret3, buffer_readu8_ret4, buffer_readu8_ret5)));
        local _ = i;
    end;

    return ColorSequence.new(table_create_ret);
end;

function v9.ColorSequence(p148: userdata) -- Line: 431
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v149 = #p148.Keypoints;
    local v150 = u4 + (v149 * 4 + 1);

    if u3 < v150 then
        while u3 < v150 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, v149);
    u4 = u4 + 1;

    for _, v in p148.Keypoints do
        buffer.writeu8(u2, u4, v.Time * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v.Value.R * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v.Value.G * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v.Value.B * 255 + 0.5);
        u4 = u4 + 1;
    end;
end;

local script_Characters = require(script.Characters);
local u151 = {};

for i, v in script_Characters do
    u151[v] = i;
end;

local math_log_ret = math.log(#script_Characters + 1, 2);
local math_ceil_ret = math.ceil(math_log_ret);
local u152 = math_ceil_ret / 8;
v7.Characters = "Characters";

function v8.Characters() -- Line: 447
    -- upvalues: u2 (ref), u4 (ref), u152 (copy), script_Characters (copy), math_ceil_ret (copy)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local table_create_ret = table.create(buffer_readu8_ret);
    local v153 = u4 * 8;
    u4 = u4 + math.ceil(buffer_readu8_ret * u152);

    for i = 1, buffer_readu8_ret do
        local v154 = script_Characters[buffer.readbits(u2, v153, math_ceil_ret)];
        table.insert(table_create_ret, v154);
        v153 = v153 + math_ceil_ret;
        local _ = i;
    end;

    return table.concat(table_create_ret);
end;

function v9.Characters(p155: string) -- Line: 458
    -- upvalues: u152 (copy), u4 (ref), u3 (ref), u2 (ref), u1 (ref), math_ceil_ret (copy), u151 (copy)
    local v156 = #p155;
    local math_ceil_ret2 = math.ceil(v156 * u152);
    local v157 = u4 + (math_ceil_ret2 + 1);

    if u3 < v157 then
        while u3 < v157 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, v156);
    u4 = u4 + 1;
    local v158 = u4 * 8;

    for i = 1, v156 do
        buffer.writebits(u2, v158, math_ceil_ret, u151[p155:sub(i, i)]);
        v158 = v158 + math_ceil_ret;
        local _ = i;
    end;

    u4 = u4 + math_ceil_ret2;
end;

local script_Enums = require(script.Enums);
local u159 = {};

for i, v in script_Enums do
    u159[v] = i;
end;

v7.EnumItem = "EnumItem";

function v8.EnumItem() -- Line: 475
    -- upvalues: script_Enums (copy), u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v160 = script_Enums[buffer_readu8_ret];
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;

    return v160:FromValue(buffer_readu16_ret);
end;

function v9.EnumItem(p161: userdata) -- Line: 476
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u159 (copy)
    local v162 = u4 + 3;

    if u3 < v162 then
        while u3 < v162 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, u159[p161.EnumType]);
    u4 = u4 + 1;
    buffer.writeu16(u2, u4, p161.Value);
    u4 = u4 + 2;
end;

local script_Static1 = require(script.Static1);
local u163 = {};

for i, v in script_Static1 do
    u163[v] = i;
end;

v7.Static1 = "Static1";

function v8.Static1() -- Line: 482
    -- upvalues: script_Static1 (copy), u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return script_Static1[buffer_readu8_ret];
end;

function v9.Static1(p164) -- Line: 483
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u163 (copy)
    local v165 = u4 + 1;

    if u3 < v165 then
        while u3 < v165 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, u163[p164] or 0);
    u4 = u4 + 1;
end;

local script_Static2 = require(script.Static2);
local u166 = {};

for i, v in script_Static2 do
    u166[v] = i;
end;

v7.Static2 = "Static2";

function v8.Static2() -- Line: 489
    -- upvalues: script_Static2 (copy), u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return script_Static2[buffer_readu8_ret];
end;

function v9.Static2(p167) -- Line: 490
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u166 (copy)
    local v168 = u4 + 1;

    if u3 < v168 then
        while u3 < v168 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, u166[p167] or 0);
    u4 = u4 + 1;
end;

local script_Static3 = require(script.Static3);
local u169 = {};

for i, v in script_Static3 do
    u169[v] = i;
end;

v7.Static3 = "Static3";

function v8.Static3() -- Line: 496
    -- upvalues: script_Static3 (copy), u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return script_Static3[buffer_readu8_ret];
end;

function v9.Static3(p170) -- Line: 497
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u169 (copy)
    local v171 = u4 + 1;

    if u3 < v171 then
        while u3 < v171 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, u169[p170] or 0);
    u4 = u4 + 1;
end;

u10[0] = function() -- Line: 501
    return nil;
end;

u11["nil"] = function(p172: nil) -- Line: 502
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v173 = u4 + 1;

    if u3 < v173 then
        while u3 < v173 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 0);
    u4 = u4 + 1;
end;

u10[1] = function() -- Line: 504
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return -buffer_readu8_ret;
end;

u10[2] = function() -- Line: 505
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;

    return -buffer_readu16_ret;
end;

u10[3] = function() -- Line: 506
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readbits_ret = buffer.readbits(u2, u4 * 8, 24);
    u4 = u4 + 3;

    return -buffer_readbits_ret;
end;

u10[4] = function() -- Line: 507
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu32_ret = buffer.readu32(u2, u4);
    u4 = u4 + 4;

    return -buffer_readu32_ret;
end;

u10[5] = function() -- Line: 508
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return buffer_readu8_ret;
end;

u10[6] = function() -- Line: 509
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;

    return buffer_readu16_ret;
end;

u10[7] = function() -- Line: 510
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readbits_ret = buffer.readbits(u2, u4 * 8, 24);
    u4 = u4 + 3;

    return buffer_readbits_ret;
end;

u10[8] = function() -- Line: 511
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu32_ret = buffer.readu32(u2, u4);
    u4 = u4 + 4;

    return buffer_readu32_ret;
end;

u10[9] = function() -- Line: 512
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return buffer_readf32_ret;
end;

u10[10] = function() -- Line: 513
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readf64_ret = buffer.readf64(u2, u4);
    u4 = u4 + 8;

    return buffer_readf64_ret;
end;

function u11.number(p174: number) -- Line: 514
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    if p174 % 1 ~= 0 then
        if p174 > -1048576 and p174 < 1048576 then
            local v175 = u4 + 5;

            if u3 < v175 then
                while u3 < v175 do
                    u3 = u3 * 2;
                end;

                local buffer_create_ret = buffer.create(u3);
                buffer.copy(buffer_create_ret, 0, u2, 0, u4);
                u1.Buffer = buffer_create_ret;
                u2 = buffer_create_ret;
            end;

            buffer.writeu8(u2, u4, 9);
            u4 = u4 + 1;
            buffer.writef32(u2, u4, p174);
            u4 = u4 + 4;

            return;
        end;

        local v176 = u4 + 9;

        if u3 < v176 then
            while u3 < v176 do
                u3 = u3 * 2;
            end;

            local buffer_create_ret = buffer.create(u3);
            buffer.copy(buffer_create_ret, 0, u2, 0, u4);
            u1.Buffer = buffer_create_ret;
            u2 = buffer_create_ret;
        end;

        buffer.writeu8(u2, u4, 10);
        u4 = u4 + 1;
        buffer.writef64(u2, u4, p174);
        u4 = u4 + 8;

        return;
    end;

    if p174 < 0 then
        if p174 > -256 then
            local v177 = u4 + 2;

            if u3 < v177 then
                while u3 < v177 do
                    u3 = u3 * 2;
                end;

                local buffer_create_ret = buffer.create(u3);
                buffer.copy(buffer_create_ret, 0, u2, 0, u4);
                u1.Buffer = buffer_create_ret;
                u2 = buffer_create_ret;
            end;

            buffer.writeu8(u2, u4, 1);
            u4 = u4 + 1;
            buffer.writeu8(u2, u4, -p174);
            u4 = u4 + 1;

            return;
        end;

        if p174 > -65536 then
            local v178 = u4 + 3;

            if u3 < v178 then
                while u3 < v178 do
                    u3 = u3 * 2;
                end;

                local buffer_create_ret = buffer.create(u3);
                buffer.copy(buffer_create_ret, 0, u2, 0, u4);
                u1.Buffer = buffer_create_ret;
                u2 = buffer_create_ret;
            end;

            buffer.writeu8(u2, u4, 2);
            u4 = u4 + 1;
            buffer.writeu16(u2, u4, -p174);
            u4 = u4 + 2;

            return;
        end;

        if p174 > -16777216 then
            local v179 = u4 + 4;

            if u3 < v179 then
                while u3 < v179 do
                    u3 = u3 * 2;
                end;

                local buffer_create_ret = buffer.create(u3);
                buffer.copy(buffer_create_ret, 0, u2, 0, u4);
                u1.Buffer = buffer_create_ret;
                u2 = buffer_create_ret;
            end;

            buffer.writeu8(u2, u4, 3);
            u4 = u4 + 1;
            buffer.writebits(u2, u4 * 8, 24, -p174);
            u4 = u4 + 3;

            return;
        end;

        if p174 > -4294967296 then
            local v180 = u4 + 5;

            if u3 < v180 then
                while u3 < v180 do
                    u3 = u3 * 2;
                end;

                local buffer_create_ret = buffer.create(u3);
                buffer.copy(buffer_create_ret, 0, u2, 0, u4);
                u1.Buffer = buffer_create_ret;
                u2 = buffer_create_ret;
            end;

            buffer.writeu8(u2, u4, 4);
            u4 = u4 + 1;
            buffer.writeu32(u2, u4, -p174);
            u4 = u4 + 4;

            return;
        end;

        local v181 = u4 + 9;

        if u3 < v181 then
            while u3 < v181 do
                u3 = u3 * 2;
            end;

            local buffer_create_ret = buffer.create(u3);
            buffer.copy(buffer_create_ret, 0, u2, 0, u4);
            u1.Buffer = buffer_create_ret;
            u2 = buffer_create_ret;
        end;

        buffer.writeu8(u2, u4, 10);
        u4 = u4 + 1;
        buffer.writef64(u2, u4, p174);
        u4 = u4 + 8;

        return;
    end;

    if p174 < 256 then
        local v182 = u4 + 2;

        if u3 < v182 then
            while u3 < v182 do
                u3 = u3 * 2;
            end;

            local buffer_create_ret = buffer.create(u3);
            buffer.copy(buffer_create_ret, 0, u2, 0, u4);
            u1.Buffer = buffer_create_ret;
            u2 = buffer_create_ret;
        end;

        buffer.writeu8(u2, u4, 5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, p174);
        u4 = u4 + 1;

        return;
    end;

    if p174 < 65536 then
        local v183 = u4 + 3;

        if u3 < v183 then
            while u3 < v183 do
                u3 = u3 * 2;
            end;

            local buffer_create_ret = buffer.create(u3);
            buffer.copy(buffer_create_ret, 0, u2, 0, u4);
            u1.Buffer = buffer_create_ret;
            u2 = buffer_create_ret;
        end;

        buffer.writeu8(u2, u4, 6);
        u4 = u4 + 1;
        buffer.writeu16(u2, u4, p174);
        u4 = u4 + 2;

        return;
    end;

    if p174 < 16777216 then
        local v184 = u4 + 4;

        if u3 < v184 then
            while u3 < v184 do
                u3 = u3 * 2;
            end;

            local buffer_create_ret = buffer.create(u3);
            buffer.copy(buffer_create_ret, 0, u2, 0, u4);
            u1.Buffer = buffer_create_ret;
            u2 = buffer_create_ret;
        end;

        buffer.writeu8(u2, u4, 7);
        u4 = u4 + 1;
        buffer.writebits(u2, u4 * 8, 24, p174);
        u4 = u4 + 3;

        return;
    end;

    if p174 < 4294967296 then
        local v185 = u4 + 5;

        if u3 < v185 then
            while u3 < v185 do
                u3 = u3 * 2;
            end;

            local buffer_create_ret = buffer.create(u3);
            buffer.copy(buffer_create_ret, 0, u2, 0, u4);
            u1.Buffer = buffer_create_ret;
            u2 = buffer_create_ret;
        end;

        buffer.writeu8(u2, u4, 8);
        u4 = u4 + 1;
        buffer.writeu32(u2, u4, p174);
        u4 = u4 + 4;

        return;
    end;

    local v186 = u4 + 9;

    if u3 < v186 then
        while u3 < v186 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 10);
    u4 = u4 + 1;
    buffer.writef64(u2, u4, p174);
    u4 = u4 + 8;
end;

u10[11] = function() -- Line: 548
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_readstring_ret = buffer.readstring(u2, u4, buffer_readu8_ret);
    u4 = u4 + buffer_readu8_ret;

    return buffer_readstring_ret;
end;

function u11.string(p187: string) -- Line: 549
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v188 = #p187;
    local v189 = u4 + (v188 + 2);

    if u3 < v189 then
        while u3 < v189 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 11);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v188);
    u4 = u4 + 1;
    buffer.writestring(u2, u4, p187);
    u4 = u4 + #p187;
end;

u10[12] = function() -- Line: 551
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_create_ret = buffer.create(buffer_readu8_ret);
    buffer.copy(buffer_create_ret, 0, u2, u4, buffer_readu8_ret);
    u4 = u4 + buffer_readu8_ret;

    return buffer_create_ret;
end;

function u11.buffer(p190: buffer) -- Line: 552
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local buffer_len_ret = buffer.len(p190);
    local v191 = u4 + (2 + buffer_len_ret);

    if u3 < v191 then
        while u3 < v191 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 12);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, buffer_len_ret);
    u4 = u4 + 1;
    buffer.copy(u2, u4, p190);
    u4 = u4 + buffer.len(p190);
end;

u10[13] = function() -- Line: 554
    -- upvalues: u6 (ref), u5 (ref)
    u6 = u6 + 1;

    return u5[u6];
end;

function u11.Instance(p192: userdata) -- Line: 555
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u6 (ref), u5 (ref)
    local v193 = u4 + 1;

    if u3 < v193 then
        while u3 < v193 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 13);
    u4 = u4 + 1;
    u6 = u6 + 1;
    u5[u6] = p192;
end;

u10[14] = function() -- Line: 557
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return buffer_readu8_ret == 1;
end;

function u11.boolean(p194: boolean) -- Line: 558
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v195 = u4 + 2;

    if u3 < v195 then
        while u3 < v195 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 14);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, p194 and 1 or 0);
    u4 = u4 + 1;
end;

u10[15] = function() -- Line: 560
    -- upvalues: u2 (ref), u4 (ref)
    local NumberRange_new = NumberRange.new;
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return NumberRange_new(buffer_readf32_ret, buffer_readf32_ret2);
end;

function u11.NumberRange(p196) -- Line: 561
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v197 = u4 + 9;

    if u3 < v197 then
        while u3 < v197 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 15);
    u4 = u4 + 1;
    buffer.writef32(u2, u4, p196.Min);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p196.Max);
    u4 = u4 + 4;
end;

u10[16] = function() -- Line: 563
    -- upvalues: u2 (ref), u4 (ref)
    local BrickColor_new = BrickColor.new;
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;

    return BrickColor_new(buffer_readu16_ret);
end;

function u11.BrickColor(p198: userdata) -- Line: 564
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v199 = u4 + 3;

    if u3 < v199 then
        while u3 < v199 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 16);
    u4 = u4 + 1;
    buffer.writeu16(u2, u4, p198.Number);
    u4 = u4 + 2;
end;

u10[17] = function() -- Line: 566
    -- upvalues: u2 (ref), u4 (ref)
    local Color3_fromRGB = Color3.fromRGB;
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_readu8_ret2 = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local buffer_readu8_ret3 = buffer.readu8(u2, u4);
    u4 = u4 + 1;

    return Color3_fromRGB(buffer_readu8_ret, buffer_readu8_ret2, buffer_readu8_ret3);
end;

function u11.Color3(p200) -- Line: 567
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v201 = u4 + 4;

    if u3 < v201 then
        while u3 < v201 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 17);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, p200.R * 255 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, p200.G * 255 + 0.5);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, p200.B * 255 + 0.5);
    u4 = u4 + 1;
end;

u10[18] = function() -- Line: 569
    -- upvalues: u2 (ref), u4 (ref)
    local UDim_new = UDim.new;
    local buffer_readi16_ret = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u2, u4);
    u4 = u4 + 2;

    return UDim_new(buffer_readi16_ret / 1000, buffer_readi16_ret2);
end;

function u11.UDim(p202) -- Line: 570
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v203 = u4 + 5;

    if u3 < v203 then
        while u3 < v203 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 18);
    u4 = u4 + 1;
    buffer.writei16(u2, u4, p202.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p202.Offset);
    u4 = u4 + 2;
end;

u10[19] = function() -- Line: 572
    -- upvalues: u2 (ref), u4 (ref)
    local UDim2_new = UDim2.new;
    local buffer_readi16_ret = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret2 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret3 = buffer.readi16(u2, u4);
    u4 = u4 + 2;
    local buffer_readi16_ret4 = buffer.readi16(u2, u4);
    u4 = u4 + 2;

    return UDim2_new(buffer_readi16_ret / 1000, buffer_readi16_ret2, buffer_readi16_ret3 / 1000, buffer_readi16_ret4);
end;

function u11.UDim2(p204) -- Line: 573
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v205 = u4 + 9;

    if u3 < v205 then
        while u3 < v205 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 19);
    u4 = u4 + 1;
    buffer.writei16(u2, u4, p204.X.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p204.X.Offset);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p204.Y.Scale * 1000);
    u4 = u4 + 2;
    buffer.writei16(u2, u4, p204.Y.Offset);
    u4 = u4 + 2;
end;

u10[20] = function() -- Line: 575
    -- upvalues: u2 (ref), u4 (ref)
    local Rect_new = Rect.new;
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret4 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return Rect_new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3, buffer_readf32_ret4);
end;

function u11.Rect(p206) -- Line: 576
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v207 = u4 + 17;

    if u3 < v207 then
        while u3 < v207 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 20);
    u4 = u4 + 1;
    buffer.writef32(u2, u4, p206.Min.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p206.Min.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p206.Max.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p206.Max.Y);
    u4 = u4 + 4;
end;

u10[21] = function() -- Line: 578
    -- upvalues: u2 (ref), u4 (ref)
    local Vector2_new = Vector2.new;
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return Vector2_new(buffer_readf32_ret, buffer_readf32_ret2);
end;

function u11.Vector2(p208) -- Line: 579
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v209 = u4 + 9;

    if u3 < v209 then
        while u3 < v209 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 21);
    u4 = u4 + 1;
    buffer.writef32(u2, u4, p208.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p208.Y);
    u4 = u4 + 4;
end;

u10[22] = function() -- Line: 581
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function u11.Vector3(p210: vector) -- Line: 582
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v211 = u4 + 13;

    if u3 < v211 then
        while u3 < v211 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 22);
    u4 = u4 + 1;
    buffer.writef32(u2, u4, p210.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p210.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p210.Z);
    u4 = u4 + 4;
end;

u10[23] = function() -- Line: 584
    -- upvalues: u2 (ref), u4 (ref)
    local CFrame_fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local buffer_readu16_ret2 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local buffer_readu16_ret3 = buffer.readu16(u2, u4);
    u4 = u4 + 2;
    local v212 = CFrame_fromEulerAnglesXYZ(buffer_readu16_ret / 10430.219195527361, buffer_readu16_ret2 / 10430.219195527361, buffer_readu16_ret3 / 10430.219195527361);
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return v212 + Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
end;

function u11.CFrame(p213) -- Line: 588
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v214, v215, v216 = p213:ToEulerAnglesXYZ();
    local v217 = u4 + 19;

    if u3 < v217 then
        while u3 < v217 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 23);
    u4 = u4 + 1;
    buffer.writeu16(u2, u4, v214 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writeu16(u2, u4, v215 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writeu16(u2, u4, v216 * 10430.219195527361 + 0.5);
    u4 = u4 + 2;
    buffer.writef32(u2, u4, p213.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p213.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, p213.Z);
    u4 = u4 + 4;
end;

u10[24] = function() -- Line: 596
    -- upvalues: u2 (ref), u4 (ref)
    local Region3_new = Region3.new;
    local buffer_readf32_ret = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret2 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret3 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local Vector3_new_ret = Vector3.new(buffer_readf32_ret, buffer_readf32_ret2, buffer_readf32_ret3);
    local buffer_readf32_ret4 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret5 = buffer.readf32(u2, u4);
    u4 = u4 + 4;
    local buffer_readf32_ret6 = buffer.readf32(u2, u4);
    u4 = u4 + 4;

    return Region3_new(Vector3_new_ret, (Vector3.new(buffer_readf32_ret4, buffer_readf32_ret5, buffer_readf32_ret6)));
end;

function u11.Region3(p218: userdata) -- Line: 602
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v219 = p218.Size / 2;
    local v220 = p218.CFrame.Position - v219;
    local v221 = p218.CFrame.Position + v219;
    local v222 = u4 + 25;

    if u3 < v222 then
        while u3 < v222 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 24);
    u4 = u4 + 1;
    buffer.writef32(u2, u4, v220.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v220.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v220.Z);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v221.X);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v221.Y);
    u4 = u4 + 4;
    buffer.writef32(u2, u4, v221.Z);
    u4 = u4 + 4;
end;

u10[25] = function() -- Line: 612
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local table_create_ret = table.create(buffer_readu8_ret);

    for i = 1, buffer_readu8_ret do
        local NumberSequenceKeypoint_new = NumberSequenceKeypoint.new;
        local buffer_readu8_ret2 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local buffer_readu8_ret3 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local buffer_readu8_ret4 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        table.insert(table_create_ret, NumberSequenceKeypoint_new(buffer_readu8_ret2 / 255, buffer_readu8_ret3 / 255, buffer_readu8_ret4 / 255));
        local _ = i;
    end;

    return NumberSequence.new(table_create_ret);
end;

function u11.NumberSequence(p223: userdata) -- Line: 620
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v224 = #p223.Keypoints;
    local v225 = u4 + (v224 * 3 + 2);

    if u3 < v225 then
        while u3 < v225 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 25);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v224);
    u4 = u4 + 1;

    for _, v in p223.Keypoints do
        buffer.writeu8(u2, u4, v.Time * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v.Value * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v.Envelope * 255 + 0.5);
        u4 = u4 + 1;
    end;
end;

u10[26] = function() -- Line: 630
    -- upvalues: u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local table_create_ret = table.create(buffer_readu8_ret);

    for i = 1, buffer_readu8_ret do
        local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
        local buffer_readu8_ret2 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local Color3_fromRGB = Color3.fromRGB;
        local buffer_readu8_ret3 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local buffer_readu8_ret4 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        local buffer_readu8_ret5 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        table.insert(table_create_ret, ColorSequenceKeypoint_new(buffer_readu8_ret2 / 255, Color3_fromRGB(buffer_readu8_ret3, buffer_readu8_ret4, buffer_readu8_ret5)));
        local _ = i;
    end;

    return ColorSequence.new(table_create_ret);
end;

function u11.ColorSequence(p226: userdata) -- Line: 638
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref)
    local v227 = #p226.Keypoints;
    local v228 = u4 + (v227 * 4 + 2);

    if u3 < v228 then
        while u3 < v228 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 26);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, v227);
    u4 = u4 + 1;

    for _, v in p226.Keypoints do
        buffer.writeu8(u2, u4, v.Time * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v.Value.R * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v.Value.G * 255 + 0.5);
        u4 = u4 + 1;
        buffer.writeu8(u2, u4, v.Value.B * 255 + 0.5);
        u4 = u4 + 1;
    end;
end;

u10[27] = function() -- Line: 649
    -- upvalues: script_Enums (copy), u2 (ref), u4 (ref)
    local buffer_readu8_ret = buffer.readu8(u2, u4);
    u4 = u4 + 1;
    local v229 = script_Enums[buffer_readu8_ret];
    local buffer_readu16_ret = buffer.readu16(u2, u4);
    u4 = u4 + 2;

    return v229:FromValue(buffer_readu16_ret);
end;

function u11.EnumItem(p230: userdata) -- Line: 652
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u159 (copy)
    local v231 = u4 + 4;

    if u3 < v231 then
        while u3 < v231 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 27);
    u4 = u4 + 1;
    buffer.writeu8(u2, u4, u159[p230.EnumType]);
    u4 = u4 + 1;
    buffer.writeu16(u2, u4, p230.Value);
    u4 = u4 + 2;
end;

u10[28] = function() -- Line: 659
    -- upvalues: u2 (ref), u4 (ref), u10 (copy)
    local v232 = {};

    while true do
        local buffer_readu8_ret = buffer.readu8(u2, u4);
        u4 = u4 + 1;

        if buffer_readu8_ret == 0 then
            break;
        end;

        local v233 = u10[buffer_readu8_ret]();
        local buffer_readu8_ret2 = buffer.readu8(u2, u4);
        u4 = u4 + 1;
        v232[v233] = u10[buffer_readu8_ret2]();
    end;

    return v232;
end;

function u11.table(p234: table) -- Line: 666
    -- upvalues: u4 (ref), u3 (ref), u2 (ref), u1 (ref), u11 (copy)
    local v235 = u4 + 1;

    if u3 < v235 then
        while u3 < v235 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 28);
    u4 = u4 + 1;

    for i, v in p234 do
        u11[typeof(i)](i);
        u11[typeof(v)](v);
    end;

    local v236 = u4 + 1;

    if u3 < v236 then
        while u3 < v236 do
            u3 = u3 * 2;
        end;

        local buffer_create_ret = buffer.create(u3);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);
        u1.Buffer = buffer_create_ret;
        u2 = buffer_create_ret;
    end;

    buffer.writeu8(u2, u4, 0);
    u4 = u4 + 1;
end;

return {
    Import = function(p237: table) -- Line: 676, Name: Import
        -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref)
        u1 = p237;
        u2 = p237.Buffer;
        u3 = p237.BufferLength;
        u4 = p237.BufferOffset;
        u5 = p237.Instances;
        u6 = p237.InstancesOffset;
    end,

    Export = function() -- Line: 685, Name: Export
        -- upvalues: u1 (ref), u3 (ref), u4 (ref), u6 (ref)
        u1.BufferLength = u3;
        u1.BufferOffset = u4;
        u1.InstancesOffset = u6;

        return u1;
    end,

    Truncate = function() -- Line: 692, Name: Truncate
        -- upvalues: u4 (ref), u2 (ref), u6 (ref), u5 (ref)
        local buffer_create_ret = buffer.create(u4);
        buffer.copy(buffer_create_ret, 0, u2, 0, u4);

        if u6 == 0 then
            return buffer_create_ret;
        end;

        return buffer_create_ret, u5;
    end,

    Ended = function() -- Line: 698, Name: Ended
        -- upvalues: u4 (ref), u3 (ref)
        return u3 <= u4;
    end,

    Types = v7,
    Reads = v8,
    Writes = v9
};