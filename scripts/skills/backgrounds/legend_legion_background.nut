this.legend_legion_background <- this.inherit("scripts/skills/skill", {
	m = {
		HiringCost = 0,
		DailyCost = 0,
		DailyCostMult = 1.0,
		Excluded = [],
		ExcludedTalents = [
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery
		],
		Faces = null,
		Hairs = null,
		HairColors = null,
		Beards = null,
		Bodies = this.Const.Bodies.AllMale,
		Ethnicity = 0,
		Level = 1,
		BeardChance = 60,
		Names = this.Const.Strings.CharacterNames,
		LastNames = [],
		Titles = [],
		RawDescription = "",
		BackgroundDescription = "",
		GoodEnding = null,
		BadEnding = null,
		IsScenarioOnly = false,
		IsNew = true,
		IsUntalented = false,
		IsOffendedByViolence = false,
		IsCombatBackground = false,
		IsNoble = false,
		IsLowborn = false
	},
	function isExcluded( _id )
	{
		return this.m.Excluded.find(_id) != null;
	}

	function isUntalented()
	{
		return this.m.IsUntalented;
	}

	function setScenarioOnly( _f )
	{
		this.m.IsScenarioOnly = _f;
	}

	function isOffendedByViolence()
	{
		return this.m.IsOffendedByViolence;
	}

	function isCombatBackground()
	{
		return this.m.IsCombatBackground;
	}

	function isNoble()
	{
		return this.m.IsNoble;
	}

	function isLowborn()
	{
		return this.m.IsLowborn;
	}

	function getEthnicity()
	{
		return this.m.Ethnicity;
	}

	function getExcludedTalents()
	{
		return this.m.ExcludedTalents;
	}

	function getGoodEnding()
	{
		return this.m.GoodEnding;
	}

	function getBadEnding()
	{
		return this.m.BadEnding;
	}

	function create()
	{
		this.m.Type = this.Const.SkillType.Background | this.Const.SkillType.Trait;
		this.m.Order = this.Const.SkillOrder.Background;
		this.m.DailyCostMult = this.Math.rand(90, 110) * 0.01;
	}

	function isHidden()
	{
		return this.skill.isHidden() || this.m.IsScenarioOnly;
	}

	function getName()
	{
		return "Background: " + this.m.Name;
	}

	function getNameOnly()
	{
		return this.m.Name;
	}

	function getBackgroundDescription()
	{
		return this.m.BackgroundDescription;
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
				text = "Immune to Bleeding, poison and most fresh injuries"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Recovers hitpoints at only 20% of the normal rate and requires no food. and has resistance to piercing type attacks"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "Has resistance to piercing type attacks"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Effected by fatigue at 10% normal rate"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Not affected by morale checks or allies fleeing and dying"
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

	function addEquipment()
	{
		this.onAddEquipment();
		this.adjustHiringCostBasedOnEquipment();
	}

	function onUpdate( _properties )
	{
		if (this.m.DailyCost == 0 || this.getContainer().hasSkill("trait.player"))
		{
			_properties.DailyWage = 0;
		}
		else
		{
			local level = this.getContainer().getActor().getLevel();
			local wage = this.Math.round(this.m.DailyCost * this.m.DailyCostMult);
			_properties.DailyWage += wage * this.Math.pow(1.1, this.Math.min(10, level - 1));

			if (level > 11)
			{
				local previous = wage * this.Math.pow(1.1, 10);
				_properties.DailyWage += previous * this.Math.pow(1.03, level - 1 - 10) - previous;
			}
		}

		if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin() != null && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getID() != "background.slave")
		{
			_properties.XPGainMult *= 0.9;
		}

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
	}

	function adjustHiringCostBasedOnEquipment()
	{
		local actor = this.getContainer().getActor();
		actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 0 * this.Math.pow(this.m.Level - 1, 1.5));
		local items = actor.getItems().getAllItems();
		local cost = 0;

		foreach( i in items )
		{
			cost = cost + i.getValue();
		}

		cost = cost * 0.0;
		actor.m.HiringCost = actor.m.HiringCost + cost;
		actor.m.HiringCost *= 0.0;
		actor.m.HiringCost = this.Math.ceil(actor.m.HiringCost);
		actor.m.HiringCost *= 0.0;
	}

	function onAdded()
	{
		if (this.m.DailyCost > 0)
		{
			this.m.DailyCost += 1;
		}

		local actor = this.getContainer().getActor();
		actor.m.Background = this;

		if (this.m.IsNew && !(("State" in this.Tactical) && this.Tactical.State != null && this.Tactical.State.isScenarioMode()))
		{
			this.m.IsNew = false;

			if (actor.getTitle() == "" && this.m.LastNames.len() != 0 && this.Math.rand(0, 1) == 1)
			{
				actor.setTitle(this.m.LastNames[this.Math.rand(0, this.m.LastNames.len() - 1)]);
			}

			if (actor.getTitle() == "" && this.m.Titles.len() != 0 && this.Math.rand(0, 3) == 3)
			{
				actor.setTitle(this.m.Titles[this.Math.rand(0, this.m.Titles.len() - 1)]);
			}

			if (this.m.Level != 1)
			{
				actor.m.PerkPoints = this.m.Level - 1;
				actor.m.LevelUps = this.m.Level - 1;
				actor.m.Level = this.m.Level;
				actor.m.XP = this.Const.LevelXP[this.m.Level - 1];
			}
		}

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

	function onBuildDescription()
	{
		return "";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeString(this.m.Description);
		_out.writeString(this.m.RawDescription);
		_out.writeU8(this.m.Level);
		_out.writeBool(this.m.IsNew);
		_out.writeF32(this.m.DailyCostMult);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.Description = _in.readString();
		this.m.RawDescription = _in.readString();
		this.m.Level = _in.readU8();
		this.m.IsNew = _in.readBool();

		if (_in.getMetaData().getVersion() >= 39)
		{
			this.m.DailyCostMult = _in.readF32();
		}
		else
		{
			this.m.DailyCostMult = 1.0;
		}
	}

});

