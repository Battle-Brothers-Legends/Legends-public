this.kobold_fighter <- this.inherit("scripts/entity/tactical/kobold", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.KoboldFighter;
		this.m.XP = this.Const.Tactical.Actor.KoboldFighter.XP;
		this.kobold.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_ranged_agent");
		this.m.AIAgent.setActor(this);
	}


	function onInit()
	{
		this.kobold.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.KoboldFighter);
		b.DamageDirectMult = 1.4;
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("head_kobold_0" + this.Math.rand(1, 5));
		//this.getSprite("quiver").Visible = true;
		this.addDefaultStatusSprites();

		if (!this.m.IsLow)
		{
			b.IsSpecializedInBows = true;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 180)
			{
				b.DamageDirectMult = 1.5;
			}
		}

		this.m.Skills.add(this.new("scripts/skills/racial/goblin_ambusher_racial"));
		if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ballistics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			}

	}

	function assignRandomEquipment()
	{
		// if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		// {
		// 	local r = this.Math.rand(1, 2);

		// 	if (r == 1)
		// 	{
		// 		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_bow"));
		// 	}
		// 	else if (r == 2)
		// 	{
		// 		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_heavy_bow"));
		// 	}
		// }

		this.m.Items.addToBag(this.new("scripts/items/weapons/goblin_notched_blade"));
		this.m.Items.equip(this.new("scripts/items/weapons/legend_blowgun"));
		this.m.Items.equip(this.new("scripts/items/ammo/legend_darts"));

		if (this.Math.rand(1, 100) <= 10)
		{
			this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
		}
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
			}

	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_goblin_heavy_bow"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		return true;
	}

});

