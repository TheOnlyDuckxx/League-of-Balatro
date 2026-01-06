local function make_cool(level, chips, mult, next_key)
  SMODS.Joker{
    key = "cool_blud_"..level,

    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,

    config = { extra = { level = level, chips = chips, mult = mult, next = next_key } },

    -- seul le niveau 1 peut spawn en shop
    in_pool = function(self, args)
      return level == 1
    end,

    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.level, card.ability.extra.chips, card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
      -- hook reward blind (small/big)
      if context.joker_main then
        return {
          chips = card.ability.extra.chips,
          mult = card.ability.extra.mult,
        }
      end
    end,
  }
end

make_cool(1, 50, 50, "j_lob_cool_blud_2")
make_cool(2, 80, 80, "j_lob_cool_blud_3")
make_cool(3, 120, 120, "j_lob_cool_blud_4")
make_cool(4, 200, 200, nil)


local function make_jhin(level, xmult, every, next_key)
  SMODS.Joker{
    key = "jhin_"..level,

    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,

    config = { extra = { level = level, xmult = xmult, every = every, hand_played = 0, next = next_key } },

    in_pool = function(self, args)
      return level == 1
    end,

    loc_vars = function(self, info_queue, card)
      local e = card.ability.extra.every
      local played = card.ability.extra.hand_played
      local remaining = e - (played % e)
      if remaining == e then remaining = 0 end
      return { vars = { card.ability.extra.level, card.ability.extra.xmult, e, remaining } }
    end,

    calculate = function(self, card, context)
      if context.joker_main then
        card.ability.extra.hand_played = card.ability.extra.hand_played + 1

        if (card.ability.extra.hand_played % card.ability.extra.every) == 0 then
          return {
            xmult = card.ability.extra.xmult,
            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
          }
        end
      end
    end,
  }
end

make_jhin(1, 2.0, 4, "j_lob_jhin_2")
make_jhin(2, 2.25, 4, "j_lob_jhin_3")
make_jhin(3, 2.5, 4, "j_lob_jhin_4")
make_jhin(4, 3.0, 4, nil)
