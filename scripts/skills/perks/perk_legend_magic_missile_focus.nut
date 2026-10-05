this.perk_legend_magic_missile_focus <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMagicMissileFocus);
		this.m.Icon = "ui/perks/legend_magic_missile.png";
	}
});
