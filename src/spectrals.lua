SMODS.Consumable{
  set = "Spectral",
  key = "ascension",

  cost = 0,
  unlocked = true,
  discovered = true,

  loc_txt = {
    name = "Ascension",
    text = {
      "Améliore {C:attention}aléatoirement{}",
      "un Joker {C:attention}League of Balatro{}",
      "{C:inactive}(Niveau max 4){}"
    }
  },

  can_use = function(self, card)
    if not (G and G.jokers and G.jokers.cards) then return false end
    for _, j in ipairs(G.jokers.cards) do
      if LOB.is_lob_joker(j) and LOB.next_key(j) then
        return true
      end
    end
    return false
  end,

  use = function(self, card, area, copier)
    local pool = {}
    for _, j in ipairs(G.jokers.cards) do
      if LOB.is_lob_joker(j) and LOB.next_key(j) then
        pool[#pool+1] = j
      end
    end
    if #pool == 0 then return end

    local chosen = pseudorandom_element(pool, 'lob_ascension_pick')
    if chosen then
      LOB.upgrade(chosen)
    end
  end
}
