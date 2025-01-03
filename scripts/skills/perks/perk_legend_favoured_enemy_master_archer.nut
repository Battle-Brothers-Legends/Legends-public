this.perk_legend_favoured_enemy_master_archer <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendFavouredEnemyArcher);
		this.m.ValidTypes = this.Const.LegendMod.FavoriteArcher;
	}

	function onAfterUpdate( _properties )
	{
		_properties.RangedAttackBlockedChanceMult *= 0.66;
	}

});

