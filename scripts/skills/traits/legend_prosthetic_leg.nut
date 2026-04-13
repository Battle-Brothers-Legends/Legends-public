this.legend_prosthetic_leg <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		IsUpgraded = false
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticLeg);
		this.m.Name = "Prosthetic Leg";
		this.m.Icon = "ui/traits/legend_prosthetic_leg.png";
		this.m.Description = "A fake leg of wood and metal. Not much to run on, but at least it\'ll let a man hobble. While it makes the most annoying clanking noise you\'ve ever heard, it\'ll ensure a mercenary is able to walk.";
		if (this.m.IsUpgraded)
		{
			this.m.Name = "Enhanced Prosthetic Leg";
			this.m.Description = "Lovingly recrafted prosthetic leg, which due to some mechanical marvel moves almost like a real leg. It still doesn't perform like a normal leg, but walking with it doesn\'t resemble shambling. Some reinforced pieces with spikes allow the wearer\'s kicks to be very damaging.";
		}
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
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-20%[/color] Initiative"
			}
		];
		if (!this.m.IsUpgraded)
		{
			ret.extend([
				{
					id = 7,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=%negative%]-15%[/color] Melee Defense"
				},
				{
					id = 7,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=%negative%]-15%[/color] Ranged Defense"
				}
			]);
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=#400080]Kick[/color] will now deal 15-30 damage"
			});
		}

		return ret
	}

	function onUpdate (_properties)
	{
		if (!this.m.IsUpgraded)
		{
			_properties.MeleeDefenseMult *= 0.85;
			_properties.RangedDefenseMult *= 0.85;
		}
		_properties.InitiativeMult *= 0.8;
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendKick) && this.m.IsUpgraded)
		{
			_properties.DamageRegularMin = 15;
			_properties.DamageRegularMax = 30;
			_properties.DamageArmorMult = 0.5;
		}
	}
});
