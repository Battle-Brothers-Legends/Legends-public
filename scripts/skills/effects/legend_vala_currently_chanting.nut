this.legend_vala_currently_chanting <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendValaCurrentlyChanting);
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.IconMini = "perk_28_mini";
		this.m.Overlay = "perk_28";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 6;
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
		if (!this.isHidden())
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
					text = "This character is currently chanting."
				}
			];
		}
		else
		{
			return;
		}
	}


	function onRemoved()
	{
		local ChantDisharmony = ::Legends.Perks.get(this.getContainer().getActor(), ::Legends.Perk.LegendValaChantDisharmony);
		local ChantFury = ::Legends.Perks.get(this.getContainer().getActor(), ::Legends.Perk.LegendValaChantFury);

		if (ChantDisharmony != null)
		{
			ChantDisharmony.resetChant();
		}
		if (ChantFury != null)
		{
			ChantFury.resetChant();
		}
	}


	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}


	function onCombatFinished()
	{
		this.removeSelf();
	}
});
