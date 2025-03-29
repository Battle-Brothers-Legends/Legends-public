this.legend_mummy_queen <- this.inherit("scripts/entity/tactical/legend_mummy", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendMummyQueen;
		this.m.XP = this.Const.Tactical.Actor.LegendMummyQueen.XP;
		this.m.ResurrectionValue = 5.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/legend_mummy_queen";
		this.legend_mummy.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_mummy_queen_agent");
		this.m.AIAgent.setActor(this);

		this.m.OnDeathLootTable.extend([
			[100, "scripts/items/loot/ancient_gold_coins_item"],
			[100, "scripts/items/loot/jeweled_crown_item"],
		]);
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++) {
			this.m.OnDeathLootTable.extend([
				[50, "scripts/items/misc/legend_ancient_scroll_item"]
			]);
		}
	}

	function onInit()
	{
		this.legend_mummy.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendMummyQueen);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToDisarm = true;
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
		{
			b.IsSpecializedInPolearms = true;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Effects.grant(this, ::Legends.Effect.DoubleGrip);
		::Legends.Traits.grant(this, ::Legends.Trait.RacialVampire);
		::Legends.Traits.grant(this, ::Legends.Trait.RacialAlp);
		::Legends.Actives.grant(this, ::Legends.Active.Darkflight);
		::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
		::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendCarnage);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}

	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_royal_lance"));

		local armor = [
			[1, "ancient/legend_mummy_dress"]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[1, "ancient/legend_mummy_crown"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

