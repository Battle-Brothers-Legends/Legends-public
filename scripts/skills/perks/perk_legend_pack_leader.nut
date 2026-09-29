this.perk_legend_pack_leader <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPackLeader);
	}
	//handled with ::Legends.S.isWarhoundAllowedIntoBags
});
