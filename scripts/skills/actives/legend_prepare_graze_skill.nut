this.legend_prepare_graze_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendPrepareGraze);
		this.m.Description = "Evaluate your enemy, preparing your next attack to leave them bleeding from multiple grazes.";
		this.m.Icon = "skills/graze_square.png";
		this.m.IconDisabled = "skills/graze_square_bw.png";
		this.m.Overlay = "status_effect_01";
		this.m.SoundOnUse = [
			"sounds/combat/rupture_blood_01.wav",
			"sounds/combat/rupture_blood_02.wav",
			"sounds/combat/rupture_blood_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = true;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 15;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The next attack will apply the Grazed bleeding status effect."
			}
		];


		return ret;
	}

	function isUsable()
	{
		local poison = ::Legends.Effects.get(this, ::Legends.Effect.LegendGrazePrepared);

		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && poison == null;
	}

	function onUse( _user, _targetTile )
	{
		local poison = ::Legends.Effects.get(_user, ::Legends.Effect.LegendGrazePrepared);

		if (poison != null)
		{
			poison.resetTime();
		}
		else
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendGrazePrepared);
		}

		if (this.m.Item != null && !this.m.Item.isNull())
		{
			this.m.Item.removeSelf();
		}

		return true;
	}

});

