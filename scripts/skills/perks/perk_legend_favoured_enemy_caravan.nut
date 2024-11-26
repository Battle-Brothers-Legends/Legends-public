this.perk_legend_favoured_enemy_caravan <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteCaravan;
	}

	function isDroppedAsLoot( _item )
	{
		return this.Math.rand(1, 100) <= 5; //5% more loot, counts for beast loot, weapons, armour, scrolls and anything else tagged as "isdroppedasloot". Stacks with other sources.
	}
});

