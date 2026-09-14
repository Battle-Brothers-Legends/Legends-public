// this.legend_kobold_fighter <- this.inherit("scripts/entity/tactical/legend_kobold", {
// 	m = {
// 		IsLow = false
// 	},
// 	function create()
// 	{
// 		this.m.Type = this.Const.EntityType.KoboldFighter;
// 		this.m.XP = this.Const.Tactical.Actor.KoboldFighter.XP;
// 		this.legend_kobold.create();
// 		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_ranged_agent");
// 		this.m.AIAgent.setActor(this);
// 	}


// 	function onInit()
// 	{
// 		this.legend_kobold.onInit();
// 		local b = this.m.BaseProperties;
// 		b.setValues(this.Const.Tactical.Actor.KoboldFighter);
// 		b.DamageDirectMult = 1.4;
// 		b.TargetAttractionMult = 1.1;
// 		this.m.ActionPoints = b.ActionPoints;
// 		this.m.Hitpoints = b.Hitpoints;
// 		this.m.CurrentProperties = clone b;
// 		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
// 		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
// 		this.getSprite("head").setBrush("bust_goblin_01_head_0" + this.Math.rand(1, 3));
// 		//this.getSprite("quiver").Visible = true;
// 		this.addDefaultStatusSprites();

// 		if (!this.m.IsLow)
// 		{
// 			b.IsSpecializedInBows = true;

// 			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 180)
// 			{
// 				b.DamageDirectMult = 1.5;
// 			}
// 		}

// 		::Legends.Traits.grant(this, ::Legends.Trait.RacialGoblinAmbusher);
// 		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
// 		::Legends.Perks.grant(this, ::Legends.Perk.LegendBackflip);
// 		::Legends.Perks.grant(this, ::Legends.Perk.LegendHairSplitter);
// 		if (::Legends.isLegendaryDifficulty())
// 		{
// 			::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
// 			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
// 		}

// 	}

// 	function assignRandomEquipment()
// 	{
// 		// if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
// 		// {
// 		// 	local r = this.Math.rand(1, 2);

// 		// 	if (r == 1)
// 		// 	{
// 		// 		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_bow"));
// 		// 	}
// 		// 	else if (r == 2)
// 		// 	{
// 		// 		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_heavy_bow"));
// 		// 	}
// 		// }

// 		this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_notched_blade"));
// 		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/legend_blowgun"));
// 		this.m.Items.equip(this.new("scripts/items/ammo/legend_darts"));

// 		if(::Legends.isLegendaryDifficulty())
// 		{
// 			this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
// 			this.m.Items.addToBag(this.new("scripts/items/accessory/spider_poison_item"));
// 		}
// 		else
// 		{
// 			if (this.Math.rand(1, 100) <= 90)
// 			{
// 				this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
// 			}
// 		}
// 	}

// });

