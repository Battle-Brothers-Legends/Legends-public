this.legend_inspired_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsApplied = false
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendInspired);
		this.m.Description = "I can do this for the company! This character has been inspired by hearing just the right words, and is ready to go to their limits and beyond.";
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.IconMini = "perk_28_mini";
		this.m.Overlay = "perk_28";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}


	function onAdded()
	{
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += 4;
	}

	function onTurnStart()
	{
		if (!this.m.IsApplied)
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 4));
			this.m.IsApplied = true;
		}
	}

	function onResumeTurn()
	{
		if (!this.m.IsApplied)
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 4));
			this.m.IsApplied = true;
		}
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});

