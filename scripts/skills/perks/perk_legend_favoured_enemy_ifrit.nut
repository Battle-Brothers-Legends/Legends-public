this.perk_legend_favoured_enemy_ifrit <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendFavouredEnemyIfrit);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteIfrits;
	}

});

