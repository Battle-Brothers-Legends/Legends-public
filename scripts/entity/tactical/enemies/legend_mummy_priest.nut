this.legend_mummy_priest <- this.inherit("scripts/entity/tactical/legend_mummy", {
	m = {
		Entity = "LegendMummyPriest"
	},

	function create() {
		this.legend_mummy.create();
		this.m.ResurrectionValue = 2.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/legend_mummy_priest";
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_mummy_queen_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit() {
		this.legend_mummy.onInit();
		this.getSprite("body").setBrush("bust_skeleton_body_02");
		this.setDirty(true);
		local b = this.m.BaseProperties;
		b.TargetAttractionMult = 3.0;
		this.m.CurrentProperties = clone b;
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendWindReader);
		::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
	}

	function assignRandomEquipment() {
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/ancient/legend_kopis"]
		], "scripts/items/"));

		this.getItems().equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.legend_mummy_dress]
		]));

		this.getItems().equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.legend_mummy_headband],
			[1, ::Legends.Helmet.Ancient.legend_mummy_crown]
		]));
	}

});
