-- Kamen Rider
local s, id = GetID()
function s.initial_effect(c)
  -- effects

	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_ALL)
	e1:SetValue(0xa008c008)
	c:RegisterEffect(e1)
end
