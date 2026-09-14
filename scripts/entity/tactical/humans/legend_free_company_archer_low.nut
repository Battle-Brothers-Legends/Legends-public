this.legend_free_company_archer_low <- this.inherit("scripts/entity/tactical/humans/legend_free_company_archer", {
	m = {
		Outfits = [
			[1, ::Legends.Outfit.low_tier_unit_catchall_outfit_01]
		],
		PerkList = this.Const.EnemyPerks.FreeCompanyArcher,
		PerkPower = 3
	},
	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanyArcher);
		b.RangedSkill -= 10;
		b.MeleeDefense -= 5;
		b.RangedDefense -= 5;
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
		this.m.Items.equip(this.new("scripts/items/weapons/short_bow"));
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));

		this.legend_free_company_abstract.assignRandomEquipment();

		this.getItems().addToBag(::Const.World.Common.pickItem([
			[1, "weapons/knife"]
		], "scripts/items/"));
	}

});

