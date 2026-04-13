this.perk_legend_wind_reader <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendWindReader);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function getBonus()
	{
		if (this.getContainer() == null)
		{
			return 3;
		}

		local actor = this.getContainer().getActor();

		if (actor == null)
		{
			return 3;
		}

		local rdef = actor.getBaseProperties().RangedDefense;
		local bonus = rdef / 3;
		return this.Math.max(3, this.Math.floor(bonus));
	}


	function getTooltip()
	{
		local bonus = this.getBonus();
		local tooltip = this.skill.getTooltip();

			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "You are gaining [color=%positive%]" + bonus + "[/color] ranged skill due to wind reading"
			});


		return tooltip;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.RangedSkill += bonus;

	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null)
		{
			local targetTile = _targetEntity.getTile();
			local actor = this.getContainer().getActor();
			local myTile = actor.getTile();
			local difference = myTile.Level - targetTile.Level;
			if (difference >= 1)
			{
				local weapon = actor.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
				local bonus = 0.05 * difference;
				_properties.RangedDamageMult *= 1.0 + bonus;
			}
		}
	}
});
