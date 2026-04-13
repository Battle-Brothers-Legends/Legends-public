this.legend_mummy <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		ResurrectionValue = 2.0,
		ResurrectionChance = 33,
		ResurrectWithScript = "scripts/entity/tactical/legend_mummy",
		IsResurrectingOnFatality = false,
		IsResurrectable = true
	},
	function create()
	{
		this.m.BloodType = this.Const.BloodType.Bones;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/mummy_hurt_01.wav",
			"sounds/enemies/mummy_hurt_02.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/mummy_die_01.wav",
			"sounds/enemies/mummy_die_02.wav",
			"sounds/enemies/mummy_die_03.wav",
			"sounds/enemies/mummy_die_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Resurrect] = [
			"sounds/enemies/skeleton_rise_01.wav",
			"sounds/enemies/skeleton_rise_02.wav",
			"sounds/enemies/skeleton_rise_03.wav",
			"sounds/enemies/skeleton_rise_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/mummy_idle_01.wav",
			"sounds/enemies/mummy_idle_02.wav",
			"sounds/enemies/mummy_idle_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/mummy_idle_01.wav",
			"sounds/enemies/mummy_idle_02.wav",
			"sounds/enemies/mummy_idle_03.wav"
		];
		this.getFlags().add("undead");
		this.getFlags().add("skeleton");
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50)
		{
			return;
		}

		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = this.Math.rand(0, 100) < 50;
		this.m.IsCorpseFlipped = flip;
		local isResurrectable = _fatalityType != this.Const.FatalityType.Decapitated && this.m.IsResurrectable;
		local appearance = this.getItems().getAppearance();
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");
		local sprite_face = this.getSprite("face");
		local corpse = clone this.Const.Corpse;

		if (_tile != null)
		{
			local decal = _tile.spawnDetail("mummy_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
			decal.Color = sprite_body.Color;
			decal.Saturation = sprite_body.Saturation;
			decal.Scale = 0.9;

			if (appearance.CorpseArmor != "")
			{
				local armorDecal;

				if (this.doesBrushExist(appearance.CorpseArmor + "_skeleton"))
				{
					armorDecal = appearance.CorpseArmor + "_skeleton";
				}
				else
				{
					armorDecal = appearance.CorpseArmor;
				}

				local decal = _tile.spawnDetail(armorDecal, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.9;
			}

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				if (!appearance.HideCorpseHead)
				{
					local decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = 0.9;
				}

				if (!appearance.HideCorpseHead)
				{
					local decal = _tile.spawnDetail(sprite_face.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_face.Color;
					decal.Saturation = sprite_face.Saturation;
					decal.Scale = 0.9;
				}

				if (appearance.HelmetCorpse != "")
				{
					local decal = _tile.spawnDetail(appearance.HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					if (decal != null && decal.Scale != null)
					{
						decal.Scale = 0.9;
					}

				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [];

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_face.getBrush().Name + "_dead");
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					layers.push(appearance.HelmetCorpse);
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-20, 15), -90.0, "");

				if (!appearance.HideCorpseHead)
				{
					decap[0].Color = sprite_head.Color;
					decap[0].Saturation = sprite_head.Saturation;
					decap[0].Scale = 0.9;
					decap[0].setHorizontalFlipping(true);
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decap[1].Scale = 0.9;
					decap[1].setHorizontalFlipping(true);
				}
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				local armorDecal;

				if (appearance.CorpseArmor != "" && this.doesBrushExist(appearance.CorpseArmor + "_skeleton"))
				{
					armorDecal = appearance.CorpseArmor + "_skeleton_arrows";
				}
				else if (appearance.CorpseArmor != "")
				{
					armorDecal = appearance.CorpseArmor + "_arrows";
				}
				else
				{
					armorDecal = appearance.Corpse + "_arrows";
				}

				if (this.doesBrushExist(armorDecal))
				{
					decal = _tile.spawnDetail(armorDecal, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Saturation = 0.85;
				}
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				local armorDecal;

				if (appearance.CorpseArmor != "" && this.doesBrushExist(appearance.CorpseArmor + "_skeleton"))
				{
					armorDecal = appearance.CorpseArmor + "_skeleton_javelin";
				}
				else if (appearance.CorpseArmor != "")
				{
					armorDecal = appearance.CorpseArmor + "_javelin";
				}
				else
				{
					armorDecal = appearance.Corpse + "_javelin";
				}

				if (this.doesBrushExist(armorDecal))
				{
					decal = _tile.spawnDetail(armorDecal, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Saturation = 0.85;
				}
			}

			this.spawnTerrainDropdownEffect(_tile);
			local custom = {
				Face = sprite_face.getBrush().Name,
				Body = sprite_body.getBrush().Name,
				BodyColor = sprite_body.Color,
				BodySaturation = sprite_body.Saturation
			};
			corpse.Type = this.m.ResurrectWithScript;
			corpse.Faction = this.getFaction();
			corpse.CorpseName = (this.m.IsGeneratingKillName ? this.Const.Strings.getArticleCapitalized(this.getName()) : "") + this.getName();
			corpse.Tile = _tile;
			corpse.Value = this.m.ResurrectionValue;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.Items = this.getItems();
			corpse.Color = sprite_body.Color;
			corpse.Saturation = sprite_body.Saturation;
			corpse.Custom = custom;
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			corpse.IsConsumable = false;

			if (isResurrectable)
			{
				corpse.IsResurrectable = true;
			}

			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		this.dropLoot(_tile, tileLoot, !flip);

		if (_tile == null) {
			this.Tactical.Entities.addUnplacedCorpse(corpse);
		} else {
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onResurrected( _info )
	{
		if (_info.Custom != null)
		{
			local face = this.getSprite("face");
			local body = this.getSprite("body");
			face.setBrush(_info.Custom.Face);
			body.setBrush(_info.Custom.Body);
			body.Color = _info.Custom.BodyColor;
			body.Saturation = _info.Custom.BodySaturation;
		}

		this.actor.onResurrected(_info);
		this.m.IsResurrected = true;
		this.pickupMeleeWeaponAndShield(this.getTile());
		this.getSkills().update();
		this.m.XP /= 4;
		local tile = this.getTile();

		for( local i = 0; i != 6; i = ++i )
		{
			if (!tile.hasNextTile(i))
			{
			}
			else
			{
				local otherTile = tile.getNextTile(i);

				if (!otherTile.IsOccupiedByActor)
				{
				}
				else
				{
					local otherActor = otherTile.getEntity();
					local numEnemies = otherTile.getZoneOfControlCountOtherThan(otherActor.getAlliedFactions());

					if (otherActor.m.MaxEnemiesThisTurn < numEnemies && !otherActor.isAlliedWith(this))
					{
						local difficulty = this.Math.maxf(10.0, 50.0 - this.getXPValue() * 0.1);
						otherActor.checkMorale(-1, difficulty);
						otherActor.m.MaxEnemiesThisTurn = numEnemies;
					}
				}
			}
		}
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_chain").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_plate").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_tabbard").setHorizontalFlipping(flip);
		this.getSprite("armor_layer_cloak").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_back").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("face").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			if (!this.hasSprite(a))
			{
				continue;
			}
			this.getSprite(a).setHorizontalFlipping(flip);
		}

		this.getSprite("body_blood").setHorizontalFlipping(flip);
		this.getSprite("dirt").setHorizontalFlipping(flip);
	}

	function onInit()
	{
		this.actor.onInit();
		this.addSprite("socket").setBrush("bust_base_undead");
		local body = this.addSprite("body");
		body.setBrush("mummy_body_01");
		body.setHorizontalFlipping(true);
		// body.Saturation = 0.8;

		// if (this.Math.rand(0, 100) < 75)
		// {
		// 	body.varySaturation(0.2);
		// }

		// if (this.Math.rand(0, 100) < 90)
		// {
		// 	body.varyColor(0.025, 0.025, 0.025);
		// }

		this.m.BloodColor = body.Color;
		this.m.BloodSaturation = body.Saturation;
		//this.addSprite("body_injury").setBrush("bust_skeleton_body_injured");
		this.addSprite("armor");
		this.addSprite("armor_layer_chain");
		this.addSprite("armor_layer_plate");
		this.addSprite("armor_layer_tabbard");
		this.addSprite("armor_layer_cloak");
		this.addSprite("armor_upgrade_back");

		local head = this.addSprite("head");
		head.setBrush("bust_skeleton_head_03");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.setBrush("bust_skeleton_head_injured");

		local face = this.addSprite("face");
		face.setBrush("mummy_head_0" + this.Math.rand(1, 4));

		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a)
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.setHorizontalFlipping(true);
		body_blood.Visible = false;
		local body_dirt = this.addSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.setHorizontalFlipping(true);
		body_dirt.Visible = this.Math.rand(1, 100) <= 33;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		::Legends.Traits.grant(this, ::Legends.Trait.RacialLegendMummy);
		::Legends.Effects.grant(this, ::Legends.Effect.DoubleGrip);
		::Legends.Actives.grant(this, ::Legends.Active.HandToHand);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
	}

});

