LOB = LOB or {}
LOB.MAX_LEVEL = 4

-- Retourne la "center key" du joker (ex: "j_lob_cool_blud_1")
function LOB.center_key(card)
  return card and card.config and card.config.center and card.config.center.key
end

function LOB.is_lob_joker(card)
  local k = LOB.center_key(card)
  return type(k) == "string" and k:find("^j_lob_") ~= nil
end

-- Si le joker a un prochain niveau
function LOB.next_key(card)
  local e = card and card.ability and card.ability.extra
  if not e then return nil end
  return e.next
end

-- Upgrade (transformation)
function LOB.upgrade(card)
  local nextk = LOB.next_key(card)
  if not nextk then return false end
  card:set_ability(nextk, nil, true) -- fonctionne aussi sur les jokers (set_ability prend une key string)
  card:juice_up(0.6, 0.6)
  return true
end

-- Donne 1 carte Spectrale Ascension si possible
function LOB.give_ascension()
  if not (G and G.consumeables and G.consumeables.cards and G.consumeables.config) then return end
  if #G.consumeables.cards >= G.consumeables.config.card_limit then
    return
  end

  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.2,
    func = function()
      local c = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_lob_ascension')
      c:add_to_deck()
      G.consumeables:emplace(c)
      return true
    end
  }))
end