-- Kamen Rider Kuuga
local s, id = GetID()
function s.initial_effect(c)
    -- effects
    -- attribute
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_ALL)
    e1:SetCode(EFFECT_ADD_ATTRIBUTE)
    e1:SetValue(ATTRIBUTE_LIGHT)
    c:RegisterEffect(e1)
    -- race
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetRange(LOCATION_ALL)
    e2:SetCode(EFFECT_ADD_RACE)
    e2:SetValue(RACE_WARRIOR)
    c:RegisterEffect(e2)
    -- atkup
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetCode(EFFECT_UPDATE_ATTACK)
    e3:SetRange(LOCATION_MZONE)
    e3:SetValue(s.val)
    c:RegisterEffect(e3)
end

function s.val(e, c)
    return Duel.GetFieldGroupCount(1 - c:GetControler(), LOCATION_MZONE, 0) * 200
end
