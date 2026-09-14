this.legend_free_company_slayer <- this.inherit("scripts/entity/tactical/legend_free_company_abstract", {
	m = {
		Outfits = [
			[1, ::Legends.Outfit.mercenary_spearman_outfit_00]
		],
		PerkList = this.Const.EnemyPerks.FreeCompanySlayer,
		PerkPower = 12
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.FreeCompanySlayer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.FreeCompanySlayer.XP;
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
		b.setValues(this.Const.Tactical.Actor.FreeCompanySlayer);
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
			[32, "weapons/morning_star"],
			[32, "weapons/flail"],
			[32, "weapons/hand_axe"],
			[6, "weapons/three_headed_flail"],
		], "scripts/items/"));

		this.getItems().equip(::Const.World.Common.pickItem([
			[3, "shields/kite_shield"],
			[3, "shields/heater_shield"],
			[4, "tools/throwing_net"],
		], "scripts/items/"));

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
		{
			this.getItems().addToBag(::Const.World.Common.pickItem([
				[1, "weapons/throwing_axe"],
				[1, "weapons/javelin"],
			], "scripts/items/"));
		}

		this.legend_free_company_abstract.assignRandomEquipment();
	}

});

