this.legend_flesh_golem <- this.inherit("scripts/entity/tactical/actor", {
	//this file uses the inherit hijack in order to position itself between vanilla flesh golems and actor

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
			local decal = _tile.spawnDetail(sprite_prefix + "_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = sprite_body.Color;
			decal.Saturation = sprite_body.Saturation;
			decal.Scale = targetScale;
			decal.setBrightness(targetBrightness);

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

				foreach (layer in helmetLayers) {
					if (appearance[layer] != "") {
						decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, flip);
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

				//foreach (layer in helmetLayers) {
				//	if (appearance[layer] != "") {
				//		layers.push(appearance[layer]);
				//	}
				//}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-75, 50), 90.0, sprite_head.getBrush().Name + "_dead_bloodpool");
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

				//foreach (layer in helmetLayers) {
				//	if (appearance[layer] != "") {
				//		decap[idx].Scale = targetScale;
				//		decap[idx].setBrightness(targetBrightness);
				//		idx = ++idx;
				//	}
				//}
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled) {
				decal = _tile.spawnDetail("guts_flesh_golem_body_02_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = targetScale;
			} else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow) {
				decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = targetScale;
			} else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin) {
				decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
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

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}
});
