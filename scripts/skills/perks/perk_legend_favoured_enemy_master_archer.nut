this.perk_legend_favoured_enemy_master_archer <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_master_archer";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemyMasterArcher;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemyMasterArcher;
		this.m.Icon = "ui/perks/favoured_archer_01.png";
		this.m.ValidTypes = this.Const.LegendMod.FavoriteArcher;
	}

});

