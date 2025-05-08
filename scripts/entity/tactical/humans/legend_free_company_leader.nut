this.legend_free_company_leader <- this.inherit("scripts/entity/tactical/legend_free_company_abstract", {
	m = {
		Outfits = [
			[1, ::Legends.Outfit.mercenary_leader_outfit_uncommon_00],
			[1, ::Legends.Outfit.mercenary_leader_outfit_00]
		],
		PerkList = this.Const.EnemyPerks.FreeCompanyLeader,
		PerkPower = 10
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.FreeCompanyLeader;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.FreeCompanyLeader.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FreeCompanyLeader);
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
			[1, "weapons/bardiche"],
			[1, "weapons/greataxe"],
			[1, "weapons/greatsword"],
			[1, "weapons/two_handed_flanged_mace"],
			[1, "weapons/fighting_axe"],
			[1, "weapons/legend_military_goedendag"],
			[1, "weapons/legend_military_warscythe"],
		], "scripts/items/"));

		if (this.getIdealRange() == 1) {
			this.getItems().addToBag(::Const.World.Common.pickItem([
				[1, "weapons/throwing_axe"],
				[1, "weapons/javelin"],
			], "scripts/items/"));
		}

		this.legend_free_company_abstract.assignRandomEquipment();
	}

});

