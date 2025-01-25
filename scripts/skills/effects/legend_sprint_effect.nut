this.legend_sprint_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSprint);
		this.m.Description = "This character runs like the wind, moving at great speed. Movement costs 1 less AP, at 50% increased fatigue costs.";
		this.m.Icon = "ui/perks/perk_sprint.png";
		this.m.Overlay = "perk_37";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onUpdate( _properties )
	{
		if (!this.isGarbage())
		{
			_properties.MovementAPCostAdditional += -1;
			_properties.MovementFatigueCostMult *= 1.5;
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});

