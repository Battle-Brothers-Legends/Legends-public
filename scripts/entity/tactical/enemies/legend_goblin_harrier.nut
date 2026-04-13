this.legend_goblin_harrier <- this.inherit("scripts/entity/tactical/enemies/goblin_fighter", {
	m = {},

	function create()
	{
		this.m.Type = this.Const.EntityType.LegendGoblinHarrier;
		this.m.XP = this.Const.Tactical.Actor.LegendGoblinHarrier.XP;
		this.goblin.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin_fighter.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendGoblinHarrier);
		::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendFreedomOfMovement);
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 2);

		local weapons = [
			"weapons/greenskins/goblin_falchion",
			"weapons/greenskins/goblin_spear",
			"weapons/legend_chain",
			"weapons/greenskins/goblin_notched_blade",
			"weapons/greenskins/legend_goblin_infantry_axe",
			"weapons/greenskins/goblin_pike",
			"weapons/greenskins/legend_goblin_infantry_axe"
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local item = this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Greenskin.goblin_medium_armor],
				[2, ::Legends.Armor.Greenskin.goblin_heavy_armor]
			]);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local item = this.Const.World.Common.pickHelmet([
				[25, ::Legends.Helmet.Greenskin.goblin_light_helmet],
				[75, ::Legends.Helmet.Greenskin.goblin_heavy_helmet]
			]);
			if (item != null)
			{
				this.m.Items.equip(item);
			}
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
			"weapons/named/legend_named_goblin_gruesome_falchion",
			"weapons/named/named_goblin_pike",
			"weapons/named/named_goblin_spear",
			"weapons/named/named_warbrand",
			"weapons/named/legend_named_goblin_notched_blade"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		return true;
	}

});
