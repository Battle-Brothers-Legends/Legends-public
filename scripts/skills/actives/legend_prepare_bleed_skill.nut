this.legend_prepare_bleed_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		this.m.ID = "actives.legend_prepare_bleed";
		this.m.Name = "Prepare to Bleed";
		this.m.Description = "Evaluate your enemy, preparing your next attack to leave them bleeding.";
		this.m.Icon = "skills/bleed_square.png";
		this.m.IconDisabled = "skills/bleed_square_bw.png";
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
				text = "The next attack will apply the Bleeding status effect."
			}
		];


		return ret;
	}

	function isUsable()
	{
		local poison = this.getContainer().getSkillByID("effects.legend_bleed_prepared");

		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && poison == null;
	}

	function onUse( _user, _targetTile )
	{
		local poison = _user.getSkills().getSkillByID("effects.legend_bleed_prepared");

		if (poison != null)
		{
			poison.resetTime();
		}
		else
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendBleedPrepared);
		}

		if (this.m.Item != null && !this.m.Item.isNull())
		{
			this.m.Item.removeSelf();
		}

		return true;
	}

});

