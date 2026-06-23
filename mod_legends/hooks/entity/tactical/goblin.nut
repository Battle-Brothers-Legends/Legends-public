::mods_hookExactClass("entity/tactical/goblin", function (o) {
	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
	}

	o.onDeath = function (_killer, _skill, _tile, _fatalityType) {
		local appearance = this.getItems().getAppearance();
		local targetBrightness = 0.9;
		local targetScale = 0.95;
		local flip = this.Math.rand(1, 100) < 50;

		if (_tile != null) {
			this.m.IsCorpseFlipped = flip;
			local skin = this.getSprite("body");
			local decal = _tile.spawnDetail("bust_goblin_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.setBrightness(targetBrightness);
			decal.Scale = targetScale;

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
						local decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, flip);
						decal.Scale = targetScale;
						decal.setBrightness(targetBrightness);
					}
				}

				if (!appearance.HideCorpseHead) {
					decal = _tile.spawnDetail(this.getSprite("head").getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = skin.Color;
					decal.Saturation = skin.Saturation;
					decal.setBrightness(targetBrightness);
					decal.Scale = targetScale;
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

				layers.push(this.getSprite("head").getBrush().Name + "_dead");

				//foreach (layer in helmetLayers) {
				//	if (appearance[layer] != "") {
				//		layers.push(appearance[layer]);
				//	}
				//}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-50, 30), 180.0, this.getSprite("head").getBrush().Name + "_dead_bloodpool");
				local idx = 0;

				//foreach (layer in helmetLowerLayers) {
				//	if (appearance[layer] != "") {
				//		decap[idx].setBrightness(targetBrightness);
				//		idx = ++idx;
				//	}
				//}
				
				decap[idx].Color = skin.Color;
				decap[idx].Saturation = skin.Saturation;
				decap[idx].setBrightness(targetBrightness);
				decap[idx].Scale = targetScale;
				idx = ++idx;

				//foreach (layer in helmetLayers) {
				//	if (appearance[layer] != "") {
				//		decap[idx].setBrightness(targetBrightness);
				//		idx = ++idx;
				//	}
				//}
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled) {
				local decal = _tile.spawnDetail("bust_goblin_body_dead_guts", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = targetScale;
			} else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow) {
				decal = _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = targetScale;
			} else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin) {
				decal = _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
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
