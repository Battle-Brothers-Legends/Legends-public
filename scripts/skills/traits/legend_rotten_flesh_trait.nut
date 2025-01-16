this.legend_rotten_flesh_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		InjuryType = this.Math.rand(1, 4)
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendRottenFlesh);
		this.m.Name = "Rotting Flesh";
		this.m.Description = "With flesh is pale and gaunt, this one rots away as merely a souless animal.";
		this.m.Icon = "ui/traits/rotting_flesh_trait.png";
	}

	function getTooltip()
	{
		return [
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
				id = 7,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "-3 Action Points. Recovers hitpoints at only 10% of the normal rate. Requires 3 provisions a day."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Immune to bleeding, poison and most types of injuries."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Not effected by fatigue, but needs fatigue to equip items."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Not affected by morale or allies fleeing and dying. Requires no pay."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/kills.png",
				text = "Not affected by mood. Experience is gained at 75% normal rate."
			}
		];
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor().get();
		actor.m.rawset("InjuryType", this.m.InjuryType);
		actor.m.BloodType = this.Const.BloodType.Dark;
		actor.m.MoraleState = this.Const.MoraleState.Ignore;
		actor.getFlags().add("undead");
		actor.getFlags().add("zombie_minion");

		local body_blood = actor.getSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.Visible = true;

		local body_dirt = actor.getSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");

		local rage = actor.addSprite("status_rage");
		rage.setBrush("mind_control");
		rage.Visible = false;

		if (::MSU.isKindOf(actor, "player"))
		{
			actor.improveMood = function ( _change, _text = "" )
			{
			};
			actor.worsenMood = function ( _change, _text = "" )
			{
			};
		}

		actor.onUpdateInjuryLayer = function ()
		{
			local injury = this.getSprite("injury");
			local injury_body = this.getSprite("injury_body");
			local p = this.m.Hitpoints / this.getHitpointsMax();

			if (p > 0.5)
			{
				if (!injury.HasBrush || injury.getBrush().Name != "zombify_0" + this.m.InjuryType)
				{
					injury.setBrush("zombify_0" + this.m.InjuryType);
				}
			}
			else if (!injury.HasBrush || injury.getBrush().Name != "zombify_0" + this.m.InjuryType + "_injured")
			{
				injury.setBrush("zombify_0" + this.m.InjuryType + "_injured");
			}

			if (p > 0.5)
			{
				injury_body.setBrush("zombify_body_01");
			}
			else
			{
				injury_body.setBrush("zombify_body_02");
			}

			injury.Visible = true;
			injury_body.Visible = true;
			this.setDirty(true);
		};

		actor.m.ExcludedInjuries = [
			"injury.cut_artery",
			"injury.cut_throat",
			"injury.deep_abdominal_cut",
			"injury.deep_chest_cut",
			"injury.exposed_ribs",
			"injury.grazed_kidney",
			"injury.grazed_neck",
			"injury.infected_wound",
			"injury.sickness",
			"injury.stabbed_guts",
			"injury.broken_nose",
			"injury.broken_ribs",
			"injury.crushed_windpipe",
			"injury.fractured_ribs",
			"injury.inhaled_flames",
			"injury.pierced_chest",
			"injury.pierced_lung",
			"injury.pierced_side"
		];

		local sw_onFactionChanged = actor.onFactionChanged;
		actor.onFactionChanged = function ()
		{
			sw_onFactionChanged();
			local flip = !this.isAlliedWithPlayer();
			this.getSprite("injury_body").setHorizontalFlipping(!flip);
			this.getSprite("status_rage").setHorizontalFlipping(flip);
		};

		if (this.m.IsNew)
		{
			this.onApplyAppearance();
			actor.m.Flags.add("undead");
			actor.m.Flags.add("zombie");
			actor.m.Flags.add("zombie_minion");
			this.m.IsNew = false;
		}
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;
		_properties.IsAffectedByNight = true;
		_properties.IsAffectedByFleeingAllies = false;
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByFreshInjuries = true;
		_properties.MoraleEffectMult *= 0.1;
		_properties.FatigueEffectMult *= 0.0;
		_properties.HitpointsRecoveryRateMult *= 0.1;
		_properties.MovementFatigueCostMult *= 0.0;
		_properties.XPGainMult *= 0.75;
		_properties.DailyWageMult *= 0;
		_properties.DailyFood += 1;
		_properties.ActionPoints -= 3;
	}

	function onApplyAppearance()
	{
		local actor = this.getContainer().getActor();
		local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
		local sprite = actor.getSprite("head");
		sprite.Saturation = 0.5;
		sprite.varySaturation(0.2);
		sprite.Color = this.createColor("#c1ddaa");
		sprite.varyColor(0.05, 0.05, 0.05);
		local body = actor.getSprite("body");
		body.Color = sprite.Color;
		body.Saturation = sprite.Saturation;
		local beard = actor.getSprite("beard");
		local hair = actor.getSprite("hair");

		if (this.Math.rand(1, 100) <= 50)
		{
			if (this.m.InjuryType == 4)
			{
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.ZombieExtended[this.Math.rand(0, this.Const.Beards.ZombieExtended.len() - 1)]);
				beard.setBrightness(0.9);
			}
			else
			{
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.Zombie[this.Math.rand(0, this.Const.Beards.Zombie.len() - 1)]);
			}

			if (this.Math.rand(0, this.Const.Hair.Zombie.len()) != this.Const.Hair.Zombie.len())
			{
				hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.Zombie[this.Math.rand(0, this.Const.Hair.Zombie.len() - 1)]);
			}
			else
			{
				hair.resetBrush();
			}
		}

		if (hairColor != "grey")
		{
			beard.varyColor(0.1, 0.1, 0.1);
			hair.Color = beard.Color;
		}
		else
		{
			beard.varyBrightness(0.1);
		}

		local beard_top = actor.getSprite("beard_top");

		if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
		{
			beard_top.setBrush(beard.getBrush().Name + "_top");
			beard_top.Color = beard.Color;
		}
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = this.Const.MoraleState.Ignore;
		actor.m.BloodType = this.Const.BloodType.Dark;
		actor.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = [
			"sounds/enemies/zombie_idle_14.wav",
			"sounds/enemies/zombie_idle_15.wav",
			"sounds/enemies/zombie_idle_16.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/zombie_hurt_01.wav",
			"sounds/enemies/zombie_hurt_02.wav",
			"sounds/enemies/zombie_hurt_03.wav",
			"sounds/enemies/zombie_hurt_04.wav",
			"sounds/enemies/zombie_hurt_05.wav",
			"sounds/enemies/zombie_hurt_06.wav",
			"sounds/enemies/zombie_hurt_07.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/zombie_death_01.wav",
			"sounds/enemies/zombie_death_02.wav",
			"sounds/enemies/zombie_death_03.wav",
			"sounds/enemies/zombie_death_04.wav",
			"sounds/enemies/zombie_death_05.wav",
			"sounds/enemies/zombie_death_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = [
			"sounds/enemies/zombie_bite_01.wav",
			"sounds/enemies/zombie_bite_02.wav",
			"sounds/enemies/zombie_bite_03.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/zombie_bite_01.wav",
			"sounds/enemies/zombie_bite_02.wav",
			"sounds/enemies/zombie_bite_03.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/zombie_idle_01.wav",
			"sounds/enemies/zombie_idle_02.wav",
			"sounds/enemies/zombie_idle_03.wav",
			"sounds/enemies/zombie_idle_04.wav",
			"sounds/enemies/zombie_idle_05.wav",
			"sounds/enemies/zombie_idle_06.wav",
			"sounds/enemies/zombie_idle_07.wav",
			"sounds/enemies/zombie_idle_08.wav",
			"sounds/enemies/zombie_idle_09.wav",
			"sounds/enemies/zombie_idle_10.wav",
			"sounds/enemies/zombie_idle_11.wav",
			"sounds/enemies/zombie_idle_12.wav",
			"sounds/enemies/zombie_idle_13.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/zombie_bite_01.wav",
			"sounds/enemies/zombie_bite_02.wav",
			"sounds/enemies/zombie_bite_03.wav"
		];
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.m.BloodType = this.Const.BloodType.Red;
		actor.m.MoraleState = this.Const.MoraleState.Steady;
		actor.getFlags().remove("undead");
		actor.getFlags().remove("zombie");
		actor.getFlags().remove("zombie_minion");
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU8(this.m.InjuryType);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.InjuryType = _in.readU8();
	}

});

