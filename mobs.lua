-- Sand Monster by PilzAdam
--The MIT License (MIT) (for sand monster)
--Copyright (c) 2016 TenPlus1 (for sand monster)
local S = mobs.intllib

local dirt_types = {

    {	nodes = {"ethereal:dry_dirt"},
         skins = {"mobs_dirt_monster3.png"},
         drops = {
             {name = "ethereal:dry_dirt", chance = 1, min = 0, max = 2},
             {name = "alchemy:eye_of_earth",chance=23,min = 1, max = 3}
         }
    }
}
local tree_types = {

    {	nodes = {"ethereal:sakura_leaves", "ethereal:sakura_leaves2"},
         skins = {"mobs_tree_monster5.png"},
         drops = {
             {name = "default:stick", chance = 1, min = 1, max = 3},
             {name = "ethereal:sakura_leaves", chance = 1, min = 1, max = 2},
             {name = "ethereal:sakura_trunk", chance = 2, min = 1, max = 2},
             {name = "ethereal:sakura_tree_sapling", chance = 2, min = 0, max = 2},
             {name = "alchemy:arboreal_tooth", chance = 30, min = 0, max = 1}
         }
    },

    {	nodes = {"ethereal:frost_leaves"},
         skins = {"mobs_tree_monster3.png"},
         drops = {
             {name = "default:stick", chance = 1, min = 1, max = 3},
             {name = "ethereal:frost_leaves", chance = 1, min = 1, max = 2},
             {name = "ethereal:frost_tree", chance = 2, min = 1, max = 2},
             {name = "ethereal:crystal_spike", chance = 4, min = 0, max = 2},
             {name = "alchemy:arboreal_tooth", chance = 30, min = 0, max = 1}
         }
    },

    {	nodes = {"ethereal:yellowleaves"},
         skins = {"mobs_tree_monster4.png"},
         drops = {
             {name = "default:stick", chance = 1, min = 1, max = 3},
             {name = "ethereal:yellowleaves", chance = 1, min = 1, max = 2},
             {name = "ethereal:yellow_tree_sapling", chance = 2, min = 0, max = 2},
             {name = "ethereal:golden_apple", chance = 3, min = 0, max = 2},
             {name = "alchemy:arboreal_tooth", chance = 30, min = 0, max = 1}
         }
    },

    {	nodes = {"default:acacia_bush_leaves"},
         skins = {"mobs_tree_monster6.png"},
         drops = {
             {name = "tnt:gunpowder", chance = 1, min = 0, max = 2},
             {name = "default:iron_lump", chance = 5, min = 0, max = 2},
             {name = "default:coal_lump", chance = 3, min = 0, max = 3},
             {name = "alchemy:arboreal_tooth", chance = 30, min = 0, max = 1}
         },
         explode = true
    },
}
mobs:register_mob("alchemy:sand_monster", {
    type = "monster",
    passive = false,
    attack_type = "dogfight",
    pathfinding = true,
    --specific_attack = {"player", "mobs_npc:npc"},
    --ignore_invisibility = true,
    reach = 2,
    damage = 1,
    hp_min = 4,
    hp_max = 20,
    armor = 100,
    collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
    visual = "mesh",
    mesh = "mobs_sand_monster.b3d",
    textures = {
        {"mobs_sand_monster.png"},
        {"mobs_sand_monster2.png"},
    },
    blood_texture = "default_desert_sand.png",
    makes_footstep_sound = true,
    sounds = {
        random = "mobs_sandmonster",
    },
    walk_velocity = 1.5,
    run_velocity = 4,
    view_range = 8, --15
    jump = true,
    floats = 0,
    drops = {
        {name = "default:dirt", chance = 1, min = 3, max = 5},
        {name = "alchemy:eye_of_sand", chance = 20, min = 1, max = 3},
    },
    water_damage = 3,
    lava_damage = 4,
    light_damage = 0,
    fear_height = 4,
    animation = {
        speed_normal = 15,
        speed_run = 15,
        stand_start = 0,
        stand_end = 39,
        walk_start = 41,
        walk_end = 72,
        run_start = 74,
        run_end = 105,
        punch_start = 74,
        punch_end = 105,
    },
    immune_to = {
        {"default:shovel_wood", 3}, -- shovels deal more damage to sand monster
        {"default:shovel_stone", 3},
        {"default:shovel_bronze", 4},
        {"default:shovel_steel", 4},
        {"default:shovel_mese", 5},
        {"default:shovel_diamond", 7},
    },
    --[[
        custom_attack = function(self, p)
            local pos = self.object:get_pos()
            minetest.add_item(pos, "default:sand")
        end,
    ]]
    on_die = function(self, pos)
        pos.y = pos.y + 0.5
        mobs:effect(pos, 30, "mobs_sand_particles.png", .1, 2, 3, 5)
        pos.y = pos.y + 0.25
        mobs:effect(pos, 30, "mobs_sand_particles.png", .1, 2, 3, 5)
    end,
    --[[
        on_rightclick = function(self, clicker)

            local tool = clicker:get_wielded_item()
            local name = clicker:get_player_name()

            if tool:get_name() == "default:sand" then

                self.owner = name
                self.type = "npc"

                mobs:force_capture(self, clicker)
            end
        end,
    ]]
})


-- Dirt Monster by PilzAdam

mobs:register_mob("alchemy:dirt_monster", {
    type = "monster",
    passive = false,
    attack_type = "dogfight",
    pathfinding = true,
    reach = 2,
    damage = 2,
    hp_min = 3,
    hp_max = 27,
    armor = 100,
    collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
    visual = "mesh",
    mesh = "mobs_stone_monster.b3d",
    textures = {
        {"mobs_dirt_monster.png"},
        {"mobs_dirt_monster2.png"},
    },
    blood_texture = "default_dirt.png",
    makes_footstep_sound = true,
    sounds = {
        random = "mobs_dirtmonster",
    },
    view_range = 15,
    walk_velocity = 1,
    run_velocity = 3,
    jump = true,
    drops = {
        {name = "default:dirt", chance = 1, min = 0, max = 2},
        {name = "alchemy:eye_of_earth", chance = 23, min = 1, max = 3}
    },
    water_damage = 1,
    lava_damage = 5,
    light_damage = 3,
    fear_height = 4,
    animation = {
        speed_normal = 15,
        speed_run = 15,
        stand_start = 0,
        stand_end = 14,
        walk_start = 15,
        walk_end = 38,
        run_start = 40,
        run_end = 63,
        punch_start = 40,
        punch_end = 63,
    },

    -- check surrounding nodes and spawn a specific monster
    on_spawn = function(self)

        local pos = self.object:get_pos() ; pos.y = pos.y - 1
        local tmp

        for n = 1, #dirt_types do

            tmp = dirt_types[n]

            if minetest.find_node_near(pos, 1, tmp.nodes) then

                self.base_texture = tmp.skins
                self.object:set_properties({textures = tmp.skins})

                if tmp.drops then
                    self.drops = tmp.drops
                end

                return true
            end
        end

        return true -- run only once, false/nil runs every activation
    end
})


mobs:register_mob("alchemy:tree_monster", {
    type = "monster",
    passive = false,
    attack_type = "dogfight",
    attack_animals = true,
    --specific_attack = {"player", "mobs_animal:chicken"},
    reach = 2,
    damage = 2,
    hp_min = 20,
    hp_max = 40,
    armor = 100,
    collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
    visual = "mesh",
    mesh = "mobs_tree_monster.b3d",
    textures = {
        {"mobs_tree_monster.png"},
        {"mobs_tree_monster2.png"},
    },
    blood_texture = "default_wood.png",
    makes_footstep_sound = true,
    sounds = {
        random = "mobs_treemonster",
    },
    walk_velocity = 1,
    run_velocity = 3,
    jump = true,
    view_range = 15,
    drops = {
        {name = "default:stick", chance = 1, min = 0, max = 2},
        {name = "default:sapling", chance = 2, min = 0, max = 2},
        {name = "default:junglesapling", chance = 3, min = 0, max = 2},
        {name = "default:apple", chance = 4, min = 1, max = 2},
        {name = "alchemy:arboreal_tooth", chance = 30, min = 0, max = 1}
    },
    water_damage = 0,
    lava_damage = 0,
    light_damage = 2,
    fall_damage = 0,
    immune_to = {
        {"default:axe_wood", 0}, -- wooden axe doesnt hurt wooden monster
        {"default:axe_stone", 4}, -- axes deal more damage to tree monster
        {"default:axe_bronze", 5},
        {"default:axe_steel", 5},
        {"default:axe_mese", 7},
        {"default:axe_diamond", 9},
        {"default:sapling", -5}, -- default and jungle saplings heal
        {"default:junglesapling", -5},
        --		{"all", 0}, -- only weapons on list deal damage
    },
    animation = {
        speed_normal = 15,
        speed_run = 15,
        stand_start = 0,
        stand_end = 24,
        walk_start = 25,
        walk_end = 47,
        run_start = 48,
        run_end = 62,
        punch_start = 48,
        punch_end = 62,
    },

    -- check surrounding nodes and spawn a specific tree monster
    on_spawn = function(self)

        local pos = self.object:get_pos() ; pos.y = pos.y - 1
        local tmp

        for n = 1, #tree_types do

            tmp = tree_types[n]

            if tmp.explode and math.random(2) == 1 then return true end

            if minetest.find_node_near(pos, 1, tmp.nodes) then

                self.base_texture = tmp.skins
                self.object:set_properties({textures = tmp.skins})

                if tmp.drops then
                    self.drops = tmp.drops
                end

                if tmp.explode then
                    self.attack_type = "explode"
                    self.explosion_radius = 3
                    self.explosion_timer = 3
                    self.damage = 21
                    self.reach = 3
                    self.fear_height = 4
                    self.water_damage = 2
                    self.lava_damage = 15
                    self.light_damage = 0
                    self.makes_footstep_sound = false
                    self.runaway_from = {"mobs_animal:kitten"}
                    self.sounds = {
                        attack = "tnt_ignite",
                        explode = "tnt_explode",
                        fuse = "tnt_ignite"
                    }
                end

                return true
            end
        end

        return true -- run only once, false/nil runs every activation
    end
})
-- Lava Flan by Zeg9 (additional textures by JurajVajda)

mobs:register_mob("alchemy:lava_flan", {
    type = "monster",
    passive = false,
    attack_type = "dogfight",
    reach = 2,
    damage = 3,
    hp_min = 10,
    hp_max = 35,
    armor = 80,
    collisionbox = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
    visual = "mesh",
    mesh = "zmobs_lava_flan.x",
    textures = {
        {"zmobs_lava_flan.png"},
        {"zmobs_lava_flan2.png"},
        {"zmobs_lava_flan3.png"},
    },
    blood_texture = "fire_basic_flame.png",
    makes_footstep_sound = false,
    sounds = {
        random = "mobs_lavaflan",
        war_cry = "mobs_lavaflan",
    },
    walk_velocity = 0.5,
    run_velocity = 2,
    jump = true,
    view_range = 10,
    floats = 1,
    drops = {
        {name = "alchemy:essense_of_fire", chance = 10, min = 1, max = 1},
    },
    water_damage = 8,
    lava_damage = 0,
    fire_damage = 0,
    light_damage = 0,
    immune_to = {
        {"mobs:pick_lava", -2}, -- lava pick heals 2 health
    },
    fly_in = {"default:lava_source", "default:lava_flowing"},
    animation = {
        speed_normal = 15,
        speed_run = 15,
        stand_start = 0,
        stand_end = 8,
        walk_start = 10,
        walk_end = 18,
        run_start = 20,
        run_end = 28,
        punch_start = 20,
        punch_end = 28,
    },
    on_die = function(self, pos)
        local cod = self.cause_of_death or {}
        local def = cod.node and minetest.registered_nodes[cod.node]
            if minetest.get_node(pos).name == "air" then
                minetest.set_node(pos, {name = "fire:basic_flame"})
            end
            mobs:effect(pos, 40, "fire_basic_flame.png", 2, 3, 2, 5, 10, nil)
            self.object:remove()
    end,
    glow = 10,
})





if not mobs.custom_spawn_monster then
    mobs:spawn({
        name = "mobs_monster:dirt_monster",
        nodes = {"default:dirt_with_grass", "ethereal:gray_dirt", "ethereal:dry_dirt"},
        min_light = 0,
        max_light = 7,
        chance = 6000,
        active_object_count = 2,
        min_height = 0,
        day_toggle = false,
    })
    mobs:spawn({
        name = "alchemy:sand_monster",
        nodes = {"default:desert_sand"},
        chance = 7000,
        active_object_count = 2,
        min_height = 0,
    })
    mobs:spawn({
        name = "alchemy:tree_monster",
        nodes = {"group:leaves"}, --{"default:leaves", "default:jungleleaves"},
        max_light = 7,
        chance = 7000,
        min_height = 0,
        day_toggle = false,
    })

    mobs:spawn({
        name = "alchemy:lava_flan",
        nodes = {"default:lava_source"},
        chance = 1500,
        active_object_count = 1,
        max_height = 0,
    })
end


mobs:register_egg("alchemy:sand_monster", S("Sand Monster"), "default_desert_sand.png", 1)
mobs:register_egg("alchemy:tree_monster", S("Tree Monster"), "default_tree_top.png", 1)
mobs:register_egg("alchemy:lava_flan", S("Lava Flan"), "default_lava.png", 1)
mobs:register_egg("alchemy:dirt_monster", S("Dirt Monster"), "default_dirt.png", 1)

--ironically removed alias for compatability


---thank you to TenPlus1 for this source code. Im sorry i pretty much ripped off your source, its only temporary
---until i am able to finish up my own custom mobs. Ive included the copyrite to the original code below.
---
---
---The MIT License (MIT)

---Copyright (c) 2016 TenPlus1

---Permission is hereby granted, free of charge, to any person obtaining a copy
---of this software and associated documentation files (the "Software"), to deal
---in the Software without restriction, including without limitation the rights
---to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
---copies of the Software, and to permit persons to whom the Software is
---furnished to do so, subject to the following conditions:

---The above copyright notice and this permission notice shall be included in
---all copies or substantial portions of the Software.

---THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
---IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
---FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
---AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
---LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
---OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
---THE SOFTWARE.

---mobs.fireball.png was originally made by Sapier and edited by Benrob:

-- Animals Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
-- (c) Sapier
-- Contact sapier a t gmx net
