this.perk_legend_last_stand <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendLastStand);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function isHidden()
	{
		return this.getContainer().getActor().getHitpointsPct() >= 0.66;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local currentPercent = this.getContainer().getActor().getHitpointsPct();
		if (currentPercent < 0.66)
		{
			local bonus = this.Math.floor(100 * (0.66 - currentPercent) / 2.0);

			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Your melee and ranged defense are increased by [color=%positive%]" + bonus + "[/color]."
			});

			if (currentPercent < 0.33)
			{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Immune to the effects of fresh injuries, and not upset by health losses."
				});
			}
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		local currentPercent = this.getContainer().getActor().getHitpointsPct();
		if (currentPercent < 0.66)
		{
			local bonus = this.Math.floor(100 * (0.66 - currentPercent) / 2.0);
			_properties.MeleeDefense += bonus;
			_properties.RangedDefense += bonus;

			if (currentPercent < 0.33)
			{
				_properties.IsAffectedByFreshInjuries = false;
				_properties.IsAffectedByLosingHitpoints = false;
			}
		}
	}
});

