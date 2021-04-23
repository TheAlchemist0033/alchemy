local slowheal = slowheal or {}
alchemy = {players = {}}
local time = 0
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

minetest.register_globalstep(function(dtime)
    time = time + dtime
    if time >= 3 then
        if slowheal[1]~=nil then
            player = minetest.get_player_by_name(slowheal[1])
            if slowheal[2]==1 then
                player:set_hp(player:get_hp()+1)
            end
        end
        time = 0
    end
end)
minetest.register_on_joinplayer(function(player)
    phys = player:get_physics_override()
    alchemy.players[player:get_player_name()] = {
        speed = 0, default_speed = phys.speed, jump = 0, default_jump = phys.jump, gravity = 0, default_gravity = phys.gravity
    }
end)


minetest.register_craftitem(
        "alchemy:breath_potion",
        {
            description = "Waterbreathing Potion I",
            inventory_image = "alchemy_base_potion.png^[colorize:#0429A5:100",
            on_use = function(itemstack, player, pointed_thing)
                player:set_properties(
                        {
                            breath_max = 1000
                        }
                )
                player:set_breath(1000)
                minetest.after(
                        60,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "Effects worn off for Waterbreathing I")
                            player:set_properties({breath_max = minetest.PLAYER_MAX_BREATH_DEFAULT})
                            player:set_breath(10)
                        end
                )
                minetest.after(
                        50,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of Waterbreathing I ")
                        end
                )
                itemstack:take_item()
                return itemstack
            end
        }

)
minetest.register_craftitem(
        "alchemy:fortitude_potion",
        {
            description = "Fortitude Potion I",
            inventory_image = "alchemy_base_potion.png^[colorize:#940000:100",
            on_use = function(itemstack, player, pointed_thing)
                player:set_properties(
                        {
                            hp_max = minetest.PLAYER_MAX_HP_DEFAULT * 2
                        }
                )
                player:set_hp(minetest.PLAYER_MAX_HP_DEFAULT * 2)
                minetest.after(
                        60,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "Effects worn off for Fortitude I")
                            player:set_properties({hp_max = minetest.PLAYER_MAX_HP_DEFAULT})
                            player:set_hp(10)
                        end
                )
                minetest.after(
                        50,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of Fortitude I")
                        end
                )
                itemstack:take_item()
                return itemstack
            end
        }
)
minetest.register_craftitem(
        "alchemy:invisibility_potion",
        {
            description = "invisibility potion I",
            inventory_image = "alchemy_base_potion.png^[colorize:#708F9F:100",
            on_use = function(itemstack, player, pointed_thing)
                prop =
                player:set_properties(
                        {
                            visual_size = {x = 0, y = 0},
                            is_visible = false
                        }
                )
                player:set_nametag_attributes(
                        {
                            color = {a = 0, r = 255, g = 255, b = 255}
                        }
                )
                minetest.after(
                        60,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "Effects worn off for Invisibility I")
                            player:set_properties(
                                    {
                                        visual_size = {x = 1, y = 1},
                                        is_visible = true
                                    }
                            )
                            player:set_nametag_attributes(
                                    {
                                        color = {a = 255, r = 255, g = 255, b = 255}
                                    }
                            )
                        end
                )
                minetest.after(
                        50,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of Invisibility I")
                        end
                )
                itemstack:take_item()
                return itemstack
            end
        }
)
minetest.register_craftitem(
        "alchemy:slow_healing_potion",
        {
            description = "slow healing potion I",
            inventory_image = "alchemy_base_potion.png^[colorize:#C91060:100",
            on_use= function(itemstack, player, pointed_thing)
                slowheal = {player:get_player_name(),1}
                print(slowheal)
                minetest.after(
                        60,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "Effects worn off for Slowhealing I")
                            slowheal = {player:get_player_name(),0}
                        end
                )
                minetest.after(
                        50,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of Slowhealing I ")
                        end
                )
                itemstack:take_item()
                return itemstack
            end
        }
)
minetest.register_craftitem(
        "alchemy:leaping_potion",
        {
            description = "Leaping Potion I",
            inventory_image = "alchemy_base_potion.png^[colorize:#7FFF00:100",
            on_use = function(itemstack, player, pointed_thing)
                physics = player:get_physics_override()
                if alchemy.players[player:get_player_name()].jump == 0 then
                    alchemy.players[player:get_player_name()].jump = player_monoids.jump:add_change(player, physics.jump*2)
                    minetest.after(
                            60,
                            function()
                                minetest.chat_send_player(player:get_player_name(), "Effects worn off for Leaping I")
                                player_monoids.jump:del_change(player, alchemy.players[player:get_player_name()].jump)
                                alchemy.players[player:get_player_name()].jump = 0
                            end
                    )
                    minetest.after(
                            50,
                            function()
                                minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of Leaping I")
                            end
                    )
                    itemstack:take_item()
                    return itemstack
                end

            end
        }
)
minetest.register_craftitem(
        "alchemy:lunar_potion",
        {
            description = "Lunar Potion I",
            inventory_image = "alchemy_base_potion.png^[colorize:#76b5c5:100",
            on_use = function(itemstack, player, pointed_thing)
                physics = player:get_physics_override()
                if alchemy.players[player:get_player_name()].gravity == 0 then
                    alchemy.players[player:get_player_name()].gravity = player_monoids.gravity:add_change(player, physics.gravity/2)
                    minetest.after(
                            60,
                            function()
                                minetest.chat_send_player(player:get_player_name(), "Effects worn off for Lunar I")
                                player_monoids.gravity:del_change(player, alchemy.players[player:get_player_name()].gravity)
                                alchemy.players[player:get_player_name()].gravity = 0
                            end
                    )
                    minetest.after(
                            50,
                            function()
                                minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of Lunar I")
                            end
                    )
                    itemstack:take_item()
                    return itemstack
                end

            end
        }
)
minetest.register_craftitem(
        "alchemy:speed_potion",
        {
            description = "Speed Potion I",
            inventory_image = "alchemy_base_potion.png^[colorize:#eae583:100",
            on_use = function(itemstack, player, pointed_thing)
                breathIsActive = 1
                firstrun = 0
                physics = player:get_physics_override()
                if alchemy.players[player:get_player_name()].speed == 0 then
                    alchemy.players[player:get_player_name()].speed = player_monoids.speed:add_change(player, physics.speed*2)
                    minetest.after(
                            60,
                            function()
                                minetest.chat_send_player(player:get_player_name(), "Effects worn off for Speed I")
                                player_monoids.speed:del_change(player, alchemy.players[player:get_player_name()].speed)
                                alchemy.players[player:get_player_name()].speed = 0
                            end
                    )
                    minetest.after(
                            50,
                            function()
                                minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of Speed I")
                            end
                    )
                    itemstack:take_item()
                    return itemstack
                end

            end
        }
)
minetest.register_craftitem(
        "alchemy:nightvision_potion",
        {
            description = "Nightvision I",
            inventory_image = "alchemy_base_potion.png^[colorize:#00720d:100",
            on_use = function(itemstack, player, pointed_thing)
                player:override_day_night_ratio(1)
                minetest.after(
                        60,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "Effects worn off for Nightvision I")
                            player:override_day_night_ratio(nil)
                        end
                )
                minetest.after(
                        50,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of nightvision I")
                        end
                )
                itemstack:take_item()
                return itemstack
            end
        }
)
dofile(path .. 'items.lua')
dofile(path .. 'mobs.lua')
dofile(path .. 'earth_monster.lua')
dofile(path .. 'recipes.lua')
dofile(path .. 'throwpotion.lua')
minetest.register_on_leaveplayer(function(player)
    alchemy.players[player:get_player_name()] = nil
end)
