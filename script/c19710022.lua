-- Kamen Rider Nadeshiko
local s, id = GetID()
function s.initial_effect(c)
    -- xyz summon
    Xyz.AddProcedure(c, aux.FilterBoolFunctionEx(Card.IsAttribute,ATTRIBUTE_LIGHT), 2, 2)
    c:EnableReviveLimit()
    -- Attach XYZ
    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id,1))
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_BATTLE_DESTROYING)
    e1:SetCondition(s.condition)
    e1:SetTarget(s.target)
    e1:SetOperation(s.operation)
    c:RegisterEffect(e1)

	local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e4:SetRange(LOCATION_MZONE)
    e4:SetCode(EFFECT_SEND_REPLACE)
    e4:SetTarget(s.reptg)
    c:RegisterEffect(e4)
  
    --atk/def
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
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
function s.condition(e, tp, eg, ep, ev, re, r, rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if not c:IsRelateToBattle() or c:IsFacedown() then return false end
	e:SetLabelObject(tc)
	return tc:IsLocation(LOCATION_GRAVE) and tc:IsMonster() and tc:IsReason(REASON_BATTLE)
end

function s.target(e, tp, eg, ep, ev, re, r, rp, chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ) end
	local tc=e:GetLabelObject()
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,tc,1,0,0)
end

function s.operation(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	local tc = Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Overlay(c,tc)
	end
end

function s.xyzfilter(c,oc,tp)
    return c:IsFaceup() and c:IsType(TYPE_XYZ) and oc:IsCanBeXyzMaterial(c,tp,REASON_EFFECT)
end
function s.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then return r&(REASON_REPLACE|REASON_REDIRECT)==0
        and c:GetDestination()&(LOCATION_ONFIELD|LOCATION_FZONE|LOCATION_PZONE)==0
        and Duel.IsExistingMatchingCard(s.xyzfilter,tp,LOCATION_MZONE,0,1,c,c,tp)
    end
    if not Duel.SelectYesNo(tp,aux.Stringid(id,0)) then return false end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
    local xc=Duel.SelectMatchingCard(tp,s.xyzfilter,tp,LOCATION_MZONE,0,1,1,c,c,tp):GetFirst()
    if not xc then return false end
    Duel.Overlay(xc,c)
    return true
end