this.legend_vampire_lord <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		WasInjured = false,
		IsLady = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendVampireLord;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.LegendVampireLord.XP;
 		if(this.Math.rand(1, 100) <= 25)
		 {
			 this.m.IsLady = true;
		 }

		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/vampire_hurt_01.wav",
			"sounds/enemies/vampire_hurt_02.wav",
			"sounds/enemies/vampire_hurt_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/vampire_death_01.wav",
			"sounds/enemies/vampire_death_02.wav",
			"sounds/enemies/vampire_death_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/vampire_idle_01.wav",
			"sounds/enemies/vampire_idle_02.wav",
			"sounds/enemies/vampire_idle_03.wav"
		];
		this.getFlags().add("undead");
		this.getFlags().add("vampire");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/vampire_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("BackToTheGrave", 1, 1);
		}

		this.m.BloodType = this.Const.BloodType.Ash;
		local flip = this.Math.rand(0, 100) < 50;
		this.m.IsCorpseFlipped = flip;

		if (_tile != null)
		{
			local decal = _tile.spawnDetail("bust_vampire_lord_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.Faction = this.getFaction();
			corpse.CorpseName = "A " + this.getName();
			corpse.Tile = _tile;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.Items = this.getItems();
			corpse.IsHeadAttached = true;
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.getItems().dropAll(_tile, _killer, !flip);

		local loot = this.new("scripts/items/misc/vampire_dust_item");
		loot.drop(_tile);

		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

			for( local i = 0; i < n; i = ++i )
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					local loot = this.new("scripts/items/misc/legend_ancient_scroll_item");
					loot.drop(_tile);
				}
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("body_detail").setHorizontalFlipping(flip);
		this.getSprite("old_body").setHorizontalFlipping(flip);
		this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("head_detail").setHorizontalFlipping(flip);
		this.getSprite("old_head").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("beard").setHorizontalFlipping(flip);
		this.getSprite("hair").setHorizontalFlipping(flip);
		this.getSprite("helmet").setHorizontalFlipping(flip);
		this.getSprite("helmet_damage").setHorizontalFlipping(flip);
		//this.getSprite("beard_top").setHorizontalFlipping(flip);
		this.getSprite("body_blood").setHorizontalFlipping(flip);
		this.getSprite("dirt").setHorizontalFlipping(flip);
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		if (_hitInfo.DamageRegular >= 25)
		{
			this.m.WasInjured = true;
		}

		this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function onUpdateInjuryLayer()
	{
		local p = this.getHitpointsPct();
		local bodyBrush = this.getSprite("body").getBrush().Name;
		local headBrush = this.getSprite("head").getBrush().Name;

		if (p <= 0.33)
		{
			this.getSprite("body").setBrush("bust_vampire_lord_body_03");
			this.getSprite("body_injury").setBrush("bust_skeleton_body_03_injured");
			this.getSprite("head").setBrush("bust_vampire_lord_head_03");
			this.getSprite("injury").setBrush("bust_skeleton_head_03_injured");
		}
		else if (p <= 0.66)
		{
			this.getSprite("body").setBrush("bust_vampire_lord_body_02");
			this.getSprite("body_injury").setBrush("bust_skeleton_body_04_injured");
			this.getSprite("head").setBrush("bust_vampire_lord_head_02");
			this.getSprite("injury").setBrush("bust_skeleton_head_04_injured");
		}
		else if (this.m.IsLady == true)
		{
			this.getSprite("body").setBrush("bust_vampire_lady_body_01");
			this.getSprite("body_injury").setBrush("bust_skeleton_body_05_injured");
			this.getSprite("head").setBrush("bust_vampire_lady_head_01");
			this.getSprite("injury").setBrush("bust_skeleton_head_05_injured");
			this.getSprite("hair").setBrush("hair_black_25");
		}
		else
		{
			this.getSprite("body").setBrush("bust_vampire_lord_body_01");
			this.getSprite("body_injury").setBrush("bust_skeleton_body_05_injured");
			this.getSprite("head").setBrush("bust_vampire_lord_head_01");
			this.getSprite("injury").setBrush("bust_skeleton_head_05_injured");
		}

		this.getSprite("body_injury").Visible = this.m.WasInjured;
		this.getSprite("injury").Visible = this.m.WasInjured;

		if (bodyBrush != this.getSprite("body").getBrush().Name)
		{
			local old_body = this.getSprite("old_body");
			old_body.Visible = true;
			old_body.Alpha = 255;
			old_body.setBrush(bodyBrush);
			old_body.fadeOutAndHide(3000);
			local old_head = this.getSprite("old_head");
			old_head.Visible = true;
			old_head.Alpha = 255;
			old_head.setBrush(headBrush);
			old_head.fadeOutAndHide(3000);
		}

		this.setDirty(true);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Vampire);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsSpecializedInSwords = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
		this.addSprite("socket").setBrush("bust_base_undead");
		local body = this.addSprite("body");
		body.setBrush("bust_vampire_lord_body_01");
		body.setHorizontalFlipping(true);
		this.addSprite("old_body");
		this.addSprite("body_injury").setBrush("bust_skeleton_body_05_injured");
		this.addSprite("armor");
		local head_detail = this.addSprite("head_detail");

		if (this.Math.rand(1, 100) <= 50)
		{
			head_detail.setBrush("bust_skeleton_head_detail_01");
		}

		local body_detail = this.addSprite("body_detail");
		if (this.Math.rand(1, 100) <= 50)
		{
			body_detail.setBrush("bust_skeleton_detail_03")
		}
		local head = this.addSprite("head");
		head.setBrush("bust_vampire_lord_head_01");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		this.addSprite("old_head");
		local injury = this.addSprite("injury");
		injury.setBrush("bust_skeleton_head_05_injured");
		local beard = this.addSprite("beard");
		beard.setBrightness(0.7);
		beard.varyColor(0.02, 0.02, 0.02);
		local hair = this.addSprite("hair");
		hair.Color = beard.Color;
		if (this.Math.rand(1, 100) <= 60)
		{
			local idx = this.Math.rand(0, this.Const.Hair.Vampire.len());
			if (idx = this.Const.Hair.Vampire.len())
			{
				hair.setBrush("bust_vampire_lord_hair_01")
			}
			else
			{
				hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.Vampire[idx]);
			}
		}
		this.setSpriteOffset("hair", this.createVec(0, -3));
		this.addSprite("helmet");
		this.addSprite("helmet_damage");

		if (this.m.IsLady)
		{
			// if (this.Math.rand(1,100) <= 50)
			// {
				// this.getSprite("body").setBrush("bust_vampire_lady_body_01");
				// this.getSprite("head").setBrush("bust_vampire_lady_head_01");
			// }
			// else
			// {
			// 	this.getSprite("body").setBrush("bust_vampire_lady_body_02");
			// 	this.getSprite("head").setBrush("bust_vampire_lady_head_02");
			// }
			// if (this.Math.rand(1, 100) <= 60)
			// {
			// 	hair.setBrush("hair_black_25")
			// }
			this.getSprite("body").setBrush("bust_vampire_lady_body_02");
			this.getSprite("head").setBrush("bust_vampire_lady_head_02");
			// hair.Alpha = 0;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_terrifying_visage"));
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
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/racial/vampire_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/darkflight"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.NineLives);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_carnage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			b.MeleeSkill += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
		if (!this.Tactical.State.isScenarioMode())
		{
			local dateToSkip = 0;
			switch (this.World.Assets.getCombatDifficulty())
			{
				case this.Const.Difficulty.Easy:
					dateToSkip = 250;
					break;
				case this.Const.Difficulty.Normal:
					dateToSkip = 200
					break;
				case this.Const.Difficulty.Hard:
					dateToSkip = 150
					break;
				case this.Const.Difficulty.Legendary:
					dateToSkip = 100
					break;
			}

			if (this.World.getTime().Days >= dateToSkip)
			{
				local bonus = this.Math.min(1, this.Math.floor( (this.World.getTime().Days - dateToSkip) / 20.0));
				b.MeleeSkill += bonus;
				b.RangedSkill += bonus;
				b.MeleeDefense += this.Math.floor(bonus / 2);
				b.RangedDefense += this.Math.floor(bonus / 2);
				b.Hitpoints += this.Math.floor(bonus * 2);
				b.Initiative += this.Math.floor(bonus / 2);
				b.Stamina += bonus;
			//	b.XP += this.Math.floor(bonus * 4);
				b.Bravery += bonus;
				b.FatigueRecoveryRate += this.Math.floor(bonus / 4);
			}
		}
	}

	function assignRandomEquipment()
	{

		local item = this.Const.World.Common.pickArmor([
			[1, "legend_vampire_lord_armor"]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[66, "legend_vampire_lord_helmet"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}

		local r = this.Math.rand(1, 2);

		// if (r == 1)
		// {
		// 	this.m.Items.equip(this.new("scripts/items/weapons/named/named_crypt_cleaver"));
		// }
		// else if (r <= 4)
		// {
		// 	this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_great_khopesh"));
		// }
		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/legend_great_khopesh"));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/named/named_khopesh"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/named/named_crypt_cleaver"));
		}

		{
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_terrifying_visage"));
		return true;
		}
	}

});

