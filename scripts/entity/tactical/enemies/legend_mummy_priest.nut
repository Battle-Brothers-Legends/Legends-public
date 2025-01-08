this.legend_mummy_priest <- this.inherit("scripts/entity/tactical/legend_mummy", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendMummyPriest;
		this.legend_mummy.create();
		this.m.XP = this.Const.Tactical.Actor.LegendMummyPriest.XP;
		this.m.ResurrectionValue = 2.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/legend_mummy_priest";
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_mummy_queen_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_mummy.onInit();
		this.getSprite("body").setBrush("bust_skeleton_body_02");
		this.setDirty(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendMummyPriest);
		b.TargetAttractionMult = 3.0;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.HoldOut);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.FastAdaption);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Underdog);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Berserk);
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Anticipation);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.HeadHunter);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.NineLives);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBloodbath);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendCarnage);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BattleForged);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
		}

	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/ancient/legend_kopis"));

		local armor = [
			[1, "ancient/legend_mummy_dress"]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[1, "ancient/legend_mummy_headband"],
			[1, "ancient/legend_mummy_crown"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

