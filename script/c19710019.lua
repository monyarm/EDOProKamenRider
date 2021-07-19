-- Kamen Rider Fourze
local s, id = GetID()
function s.initial_effect(c)
    -- xyz summon
    Xyz.AddProcedure(c, nil, 4, 2)
    c:EnableReviveLimit()
    -- Attach XYZ
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_BATTLE_DESTROYING)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCondition(s.condition)
    e1:SetTarget(s.target)
    e1:SetOperation(s.operation)
    c:RegisterEffect(e1)
    -- Attach from hand
    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(id, 0))
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE+LOCATION_HAND)
    e2:SetCountLimit(1)
    e2:SetTarget(s.target_hand)
    e2:SetOperation(s.operation_hand)
    c:RegisterEffect(e2)

    --atk/def
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetCode(EFFECT_UPDATE_ATTACK)
    e3:SetRange(LOCATION_MZONE)
    e3:SetValue(s.atkval)
    c:RegisterEffect(e3)
end
function s.atkval(e,c)
  return c:GetOverlayCount()*200
end
s.listed_series = {0xa008, 0x622}
function s.filter(c)
	return ( c:IsSetCard(0xa008) or c:IsSetCard(0x622) )and c:IsType(TYPE_MONSTER)
end
function s.target_hand(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ) 
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
end
function s.operation_hand(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	if #g>0 then
		Duel.Overlay(c,g)
	end
end
function s.condition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function s.target(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end

function s.operation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local tc = Duel.GetFirstTarget()
    if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
        local og = tc:GetOverlayGroup()
        if #og > 0 then
            Duel.SendtoGrave(og, REASON_RULE)
        end
        Duel.Overlay(c, Group.FromCards(tc))
    end
end
