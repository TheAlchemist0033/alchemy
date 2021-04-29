slowheal = slowheal or {}
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
                time = 0
            end
            if slowheal[2]==-1 then
                    player:set_hp(player:get_hp()-1)
            end
            time = 0
        end
    end
end)
minetest.register_globalstep(function(dtime)
    time = time + dtime
    if time >= 3 then

    end

end)
minetest.register_on_joinplayer(function(player)
    phys = player:get_physics_override()
    alchemy.players[player:get_player_name()] = {
        speed = 0, default_speed = phys.speed, jump = 0, default_jump = phys.jump, gravity = 0, default_gravity = phys.gravity
    }
end)

potions = {
    {"alchemy_base_potion.png", "alchemy:potion", "basepotion"},
    {"alchemy_base_potion.png^[colorize:#0429A5:100", "alchemy:breath_potion", "waterbreathing"},
    {"alchemy_base_potion.png^[colorize:#940000:100", "alchemy:fortitude_potion","fortitude"},
    {"alchemy_base_potion.png^[colorize:#708F9F:100", "alchemy:invisibility_potion","invisibility" },
    {"alchemy_base_potion.png^[colorize:#C91060:100", "alchemy:slow_healing_potion","slowheal"},
    {"alchemy_base_potion.png^[colorize:#7FFF00:100", "alchemy:leaping_potion","leap"},
    {"alchemy_base_potion.png^[colorize:#76b5c5:100", "alchemy:lunar_potion","lunar"},
    {"alchemy_base_potion.png^[colorize:#eae583:100", "alchemy:speed_potion","speed"},

    {"alchemy_base_potion.png^[colorize:#00720d:100","alchemy:nightvision_potion","nightvision"},
    {"alchemy_base_potion.png^[colorize:#40d869:100","alchemy:poison","poison"}

}
function register_potions( tex, pot, effects)
    temp = string.gsub(pot, "alchemy:", "")
    hrname = string.gsub(temp, "_", " ")
    minetest.register_craftitem(
            pot,
            {
                description = hrname ,
                inventory_image = tex,
                on_use = function(itemstack, player, pointed_thing)
                    effect(player,effects)
                    itemstack:take_item()
                    return itemstack
                end
            }
    )
end
for i in ipairs(potions) do
    register_potions(potions[i][1],potions[i][2],potions[i][3])
end
--
dofile(path .. 'nodes.lua')
dofile(path .. 'powders.lua')
dofile(path .. 'items.lua')
dofile(path .. 'mobs.lua')
dofile(path .. 'earth_monster.lua')
dofile(path .. 'recipes.lua')
dofile(path .. 'grasses.lua')
dofile(path .. 'grinder.lua')
--i really... really... hate formspec...
dofile(path .. 'mixer.lua')
--now i hate it even more.
minetest.register_on_leaveplayer(function(player)
    alchemy.players[player:get_player_name()] = nil
end)