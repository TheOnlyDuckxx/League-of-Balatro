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

SMODS.Joker{
  key = "jhin",

  rarity = 2,
  cost = 4,

  unlocked = true,
  discovered = true,

  config = { extra = { Xmult = 2, every = 4, hand_played = 0 } },

  loc_vars = function(self, info_queue, card)
    local every = card.ability.extra.every
    local played = card.ability.extra.hand_played
    local remaining = every - (played % every)
    if remaining == every then remaining = 4 end  -- si tu veux afficher 0 quand ça proc
    return { vars = { card.ability.extra.Xmult, every, remaining } }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      card.ability.extra.hand_played = card.ability.extra.hand_played + 1

      if card.ability.extra.hand_played >= 4 then
        card.ability.extra.hand_played = 0
        return {
          Xmult_mod = card.ability.extra.Xmult,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
        }
      end
    end
  end,
}