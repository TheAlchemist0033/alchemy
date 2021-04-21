local slowheal = slowheal or {}
alchemy = {players = {}}
local time = 0
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
                            player:set_properties({breath_max = minetest.PLAYER_MAX_BREATH_DEFAULT})
                            player:set_breath(10)
                        end
                )
                minetest.after(
                        50,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of waterbreathing I ")
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
                            player:set_properties({hp_max = minetest.PLAYER_MAX_HP_DEFAULT})
                            player:set_hp(10)
                        end
                )
                minetest.after(
                        50,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of fortitude I")
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
                            minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of invisibility I")
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
                            slowheal = {player:get_player_name(),0}
                        end
                )
                minetest.after(
                        50,
                        function()
                            minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of slowhealing I ")
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
                                player_monoids.jump:del_change(player, alchemy.players[player:get_player_name()].jump)
                                alchemy.players[player:get_player_name()].jump = 0
                            end
                    )
                    minetest.after(
                            50,
                            function()
                                minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of leaping I")
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
                                player_monoids.gravity:del_change(player, alchemy.players[player:get_player_name()].gravity)
                                alchemy.players[player:get_player_name()].gravity = 0
                            end
                    )
                    minetest.after(
                            50,
                            function()
                                minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of lunar I")
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
                                player_monoids.speed:del_change(player, alchemy.players[player:get_player_name()].speed)
                                alchemy.players[player:get_player_name()].speed = 0
                            end
                    )
                    minetest.after(
                            50,
                            function()
                                minetest.chat_send_player(player:get_player_name(), "you have 10 seconds left of speed I")
                            end
                    )
                    itemstack:take_item()
                    return itemstack
                end

            end
        }
)

minetest.register_craftitem(
        "alchemy:eye_of_earth",
        {
            description = "Eye of Earth",
            inventory_image = "alchemy_earth_eye.png",
)
minetest.register_on_leaveplayer(function(player)
	alchemy.players[player:get_player_name()] = nil
end)
--todo:
--waterbreathing done
--speed done
--leaping done
--invisibility done
--fortitude_potion done
--nightvision
--fireresistance
--damage
--healing done
