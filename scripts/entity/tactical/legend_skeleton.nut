this.legend_skeleton <- this.inherit("scripts/entity/tactical/skeleton", {
	m = {
		Item = null,
		SpawnType = null
	},

	function create()
	{
		this.m.IsControlledByPlayer = true;
		this.m.Type = this.Const.EntityType.SkeletonLight;
		this.skeleton.create();
		this.m.ResurrectWithScript = "";
		this.m.AIAgent = this.new("scripts/ai/tactical/idle_agent");
		this.m.AIAgent.setActor(this);
		this.m.IsSummoned = true;
	}

	function isGuest()
	{
		return false;
	}

	function addXP(_xp)
	{

	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.m.SpawnType);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
		this.addSprite("socket").setBrush("bust_base_undead");
		local body = this.addSprite("body");

		if (this.Math.rand(1, 2) == 1)
		{
			body.setBrush("bust_skeleton_body_0" + this.Math.rand(1, 2));
		}
		else
		{
			body.setBrush("bust_skeleton_body_01");
		}

		body.setHorizontalFlipping(true);
		body.Saturation = 0.8;

		if (this.Math.rand(0, 100) < 75)
		{
			body.varySaturation(0.2);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.025, 0.025, 0.025);
		}

		this.m.BloodColor = body.Color;
		this.m.BloodSaturation = body.Saturation;
		this.addSprite("body_injury").setBrush("bust_skeleton_body_injured");
		this.addSprite("armor");
		this.addSprite("armor_layer_chain");
		this.addSprite("armor_layer_plate");
		this.addSprite("armor_layer_tabbard");
		this.addSprite("armor_layer_cloak");
		this.addSprite("armor_upgrade_back");
		local head = this.addSprite("head");
		head.setBrush("bust_skeleton_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.setBrush("bust_skeleton_head_injured");
		local beard = this.addSprite("beard");
		beard.varyColor(0.02, 0.02, 0.02);

		if (this.Math.rand(1, 100) <= 25)
		{
			beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.ZombieOnly[this.Math.rand(0, this.Const.Beards.ZombieOnly.len() - 1)]);
		}

		local face = this.addSprite("face");
		face.setBrush("bust_skeleton_face_0" + this.Math.rand(1, 6));
		local hair = this.addSprite("hair");
		hair.setHorizontalFlipping(true);
		hair.Color = beard.Color;

		if (this.Math.rand(1, 100) <= 50)
		{
			hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.ZombieOnly[this.Math.rand(0, this.Const.Hair.ZombieOnly.len() - 1)]);
		}

		this.setSpriteOffset("hair", this.createVec(0, -3));
		foreach (a in this.Const.CharacterSprites.Helmets)
		{
			this.addSprite(a)
		}
		local beard_top = this.addSprite("beard_top");

		if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
		{
			beard_top.setBrush(beard.getBrush().Name + "_top");
			beard_top.Color = beard.Color;
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
		::Legends.Traits.grant(this, ::Legends.Trait.RacialSkeleton);
		::Legends.Effects.grant(this, ::Legends.Effect.DoubleGrip);
		::Legends.Actives.grant(this, ::Legends.Active.HandToHand);
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
	}

	function setItem( _i )
	{
		if (typeof _i == "instance")
		{
			this.m.Item = _i;
			return
		}

		this.m.Item = this.WeakTableRef(_i);
	}

	function setVariant( _v )
	{

	}


	function isReallyKilled(_fatalityType)
	{
		return false;
	}


	function onActorKilled( _actor, _tile, _skill )
	{
		this.actor.onActorKilled(_actor, _tile, _skill);
		local XPkiller = this.Math.floor(_actor.getXPValue() * this.Const.XP.XPForKillerPct);
		local XPgroup = _actor.getXPValue() * (1.0 - this.Const.XP.XPForKillerPct);

		local summoner = getFlags().get("Summoner");
		if (summoner != null && "addXP" in summoner)
		{
			summoner.addXP(this.Math.floor(XPkiller * 0.50));
		}

		local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

		if (brothers.len() == 1)
		{
			this.addXP(XPgroup);
		}
		else
		{
			foreach( bro in brothers )
			{
				bro.addXP(this.Math.max(1, this.Math.floor(XPgroup / brothers.len())));
			}
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = false;
		this.m.IsCorpseFlipped = false;
		local isResurrectable = false;
		local appearance = this.getItems().getAppearance();
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");
		local sprite_face = this.getSprite("face");
		local sprite_hair = this.getSprite("hair");
		local sprite_beard = this.getSprite("beard");
		local sprite_beard_top = this.getSprite("beard_top");

		if (_tile != null)
		{
			local decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
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

				if (!appearance.HideBeard && !appearance.HideCorpseHead && sprite_beard.HasBrush)
				{
					local decal = _tile.spawnDetail(sprite_beard.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_beard.Color;
					decal.Saturation = sprite_beard.Saturation;
					decal.Scale = 0.9;

					if (sprite_beard_top.HasBrush)
					{
						local decal = _tile.spawnDetail(sprite_beard_top.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Color = sprite_beard.Color;
						decal.Saturation = sprite_beard.Saturation;
						decal.Scale = 0.9;
					}
				}

				if (!appearance.HideCorpseHead)
				{
					local decal = _tile.spawnDetail(sprite_face.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_face.Color;
					decal.Saturation = sprite_face.Saturation;
					decal.Scale = 0.9;
				}

				if (!appearance.HideHair && !appearance.HideCorpseHead && sprite_hair.HasBrush)
				{
					local decal = _tile.spawnDetail(sprite_hair.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_hair.Color;
					decal.Saturation = sprite_hair.Saturation;
					decal.Scale = 0.9;
				}

				if (appearance.HelmetCorpse != "")
				{
					local decal = _tile.spawnDetail(appearance.HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Scale = 0.9;
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [];

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (!appearance.HideBeard && sprite_beard.HasBrush)
				{
					layers.push(sprite_beard.getBrush().Name + "_dead");
				}

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_face.getBrush().Name + "_dead");
				}

				if (!appearance.HideHair && sprite_hair.HasBrush)
				{
					layers.push(sprite_hair.getBrush().Name + "_dead");
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					layers.push(appearance.HelmetCorpse);
				}

				if (!appearance.HideBeard && sprite_beard_top.HasBrush)
				{
					layers.push(sprite_beard_top.getBrush().Name + "_dead");
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-20, 15), -90.0, "");
				local idx = 0;

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setHorizontalFlipping(true);
					idx = ++idx;
				}

				if (!appearance.HideBeard && sprite_beard.HasBrush)
				{
					decap[idx].Color = sprite_beard.Color;
					decap[idx].Saturation = sprite_beard.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setHorizontalFlipping(true);
					idx = ++idx;
				}

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Scale = 0.9;
					decap[idx].setHorizontalFlipping(true);
					idx = ++idx;
				}

				if (!appearance.HideHair && sprite_hair.HasBrush)
				{
					decap[idx].Color = sprite_hair.Color;
					decap[idx].Saturation = sprite_hair.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setHorizontalFlipping(true);
					idx = ++idx;
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decap[idx].Scale = 0.9;
					decap[idx].setHorizontalFlipping(true);
					idx = ++idx;
				}

				if (!appearance.HideBeard && sprite_beard_top.HasBrush)
				{
					decap[idx].Color = sprite_beard.Color;
					decap[idx].Saturation = sprite_beard.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setHorizontalFlipping(true);
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
				Hair = sprite_hair.HasBrush ? sprite_hair.getBrush().Name : null,
				HairColor = sprite_hair.Color,
				HairSaturation = sprite_hair.Saturation,
				Beard = sprite_beard.HasBrush ? sprite_beard.getBrush().Name : null,
				BodyColor = sprite_body.Color,
				BodySaturation = sprite_body.Saturation
			};
			local corpse = clone this.Const.Corpse;
			corpse.Type = this.m.ResurrectWithScript;
			corpse.Faction = this.getFaction();
			corpse.CorpseName = this.Const.Strings.getArticleCapitalized(this.getName()) + this.getName();
			corpse.Tile = _tile;
			corpse.Value = this.m.ResurrectionValue;
			corpse.Armor = this.m.BaseProperties.Armor;
			//corpse.Items = this.getItems();
			corpse.Color = sprite_body.Color;
			corpse.Saturation = sprite_body.Saturation;
			corpse.Custom = custom;
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;

			_tile.Properties.set("Corpse", corpse);
			_tile.Properties.set("IsSummoned", true);
			this.Tactical.Entities.addCorpse(_tile);
		}

		//this.getItems().dropAll(_tile, _killer, !flip);
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}


});
