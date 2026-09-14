this.legend_free_company_longbow <- this.inherit("scripts/entity/tactical/legend_free_company_abstract", {
	m = {
		Outfits = [
			[1, ::Legends.Outfit.mercenary_longbow_outfit_00]
		],
		PerkList = this.Const.EnemyPerks.FreeCompanyLongbow,
		PerkPower = 8
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.FreeCompanyLongbow;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.FreeCompanyLongbow.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanyLongbow);
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
			[95, "weapons/hunting_bow"],
			[5, "weapons/war_bow"],
		], "scripts/items/"));

		this.getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));

		this.legend_free_company_abstract.assignRandomEquipment();

		this.getItems().addToBag(::Const.World.Common.pickItem([
			[1, "weapons/dagger"],
			[3, "weapons/knife"]
		], "scripts/items/"));
	}

});

