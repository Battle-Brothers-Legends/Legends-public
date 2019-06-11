this.perk_legend_favoured_enemy_caravan <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_caravan";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemyCaravan;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemyCaravan;
		this.m.Icon = "ui/perks/favoured_caravan_01.png";
		this.m.ValidTypes = [
			this.Const.EntityType.Peasant,
			this.Const.EntityType.CaravanHand,
			this.Const.EntityType.CaravanGaurd,
			this.Const.EntityType.Militia,
			this.Const.EntityType.MilitiaVeteran,
			this.Const.EntityType.MilitiaCaptain,
			this.Const.EntityType.MilitiaArcher
		];
	}

});

