this.legend_martial_march_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsApplied = false
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendMartialMarch);
		this.m.Description = "I can do this for the company! This character has been inspired by hearing just the right words, and is ready to go to their limits and beyond.";
		this.m.Icon = "ui/perks/drums_of_war.png";
		this.m.IconMini = "drums_of_war_circle";
		this.m.Overlay = "drums_of_war";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsHidden = false;
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
