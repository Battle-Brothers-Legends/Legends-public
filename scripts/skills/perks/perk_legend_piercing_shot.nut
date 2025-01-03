this.perk_legend_piercing_shot <- this.inherit("scripts/skills/skill", {
	m = {
		BonusRange = 1,
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendPiercingShot);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		local s = this.getContainer().getSkillByID("actives.fire_handgonne");
		if (s != null)
		{
			s.m.MaxRange += this.m.BonusRange;
			// The getTooltip() function in fire_handgonne_skill has logic to display this bonus
		}
	}
});
