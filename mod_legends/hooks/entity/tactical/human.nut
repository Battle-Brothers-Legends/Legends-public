::mods_hookExactClass("entity/tactical/human", function(o)
{

	o.m.Outfits <- [];  //Always overridden if it's used
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Gender = -1;
	}

	o.getPronoun <- function (_neuter)
	{
		return this.Const.LegendMod.getPronoun(this.getGender(), _neuter);
	}

	// -1 = Default Male, 0 = Male, 1 = Female
	o.getGender <- function ()
	{
		return this.m.Gender;
	}

	o.setGender <- function ( _v, _reroll = true)
	{
		if ("LegendMod" in this.World && ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled")
			_v = 0;

		this.m.Gender = _v;
		if(this.m.Gender == 1)
		{
			this.m.Faces = this.Const.Faces.AllFemale;
			this.m.Beards = null;
			this.m.Bodies = this.Const.Bodies.AllFemale;
			this.m.BeardChance = 0;
			this.m.Hairs = this.Const.Hair.AllFemale;
			if (this.m.Ethnicity == 1)
			{
				this.m.Bodies = this.Const.Bodies.SouthernFemale;
				this.m.Faces = this.Const.Faces.SouthernFemale;
				this.m.Hairs = this.Const.Hair.SouthernFemale;
				this.m.HairColors = this.Const.HairColors.Southern;
			}

			if (_reroll)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.WomanSounds.len() - 1);
				this.m.Body = this.Math.rand(0, this.m.Bodies.len() - 1);
			}

			this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.Const.WomanSounds[this.m.VoiceSet].NoDamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = this.Const.WomanSounds[this.m.VoiceSet].DamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.Death] = this.Const.WomanSounds[this.m.VoiceSet].Death;
			this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.Const.WomanSounds[this.m.VoiceSet].Flee;
			this.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = this.Const.WomanSounds[this.m.VoiceSet].Fatigue;
			this.m.SoundPitch = this.Math.rand(105, 115) * 0.01;
		}
		else
		{
			if (_reroll)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.HumanSounds.len() - 1);
				this.m.Body = this.Math.rand(0, this.m.Bodies.len() - 1);
			}
			this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.Const.HumanSounds[this.m.VoiceSet].NoDamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = this.Const.HumanSounds[this.m.VoiceSet].DamageReceived;
			this.m.Sound[this.Const.Sound.ActorEvent.Death] = this.Const.HumanSounds[this.m.VoiceSet].Death;
			this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.Const.HumanSounds[this.m.VoiceSet].Fatigue;
			this.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = this.Const.HumanSounds[this.m.VoiceSet].Fatigue;
			this.m.SoundPitch = this.Math.rand(95, 105) * 0.01;
		}

		this.m.SoundVolume[this.Const.Sound.ActorEvent.NoDamageReceived] = 1.4;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Flee] = 1.1;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Fatigue] = 0.95;
	}

	o.playSound = function ( _type, _volume, _pitch = 1.0 )
	{
		if (this.m.Sound[_type].len() == 0)
		{
			return;
		}

		local volume = 1.0;
		if(this.m.Gender == 1)
		{
			if (this.m.VoiceSet > this.Const.WomanSounds.len() - 1)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.WomanSounds.len() - 1);
			}
			volume *= this.Const.WomanSounds[this.m.VoiceSet].Volume
		}
		else
		{
			volume *= this.Const.HumanSounds[this.m.VoiceSet].Volume
		}

		this.Sound.play(this.m.Sound[_type][this.Math.rand(0, this.m.Sound[_type].len() - 1)], volume, this.getPos(), _pitch);
	}

	o.onDeath = function ( _killer, _skill, _tile, _fatalityType ) {
		local originalFunc = null;
		local needToCheese = this.getFlags().get("donkey");

		if (_tile != null && needToCheese) {
			// a cheese to stop donkey background from being raised back as zombie during undead crisis
			originalFunc = ::World.FactionManager.get().isUndeadScourge;
			::World.FactionManager.get().isUndeadScourge = function () {
				return false
			};
		}

		local appearance = this.getItems().getAppearance();
		local targetBrightness = 0.9;
		local targetScale = 0.9;
		local flip = this.Math.rand(1, 100) < 50;
		this.m.IsCorpseFlipped = flip;

		if (_tile != null) {
			local sprite_body = this.getSprite("body");
			local sprite_head = this.getSprite("head");
			local sprite_hair = this.getSprite("hair");
			local sprite_beard = this.getSprite("beard");
			local sprite_beard_top = this.getSprite("beard_top");
			local sprite_accessory = this.getSprite("accessory");
			local sprite_accessory_special = this.getSprite("accessory_special");
			local sprite_body_tattoo = this.getSprite("tattoo_body");
			local sprite_head_tattoo = this.getSprite("tattoo_head");
			local decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
			decal.Color = sprite_head.Color;
			decal.Saturation = sprite_head.Saturation;
			decal.Scale = targetScale;
			decal.setBrightness(targetBrightness);

			if (sprite_body_tattoo.HasBrush && this.doesBrushExist(sprite_body_tattoo.getBrush().Name + "_dead"))
			{
				local decal = _tile.spawnDetail(sprite_body_tattoo.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Color = sprite_head.Color;
				decal.Saturation = sprite_head.Saturation;
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

			if (sprite_accessory.HasBrush && this.doesBrushExist(sprite_accessory.getBrush().Name + "_dead"))
			{
				decal = _tile.spawnDetail(sprite_accessory.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = targetScale;
				decal.setBrightness(targetBrightness);
			}

			if (sprite_accessory_special.HasBrush && this.doesBrushExist(sprite_accessory_special.getBrush().Name + "_dead"))
			{
				decal = _tile.spawnDetail(sprite_accessory_special.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = targetScale;
				decal.setBrightness(targetBrightness);
			}

			if (_fatalityType == this.Const.FatalityType.None && (!_skill || _skill.getProjectileType() == this.Const.ProjectileType.None) && this.Math.rand(1, 100) <= 33)
			{
				decal = _tile.spawnDetail("dead_body_splatter", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Alpha = 160;
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				decal = _tile.spawnDetail("bust_body_guts_0" + this.Math.rand(1, 3), this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = targetScale;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}
				else
				{
					decal = _tile.spawnDetail(appearance.Corpse + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}

				decal.Scale = targetScale;
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

				decal.Scale = targetScale;
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
				}

				if (sprite_head_tattoo.HasBrush && this.doesBrushExist(sprite_head_tattoo.getBrush().Name + "_dead"))
				{
					local decal = _tile.spawnDetail(sprite_head_tattoo.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = targetScale;
					decal.setBrightness(targetBrightness);
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
					decal = _tile.spawnDetail("bust_head_smashed_01", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Scale = targetScale;
				}
				else {
					foreach (layer in helmetLayers) {
						if (appearance[layer] != "") {
							local decal = _tile.spawnDetail(appearance[layer], this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
							decal.Scale = targetScale;
							decal.setBrightness(targetBrightness);
						}
					}
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
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

				if (!appearance.HideCorpseHead && sprite_head_tattoo.HasBrush && this.doesBrushExist(sprite_head_tattoo.getBrush().Name + "_dead"))
				{
					layers.push(sprite_head_tattoo.getBrush().Name + "_dead");
				}

				if (!appearance.HideBeard && sprite_beard.HasBrush)
				{
					layers.push(sprite_beard.getBrush().Name + "_dead");
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

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), -90.0, "bust_head_dead_bloodpool");
				local idx = 0;

				//foreach (layer in helmetLowerLayers) {
				//	if (appearance[layer] != "") {
				//		decap[idx].Scale = targetScale;
				//		decap[idx].setBrightness(targetBrightness);
				//		idx = ++idx;
				//	}
				//}

				if (!appearance.HideCorpseHead)	{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = targetScale;
					decap[idx].setBrightness(targetBrightness);
					idx = ++idx;
				}

				if (!appearance.HideCorpseHead && sprite_head_tattoo.HasBrush && this.doesBrushExist(sprite_head_tattoo.getBrush().Name + "_dead"))	{
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

		if (_fatalityType != this.Const.FatalityType.Unconscious) {
			this.dropLoot(_tile, tileLoot, !flip);
		}

		local corpse = this.generateCorpse(_tile, _fatalityType, _killer);

		if (_tile == null) {
			this.Tactical.Entities.addUnplacedCorpse(corpse);
		} else {
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
		if (_tile != null) {
			_tile.Properties.get("Corpse").isHuman = 1;

			if (needToCheese) {
				_tile.Properties.get("Corpse").IsResurrectable = false; // mark as can't be raised back as undead
				::World.FactionManager.get().isUndeadScourge = originalFunc; // undo the cheese
			}
		}
	}

	local onFactionChanged = o.onFactionChanged;
	o.onFactionChanged = function()
	{
		onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("permanent_injury_scarred").setHorizontalFlipping(flip);
		this.getSprite("permanent_injury_burned").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_chain").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_plate").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_tabbard").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_cloak_front").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_cloak").setHorizontalFlipping(flip);

		this.getSprite("helmet_helm_lower").setHorizontalFlipping(flip);
		this.getSprite("helmet_top_lower").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity_lower").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity_lower_2").setHorizontalFlipping(flip);
		this.getSprite("helmet_helm").setHorizontalFlipping(flip);
		this.getSprite("helmet_top").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity").setHorizontalFlipping(flip);
		this.getSprite("helmet_vanity_2").setHorizontalFlipping(flip);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		if (this.m.Body >= this.m.Bodies.len())
			this.m.Body = this.Math.rand(0, this.m.Bodies.len() - 1);

		local self = this; // attempting to inject new sprite layer at certain positions
		local original_addSprite = self.addSprite;
		self.addSprite = function( _id )
		{
			if (_id == "accessory" || _id == "accessory_special" || _id == "armor_upgrade_back" || _id == "armor_upgrade_front")
				return null;
			else if (_id == "surcoat") {
				original_addSprite("armor_layer_chain");
				original_addSprite("armor_layer_plate");
				original_addSprite("armor_layer_tabbard");
			}
			else if (_id == "helmet") {
				original_addSprite("accessory");
				original_addSprite("accessory_special");
				original_addSprite("helmet_vanity_lower");
				original_addSprite("helmet_vanity_lower_2");
			}

			local layer = original_addSprite(_id);

			if (_id == "helmet") {
				original_addSprite("helmet_helm_lower");
				original_addSprite("helmet_top_lower");
			}
			else if (_id == "surcoat") {
				original_addSprite("armor_upgrade_back");
				original_addSprite("armor_layer_cloak");
				original_addSprite("armor_layer_cloak_front");
				original_addSprite("armor_upgrade_back_top");
			}
			else if (_id == "permanent_injury_2") {
				original_addSprite("permanent_injury_scarred");
				original_addSprite("permanent_injury_burned");
			}
			else if (_id == "helmet_damage") {
				original_addSprite("helmet_helm");
				original_addSprite("helmet_top");
				original_addSprite("helmet_vanity");
				original_addSprite("helmet_vanity_2");
				original_addSprite("armor_upgrade_front");
			}

			return layer;
		}

		onInit();
		// return to normal
		self.addSprite = original_addSprite;
		// add this as aura effect
		::Legends.Effects.grant(this, ::Legends.Effect.LegendDemonHoundAura);
	}

	o.setArmorAlpha <- function (level)
	{
		foreach (a in this.Const.CharacterSprites.Armor)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).Alpha = level;
		}
	}

	o.setArmorSaturation <- function (level)
	{
		foreach (a in this.Const.CharacterSprites.Armor)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).Saturation = level;
		}
	}

	o.setArmorBrightness <- function (level)
	{
		foreach (a in this.Const.CharacterSprites.Armor)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).setBrightness(level);
		}
	}

	o.setBrushAlpha <- function (level)
	{
		this.setArmorAlpha(10);
		foreach (a in this.Const.CharacterSprites.Human)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).Alpha = level;
		}
	}

	o.onSerialize = function ( _out )
	{
		this.actor.onSerialize(_out);
		if (this.m.Surcoat != null)
		{
			_out.writeU8(this.m.Surcoat);
		}
		else
		{
			_out.writeU8(0);
		}

		_out.writeU8(this.m.Ethnicity);
		_out.writeU8(this.m.Gender);
		_out.writeU8(this.m.VoiceSet);
		_out.writeU8(this.m.Body);
	}

	o.onDeserialize = function ( _in )
	{
		this.actor.onDeserialize(_in);
		this.m.Surcoat = _in.readU8();

		if (this.m.Surcoat == 0)
		{
			this.m.Surcoat = null;
		}

		this.m.Ethnicity = _in.readU8();
		this.m.Gender = _in.readU8();
		this.m.VoiceSet = _in.readU8();
		this.m.Body = _in.readU8();
		this.setGender(this.m.Gender, false)
	}
});
