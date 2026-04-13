this.legend_fleshless_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendFleshless);
		this.m.Name = "Fleshless";
		this.m.Description = "Only bones remain, with all skin rotten or torn away.";
		this.m.Icon = "ui/traits/fleshless_trait.png";
	}

	function getTooltip()
	{
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
				id = 7,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "Immune to Bleeding, poison and most fresh injuries."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Recovers hitpoints at only 20% of the normal rate. Requires no food and has resistance to piercing type attacks."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Effected by fatigue at 10% normal rate."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Not affected by morale checks or allies fleeing or dying."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Not affected by nighttime penalties"
			}
		];
		return ret;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor().get();

		if (::MSU.isKindOf(actor, "player"))
		{
			actor.improveMood = function ( _change, _text = "" )
			{
			};
			actor.worsenMood = function ( _change, _text = "" )
			{
			};
		}

		if (this.m.IsNew)
		{
			this.onApplyAppearance();
			actor.m.Flags.add("PlayerSkeleton");
			actor.m.Flags.add("skeleton");
			actor.m.Flags.add("undead");
			::Legends.Traits.grant(this, ::Legends.Trait.RacialSkeleton);
			this.m.IsNew = false;
		}

		actor.m.MoraleState = this.Const.MoraleState.Ignore;
		actor.m.ExcludedInjuries = [
			"injury.collapsed_lung_part",
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
			"injury.crushed_windpipe",
			"injury.inhaled_flames",
			"injury.pierced_chest",
			"injury.pierced_lung",
			"injury.pierced_side"
		];

		actor.onFactionChanged();
		actor.onUpdateInjuryLayer();
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = this.Const.MoraleState.Ignore;
		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;
		_properties.IsAffectedByNight = false;
		_properties.IsAffectedByFleeingAllies = false;
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByFreshInjuries = false;
		_properties.MoraleEffectMult = 0.1;
		_properties.FatigueEffectMult = 0.1;
		_properties.HitpointsRecoveryRateMult = 0.2;
		_properties.MovementFatigueCostMult = 0.1;
		_properties.DailyWageMult *= 0;
		_properties.XPGainMult *= 1.0;
		_properties.DailyFood = 0;
		// _properties.HitpointsMult *= 0.5; //best decided in bg/summon files from now on - Luft
	}

	function onApplyAppearance()
	{
		local actor = this.getContainer().getActor().get();

		if (::MSU.isKindOf(actor, "player"))
		{
			if (actor.getFlags().has("human"))
				actor.getSprite("injury_body").setBrush("bust_skeleton_body_injured");

			local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];
			local body = actor.getSprite("body");
			body.setBrush("bust_skeleton_body_0" + this.Math.rand(1, 2));
			body.Saturation = 0.8;

			actor.getSprite("injury_body").setBrush("bust_skeleton_body_injured");

			local head = actor.getSprite("head");
			head.setBrush("bust_skeleton_head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;

			local beard = actor.getSprite("beard");
			if (beard == !null)
			{
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.ZombieOnly[this.Math.rand(0, this.Const.Beards.ZombieOnly.len() - 1)]);
				local beard_top = actor.getSprite("beard_top");
				if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
				{
					beard_top.setBrush(beard.getBrush().Name + "_top");
					beard_top.Color = beard.Color;
				}
			}

			local face = actor.getSprite("scar_head");
			if (face == !null)
				face.setBrush("bust_skeleton_face_0" + this.Math.rand(1, 6));

			local hair = actor.getSprite("hair");
			if (hair == !null)
			{
				hair.Color = beard.Color;
				hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.ZombieOnly[this.Math.rand(0, this.Const.Hair.ZombieOnly.len() - 1)]);
				actor.setSpriteOffset("hair", this.createVec(0, -3));
			}

			local injury = actor.getSprite("injury");
			if (injury == !null)
				injury.setBrush("bust_skeleton_head_injured");
		}
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = this.Const.MoraleState.Ignore;
		actor.m.BloodType = this.Const.BloodType.Bones;
		actor.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = [
			"sounds/enemies/skeleton_idle_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/skeleton_hurt_01.wav",
			"sounds/enemies/skeleton_hurt_02.wav",
			"sounds/enemies/skeleton_hurt_03.wav",
			"sounds/enemies/skeleton_hurt_04.wav",
			"sounds/enemies/skeleton_hurt_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/skeleton_death_01.wav",
			"sounds/enemies/skeleton_death_02.wav",
			"sounds/enemies/skeleton_death_03.wav",
			"sounds/enemies/skeleton_death_04.wav",
			"sounds/enemies/skeleton_death_05.wav",
			"sounds/enemies/skeleton_death_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = [
			"sounds/enemies/skeleton_idle_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/skeleton_idle_06.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/skeleton_idle_01.wav",
			"sounds/enemies/skeleton_idle_02.wav",
			"sounds/enemies/skeleton_idle_03.wav",
			"sounds/enemies/skeleton_idle_04.wav",
			"sounds/enemies/skeleton_idle_05.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/skeleton_idle_06.wav"
		];
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.m.BloodType = this.Const.BloodType.Bones;
		actor.m.MoraleState = this.Const.MoraleState.Steady;
		::Legends.Traits.remove(actor, ::Legends.Trait.RacialSkeleton);
		actor.getFlags().remove("undead");
		actor.getFlags().remove("skeleton");
		actor.getFlags().remove("PlayerSkeleton");
		// Clear excluded injuries list
		actor.m.ExcludedInjuries = [];
		// Restore appearance
		local background = actor.getBackground();
		if (background != null) {
			background.setAppearance();
		}
		actor.getItems().updateAppearance();
		actor.setDirty(true);
	}

});
