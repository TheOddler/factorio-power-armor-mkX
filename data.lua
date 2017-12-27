function createTech(name, prev_name, science_ingredients, science_count)
	local technology = table.deepcopy(data.raw.technology["power-armor-2"])
	technology.name = name
	technology.effects =
	{
		{
			type = "unlock-recipe",
			recipe = name
		}
	}
	technology.prerequisites = {prev_name}
	technology.unit =
	{
		count = science_count,
		ingredients = science_ingredients,
		time = 30
	}
	technology.order = "g-c-d"
	data:extend({technology})
end

function createEquipmentGrid(name, size)
	local grid =
	{
		type = "equipment-grid",
		name = name,
		width = size,
		height = size,
		equipment_categories = {"armor"}
	}
	data:extend({grid})
end

function createItem(name, equipment_grid_name, inventory_bonus)
	local item = table.deepcopy(data.raw.armor["power-armor-mk2"])
	item.name = name
    item.equipment_grid = equipment_grid_name
    item.inventory_size_bonus = inventory_bonus
	data:extend({item})
end

function createRecipe(name, ingredients)
	local recipe = {
		type = "recipe",
		name = name,
		enabled = false,
		energy_required = 25,
		ingredients = ingredients,
		result = name,
		requester_paste_multiplier = 1
	}
	data:extend({recipe})
end

function createPowerArmor(name, prev_name, equipGridSize, inventory_bonus, ingredients, science_ingredients, science_count)
	createTech(name, prev_name, science_ingredients, science_count)
	local equipment_grid_name = name .. "-equipment-grid"
	createEquipmentGrid(equipment_grid_name, equipGridSize)
	createItem(name, equipment_grid_name, inventory_bonus)
	createRecipe(name, ingredients)
end

function createPowerArmorMkx(x, equipGridSize, inventory_bonus, ingridents_module_count, science_count)
	if x < 3 then
		--no!
	else
		local name = "power-armor-mk" .. x
		local prev_name = "power-armor-mk" .. (x-1)
		if x == 3 then
			prev_name = "power-armor-2"
		end
		createPowerArmor(
			name,
			prev_name,
			equipGridSize,
			inventory_bonus,
			{
				{ "effectivity-module-3", ingridents_module_count},
				{"speed-module-3", ingridents_module_count},
				{"processing-unit", 100},
				{"steel-plate", 100}
			},
			{
				{"science-pack-1", 1},
				{"science-pack-2", 1},
				{"science-pack-3", 1},
				{"military-science-pack", 1},
				{"high-tech-science-pack", 1}
			},
			science_count
		)
	end
end

for x=1,10 do
	createPowerArmorMkx(x+2, 10 + 2*x, 30 + 5*x, 5 + 5*x, 400 + 400*x)
end
