this.legend_launch_smoke_bomb_skill <- this.inherit("scripts/skills/actives/throw_smoke_bomb_skill", {
	m = {},
	function create()
	{
		this.throw_smoke_bomb_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendLaunchSmokeBomb);
		this.m.Description = "Ignite and launch, using your slingstaff, a pot filled with substances that upon impact will quickly create a dense cloud.";
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
		ret.extend([
		{
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Covers [color=%damage%]7[/color] tiles in smoke for one round, allowing anyone inside to move freely and ignore zones of control"
		},
		{
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases Ranged Defense by [color=%positive%]+100%[/color], but lowers Ranged Skill by [color=%negative%]-50%[/color] for anyone inside"
		},
		{
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Extinguishes existing tile effects like Fire or Miasma"
		}]);

		local ammo = 0;
		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag))
		{
			if (item.getID() == "weapon.smoke_bomb")
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
