--Kamen Rider Hibiki
local s,id=GetID()
function s.initial_effect(c)

	c:EnableReviveLimit()

--Type Warrior
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetCode(EFFECT_ADD_RACE)
	e0:SetRange(LOCATION_MZONE)
	e0:SetValue(RACE_WARRIOR)
	c:RegisterEffect(e0)

--ATK Bonus
local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetCondition(s.condtion)
    e1:SetValue(1300)
    c:RegisterEffect(e1)
end
function s.condtion(e)
    local ph=Duel.GetCurrentPhase()
    if not (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) then return false end
    local a=Duel.GetAttacker()
    local d=Duel.GetAttackTarget()
    return (a==e:GetHandler() and d and d:IsFaceup() and (d:IsLevelAbove(8) or d:IsRankAbove(5) or d:IsLinkAbove(3)))
        or (d==e:GetHandler() and  (a:IsLevelAbove(8) or a:IsRankAbove(5) or a:IsLinkAbove(3)))
end