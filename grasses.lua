---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by jekyl.
--- DateTime: 4/26/2021 8:18 PM
---
minetest.register_node("alchemy:sol", {
    drawtype = "plantlike",
    description = "Sol Flower",
    light_source = 5, -- The node radiates light. Min 0, max 14
    tiles = {"alchemy_sol_flower.png"},
    groups = { flora=1, attached_node=1, snappy=3},
    waving = 1,
    paramtype = "light",
    walkable = false,
    on_use = function(itemstack, player, pointed_thing)
        local pos = player:get_pos()
        minetest.set_node(pos,{name ="fire:basic_flame"})
        itemstack:take_item()
        return itemstack
    end,

    selection_box = {
        type = "fixed",
        fixed = {-2 / 16, -0.5, -2 / 16, 3 / 16, 5 / 16, 2 / 16},
    },
})
minetest.register_node("alchemy:lunar", {
    drawtype = "plantlike",
    description = "Lunar Flower",
    light_source = 1,
    tiles = {"alchemy_lunar_flower.png"},
    groups = {flora=1, attached_node=1, snappy=3},
    waving = 1,
    paramtype = "light",
    walkable = false,
    on_use = function(itemstack, player, pointed_thing)
        local pos = player:get_pos()
        minetest.set_node(pos,{name ="default:ice"})
        itemstack:take_item()
        return itemstack
    end,
    selection_box = {
        type = "fixed",
        fixed = {-2 / 16, -0.5, -2 / 16, 3 / 16, 5 / 16, 2 / 16},
    },
})
minetest.register_node("alchemy:fractalized", {
    drawtype = "plantlike",
    description = "Fractalized Flower",
    tiles = {"alchemy_fracturing_flower.png"},
    groups = {flora=1, attached_node=1, snappy=3},
    waving = 1,
    paramtype = "light",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-2 / 16, -0.5, -2 / 16, 3 / 16, 5 / 16, 2 / 16},
    },
})
minetest.register_node("alchemy:zap", {
    drawtype = "plantlike",
    description = "Zap Flower",
    light_source = 3,
    tiles = {"alchemy_zap_flower.png"},
    groups = {flora=1, attached_node=1, snappy=3},
    waving = 1,
    paramtype = "light",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-2 / 16, -0.5, -2 / 16, 3 / 16, 5 / 16, 2 / 16},
    },
    on_use = function(itemstack,player)
        used = 0
        if used == 0 then
            local f1, f2, f3, f4, fr = player:get_local_animation(player)
            player:set_local_animation(f1,f2,f3,f4,fr*2)
            used = 1
        end
        itemstack:take_item()

        minetest.after(20,function()
            player:set_local_animation(f1,f2,f3,f4,fr)
            used = 0
        end)
        return itemstack
    end
})
minetest.register_node("alchemy:life", {
    drawtype = "plantlike",
    description = "Flower of Life",
    tiles = {"alchemy_life_flower.png"},
    groups = {flora=1, attached_node=1, snappy=3},
    waving = 1,
    paramtype = "light",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-2 / 16, -0.5, -2 / 16, 3 / 16, 5 / 16, 2 / 16},
    },
    on_use = function(itemstack, player, pointed_thing)
        if player:get_hp() < 20 then
            player:set_hp(player:get_hp()+1)
            itemstack:take_item()
            return itemstack

        end
    end,
})
minetest.register_node("alchemy:hemlock", {
    drawtype = "plantlike",
    description = "Hemlock Flower",
    tiles = {"alchemy_hemlock.png"},
    groups = {flora=1, attached_node=1, snappy=3},
    waving = 1,
    paramtype = "light",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-2 / 16, -0.5, -2 / 16, 3 / 16, 5 / 16, 2 / 16},
    },
    on_use = function(itemstack, player, pointed_thing)
        player:set_hp(player:get_hp()-4)
        itemstack:take_item()
        return itemstack
    end
})
minetest.register_node("alchemy:oceanic_flower", {
    drawtype = "plantlike",
    description = "Oceanic Flower",
    tiles = {"alchemy_oceanic_flower.png"},
    light_source = 2,
    groups = {flora=1, attached_node=1, snappy=3},
    waving = 1,
    paramtype = "light",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-2 / 16, -0.5, -2 / 16, 3 / 16, 5 / 16, 2 / 16},
    },
})
minetest.register_abm({
    nodenames = {"default:dry_dirt_with_grass","default:dry_dirt"},
    neighbor = {"air"},
    interval = 10,
    chance = 1500,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local above = {x = pos.x , y = pos.y +1, z = pos.z }

        if not minetest.find_node_near(pos, 2, {"alchemy:sol"}) then
            minetest.set_node(above, {name = "alchemy:sol"})
        end
    end
})
minetest.register_abm({
    nodenames = {"alchemy:sol", "alchemy:lunar", "alchemy:solgrass","alchemy:lunargrass"},
    neighbor = {"air"},
    interval = 5,
    chance = 2,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if node.name == "alchemy:sol" then
            local sols = minetest.find_nodes_in_area_under_air(
                    {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
                    {x = pos.x + 2, y = pos.y + 1, z = pos.z + 2},
                    {"alchemy:sol"})
            if (minetest.get_node_light(pos) or 0) <= 12 then
                minetest.set_node({x = pos.x, y = pos.y -1, z = pos.z}, {name = "alchemy:lunargrass"})
                minetest.set_node(pos, {name = "alchemy:lunar"})
                return
            end
            if #sols >= 2 then
                minetest.set_node({x = pos.x, y = pos.y -1, z = pos.z}, {name = "alchemy:solgrass"})
                minetest.set_node(pos, {name = "fire:basic_flame"})

            end
        end
        if node.name == "alchemy:lunar" then
            local luns = minetest.find_nodes_in_area_under_air(
                    {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
                    {x = pos.x + 2, y = pos.y + 1, z = pos.z + 2},
                    {"alchemy:lunar"})
            if (minetest.get_node_light(pos) or 0) >= 13 then
                minetest.set_node({x = pos.x, y = pos.y -1, z = pos.z}, {name = "alchemy:solgrass"})
                minetest.set_node(pos, {name = "alchemy:sol"})
                return
            end
            if #luns >= 2 then
                minetest.set_node({x = pos.x, y = pos.y -1, z = pos.z}, {name = "alchemy:lunargrass"})
                minetest.set_node(pos, {name = "default:ice"})

            end
        end
        if node.name == "alchemy:solgrass" then
            if (minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}) or 0) < 13 then
                minetest.set_node(pos, {name = "alchemy:lunargrass"})
                return
            end
        end
        if node.name == "alchemy:lunargrass" then
            if (minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}) or 0) >= 13 then

                minetest.set_node(pos, {name = "alchemy:solgrass"})
                return
            end
        end

    end

})
minetest.register_abm({
    nodenames = {"default:dirt_with_grass"},
    neighbor = {"air"},
    interval = 10,
    chance = 100,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if (minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}) or 0) >= 13 then
            local thisstuff = {"alchemy:hemlock","alchemy:hemlock","alchemy:hemlock","alchemy:hemlock",
                               "alchemy:fractalized","alchemy:zap","alchemy:life"}
            if not minetest.find_node_near(pos, 15, thisstuff) then
                math.randomseed(os.clock())
                local r = math.random(1,7)
                minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z}, {name = thisstuff[r]})
            end
        end

    end
})
minetest.register_abm({
    nodenames = {"group:sand"},
    neighbors = {"group:water"},
    interval = 15,
    chance = 1000,
    catch_up = false,
    action = function(pos, node)
        math.randomseed(os.clock())
        local sel = math.random(6)
        pos.y = pos.y + 1
        local nod = minetest.get_node(pos).name
        if nod == "default:water_source"
                and sel == 6 then
            if not minetest.find_node_near(pos, 15, thisstuff) then
                minetest.swap_node(pos, {name = "alchemy:oceanic_flower"})
                return


            end

        end
    end
})

