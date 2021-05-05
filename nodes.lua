---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by thealchemist0033.
--- DateTime: 4/26/2021 11:16 PM
---
local S = default.get_translator
minetest.register_node("alchemy:solgrass", {
    description = S("Grass of the sun"),
    tiles = {"alchemy_solgrass.png", "default_dirt.png",
             {name = "default_dirt.png^alchemy_solgrass_side.png",
              tileable_vertical = false}},
    groups = {crumbly = 3, soil = 1, spreading_dirt_type = 0},
    drop = "default:dirt",
    sounds = default.node_sound_dirt_defaults({
        footstep = {name = "default_grass_footstep", gain = 0.25},
    }),
})

minetest.register_node("alchemy:lunargrass", {
    description = S("Grass of the moon"),
    tiles = {"alchemy_lunargrass.png", "default_dirt.png",
             {name = "default_dirt.png^alchemy_lunargrass_side.png",
              tileable_vertical = false}},
    groups = {crumbly = 3, soil = 1, spreading_dirt_type = 0},
    drop = "default:dirt",
    sounds = default.node_sound_dirt_defaults({
        footstep = {name = "default_grass_footstep", gain = 0.25},
    }),
})
