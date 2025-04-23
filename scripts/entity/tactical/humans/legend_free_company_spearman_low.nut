this.legend_free_company_spearman_low <- this.inherit("scripts/entity/tactical/humans/legend_free_company_spearman", {
	m = {
		Outfits = [
			[1, ::Legends.Outfit.low_tier_unit_catchall_outfit_01],
			// [1, ::Legends.Outfit.mercenary_spearman_outfit_01]
		]
		PerkList = this.Const.EnemyPerks.FreeCompanySpearman,
		PerkPower = 3
	},

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanySpearman);
		b.MeleeSkill -= 10;
		b.MeleeDefense -= 5;
		b.Hitpoints -= 5;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/militia_spear"],
			[1, "weapons/legend_wooden_spear"],
		], "scripts/items/"));

		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "shields/buckler_shield"],
			[1, "shields/wooden_shield"],
			[1, null],
		], "scripts/items/"));

		this.legend_free_company_abstract.assignRandomEquipment();
	}

});

