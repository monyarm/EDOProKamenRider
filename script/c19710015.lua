-- Let's Ride
local s, id = GetID()
function s.initial_effect(c)
  -- activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    --extra summon
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(id,0))
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetRange(LOCATION_SZONE)
    e2:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,0)
    e2:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
    e2:SetTarget(aux.TargetBoolFunction(s.filter))
    c:RegisterEffect(e2)
    --
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetRange(LOCATION_SZONE)
    e3:SetTargetRange(LOCATION_MZONE,0)
    e3:SetCode(EFFECT_UPDATE_ATTACK)
    e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xa008))
    e3:SetValue(200)
    c:RegisterEffect(e3)
end

s.listed_series = {0x619,0x620,0x621,0x622,0xa008}

function s.filter(c) 
  return c:IsSetCard(0x619) or c:IsSetCard(0x620) or c:IsSetCard(0x621) or c:IsSetCard(0x622)
end 