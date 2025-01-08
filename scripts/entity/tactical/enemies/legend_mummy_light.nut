this.legend_mummy_light <- this.inherit("scripts/entity/tactical/legend_mummy", {
	m = {
		IsRanged = false
	},
	function create()
	{
		this.m.IsRanged = this.Math.rand(1, 5) == 1 ? true : false;
		this.m.Type = this.Const.EntityType.LegendMummyLight;
		this.m.XP = this.Const.Tactical.Actor.LegendMummyLight.XP;
		this.m.ResurrectionValue = 2.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/legend_mummy_light";
		this.legend_mummy.create();

		if (!this.m.IsRanged)
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
		else
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
			this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Retreat);
			this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Flee);
		}
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_mummy.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendMummyLight);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldExpert);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
		}

	}

	function assignRandomEquipment()
	{

		if (!this.m.IsRanged)
		{
			local r = this.Math.rand(0, 3);

			if (r == 0)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
			}
			else if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_sword"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/legend_khopesh"));
			}

			if (this.Math.rand(1, 100) <= 66)
			{
				this.m.Items.equip(this.new("scripts/items/shields/ancient/legend_mummy_shield"));
			}
		}
		else
		{
			local weapons = [
				[
					"weapons/legend_sling"
				]
			];
			local n = this.Math.rand(0, weapons.len() - 1);

			foreach( w in weapons[n] )
			{
				this.m.Items.equip(this.new("scripts/items/" + w));
			}

			this.m.Items.addToBag(this.new("scripts/items/weapons/ancient/legend_khopesh"));
		}

		local armor = [
			[2, "ancient/legend_mummy_bandages"],
			[3, ""]

		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);



		item = this.Const.World.Common.pickHelmet([
			[1, "ancient/legend_mummy_bandages"],
			[4, ""]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

