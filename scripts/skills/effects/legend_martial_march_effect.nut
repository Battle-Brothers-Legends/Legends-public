this.legend_martial_march_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsApplied = false
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendMartialMarch);
		this.m.Description = "I can do this for the company! This character has been inspired by hearing just the right words, and is ready to go to their limits and beyond.";
		this.m.Icon = "skills/martial_march_circle.png";
		this.m.IconMini = "martial_march_mini";
		this.m.Overlay = "martial_march_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onAdded()
	{
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += 1;
	}

	function onTurnStart()
	{
		if (!this.m.IsApplied)
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 1));
			this.m.IsApplied = true;
		}
	}

	function onResumeTurn()
	{
		if (!this.m.IsApplied)
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 1));
			this.m.IsApplied = true;
		}
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});
