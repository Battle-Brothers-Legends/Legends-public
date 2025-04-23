::mods_hookExactClass("entity/tactical/humans/officer", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.OnDeathLootTable.extend([
			[2.5, "scripts/items/misc/legend_masterwork_fabric"],
			[1.5, "scripts/items/misc/legend_masterwork_metal"],
			[1.0, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		local banner = 3;

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			this.m.Items.equip(this.new("scripts/items/shields/oriental/metal_round_shield"));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Southern.padded_mail_and_lamellar_hauberk],
				[1, ::Legends.Armor.Southern.southern_long_mail_with_padding],
				[1, ::Legends.Armor.Southern.mail_and_lamellar_plating]
			]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = [
				[1, ::Legends.Helmet.Southern.turban_helmet],
				[1, ::Legends.Helmet.Southern.heavy_lamellar_helmet],
				[1, ::Legends.Helmet.Southern.southern_helmet_with_coif]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
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
			"weapons/named/named_mace",
			"weapons/named/named_two_handed_scimitar",
			"weapons/named/named_spear",
			"weapons/named/named_shamshir",
			"weapons/named/named_swordlance",
			"weapons/named/named_polemace"
		];
		local shields = this.Const.Items.NamedSouthernShields;

		local r = this.Math.rand(1, 4);
		local armor = clone this.Const.Items.NamedSouthernArmors;
		local helmets = clone this.Const.Items.NamedSouthernHelmets;

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor(
				this.Const.World.Common.convNameToList(
					armor
				)
			));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor(
				this.Const.World.Common.convNameToList(
					helmets
				)
			));
		}

		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		return true;
	}
});
