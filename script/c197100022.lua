--Kamen Rider Wizard
local s,id=GetID()
function s.initial_effect(c)

	--pendulum summon
	Pendulum.AddProcedure(c)

	--Type Warrior
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetCode(EFFECT_ADD_RACE)
	e0:SetRange(LOCATION_ALL)
	e0:SetValue(RACE_WARRIOR)
	c:RegisterEffect(e0)

	--Atk Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(s.value)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(s.efilter)
	c:RegisterEffect(e2)
	
end
function s.efilter(e,c)

	return c:IsRace(RACE_SPELLCASTER)

end


function s.value(e,c)

	return Duel.GetMatchingGroupCount(Card.IsType,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,nil,TYPE_SPELL)*100

end