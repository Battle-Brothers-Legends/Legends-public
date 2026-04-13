this.legend_horse_kick_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsRestrained = false,
		IsSpent = false
	},
	function setRestrained( _f )
	{
		this.m.IsRestrained = _f;
	}
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHorseKick);
		this.m.Description = "The main attack of a horse, more for defense than attack. Maximum damage is the average of your hitpoints and initiative minus 90.";
		this.m.KilledString = "Kicked to death";
		this.m.Icon = "skills/horse_kick.png";
		this.m.IconDisabled = "skills/horse_kick_bw.png";
		this.m.Overlay = "horse_kick";
		this.m.SoundOnUse = [
			"sounds/combat/hand_01.wav",
			"sounds/combat/hand_02.wav",
			"sounds/combat/hand_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsSerialized = false;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();
		local mult = p.MeleeDamageMult;
		local bodyHealth = actor.getHitpointsMax();
		local average = (actor.getInitiative() + bodyHealth) / 2;
		local damageMin = 5;
		local damageMax = 10;
		local avgMin = average - 100;
		local avgMax = average - 90;

		if (average - 100 > 0)
		{
			damageMin = damageMin + avgMin;
		}

		if (average - 90 > 0)
		{
			damageMax = damageMax + avgMax;
		}

		local damage_regular_min = this.Math.floor(damageMin * p.DamageRegularMult * p.DamageTotalMult);
		local damage_regular_max = this.Math.floor(damageMax * p.DamageRegularMult * p.DamageTotalMult);
		local damage_Armor_min = this.Math.floor(damageMin * p.DamageArmorMult * p.DamageTotalMult);
		local damage_Armor_max = this.Math.floor(damageMax * p.DamageArmorMult * p.DamageTotalMult);
		local damage_direct_max = this.Math.floor(damageMax * this.m.DirectDamageMult);

		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendMuscularity))
		{
			local muscularity = this.Math.floor(bodyHealth * 0.1);
			damage_regular_max = damage_regular_max + muscularity;
			damage_Armor_max = damage_Armor_max + muscularity;
			damage_direct_max = damage_direct_max + muscularity;
		}

		if (mult != 1.0)
		{
			damage_regular_min = this.Math.floor(damage_regular_min * mult);
			damage_regular_max = this.Math.floor(damage_regular_max * mult);
			damage_Armor_min = this.Math.floor(damage_Armor_min * mult);
			damage_Armor_max = this.Math.floor(damage_Armor_max * mult);
			damage_direct_max = this.Math.floor(damage_direct_max * mult);
		}

		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Inflicts damage based on hitpoints and initiative [color=%damage%]" + damage_regular_min + "[/color] - [color=%damage%]" + damage_regular_max + "[/color] damage, up to [color=%damage%]" + damage_direct_max + "[/color] damage can ignore armor"
		});

		if (damage_Armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=%damage%]" + damage_Armor_min + "[/color] - [color=%damage%]" + damage_Armor_max + "[/color] armor damage"
			});
		}

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=%negative%]-10%[/color] chance to hit"
		});
		return ret;
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return mainhand == null && this.skill.isUsable() && !this.m.IsSpent;
	}

	function isHidden()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return mainhand != null || this.skill.isHidden();
	}

	function onUpdate( _properties )
	{
		if (!this.isHidden())
		{
			_properties.DamageArmorMult *= 0.5;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local p = actor.getCurrentProperties();
			local mult = p.MeleeDamageMult;
			local bodyHealth = actor.getHitpointsMax();
			local average = (actor.getInitiative() + bodyHealth) / 2;
			local damageMin = 5;
			local damageMax = 10;
			local avgMin = average - 100;
			local avgMax = average - 90;

			if (average - 100 > 0)
			{
				damageMin = damageMin + avgMin;
			}

			if (average - 90 > 0)
			{
				damageMax = damageMax + avgMax;
			}

			if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendMuscularity))
			{
				local muscularity = this.Math.floor(bodyHealth * 0.1);
				damageMax = damageMax + muscularity;
			}

			_properties.DamageRegularMin += this.Math.floor(damageMin);
			_properties.DamageRegularMax += this.Math.floor(damageMax);
			this.m.DirectDamageMult = _properties.IsSpecializedInFists ? 0.6 : 0.3;
		}
	}

	function onUse( _user, _targetTile )
	{
		if (this.m.IsRestrained)
		{
			this.m.IsSpent = true;
		}
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}


});

