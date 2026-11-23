this.legend_launch_acid_flask_skill <- this.inherit("scripts/skills/actives/throw_acid_flask", {
	m = {},
	function create()
	{
		this.throw_acid_flask.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendLaunchAcidFlask);
		this.m.Description = "Launch a flask of acid, with your slingstaff, towards a target, where it will shatter and spray its contents. The acid will slowly corrode away any armor of those hit - friend and foe alike.";
		this.m.SoundOnUse = [
			"sounds/combat/dlc4/sling_use_01.wav",
			"sounds/combat/dlc4/sling_use_02.wav",
			"sounds/combat/dlc4/sling_use_03.wav",
			"sounds/combat/dlc4/sling_use_04.wav"
		];
		this.m.Delay = 750;
		this.m.IsOffensiveToolSkill = false;
		this.m.IsRanged = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
		this.m.MinRange = 4;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 7;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the target\'s armor by [color=%damage%]20%[/color] each turn for 3 turns."
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%damage%]33%[/color] chance to hit bystanders at the same or lower height level as well."
		});

		local ammo = 0;
		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag))
		{
			if (item.getID() == "weapon.acid_flask")
			{
				if (item.getAmmo() != 0)
				{
					ammo += item.getAmmo();
				}
			}
		}

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]" + ammo + "[/color] use left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]No ammo left in backpack[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
			return true;
		if (actor.getCurrentProperties() == null)
			return true;
		if (!actor.getCurrentProperties().IsSpecializedInSlings)
			return true;
		if (this.m.Item != null && !this.m.Item.isNull() && this.m.Item.getAmmo() != 0)
			return false;
		return this.skill.isHidden();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin = 0;
			_properties.DamageRegularMax = 0;
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.MaxRange = this.m.MaxRange + (_properties.IsSpecializedInSlings ? 1 : 0);
		this.m.FatigueCostMult = _properties.IsSpecializedInSlings ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}
});
