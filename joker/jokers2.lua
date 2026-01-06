SMODS.Joker{
    key = "ryze",
    rarity = 1,
    cost = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    -- Description et bulle Splash
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = 'Joker', key = 'j_splash', config={}}
    end,
    
    calculate = function(self, card, context)
        if context.modify_scoring_hand and not context.blueprint then
            return {
                add_to_hand = true
            }
        end
    end

}