-- Kamen Rider Sabaki
local s, id = GetID()
function s.initial_effect(c)

    c:EnableReviveLimit()

    -- Type Warrior
    local e0 = Effect.CreateEffect(c)
    e0:SetType(EFFECT_TYPE_SINGLE)
    e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e0:SetCode(EFFECT_ADD_RACE)
    e0:SetRange(LOCATION_MZONE)
    e0:SetValue(RACE_WARRIOR)
    c:RegisterEffect(e0)

    -- ATK Bonus 
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetCondition(s.atk_condtion)
    e1:SetValue(600)
    c:RegisterEffect(e1)

    --Destroy Spell/Trap
    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(id, 0))
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_BATTLE_DESTROYING)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetCondition(s.condition)
    e2:SetTarget(s.target)
    e2:SetOperation(s.activate)
    c:RegisterEffect(e2)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function s.filter(c)
  return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsOnField() and s.filter(chkc) and chkc~=e:GetHandler() end
  if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
  local g=Duel.SelectTarget(tp,s.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
  Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc and tc:IsRelateToEffect(e) then
      Duel.Destroy(tc,REASON_EFFECT)
  end
end
function s.atk_condtion(e)
    local ph = Duel.GetCurrentPhase()
    if not (ph == PHASE_DAMAGE or ph == PHASE_DAMAGE_CAL) then
        return false
    end
    local a = Duel.GetAttacker()
    local d = Duel.GetAttackTarget()
    return
        (a == e:GetHandler() and d and d:IsFaceup() and (d:IsLevelAbove(8) or d:IsRankAbove(5) or d:IsLinkAbove(3))) or
            (d == e:GetHandler() and (a:IsLevelAbove(8) or a:IsRankAbove(5) or a:IsLinkAbove(3)))
end
