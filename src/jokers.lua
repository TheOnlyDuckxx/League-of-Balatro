SMODS.Joker{
  key="cool_blud",

  rarity = 1,
  cost = 4,

  unlocked = true,
  discovered = true,

  config = { extra = { chips = 50, mult = 50 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        -- Petit truc a revoir : afficher 2 message a la suite (actuellment y'a que le chips)
        message = localize { type='variable', key='a_chips', vars={card.ability.extra.chips} },
        mult_mod = card.ability.extra.mult,
        message = localize { type='variable', key='a_mult', vars={card.ability.extra.mult} }
      }
    end
  end,
}
