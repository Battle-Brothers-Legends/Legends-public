this.legend_vala_in_trance <- this.inherit("scripts/skills/skill", {
	m = {
		Trances = [
			::Legends.Perk.LegendValaTrancePerspective,
			::Legends.Perk.LegendValaTranceMalevolent,
		]
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendValaInTrance);
		this.m.Icon = "skills/status_effect_53.png";
		this.m.IconMini = "status_effect_53_mini";
		this.m.Overlay = "status_effect_53";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 7;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function isHidden()
	{
		return false;
	}


	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character is currently in trance."
			}
		];
	}


	function onRemoved()
	{
		foreach (trance in this.m.Trances)
		{
			local skill = ::Legends.Perks.get(this, trance);
			if (skill == null)
				continue;
			skill.resetTrance();
		}

		if (this.Tactical.isActive())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " returns to this realm.");
		}

		this.getContainer().getActor().m.IsUsingZoneOfControl = true;
	}


	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.50;
		this.getContainer().getActor().m.IsUsingZoneOfControl = false;
	}


	function onCombatFinished()
	{
		this.getContainer().getActor().m.IsUsingZoneOfControl = true;
		this.removeSelf();
	}
});
