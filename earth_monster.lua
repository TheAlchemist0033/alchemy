local S = mobs.intllib

local dirt_types = {

	{	nodes = {"default:dirt"},
		skins = {"alchemy_earth_mob.png"},
		drops = {
			{name = "alchemy:eye_of_earth", chance = 10, min = 0, max = 2},
			{name = "default:diamond", chance = 10, min = 0, max = 3},
			{name = "alchemy:earth_essence", chance = 20, min = 0, max =1}

		}
	}
}


mobs:register_mob("alchemy:gaea_spawnling", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 3,
	hp_min = 80,
	hp_max = 100,
	armor = 200,
	collisionbox = {-0.75, 0, -1, 0.75, 1.5,0.5},
	visual = "mesh",
	mesh = "Earthmob.b3d",
	textures = {
	{"alchemy_earth_mob.png"}
	},
	blood_texture = "default_stone.png",
	makes_footstep_sound = true,
	sounds = {
		random = "alchemy_earth_defaults",
		jump = "alchemy_step"
	},
	view_range = 20,
	walk_velocity = 1,
	run_velocity = 4,
	jump = true,
	drops = {
		{name = "alchemy:eye_of_earth", chance = 5, min = 0, max = 2},
	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 1,
	fear_height = 2,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 26,
		stand_end = 51,
		walk_start = 11,
		walk_end = 21,
		run_start = 11,
		run_end = 21,
		punch_start = 0,
		punch_end = 9,
	},

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
		return true
	end
})
if not mobs.custom_spawn_monster then
mobs:spawn({
	name = "alchemy:gaea_spawnling",
	nodes = {"default:stone","default:dirt","default:dirt_with_grass"},
	min_light = 0,
	max_light = 10,
	chance = 6000,
	active_object_count = 2,
	min_height = 80,
	day_toggle = false,
})
end
mobs:register_egg("alchemy:gaea_spawnling", S("Earth Monster"), "default_stone.png", 1) 
