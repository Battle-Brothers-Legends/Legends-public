this.legend_boar_gore_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendBoarGore);
		this.m.Description = "A deep tusk gore performed with full force to smash a target to bits. Anyone hit will be staggered and lose initiative.";
		this.m.KilledString = "Gored";
		this.m.Icon = "skills/boar_gore.png";
		this.m.IconDisabled = "skills/boar_gore_bw.png";
		this.m.Overlay = "active_89";
		this.m.SoundOnUse = [
			"sounds/combat/boarattack1.wav",
			"sounds/combat/boargore.wav",
		];
		this.m.SoundOnHit = [
			"sounds/combat/smash_hit_01.wav",
			"sounds/combat/smash_hit_02.wav",
			"sounds/combat/smash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 99;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();
		local mult = p.MeleeDamageMult;
		local bodyHealth = actor.getHitpointsMax();
		local average = (actor.getInitiative() +  bodyHealth) / 4;
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

		if (this.getContainer().hasSkill("background.brawler") || this.getContainer().hasSkill("background.legend_commander_berserker") || this.getContainer().hasSkill("background.legend_berserker") )
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
			icon = "ui/icons/hitchance.png",
			text = "Has [color=%negative%]-10%[/color] chance to hit"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInHammers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor && !target.isNonCombatant())
		{
			::Legends.Effects.grant(target, ::Legends.Effect.Staggered);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
			}
		}

		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local bodyHealth = actor.getHitpointsMax();
			local average = (actor.getInitiative() +  bodyHealth) / 4;
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
			_properties.MeleeSkill += _properties.IsSpecializedInFists ? 10 : -10;


			this.m.DirectDamageMult = _properties.IsSpecializedInFists ? 0.5 : 0.1;
		}
	}

});

