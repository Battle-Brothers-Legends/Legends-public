this.legend_cheered_on_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsApplied = false
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendCheeredOn);
		this.m.Description = "This character has been encouraged by hearing just the right words, and is ready to give it their all.";
		this.m.Icon = "ui/perks/cheered_on_circle.png";
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
		_properties.ActionPoints += 2;
	}

	function onTurnStart()
	{
		if (!this.m.IsApplied)
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(actor.getActionPoints() + 2);
			this.m.IsApplied = true;
		}
	}

	function onResumeTurn()
	{
		if (!this.m.IsApplied)
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(actor.getActionPoints() + 2);
			this.m.IsApplied = true;
		}
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});

