this.legend_bear_bite_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendBearBite);
		this.m.Description = "Tear into an opponent with your teeth";
		this.m.KilledString = "Ripped to shreds";
		this.m.Icon = "skills/active_71.png";
		this.m.IconDisabled = "skills/active_71_bw.png";
		this.m.Overlay = "active_71";
		this.m.SoundOnUse = [
			"sounds/enemies/bear_attack1.wav",
			"sounds/enemies/bear_attack1.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/enemies/werewolf_claw_hit_01.wav",
			"sounds/enemies/werewolf_claw_hit_02.wav",
			"sounds/enemies/werewolf_claw_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 6;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}


function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();
		local mult = p.MeleeDamageMult;
		local bodyHealth = actor.getHitpointsMax();
		local average = (actor.getInitiative() +  bodyHealth) / 2;
		local damageMin = 5;
		local damageMax = 10;
		local avgMin = average - 100;
		local avgMax = average - 90;

		if ((average - 100) > 0)
		{
			damageMin += avgMin;
		}

		if ((average - 90) > 0)
		{
			damageMax += avgMax;
		}

		if (this.getContainer().hasSkill("background.brawler") || this.getContainer().hasSkill("background.legend_commander_berserker") || this.getContainer().hasSkill("background.legend_berserker") || this.getContainer().hasSkill("background.legend_commander_druid") || this.getContainer().hasSkill("background.legend_druid") )
		{
			damageMin = damageMin * 1.25;
			damageMax = damageMax * 1.25;
		}

		local damage_regular_min = this.Math.floor(damageMin * p.DamageRegularMult * p.DamageTotalMult);
		local damage_regular_max = this.Math.floor(damageMax * p.DamageRegularMult * p.DamageTotalMult);
		local damage_Armor_min = this.Math.floor(damageMin * p.DamageArmorMult * p.DamageTotalMult);
		local damage_Armor_max = this.Math.floor(damageMax * p.DamageArmorMult * p.DamageTotalMult);
		local damage_direct_max = this.Math.floor(damageMax * this.m.DirectDamageMult);

		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendMuscularity))
		{
			local muscularity = this.Math.floor(bodyHealth * 0.1);
			 damage_regular_max += muscularity;
			 damage_Armor_max += muscularity;
			 damage_direct_max += muscularity;
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
			icon = "ui/icons/special.png",
			text = " Heals for" + this.Math.floor(bodyHealth/10) + " hitpoints [10% of your maximum hp]"
		});

		return ret;
	}


function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local bodyHealth = actor.getHitpointsMax();
			local average = (actor.getInitiative() +  bodyHealth) / 2;
			local damageMin = 5;
			local damageMax = 10;
			local avgMin = average - 100;
			local avgMax = average - 90;

			if ((average - 100) > 0)
			{
				damageMin += avgMin;
			}

			if ((average - 90) > 0)
			{
				damageMax += avgMax;
			}


			if (damageMin > 50)
			{
			local minMod = (damageMin - 50);
			local minFalloff = this.Math.pow(minMod, 0.5);
			damageMin = 50 + minFalloff;
			}

			if (damageMax > 50)
			{
			local maxMod = (damageMax - 50);
			local maxFalloff = this.Math.pow(maxMod, 0.5);
			damageMax = 50 + maxFalloff;
			}




			if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendMuscularity))
			{
				local muscularity = this.Math.floor(bodyHealth * 0.1);
				damageMax += muscularity;
			}

			if (this.getContainer().hasSkill("background.brawler") || this.getContainer().hasSkill("background.legend_commander_berserker" || this.getContainer().hasSkill("background.legend_berserker")) )
			{
				damageMin = damageMin * 1.25;
				damageMax = damageMax * 1.25;
			}
			_properties.DamageRegularMin += this.Math.floor(damageMin);
			_properties.DamageRegularMax += this.Math.floor(damageMax);


			this.m.DirectDamageMult = _properties.IsSpecializedInFists ? 0.5 : 0.1;
		}
	}

	function onUse( _user, _targetTile )
	{
		local res = this.attackEntity(_user, _targetTile.getEntity());
		if (res)
		{
			local actor = this.getContainer().getActor();
			local maxHP = actor.getHitpointsMax();
			local heal = maxHP / 10;
			actor.setHitpoints(this.Math.min(actor.getHitpoints() + heal, maxHP));
		}
		return res


	}

});

