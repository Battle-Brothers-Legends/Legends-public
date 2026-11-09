this.perk_legend_vala_spiritual_bond <- this.inherit("scripts/skills/skill", {
	m = {
		DamageScaling = 0.05 // Vala bravery damage scaling factor
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendValaSpiritualBond);
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsHidden = true;
	}

	function getDamageScaling() {
		return this.m.DamageScaling;
	}
});
