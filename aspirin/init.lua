-- Aspirin mod for Minetest.
-- Copyright (C) 2024  Olivia May
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
--
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

minetest.register_craftitem("aspirin:aspirin", {
	description = "Aspirin",
	inventory_image = "aspirin.png",
	on_use = function(itemstack, user, pointed_thing)

		local hp = user:get_hp()
		if hp >= user:get_properties().hp_max then
			return nil
		end

		-- two hearts
		hp = hp + 4
		user:set_hp(hp)
		itemstack:take_item(1)

		return itemstack
	end,
})

minetest.register_craftitem("aspirin:bottle_of_aspirin", {
	description = "Bottle of Aspirin",
	inventory_image = "bottle_of_aspirin.png",
	on_use = function(itemstack, user, pointed_thing)

		local hp = user:get_hp()
		if hp >= user:get_properties().hp_max then
			return nil
		end

		-- 10 hearts
		hp = hp + 20
		user:set_hp(hp)
		itemstack:take_item(1)

		return itemstack
	end,
})

has_ethereal = minetest.get_modpath("ethereal")
has_moretrees = minetest.get_modpath("moretrees")

if minetest.get_modpath("technic") then

	if not (has_ethereal or has_moretrees) then

		technic.register_extractor_recipe(
			{input = {"default:leaves"},
			output = "aspirin:aspirin"
		})
	end

	if has_ethereal then

		technic.register_extractor_recipe(
			{input = {"ethereal:willow_twig"},
			output = "aspirin:aspirin"
		})
	end

	if has_moretrees then

		technic.register_extractor_recipe(
			{input = {"moretrees:willow_leaves"},
			output = "aspirin:aspirin"
		})
	end

else

	if not (has_ethereal or has_moretrees) then

		minetest.register_craft({
			output = "aspirin:aspirin",
			type = "shapeless",
			recipe = {
				"default:leaves",
			},
		})
	end

	if has_ethereal then

		minetest.register_craft({
			output = "aspirin:aspirin",
			type = "shapeless",
			recipe = {
				"ethereal:willow_twig",
			},
		})
	end

	if has_moretrees then

		minetest.register_craft({
			output = "aspirin:aspirin",
			type = "shapeless",
			recipe = {
				"moretrees:willow_leaves",
			},
		})
	end
end

minetest.register_craft({
	output = "aspirin:bottle_of_aspirin",
	type = "shapeless",
	recipe = {
		"aspirin:aspirin",
		"aspirin:aspirin",
		"aspirin:aspirin",
		"aspirin:aspirin",
		"aspirin:aspirin",
		"vessels:glass_bottle",
	},
})
