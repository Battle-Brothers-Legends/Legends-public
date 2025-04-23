this.legend_free_company_billman <- this.inherit("scripts/entity/tactical/legend_free_company_abstract", {
	m = {
		Outfits = [
			[1, ::Legends.Outfit.mercenary_billman_outfit_00]
		],
		PerkList = this.Const.EnemyPerks.FreeCompanyBillman,
		PerkPower = 7
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.FreeCompanyBillman;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.FreeCompanyBillman.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanyBillman);
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
			[25, "weapons/billhook"],
			[25, "weapons/longaxe"],
			[25, "weapons/legend_halberd"],
			[25, "weapons/legend_battle_glaive"],
			[3, "weapons/polehammer"],
		], "scripts/items/"));

		this.legend_free_company_abstract.assignRandomEquipment();
	}

});

