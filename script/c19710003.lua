--Kamen Rider Super-1
local s,id=GetID()
function s.initial_effect(c)

--Type Warrior
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetCode(EFFECT_ADD_RACE)
	e0:SetRange(LOCATION_MZONE)
	e0:SetValue(RACE_WARRIOR)
	c:RegisterEffect(e0)


	
end
