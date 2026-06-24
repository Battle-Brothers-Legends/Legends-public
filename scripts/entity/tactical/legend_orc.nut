this.legend_orc <- this.inherit("scripts/entity/tactical/actor", {
	//this file uses the inherit hijack in order to position itself between vanilla orcs and actor (legend orcs simply inherit directly)

	function onDeath(_killer, _skill, _tile, _fatalityType) {
		local appearance = this.getItems().getAppearance();
		local targetBrightness = 0.9;
		local targetScale = 0.9;
		local flip = this.Math.rand(1, 100) < 50;

		if (_tile != null) {
			this.m.IsCorpseFlipped = flip;
			this.spawnBloodPool(_tile, 1);
			local sprite_body = this.getSprite("body");
			local sprite_head = this.getSprite("head");
			local sprite_prefix = sprite_body.getBrush().Name.slice(0, sprite_body.getBrush().Name.find("_body"));
			local tattoo_head = null;
			local tattoo_body = null;
			
			if (this.hasSprite("tattoo_head")) {
				tattoo_head = this.getSprite("tattoo_head");
			}
			if (this.hasSprite("tattoo_body")) {
				tattoo_body = this.getSprite("tattoo_body");
			}
			local decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = sprite_body.Color;
			decal.Saturation = sprite_body.Saturation;
			decal.Scale = targetScale;
			decal.setBrightness(targetBrightness);

			if (tattoo_body != null && tattoo_body.HasBrush) {
				decal = _tile.spawnDetail(tattoo_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
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
			} else {
				armorLayers.insert(3, "CorpseArmorUpgradeBack");
			}

			foreach (layer in armorLayers) {
				if (appearance[layer] != "") {
					local decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = targetScale;
					decal.setBrightness(targetBrightness);
				}
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

			if (_fatalityType != this.Const.FatalityType.Decapitated) {
				foreach (layer in helmetLowerLayers) {
					if (appearance[layer] != "") {
						local decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, !flip);
						decal.Scale = targetScale;
						decal.setBrightness(targetBrightness);
					}
				}

				if (!appearance.HideCorpseHead) {
					decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = targetScale;
					decal.setBrightness(targetBrightness);
				}

				if (tattoo_head != null && tattoo_head.HasBrush) {
					decal = _tile.spawnDetail(tattoo_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = tattoo_head.Color;
					decal.Saturation = tattoo_head.Saturation;
					decal.Scale = targetScale;
					decal.setBrightness(targetBrightness);
				}

				foreach (layer in helmetLayers) {
					if (appearance[layer] != "") {
						decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, !flip, false, this.createVec(flip ? -25 : 25, 25));
						decal.Scale = targetScale;
						decal.setBrightness(targetBrightness);
					}
				}
			} else if (_fatalityType == this.Const.FatalityType.Decapitated) {
				local layers = [];

				//uncomment this and the one lower if we ever fix offsets on helms to accommodate decap heads having hats
				//foreach (layer in helmetLowerLayers) {
				//	if (appearance[layer] != "") {
				//		layers.push(appearance[layer]);
				//	}
				//}

				if (!appearance.HideCorpseHead) {
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (tattoo_head != null && !appearance.HideCorpseHead && tattoo_head.HasBrush) {
					layers.push(tattoo_head.getBrush().Name + "_dead");
				}

				//foreach (layer in helmetLayers) {
				//	if (appearance[layer] != "") {
				//		layers.push(appearance[layer]);
				//	}
				//}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-50, 30), 180.0, sprite_prefix + "_head_dead_bloodpool");
				local idx = 0;

				//foreach (layer in helmetLowerLayers) {
				//	if (appearance[layer] != "") {
				//		decap[idx].Scale = targetScale;
				//		decap[idx].setBrightness(targetBrightness);
				//		idx = ++idx;
				//	}
				//}

				if (!appearance.HideCorpseHead) {
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = targetScale;
					decap[idx].setBrightness(targetBrightness);
					idx = ++idx;
				}

				if (tattoo_head != null && !appearance.HideCorpseHead && tattoo_head.HasBrush) {
					decap[idx].Color = tattoo_head.Color;
					decap[idx].Saturation = tattoo_head.Saturation;
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
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled && sprite_prefix != "bust_orc_04") { // warlords have very heavy armor and no guts sprites
				if (appearance.CorpseArmor != "") {
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_guts", this.Const.Tactical.DetailFlag.Corpse, flip);
				} else {
					decal = _tile.spawnDetail(sprite_prefix + "_body_dead_guts", this.Const.Tactical.DetailFlag.Corpse, flip);
				}
				decal.Scale = targetScale;
			} else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow) {
				if (appearance.CorpseArmor != "") {
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				} else {
					decal = _tile.spawnDetail(sprite_prefix + "_armor_01_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				}
				decal.Scale = targetScale;
			} else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin) {
				if (appearance.CorpseArmor != "") {
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				} else {
					decal = _tile.spawnDetail(sprite_prefix + "_armor_01_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				}
				decal.Scale = targetScale;
			}

			this.spawnTerrainDropdownEffect(_tile);
		}

		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		this.dropLoot(_tile, tileLoot, !flip);
		local corpse = this.generateCorpse(_tile, _fatalityType, _killer);

		if (_tile == null) {
			this.Tactical.Entities.addUnplacedCorpse(corpse);
		} else {
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		//this.getItems().dropAll(_tile, _killer, flip); //in orc elite, why?
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function updateRageVisuals( _rage ) {
		this.setDirty(true);
	}
});
