local slowheal = slowheal or {}
alchemy = {players = {}}
local time = 0
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"
dofile(path .. 'throwpotion.lua')
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
                effect(player,"waterbreathing")
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
                effect(player,"fortitude")
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
                effect(player,"invisibility")
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
                effect(player,"slowheal")
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
                effect(player,"leap")
                    itemstack:take_item()
                    return itemstack

            end
        }
)
minetest.register_craftitem(
        "alchemy:lunar_potion",
        {
            description = "Lunar Potion I",
            inventory_image = "alchemy_base_potion.png^[colorize:#76b5c5:100",
            on_use = function(itemstack, player, pointed_thing)
                effect(player,"lunar")
                    itemstack:take_item()
                    return itemstack

            end
        }
)
minetest.register_craftitem(
        "alchemy:speed_potion",
        {
            description = "Speed Potion I",
            inventory_image = "alchemy_base_potion.png^[colorize:#eae583:100",
            on_use = function(itemstack, player, pointed_thing)
                effect(player,"speed")
                    itemstack:take_item()
                    return itemstack
            end
        }
)
minetest.register_craftitem(
        "alchemy:nightvision_potion",
        {
            description = "Nightvision I",
            inventory_image = "alchemy_base_potion.png^[colorize:#00720d:100",
            on_use = function(itemstack, player, pointed_thing)
                effect(player,"nightvision")
                itemstack:take_item()
                return itemstack
            end
        }
)
dofile(path .. 'items.lua')
dofile(path .. 'mobs.lua')
dofile(path .. 'recipes.lua')

minetest.register_on_leaveplayer(function(player)
    alchemy.players[player:get_player_name()] = nil
end)
