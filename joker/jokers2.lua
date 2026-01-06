SMODS.Joker{
    key = "ryze",
    

    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = true,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    effect = "splash",

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = { set = 'Joker', key = 'j_splash', config={}}
    end
}