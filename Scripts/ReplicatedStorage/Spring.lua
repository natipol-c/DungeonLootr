--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Spring
  Path:     game.ReplicatedStorage.Modules.Spring
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:38 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    _type = "Spring"
};

function u1.new(p2: any, p3: number?, p4: number?, p5: function?) -- Line: 117
    -- upvalues: u1 (copy)
    local v6 = p5 or os.clock;
    local v7 = {
        _clock = v6,
        _time = v6(),
        _position = p2,
        _velocity = p2 * 0,
        _target = p2,
        _damping = p3 or 1,
        _speed = p4 or 1,
        _initial = p2
    };

    return setmetatable(v7, u1);
end;

function u1.Reset(p8, p9) -- Line: 144
    local v10 = p8._clock();
    local v11 = p9 or p8._initial;
    p8._position = v11;
    p8._target = v11;
    p8._velocity = 0 * v11;
    p8._time = v10;
end;

function u1.Impulse(p12, p13) -- Line: 162
    p12.Velocity = p12.Velocity + p13;
end;

local function _positionVelocity(p14: any, p15: number) -- Line: 168
    local _position = p14._position;
    local _velocity = p14._velocity;
    local _target = p14._target;
    local _damping = p14._damping;
    local _speed = p14._speed;
    local v16 = _speed * (p15 - p14._time);
    local v17 = _damping * _damping;
    local v18, v19, v20;

    if v17 < 1 then
        v18 = math.sqrt(1 - v17);
        local v21 = math.exp(-_damping * v16) / v18;
        v19 = v21 * math.cos(v18 * v16);
        v20 = v21 * math.sin(v18 * v16);
    elseif v17 == 1 then
        v18 = 1;
        v19 = math.exp(-_damping * v16) / v18;
        v20 = v19 * v16;
    else
        v18 = math.sqrt(v17 - 1);
        local v22 = 2 * v18;
        local v23 = math.exp((-_damping + v18) * v16) / v22;
        local v24 = math.exp((-_damping - v18) * v16) / v22;
        v19 = v23 + v24;
        v20 = v23 - v24;
    end;

    local v25 = _target - _position;

    return _position + v25 * (1 - (v18 * v19 + _damping * v20)) + _velocity * (v20 / _speed), v25 * (_speed * v20) + _velocity * (v18 * v19 - _damping * v20);
end;

function u1.TimeSkip(p26: any, p27: number) -- Line: 221
    -- upvalues: _positionVelocity (copy)
    local v28 = p26._clock();
    local v29, v30 = _positionVelocity(p26, v28 + p27);
    p26._position = v29;
    p26._velocity = v30;
    p26._time = v28;
end;

function u1.__index(p31, p32) -- Line: 232
    -- upvalues: u1 (copy), _positionVelocity (copy)
    if u1[p32] then
        return u1[p32];
    end;

    if p32 == "Position" or p32 == "p" then
        local v33, _ = _positionVelocity(p31, p31._clock());

        return v33;
    end;

    if p32 == "Velocity" or p32 == "v" then
        local _, v34 = _positionVelocity(p31, p31._clock());

        return v34;
    end;

    if p32 == "Target" or p32 == "t" then
        return p31._target;
    end;

    if p32 == "Damping" or p32 == "d" then
        return p31._damping;
    end;

    if p32 == "Speed" or p32 == "s" then
        return p31._speed;
    end;

    if p32 == "Clock" then
        return p31._clock;
    end;

    error(string.format("%q is not a valid member of Spring.", (tostring(p32))), 2);
end;

function u1.__newindex(p35, p36, p37) -- Line: 253
    -- upvalues: _positionVelocity (copy)
    local v38 = p35._clock();

    if p36 == "Position" or p36 == "p" then
        local _, v39 = _positionVelocity(p35, v38);
        p35._position = p37;
        p35._velocity = v39;
        p35._time = v38;

        return;
    end;

    if p36 == "Velocity" or p36 == "v" then
        local v40, _ = _positionVelocity(p35, v38);
        p35._position = v40;
        p35._velocity = p37;
        p35._time = v38;

        return;
    end;

    if p36 == "Target" or p36 == "t" then
        local v41, v42 = _positionVelocity(p35, v38);
        p35._position = v41;
        p35._velocity = v42;
        p35._target = p37;
        p35._time = v38;

        return;
    end;

    if p36 == "Damping" or p36 == "d" then
        local v43, v44 = _positionVelocity(p35, v38);
        p35._position = v43;
        p35._velocity = v44;
        p35._damping = p37;
        p35._time = v38;

        return;
    end;

    if p36 == "Speed" or p36 == "s" then
        local v45, v46 = _positionVelocity(p35, v38);
        p35._position = v45;
        p35._velocity = v46;
        p35._speed = p37 < 0 and 0 or p37;
        p35._time = v38;

        return;
    end;

    if p36 ~= "Clock" then
        error(string.format("%q is not a valid member of Spring.", (tostring(p36))), 2);

        return;
    end;

    local v47, v48 = _positionVelocity(p35, v38);
    p35._position = v47;
    p35._velocity = v48;
    p35._clock = p37;
    p35._time = p37();
end;

return u1;