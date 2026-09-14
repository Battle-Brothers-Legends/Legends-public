this.legend_perfect_focus_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPerfectFocus);
		this.m.Description = "This character has achieved perfect focus, as if time itself has stood still. Each stack grants an additional 3 Action Points during this round.";
		this.m.Icon = "ui/perks/perfectfocus_circle.png";
		this.m.IconMini = "mini_perfectfocus_circle";
		this.m.Overlay = "status_perfectfocus_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsStacking = true;
		this.m.IsHidden = true;
	}

	function getIconDisabled()
	{
		return "FUCKOFF";
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		actor.setActionPoints(actor.getActionPoints() + 3);
	}

	function onUpdate( _properties )
	{
		if (!this.isGarbage())
		{
			_properties.ActionPoints += 3;
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});

