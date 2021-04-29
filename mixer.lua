--[[
Originally made by F. Georget, redone by TheAlchemist0033
This work is free. You can redistribute it and/or modify it under the
terms of the Do What The Fuck You Want To Public License, Version 2,
as published by Sam Hocevar. See the COPYING file for more details.


-- the namespace that contains the useful functions and data
mixer = {}

-- the ui
mixer.formspec = [[
	size[8,9;]
	label[1,1;Tube]
	list[context;tube;2,1;1,1]
	label[4,1;Water]
	list[context;water;5,1;1,1]

	label[1,2;Powder 1]
	list[context;powder_1;2,2;1,1]
	label[4,2;Powder 2]
	list[context;powder_2;5,2;1,1]

	list[context;secret;2,3;1,1]
	label[7,3;Result]
	list[context;recipe;7,4;1,1]

	button[1,4;1.0,1;mix;Mix]
	label[3,4;Output]
	list[context;output;3,4;2,1]

	list[current_player;main;0,5.25;8,4;]
	]
--This is a first filter to know if something can be crafted or not
mixer.filter_recipe = function(pos)
    local inv = minetest.get_meta(pos):get_inventory()

    if (   inv:is_empty("tube")
            or inv:is_empty("powder_1")
            or inv:is_empty("powder_2")
            or (inv:is_empty("water") or inv:get_stack("water", 1):get_name() == "bucket:bucket_empty()")
    )
    then
        return false
    else
        return true
    end
    return false
end

mixer.recipes = {
    {"", "", ""},
    {"", "", ""},
    {"", "", ""},

}

-- Declares the recipes available
mixer.is_recipe = function(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()

    local powder_1 = inv:get_stack("powder_1", 1)
    local powder_2 = inv:get_stack("powder_2", 1)

    local name_1 = powder_1:get_name()
    local name_2 = powder_2:get_name()

    for _, r in pairs(mixer.recipes) do
        if (name_1 == r[1] and name_2 == r[2]) then
            inv:set_list("recipe", {ItemStack(r[3])})
            return
        end
    end
    -- if no recipe was found, no entry
    inv:set_list("recipe", {ItemStack("")})
end

-- Build the UI
mixer.on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    inv:set_size("tube", 1)
    inv:set_size("powder_1", 1)
    inv:set_size("powder_2", 1)
    inv:set_size("water", 1)
    inv:set_size("secret", 1)
    inv:set_size("recipe", 1)
    inv:set_size("output", 2)
    meta:set_string("infotext", "Potion mixer")
    meta:set_string("formspec", mixer.formspec)

end
--
-- Only certain items are accepted
mixer.put = function(_, listname, _, stack)
    local stackname = stack:get_name()
    if (listname == "tube" and stackname == "alchemy:tube")
            or (listname == "water" and stackname == "bucket:bucket_water")
            or ((listname == "powder_1" or listname == "powder_2") and
            is_powder(stackname))
            or (listname == "secret")
    then
        return stack:get_count()
    else
        return 0
    end
end

-- Refresh the "recipe" when a new item is put in the mixer
mixer.on_put = function(pos, _, _, _)
    if (mixer.filter_recipe(pos)) then
        mixer.is_recipe(pos)
    else
        local inv = minetest.get_meta(pos):get_inventory()
        inv:set_list("recipe", {ItemStack("")})
    end
end

-- You can't take the item from recipe
mixer.take = function(pos, listname, index, stack)

    if listname == "recipe" then
        return 0
    else
        return stack:get_count()
    end
end

mixer.remove_ingredients = function(inv)
    local tube = inv:get_stack("tube", 1)
    tube:take_item(1)
    inv:set_stack("tube", 1, tube)
    local powder_1 = inv:get_stack("powder_1", 1)
    powder_1:take_item(1)
    inv:set_stack("powder_1", 1, powder_1)
    local powder_2 = inv:get_stack("powder_2", 1)
    powder_2:take_item(1)
    inv:set_stack("powder_2", 1, powder_2)
end

mixer.on_mix_success = function(inv, out, number)

    inv:add_item("output", out.." "..number)

end

mixer.on_mix_critical_failure = function(inv, pos)
    --
    local damage = 2

    -- no more water
    inv:set_stack("water", 1, "bucket:bucket_empty")

    -- check for secret catalyser
    local has_secret = false
    if (not inv:is_empty("secret")) then
        local in_secret = inv:get_stack("secret", 1)
        if (in_secret:get_name() == "default:mese_crystal_fragment") then
            in_secret:take_item(1)
            inv:set_stack("secret", 1, in_secret)
            damage = 0
        else
            -- lol : wrong catalyser
            damage = 3
            inv:set_stack("secret", 1, ItemStack(""))
        end
    end

    -- explode at the face of the user :-)
    if (damage > 0) then
        objs = minetest.get_objects_inside_radius(pos, 5)
        for _, obj in pairs(objs) do
            local obj_pos = obj:getpos()
            dist = vector.distance(pos, obj_pos)
            local damage = damage*5/dist
            obj:set_hp(obj:get_hp() - damage)
        end
    end
end

-- Mix the solution
mixer.mix = function(pos)
    local inv = minetest.get_meta(pos):get_inventory()

    if inv:is_empty("recipe") then
        return
    end

    local out = inv:get_stack("recipe", 1)
    if not inv:room_for_item("output", out) then
        return
    end

    -- It's ok to mix, let's go

    mixer.remove_ingredients(inv)
    -- success ?
    local dice = math.random(1,100)
    if (dice > 90) then
        -- 2 potions
        mixer.on_mix_success(inv, out:get_name(), 2)
    elseif (dice > 40) then
        -- default
        mixer.on_mix_success(inv, out:get_name(), 1)
    elseif (dice < 10) then
        -- lol : explosion
        mixer.on_mix_critical_failure(inv, pos)
    end

    -- Refresh
    mixer.on_put(pos, _, _, _)

end

-- Act when a field is received
mixer.on_mix = function(pos, _, fields)
    if fields.mix then
        mixer.mix(pos)
    end
end

-- refresh
mixer.on_take = function(pos, listname, index, stack)
    local inv = minetest.get_meta(pos):get_inventory()

    if    listname == "tube"
            or listname == "powder_1"
            or listname == "powder_2"
            or listname == "water"
    then
        mixer.on_put(pos, listname, index, stack)
    end
end
--]]
minetest.register_node("alchemy:potion_mixer", {
    description = "A nice uh... Decorative block (see src)",
    drawtype="normal",
    tiles = {
        "alchemy_mixer_top.png",
        "alchemy_mixer_bottom.png",
        "alchemy_mixer_side.png",
        "alchemy_mixer_side.png",
        "alchemy_mixer_side.png",
        "alchemy_mixer_side.png",

    },
    is_ground_content = true,
    groups = {cracky=3, oddly_breakable_by_hand=1},
  --  inventory=true,
  --  on_construct                    = mixer.on_construct,
  --  allow_metadata_inventory_put  = mixer.put,
  --  on_metadata_inventory_put     = mixer.on_put,
  --  on_metadata_inventory_move    = mixer.on_put,
  --  allow_metadata_inventory_take = mixer.take,
  --  on_metadata_inventory_take    = mixer.on_take,
--    on_receive_fields             = mixer.on_mix
})

minetest.register_craft({
    output = "alchemy:potion_mixer",
    recipe = {
        {"default:copper_ingot", "default:glass", "default:copper_ingot"},
        {"default:glass", "default:glass", "default:glass"},
        {"default:cobble", "default:cobble", "default:cobble"}
    }
})
--this whole friggin file needs to be redone. I dont have the patience, you dont have the need.
--but without it the mod isnt totally compatable with the old version of alchemy. So what do i do?
--well, enjoy the wonderful new ~~temporary~~ decoration.
