this.legend_goblin_tribe_defender <- this.inherit("scripts/entity/tactical/goblin", {
	m = {},

	function create()
	{
		this.m.Type = ::Const.EntityType.LegendGoblinTribeDefender;
		this.m.XP = ::Const.Tactical.Actor.LegendGoblinTribeDefender.XP;
		this.goblin.create();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/goblin_leader_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendGoblinTribeDefender);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_01_head_0" + this.Math.rand(1, 3));
		this.addDefaultStatusSprites();
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInCrossbows = true;
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendClarity);
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
		this.m.Items.equip(::new("scripts/items/weapons/greenskins/goblin_crossbow"));
		this.m.Items.addToBag(::new("scripts/items/weapons/greenskins/goblin_falchion"));
		local item = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Greenskin.goblin_heavy_armor]
		]);
		this.m.Items.equip(item);
		item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Greenskin.goblin_leader_helmet]
		]);
		this.m.Items.equip(item);
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		this.m.Items.equip(::new("scripts/items/weapons/named/legend_named_goblin_crossbow"));
		this.m.Items.addToBag(::new("scripts/items/weapons/greenskins/goblin_falchion"));
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendVengeance);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		return true;
	}

});
