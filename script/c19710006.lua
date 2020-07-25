-- Kamen Rider Kiva
local s, id = GetID()
function s.initial_effect(c)
  -- effects
  
	--Type Warrior
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetCode(EFFECT_ADD_RACE)
	e0:SetRange(LOCATION_ALL)
	e0:SetValue(RACE_WARRIOR)
  c:RegisterEffect(e0)

  --pierce
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_SINGLE)
  e1:SetCode(EFFECT_PIERCE)
  c:RegisterEffect(e1)

  --recover
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
  e2:SetCategory(CATEGORY_RECOVER)
  e2:SetDescription(aux.Stringid(id,0))
  e2:SetCode(EVENT_BATTLE_DAMAGE)
  e2:SetRange(LOCATION_MZONE)
  e2:SetTarget(s.rectg)
  e2:SetOperation(s.recop)
  c:RegisterEffect(e2)

end

function s.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
  if chk==0 then return true end
  Duel.SetTargetPlayer(tp)
  Duel.SetTargetParam(ev/2)
  Duel.SetOperationInfo(0,CATEGORY_RECOVER,0,0,tp,ev)
end
function s.recop(e,tp,eg,ep,ev,re,r,rp)
  local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
  Duel.Recover(p,d,REASON_EFFECT)
end
