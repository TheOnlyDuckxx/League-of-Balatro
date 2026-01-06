LOB = LOB or {}

-- évite de hook 2 fois si reload / ordre bizarre
if not LOB.__hooked_blind_defeat then
  LOB.__hooked_blind_defeat = true

  local _old_defeat = Blind.defeat

  Blind.defeat = function(self, ...)
    -- snapshot AVANT l'appel original (clé disponible ici)
    local bd = self and self.config and self.config.blind
    local blind_key = (type(bd) == "table") and bd.key or nil

    local is_small_big = (blind_key == "bl_small" or blind_key == "bl_big")

    -- appel vanilla
    local ret = _old_defeat(self, ...)

    -- récompense après la victoire
    if is_small_big then
      LOB.give_ascension()
    end

    return ret
  end
end
