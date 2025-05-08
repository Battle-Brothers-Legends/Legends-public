::mods_hookExactClass("entity/tactical/enemies/goblin_leader", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTrueBeliever);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Perks.grant(this, ::Legends.Perk.InspiringPresence);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_crossbow"));
		this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_falchion"));
		local item = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Greenskin.goblin_leader_armor]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Greenskin.goblin_leader_helmet]
		]);
		this.m.Items.equip(item);
	}

	o.makeMiniboss <- function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_goblin_crossbow"));
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPrepared);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
		::Legends.Perks.grant(this, ::Legends.Perk.Executioner);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		return true;
	}
});
