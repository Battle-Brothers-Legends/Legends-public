::mods_hookExactClass("entity/tactical/humans/desert_devil", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.Adrenaline);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/oriental/swordlance",
					"weapons/oriental/swordlance"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "oriental/assassin_robe"],
			[1, "blade_dancer_armor_00"]
			// [1, "leather_scale_armor"]
		]));
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helm =this.Const.World.Common.pickHelmet([
				[1, "oriental/blade_dancer_head_wrap"],
				[1, "blade_dancer_helmet_00"]
			]);
			this.m.Items.equip(helm);
		}
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_shamshir",
			"weapons/named/named_swordlance",
			"weapons/named/named_swordlance"
		];

		if (this.Math.rand(1, 100) <= 75)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "named/black_leather_armor"]
			]));
		}

		this.m.BaseProperties.DamageDirectMult *= 1.25;
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		return true;
	}

	o.onDeath <- function(_killer, _skill, _tile,  _fatalityType)
	{
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);

		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			if (this.Math.rand(1, 1000) <= 15) //1.5%
			{
				local loot = this.new("scripts/items/misc/legend_masterwork_fabric");
				loot.drop(_tile);
			}

			if (this.Math.rand(1, 100) <= 1)
			{
				local loot = this.new("scripts/items/misc/legend_masterwork_metal");
				loot.drop(_tile);
			}

			if (this.Math.rand(1, 1000) <= 5) //0.5%
			{
				local loot = this.new("scripts/items/misc/legend_masterwork_tools");
				loot.drop(_tile);
			}
		}
	}

});
