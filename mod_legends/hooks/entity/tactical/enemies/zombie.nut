::mods_hookExactClass("entity/tactical/enemies/zombie", function (o) {

	o.onInit = function () {
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Zombie);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= this.Const.World.Scaling.Undead.WiedergangerDamageIncreaseDay) {
			b.DamageTotalMult += 0.1;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.ZombieMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local app = this.getItems().getAppearance();
		app.Body = "bust_naked_body_0" + this.Math.rand(0, 2);
		app.Corpse = app.Body + "_dead";
		this.m.InjuryType = this.Math.rand(1, 4);
		local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
		this.addSprite("background");
		this.addSprite("socket").setBrush("bust_base_undead");
		this.addSprite("quiver").setHorizontalFlipping(true);
		local body = this.addSprite("body");
		body.setHorizontalFlipping(true);
		body.setBrush(this.Const.Items.Default.PlayerNakedBody);
		body.Saturation = 0.5;
		body.varySaturation(0.2);
		body.Color = this.createColor("#c1ddaa");
		body.varyColor(0.05, 0.05, 0.05);
		local tattoo_body = this.addSprite("tattoo_body");
		tattoo_body.setHorizontalFlipping(true);
		tattoo_body.Saturation = 0.9;
		tattoo_body.setBrightness(0.75);
		local body_injury = this.addSprite("body_injury");
		body_injury.Visible = true;
		body_injury.setBrightness(0.75);
		body_injury.setBrush("zombify_body_01");
		this.addSprite("armor").setHorizontalFlipping(true);
		this.addSprite("armor_layer_chain").setHorizontalFlipping(true);
		this.addSprite("armor_layer_plate").setHorizontalFlipping(true);
		this.addSprite("armor_layer_tabbard").setHorizontalFlipping(true);
		this.addSprite("armor_upgrade_back").setHorizontalFlipping(true);
		this.addSprite("armor_layer_cloak").setHorizontalFlipping(true);
		this.addSprite("armor_layer_cloak_front").setHorizontalFlipping(true);
		this.addSprite("armor_upgrade_back_top").setHorizontalFlipping(true);
		this.addSprite("surcoat");
		this.addSprite("armor_upgrade_front");
		local body_blood_always = this.addSprite("body_blood_always");
		body_blood_always.setBrush("bust_body_bloodied_01");
		this.addSprite("shaft");
		local head = this.addSprite("head");
		head.setHorizontalFlipping(true);
		head.setBrush(this.Const.Faces.AllHuman[this.Math.rand(0, this.Const.Faces.AllHuman.len() - 1)]);
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local tattoo_head = this.addSprite("tattoo_head");
		tattoo_head.setHorizontalFlipping(true);
		tattoo_head.Saturation = 0.9;
		tattoo_head.setBrightness(0.75);
		local beard = this.addSprite("beard");
		beard.setHorizontalFlipping(true);
		beard.varyColor(0.02, 0.02, 0.02);

		if (this.Math.rand(1, 100) <= 50) {
			if (this.m.InjuryType == 4) {
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.ZombieExtended[this.Math.rand(0, this.Const.Beards.ZombieExtended.len() - 1)]);
				beard.setBrightness(0.9);
			} else {
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.Zombie[this.Math.rand(0, this.Const.Beards.Zombie.len() - 1)]);
			}
		}

		local injury = this.addSprite("injury");
		injury.setHorizontalFlipping(true);
		injury.setBrush("zombify_0" + this.m.InjuryType);
		injury.setBrightness(0.75);
		local hair = this.addSprite("hair");
		hair.setHorizontalFlipping(true);
		hair.Color = beard.Color;

		if (this.Math.rand(0, this.Const.Hair.Zombie.len()) != this.Const.Hair.Zombie.len()) {
			hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.Zombie[this.Math.rand(0, this.Const.Hair.Zombie.len() - 1)]);
		}

		foreach (a in this.Const.CharacterSprites.Helmets) {
			this.addSprite(a).setHorizontalFlipping(true);
		}

		local beard_top = this.addSprite("beard_top");
		beard_top.setHorizontalFlipping(true);

		if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top")) {
			beard_top.setBrush(beard.getBrush().Name + "_top");
			beard_top.Color = beard.Color;
		}

		// this.addSprite("armor_upgrade_front"); already doing this above
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.setHorizontalFlipping(true);
		body_blood.Visible = this.Math.rand(1, 100) <= 33;
		local body_dirt = this.addSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.setHorizontalFlipping(true);
		body_dirt.Visible = this.Math.rand(1, 100) <= 50;
		local rage = this.addSprite("status_rage");
		rage.setHorizontalFlipping(true);
		rage.setBrush("mind_control");
		rage.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("arms_icon").setBrightness(0.85);
		this.getSprite("status_rooted").Scale = 0.55;

		this.setHitpoints(this.getHitpointsMax() * this.Math.rand(45, 100) * 0.01);
		::Legends.Effects.grant(this, ::Legends.Effect.DoubleGrip);
		::Legends.Actives.grant(this, ::Legends.Active.ZombieBite);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);

		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
		}
	}

	o.assignRandomEquipment = function () {

		if (this.Math.rand(1, 100) <= 50) {
			local weapons = [
				"weapons/knife",
				"weapons/bludgeon",
				"weapons/militia_spear",
				"weapons/pickaxe",
				"weapons/butchers_cleaver",
				"weapons/legend_hammer",
				"weapons/legend_shovel",
				"weapons/legend_tipstaff",
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		local aList = [
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic],
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.leather_wraps],
			[1, ::Legends.Armor.Standard.apron],
			[1, ::Legends.Armor.Standard.butcher_apron],
			[1, ::Legends.Armor.Standard.monk_robe]
		];
		local armor = this.Const.World.Common.pickArmor(aList);

		if (this.Math.rand(1, 100) <= 50) {
			armor.setArmor(this.Math.round(armor.getArmorMax() / 2 - 1));
		}

		this.m.Items.equip(armor);

		if (this.Math.rand(1, 100) <= 33) {
			local item = this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.aketon_cap],
				[1, ::Legends.Helmet.Standard.full_aketon_cap],
				[1, ::Legends.Helmet.Standard.kettle_hat],
				[1, ::Legends.Helmet.Standard.padded_kettle_hat],
				[1, ::Legends.Helmet.Standard.full_leather_cap]
			]);
			if (item != null) {
				if (this.Math.rand(1, 100) <= 50) {
					item.setArmor(item.getArmorMax() / 2 - 1);
				}
			}

			this.m.Items.equip(item);
		}
	}

	o.onDeath = function ( _killer, _skill, _tile, _fatalityType ) {
		local appearance = this.getItems().getAppearance();
		local targetBrightness = 0.9;
		local targetScale = 0.9;
		local flip = this.Math.rand(1, 100) < 50;
		this.m.IsCorpseFlipped = flip;
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");
		local sprite_hair = this.getSprite("hair");
		local sprite_beard = this.getSprite("beard");
		local sprite_beard_top = this.getSprite("beard_top");
		local tattoo_body = this.getSprite("tattoo_body");
		local tattoo_head = this.getSprite("tattoo_head");

		if (_tile != null) {
			local decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
			decal.Color = sprite_body.Color;
			decal.Saturation = sprite_body.Saturation;
			decal.Scale = targetScale;
			decal.setBrightness(targetBrightness);

			if (tattoo_body.HasBrush)
			{
				decal = _tile.spawnDetail(tattoo_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Color = tattoo_body.Color;
				decal.Saturation = tattoo_body.Saturation;
				decal.Scale = targetScale;
				decal.setBrightness(targetBrightness);
			}

			local armorLayers = [
				"CorpseArmor",
				"CorpseArmorLayerChain",
				"CorpseArmorLayerPlate",
				"CorpseArmorLayerTabbard",
				"CorpseArmorLayerCloakBack",
				"CorpseArmorLayerCloakFront"
			];

			if (appearance.CorpseArmorUpgradeFront != "") {
		    	armorLayers.push("CorpseArmorUpgradeBack");
			} 
			else {
    			armorLayers.insert(3, "CorpseArmorUpgradeBack");
			}

			foreach (layer in armorLayers) {
				if (appearance[layer] != "") {
					local decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Scale = targetScale;
					decal.setBrightness(targetBrightness);
				}
			}

			if (this.m.Surcoat != null)
			{
				decal = _tile.spawnDetail("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = targetScale;
				decal.setBrightness(targetBrightness);
			}

			local helmetLowerLayers = [
					"HelmetLayerVanityLowerCorpse",
					"HelmetLayerVanity2LowerCorpse"
			];
			local helmetLayers = [
					"HelmetCorpse",
					"HelmetLayerHelmLowerCorpse",
					"HelmetLayerTopLowerCorpse",
					"HelmetLayerHelmCorpse",
					"HelmetLayerTopCorpse",
					"HelmetLayerVanityCorpse",
					"HelmetLayerVanity2Corpse"
			];

			if (_fatalityType != this.Const.FatalityType.Decapitated && !this.m.IsHeadless)	{
				foreach (layer in helmetLowerLayers) {
					if (appearance[layer] != "") {
						local decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
							decal.Scale = targetScale;
							decal.setBrightness(targetBrightness);
					}
				}

				if (!appearance.HideCorpseHead)
				{
					local decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = targetScale;
					decal.setBrightness(targetBrightness);

					if (tattoo_head.HasBrush)
					{
						local decal = _tile.spawnDetail(tattoo_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Color = tattoo_head.Color;
						decal.Saturation = tattoo_head.Saturation;
						decal.Scale = targetScale;
						decal.setBrightness(targetBrightness);
					}
				}

				if (!appearance.HideBeard && !appearance.HideCorpseHead && sprite_beard.HasBrush)
				{
					local decal = _tile.spawnDetail(sprite_beard.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_beard.Color;
					decal.Saturation = sprite_beard.Saturation;
					decal.Scale = targetScale;
					decal.setBrightness(targetBrightness);

					if (sprite_beard_top.HasBrush)
					{
						local decal = _tile.spawnDetail(sprite_beard_top.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Color = sprite_beard.Color;
						decal.Saturation = sprite_beard.Saturation;
						decal.Scale = targetScale;
						decal.setBrightness(targetBrightness);
					}
				}

				if (!appearance.HideCorpseHead)
				{
					local decal = _tile.spawnDetail("zombify_0" + this.m.InjuryType + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Scale = targetScale;
					decal.setBrightness(0.75);
				}

				if (!appearance.HideHair && !appearance.HideCorpseHead && sprite_hair.HasBrush)
				{
					local decal = _tile.spawnDetail(sprite_hair.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_hair.Color;
					decal.Saturation = sprite_hair.Saturation;
					decal.Scale = targetScale;
					decal.setBrightness(targetBrightness);
				}

				if (_fatalityType == this.Const.FatalityType.Smashed)
				{
					local decal = _tile.spawnDetail("bust_head_smashed_02", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.setBrightness(0.8);
				}
				else if (appearance.HelmetCorpse != "")	{
					foreach (layer in helmetLayers) {
						if (appearance[layer] != "") {
							local decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
							decal.Scale = targetScale;
							decal.setBrightness(targetBrightness);
						}
					}
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated && !this.m.IsHeadless)
			{
				local layers = [];

				//uncomment this and the one lower if we ever fix offsets on helms to accommodate decap heads having hats
				//foreach (layer in helmetLowerLayers) {
				//	if (appearance[layer] != "") {
				//		layers.push(appearance[layer]);
				//	}
				//}

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (!appearance.HideCorpseHead && tattoo_head.HasBrush)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (!appearance.HideBeard && sprite_beard.HasBrush)
				{
					layers.push(sprite_beard.getBrush().Name + "_dead");
				}

				if (!appearance.HideCorpseHead)
				{
					layers.push("zombify_0" + this.m.InjuryType + "_dead");
				}

				if (!appearance.HideHair && sprite_hair.HasBrush)
				{
					layers.push(sprite_hair.getBrush().Name + "_dead");
				}

				//foreach (layer in helmetLayers) {
				//	if (appearance[layer] != "") {
				//		layers.push(appearance[layer]);
				//	}
				//}

				if (!appearance.HideBeard && sprite_beard_top.HasBrush)
				{
					layers.push(sprite_beard_top.getBrush().Name + "_dead");
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), -90.0, "bust_head_dead_bloodpool_zombified");
				local idx = 0;

				//foreach (layer in helmetLowerLayers) {
				//	if (appearance[layer] != "") {
				//		decap[idx].Scale = targetScale;
				//		decap[idx].setBrightness(targetBrightness);
				//		idx = ++idx;
				//	}
				//}

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = targetScale;
					decap[idx].setBrightness(targetBrightness);
					idx = ++idx;
				}

				if (!appearance.HideCorpseHead && tattoo_head.HasBrush)
				{
					decap[idx].Color = tattoo_head.Color;
					decap[idx].Saturation = tattoo_head.Saturation;
					decap[idx].Scale = targetScale;
					decap[idx].setBrightness(targetBrightness);
					idx = ++idx;
				}

				if (!appearance.HideBeard && sprite_beard.HasBrush)
				{
					decap[idx].Color = sprite_beard.Color;
					decap[idx].Saturation = sprite_beard.Saturation;
					decap[idx].Scale = targetScale;
					decap[idx].setBrightness(targetBrightness);
					idx = ++idx;
				}

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Scale = targetScale;
					decap[idx].setBrightness(0.75);
					idx = ++idx;
				}

				if (!appearance.HideHair && sprite_hair.HasBrush)
				{
					decap[idx].Color = sprite_hair.Color;
					decap[idx].Saturation = sprite_hair.Saturation;
					decap[idx].Scale = targetScale;
					decap[idx].setBrightness(targetBrightness);
					idx = ++idx;
				}

				//foreach (layer in helmetLayers) {
				//	if (appearance[layer] != "") {
				//		decap[idx].Scale = targetScale;
				//		decap[idx].setBrightness(targetBrightness);
				//		idx = ++idx;
				//	}
				//}

				if (!appearance.HideBeard && sprite_beard_top.HasBrush)
				{
					decap[idx].Color = sprite_beard.Color;
					decap[idx].Saturation = sprite_beard.Saturation;
					decap[idx].Scale = targetScale;
					decap[idx].setBrightness(targetBrightness);
				}
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}
				else
				{
					decal = _tile.spawnDetail(appearance.Corpse + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}

				decal.Saturation = 0.85;
				decal.setBrightness(0.85);
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}
				else
				{
					decal = _tile.spawnDetail(appearance.Corpse + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}

				decal.Saturation = 0.85;
				decal.setBrightness(0.85);
			}

			if (appearance.CorpseArmorUpgradeFront != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmorUpgradeFront, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = targetScale;
				decal.setBrightness(targetBrightness);
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
		}

		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		this.dropLoot(_tile, tileLoot, !flip);
		local corpse = this.generateCorpse(_tile, _fatalityType, _killer);

		if (_tile == null)
		{
			this.Tactical.Entities.addUnplacedCorpse(corpse);
		}
		else
		{
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.onFactionChanged = function () {
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("background").setHorizontalFlipping(flip);
		this.getSprite("shaft").setHorizontalFlipping(flip);
		this.getSprite("surcoat").setHorizontalFlipping(flip);
		this.getSprite("quiver").setHorizontalFlipping(flip);
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("tattoo_body").setHorizontalFlipping(flip);
		this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_chain").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_plate").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_tabbard").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_cloak").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_back").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_front").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("tattoo_head").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("beard").setHorizontalFlipping(flip);
		this.getSprite("hair").setHorizontalFlipping(flip);
		this.getSprite("beard_top").setHorizontalFlipping(flip);
		this.getSprite("body_blood").setHorizontalFlipping(flip);
		this.getSprite("dirt").setHorizontalFlipping(flip);
		this.getSprite("status_rage").setHorizontalFlipping(flip);
		foreach (a in this.Const.CharacterSprites.Helmets) {
			if (!this.hasSprite(a)) {
				continue;
			}
			this.getSprite(a).setHorizontalFlipping(flip);
		}
	}
});
