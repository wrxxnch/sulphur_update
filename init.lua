-- Sulphur Update for BetterCraft / Mineclonia
-- SPDX-License-Identifier: MIT
local core = minetest
local S = core.get_translator("sulphur_update")

local modname = "sulphur_update"
local function tex(name)
	return name .. ".png"
end

local function register_full_block(name, description, texture, groups, sounds)
	core.register_node(modname .. ":" .. name, {
		description = S(description),
		tiles = { tex(texture) },
		is_ground_content = false,
		stack_max = 64,
		groups = groups or { pickaxey = 1, building_block = 1 },
		sounds = sounds or
			(mcl_sounds and mcl_sounds.node_sound_stone_defaults and mcl_sounds.node_sound_stone_defaults() or {}),
	})
end

local stone_groups = { pickaxey = 1, building_block = 1 }
register_full_block("sulphur_block", "Bloco de enxofre", "sulphur_block",
	{ pickaxey = 1, building_block = 1, material_sulphur = 1 })
register_full_block("cinnabar_block", "Bloco de cinábrio", "cinnabar_block",
	{ pickaxey = 2, building_block = 1, material_rock = 1 })
-- Official Sulfur/Cinnabar family names from the Minecraft Wiki.
register_full_block("cinnabar", "Cinábrio", "cinnabar", { pickaxey = 1, building_block = 1, material_rock = 1 })
register_full_block("chiseled_cinnabar", "Cinábrio talhado", "chiseled_cinnabar", stone_groups)
register_full_block("polished_cinnabar", "Cinábrio polido", "polished_cinnabar", stone_groups)
register_full_block("cinnabar_bricks", "Tijolos de cinábrio", "cinnabar_bricks", stone_groups)
register_full_block("potent_sulfur", "Enxofre potente", "potent_sulfur",
	{ pickaxey = 1, building_block = 1, material_sulphur = 1 })
register_full_block("sulfur", "Enxofre", "sulfur", { pickaxey = 1, building_block = 1, material_sulphur = 1 })
register_full_block("chiseled_sulfur", "Enxofre talhado", "chiseled_sulfur",
	{ pickaxey = 1, building_block = 1, material_sulphur = 1 })
register_full_block("polished_sulfur", "Enxofre polido", "polished_sulfur",
	{ pickaxey = 1, building_block = 1, material_sulphur = 1 })
register_full_block("sulfur_bricks", "Tijolos de enxofre", "sulfur_bricks",
	{ pickaxey = 1, building_block = 1, material_sulphur = 1 })

local spike_groups = { pickaxey = 1, attached_node = 1, material_sulphur = 1 }
local spike_box = { type = "fixed", fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 } }

local function register_spike_model(name, description, model)
	core.register_node(modname .. ":" .. name, {
		description = S(description),
		drawtype = "mesh",
		mesh = model,
		tiles = { tex("sulfur_spike") },
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		selection_box = spike_box,
		collision_box = spike_box,
		groups = spike_groups,
		drop = modname .. ":sulfur_spike",
	})
end

-- Modelos OBJ/MTL com nomes exatos fornecidos pelo usuário.
register_spike_model("sulfur_spike", "Espinho de enxofre", "sulfur_spike.obj")
register_spike_model("sulfur_spike_down_base", "Espinho de enxofre — base inferior", "sulfur_spike_down_base.obj")
register_spike_model("sulfur_spike_down_frustum", "Espinho de enxofre — frustum inferior",
	"sulfur_spike_down_frustum.obj")
register_spike_model("sulfur_spike_down_middle", "Espinho de enxofre — meio inferior", "sulfur_spike_down_middle.obj")
register_spike_model("sulfur_spike_down_tip_merge", "Espinho de enxofre — ponta inferior mesclada",
	"sulfur_spike_down_tip_merge.obj")
register_spike_model("sulfur_spike_down_tip", "Espinho de enxofre — ponta inferior", "sulfur_spike_down_tip.obj")
register_spike_model("sulfur_spike_up_base", "Espinho de enxofre — base superior", "sulfur_spike_up_base.obj")
register_spike_model("sulfur_spike_up_frustum", "Espinho de enxofre — frustum superior", "sulfur_spike_up_frustum.obj")
register_spike_model("sulfur_spike_up_middle", "Espinho de enxofre — meio superior", "sulfur_spike_up_middle.obj")
register_spike_model("sulfur_spike_up_tip_merge", "Espinho de enxofre — ponta superior mesclada",
	"sulfur_spike_up_tip_merge.obj")
register_spike_model("sulfur_spike_up_tip", "Espinho de enxofre — ponta superior", "sulfur_spike_up_tip.obj")

core.register_alias(modname .. ":cinnabar_block_wiki", modname .. ":cinnabar")
core.register_alias(modname .. ":sulfur_block_wiki", modname .. ":sulfur")

core.register_node(modname .. ":sulphur_stalactite", {
	description = S("Estalactite de enxofre"),
	drawtype = "mesh",
	mesh = "sulfur_spike_down_tip.obj",
	tiles = { tex("sulphur_stalactite") },
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	selection_box = { type = "fixed", fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 } },
	collision_box = { type = "fixed", fixed = { -0.2, -0.5, -0.2, 0.2, 0.5, 0.2 } },
	groups = { pickaxey = 1, attached_node = 1, material_sulphur = 1 },
	drop = modname .. ":sulphur_stalactite",
})

core.register_craftitem(modname .. ":bucket_of_sulfur_cube", {
	description = S("Balde com cubo de enxofre"),
	inventory_image = tex("bucket_of_sulfur_cube"),
	stack_max = 1,
	on_place = function(itemstack, placer, pointed_thing)
		if not pointed_thing or pointed_thing.type ~= "node" then return itemstack end
		local pos = pointed_thing.above
		local obj = core.add_entity(pos, modname .. ":sulfur_slime")
		if obj then
			if not core.is_creative_enabled(placer:get_player_name()) then
				itemstack:replace(ItemStack("mcl_buckets:bucket_empty"))
			end
			return itemstack
		end
		return itemstack
	end,
})

if mcl_jukebox and mcl_jukebox.register_record then
	mcl_jukebox.register_record({
		title = "Bounce",
		author = "fingerspit",
		id = "bounce",
		texture = tex(
			"music_disc_bounce"),
		sound = "mcl_jukebox_track_7",
		exclude_from_creeperdrop = true,
		comparator_signal = 8
	})
	core.register_alias(modname .. ":music_disc_bounce", "mcl_jukebox:record_bounce")
else
	core.register_craftitem(modname .. ":music_disc_bounce",
		{ description = S("Disco musical — Bounce"), inventory_image = tex("music_disc_bounce"), stack_max = 1, groups = { music_record = 1 } })
end


core.register_node(modname .. ":sulphur_smoke", {
	description = S("Fumaça de enxofre na água"),
	drawtype = "plantlike",
	tiles = { tex("sulphur_smoke") },
	paramtype = "light",
	walkable = false,
	pointable = true,
	use_texture_alpha = true,
	sunlight_propagates = true,
	groups = { not_in_creative_inventory = 1, attached_node = 1 },
	drop = "",
})

local function craft(output, recipe)
	core.register_craft({ output = modname .. ":" .. output, recipe = recipe })
end
craft("sulphur_block",
	{ { modname .. ":sulphur_stalactite", modname .. ":sulphur_stalactite" }, { modname .. ":sulphur_stalactite", modname .. ":sulphur_stalactite" } })
craft("cinnabar_block",
	{ { modname .. ":cinnabar", modname .. ":cinnabar", modname .. ":cinnabar" }, { modname .. ":cinnabar", modname .. ":cinnabar", modname .. ":cinnabar" }, { modname .. ":cinnabar", modname .. ":cinnabar", modname .. ":cinnabar" } })
craft("sulphur_bricks",
	{ { modname .. ":sulphur_block", modname .. ":sulphur_block" }, { modname .. ":sulphur_block", modname .. ":sulphur_block" } })
craft("cinnabar_bricks",
	{ { modname .. ":cinnabar_block", modname .. ":cinnabar_block" }, { modname .. ":cinnabar_block", modname .. ":cinnabar_block" } })
core.register_craft({ output = modname .. ":sulphur_stalactite 4", recipe = { { modname .. ":sulphur_block" }, { modname .. ":sulphur_block" } } })
core.register_craft({ output = modname .. ":polished_cinnabar 4", recipe = { { modname .. ":cinnabar" }, { modname .. ":cinnabar" } } })
core.register_craft({ output = modname .. ":polished_sulfur 4", recipe = { { modname .. ":sulfur" }, { modname .. ":sulfur" } } })
core.register_craft({ output = modname .. ":potent_sulfur", recipe = { { modname .. ":sulfur", modname .. ":sulfur" }, { modname .. ":sulfur", modname .. ":sulfur" } } })
core.register_craft({ output = modname .. ":chiseled_cinnabar", recipe = { { modname .. ":cinnabar" }, { modname .. ":cinnabar" } } })
core.register_craft({ output = modname .. ":chiseled_sulfur", recipe = { { modname .. ":sulfur" }, { modname .. ":sulfur" } } })
core.register_craft({ output = modname .. ":cinnabar_bricks 4", recipe = { { modname .. ":cinnabar", modname .. ":cinnabar" }, { modname .. ":cinnabar", modname .. ":cinnabar" } } })
core.register_craft({ output = modname .. ":sulfur_bricks 4", recipe = { { modname .. ":sulfur", modname .. ":sulfur" }, { modname .. ":sulfur", modname .. ":sulfur" } } })
core.register_craft({ output = modname .. ":bucket_of_sulfur_cube", recipe = { { "mcl_buckets:bucket_empty", modname .. ":sulfur" } } })
core.register_craft({ output = modname .. ":sulphur_smoke 2", recipe = { { modname .. ":sulphur_dust" }, { "mcl_core:water_source" } } })

-- Extra resource generation, guarded for engines/games without register_ore.
if core.register_ore then
	core.register_ore({
		ore_type = "scatter",
		ore = modname .. ":sulphur_ore",
		wherein = { "mcl_core:stone", "mcl_core:deepslate" },
		clust_scarcity = 13 *
			13 * 13,
		clust_num_ores = 4,
		clust_size = 3,
		y_max = 16,
		y_min = -64
	})
	core.register_ore({
		ore_type = "scatter",
		ore = modname .. ":cinnabar_block",
		wherein = { "mcl_core:stone", "mcl_core:deepslate" },
		clust_scarcity = 17 *
			17 * 17,
		clust_num_ores = 3,
		clust_size = 2,
		y_max = 0,
		y_min = -64
	})
end

local function item_is_block(name)
	return name and name ~= "" and core.registered_nodes[name] and core.registered_nodes[name].walkable
end

local material_rules = {
	wood = { speed = 0.78, gravity = 0.92, jump = 1.0, label = "madeira" },
	stone = { speed = 0.52, gravity = 1.55, jump = 0.72, label = "rocha" },
	ice = { speed = 1.65, gravity = 0.88, jump = 1.10, label = "gelo" },
	default = { speed = 1.0, gravity = 1.0, jump = 1.0, label = "enxofre" },
}

local function classify_material(name)
	if core.get_item_group(name, "wood") > 0 or core.get_item_group(name, "material_wood") > 0 then
		return material_rules
			.wood
	end
	if core.get_item_group(name, "ice") > 0 or core.get_item_group(name, "snowy") > 0 then return material_rules.ice end
	if core.get_item_group(name, "stone") > 0 or core.get_item_group(name, "rock") > 0 or core.get_item_group(name, "pickaxey") > 0 then
		return
			material_rules.stone
	end
	if name == modname .. ":sulphur_block" or core.get_item_group(name, "material_sulphur") > 0 then
		return
			material_rules.default
	end
	return nil
end

local function give_nausea(obj, duration)
	if mcl_potions and mcl_potions.give_effect then
		mcl_potions.give_effect("nausea", obj, 1, duration, false)
	end
end


-- Environmental effects.
core.register_abm({
	label = "Sulphur geyser pulse",
	nodenames = { modname .. ":potent_sulfur" },
	interval = 3,
	chance = 2,
	action = function(pos)
		core.add_particlespawner({
			amount = 18,
			time = 0.7,
			minpos = vector.offset(pos, -0.25, 0.3, -0.25),
			maxpos =
				vector.offset(pos, 0.25, 2.0, 0.25),
			minvel = { x = -0.3, y = 2, z = -0.3 },
			maxvel = { x = 0.3, y = 4, z = 0.3 },
			minacc = { x = 0, y = -2, z = 0 },
			maxacc = { x = 0, y = -1, z = 0 },
			minexptime = 0.5,
			maxexptime = 1.8,
			minsize = 2,
			maxsize = 5,
			texture =
			"sulphur_smoke_particle.png",
			glow = 3
		})
		core.sound_play("fire_large", { pos = pos, gain = 0.15, max_hear_distance = 16 })
	end
})

core.register_abm({
	label = "Sulphur water nausea",
	nodenames = { modname .. ":sulphur_smoke" },
	interval = 2,
	chance = 1,
	action = function(pos)
		for _, obj in ipairs(core.get_objects_inside_radius(pos, 3.5)) do
			if obj:is_player() then give_nausea(obj, 5) end
		end
	end
})

core.register_lbm({
	label = "Sulphur smoke over water",
	name = modname .. ":convert_smoke",
	nodenames = { modname .. ":sulphur_smoke" },
	run_at_every_load = true,
	action = function(pos)
		local below = core.get_node(vector.offset(pos, 0, -1, 0)).name
		if core.get_item_group(below, "water") == 0 and below ~= "mcl_core:water_source" then core.remove_node(pos) end
	end
})

-- Função de IA customizada para simular o Slime original
local function sulfur_slime_ai(self, dtime)
	-- Se o mob estiver morrendo ou sem objeto, não faz nada
	if not self.object:get_luaentity() then return end

	local vel = self.object:get_velocity()
	local rule = self.sulphur_rule or material_rules.default

	-- Verifica se está no chão (velocidade Y próxima de zero)
	if math.abs(vel.y) < 0.1 then
		self.movement_velocity = 0 -- Para de se mover horizontalmente no chão
		
		-- Timer para o próximo pulo
		self._jump_timer = (self._jump_timer or 0) - dtime
		if self._jump_timer <= 0 then
			-- Define o tempo para o próximo pulo (afetado pela velocidade do material)
			self._jump_timer = math.random(2, 4) * (1 / rule.speed)
			
			-- Muda a direção aleatoriamente (como o slime original)
			local new_yaw = math.random() * math.pi * 2
			self.object:set_yaw(new_yaw)

			-- Executa o pulo
			local speed = (self.movement_speed or 10) * rule.speed
			local jump_h = (self.jump_height or 7) * rule.jump
			
			-- Define a velocidade do pulo baseada no Yaw (direção)
			self.object:set_velocity({
				x = -math.sin(new_yaw) * (speed / 2.5), -- Slimes pulam um pouco menos que sua velocidade de corrida
				y = jump_h,
				z = math.cos(new_yaw) * (speed / 2.5)
			})
			
			-- Toca o som de pulo
			core.sound_play("green_slime_jump", {pos = self.object:get_pos(), gain = 0.5, max_hear_distance = 12})
		end
	end
end

-- Definição do Mob
if mcl_mobs and mcl_mobs.register_mob then
	local slime_def = {
		description = S("Slime de enxofre"),
		type = "animal", 
		spawn_class = "passive",
		hp_min = 16,
		hp_max = 16,
		armor = 80,
		damage = 2,
		collisionbox = { -0.75, -0.01, -0.75, 0.75, 1.5, 0.75 },
		visual = "mesh",
		mesh = "mobs_mc_slime.b3d",
		visual_size = { x = 9, y = 9 },
		textures = { { "sulfur_cube_entity.png", "sulfur_cube_entity.png" } },
		
		movement_speed = 10,
		jump_height = 7,
		fall_damage = 0,
		passive = true,
		makes_footstep_sound = false,
		
		sounds = {
			death = "green_slime_death",
			damage = "green_slime_damage",
		},

		drops = { { name = modname .. ":sulphur_dust", chance = 1, min = 1, max = 2 } },
		
		animation = { 
			jump_start = 1, jump_end = 20, jump_speed = 24, jump_loop = false, 
			stand_start = 1, stand_end = 1,
		},
		
		-- Usamos run_ai para nossa lógica de pulo customizada
		run_ai = sulfur_slime_ai,

		on_rightclick = function(self, clicker)
			local stack = clicker:get_wielded_item()
			local name = stack:get_name()
			
			-- Coleta no balde
			if name == "mcl_buckets:bucket_empty" then
				if not core.is_creative_enabled(clicker:get_player_name()) then
					clicker:set_wielded_item(ItemStack(modname .. ":bucket_of_sulfur_cube"))
				end
				self.object:remove()
				return
			end
			
			-- Troca de material (Cubo de Enxofre)
			if item_is_block(name) and name ~= modname .. ":sulfur_slime_spawn_egg" then
				local rule = classify_material(name)
				if rule then
					self.sulphur_material = rule.label
					self.sulphur_rule = rule
					self.object:set_acceleration({ x = 0, y = -9.8 * rule.gravity, z = 0 })
					self.object:set_properties({
						nametag = S("Cubo de enxofre: @1", rule.label),
						nametag_color = "#f4d35e"
					})
					if not core.is_creative_enabled(clicker:get_player_name()) then
						stack:take_item()
						clicker:set_wielded_item(stack)
					end
					core.sound_play("default_place_node", { pos = self.object:get_pos(), gain = 0.5, max_hear_distance = 12 })
				end
			end
		end,

		do_custom = function(self, dtime, moveresult)
			-- Salto extra se for madeira
			if self.sulphur_rule and self.sulphur_rule.label == "madeira" and moveresult and moveresult.touching_ground then
				local v = self.object:get_velocity()
				if math.abs(v.y) < 0.2 then 
					self.object:set_velocity({ x = v.x, y = 8.5, z = v.z }) 
				end
			end
		end,
	}

	-- Registro do Mob e do Ovo (APENAS AQUI DENTRO)
	mcl_mobs.register_mob(modname .. ":sulfur_slime", slime_def)
	mcl_mobs.register_egg(modname .. ":sulfur_slime", S("Slime de enxofre"), "#f4d35e", "#7a6a2f", true)
end