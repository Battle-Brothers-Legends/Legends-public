this.legend_greenwood_sap_effect <- this.inherit("scripts/skills/skill", {
	m = {
	TurnsLeft = 3
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendGreenwoodSap);
		this.m.Description = "This character has achieved perfect focus, as if time itself has stood still. They can use all skills at half their normal Action Point cost.";
		this.m.Icon = "ui/perks/perfectfocus_circle.png";
		this.m.IconMini = "perk_37_mini";
		this.m.Overlay = "perk_37";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getIconDisabled()
	{
		return "TODO";
	}

	function onUpdate( _properties )
	{
		if (!this.isGarbage())
		{
			_properties.IsSkillUseHalfCost = true;
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onTurnEnd()
	{

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

