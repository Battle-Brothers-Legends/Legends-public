this.legend_evasion_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		MeekStacks = 1,
		TurnsLeft = 1
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendEvasion);
		this.m.Description = "%name% ignores all Zones of Control and will ignore the first attack done against %them%.";
		this.m.Icon = "skills/evasion.png";
		this.m.Overlay = "evasion";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		if (this.m.MeekStacks > 0)
		{
			tooltip.push(
			{
				id = 6,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Always evade the next attack made against this character in combat"
			});
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToZoneOfControl = true;
	}

	function onTurnStart()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (this.m.MeekStacks > 0)
			_properties.IsEvadingAllAttacks = true;
	}

	function onMissed( _attacker, _skill )
	{
		if (this.m.MeekStacks > 0)
		{
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_attacker) + " underestimated " + this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s speed.");
			this.m.MeekStacks -= 1;
		}
	}

});
