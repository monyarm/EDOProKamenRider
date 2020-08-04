-- Ongeki Henshin
local s,id=GetID()
function s.initial_effect(c)
    Ritual.AddProcGreater(c, filter)(c,s.ritual_filter)
end
s.listed_series={0x619}
function s.ritual_filter(c)
    return c:IsSetCard(0x619) and c:IsRitualMonster()
end