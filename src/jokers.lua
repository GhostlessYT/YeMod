---@diagnostic disable: undefined-global

--the college dropout
SMODS.Joker {
    key = "dropout",
    atlas = 'yatlas',
    pos = { x = 0, y = 1 },
    rarity = 2,
    blueprint_compat = true,
    cost = 5,
    config = { extra = { xmult = 3, dropout_broke = 8 }, },
    loc_vars = function(self, info_queue, card)
       --establish the sell cost
        local sell_cost = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            -- if the joker is a joker in the card space and isnt empty add it to the sell cost,  i think thats what this does.
            sell_cost = sell_cost + joker.sell_cost
        end
        return { vars = { card.ability.extra.xmult, card.ability.extra.dropout_broke, sell_cost} }
    end,
    pools = {
        ["Kanye_Joker"] = true,
    },
    calculate = function(self, card, context)
        --if the joker exists, add it to the sell cost 
        if context.joker_main then
            local sell_cost = 0
            for _, joker in ipairs(G.jokers.cards) do
                sell_cost = sell_cost + joker.sell_cost
            end
            --if the sell cost is less than 8, add the xmult.
            if sell_cost < card.ability.extra.dropout_broke then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

--late registration
SMODS.Joker {
    key = "lr",
    atlas = 'yatlas',
    pos = { x = 0, y = 2 },
    rarity = 3,
    --DOESNT WORK WITH BLUEPRINT IDK WHY
    blueprint_compat = false,
    cost = 8,
    config = { extra = { xmult = 1.5, scored_suits = {} } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    pools = {
        ["Kanye_Joker"] = true,
    },    
    calculate = function(self, card, context)
-- thanks to th30ne on the balatro discord for this code. I dont understand it much though.
        if context.before and context.main_eval then
            card.ability.extra.scored_suits = {}
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.suit 
            and not card.ability.extra.scored_suits[context.other_card.base.suit] 
            then 
                card.ability.extra.scored_suits[context.other_card.base.suit] = true 
                return {
                    x_mult = card.ability.extra.xmult
                }
            end
        end
    end
}

-- Graduation
SMODS.Joker {
    key = "graduation",
    atlas = 'yatlas',
    pos = { x = 0, y = 0 },
    rarity = 2,
    blueprint_compat = true,
    cost = 4,
    config = { extra = { mult = 20 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    pools = {
        ["Kanye_Joker"] = true,
    },   
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- kanye west
SMODS.Joker {
    key = "Kanye",
    atlas = 'yatlas',
    pos = { x = 0, y = 3 },
    rarity = 4,
    blueprint_compat = true,
    cost = 20,
    config = { extra = { xmult = 2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
      -- if the current scoring joker exists, and it has a pool, and the pool is that of kanye pool. then add the xmult.
        if context.other_joker and context.other_joker.config.center.pools and context.other_joker.config.center.pools.Kanye_Joker then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}