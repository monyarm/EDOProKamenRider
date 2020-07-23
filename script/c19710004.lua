-- Ongeki Henshin
local s,id=GetID()
function s.initial_effect(c)
    Ritual.AddProcEqual(c,s.ritual_filter)
end
s.listed_series={0x1971}
function s.ritual_filter(c)
    return c:IsSetCard(0x1971) and c:IsRitualMonster()
end