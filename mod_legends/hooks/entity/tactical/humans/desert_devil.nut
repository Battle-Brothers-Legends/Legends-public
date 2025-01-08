::mods_hookExactClass("entity/tactical/humans/desert_devil", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Dodge);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Adrenaline);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Footwork);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Recover);
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
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Relentless);
		return true;
	}
});
