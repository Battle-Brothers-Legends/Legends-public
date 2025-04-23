::mods_hookExactClass("entity/tactical/humans/executioner", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.OnDeathLootTable.extend([
			[1.5, "scripts/items/misc/legend_masterwork_fabric"],
			[1.0, "scripts/items/misc/legend_masterwork_metal"],
			[0.5, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/oriental/two_handed_scimitar",
				"weapons/oriental/two_handed_scimitar",
				"weapons/two_handed_hammer",
				"weapons/two_handed_flanged_mace",
				"weapons/two_handed_flail",
				"weapons/bardiche"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}


		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.lamellar_harness],
				[1, ::Legends.Armor.Standard.heavy_lamellar_armor]
			]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helm = [
				[3, ::Legends.Helmet.Southern.nomad_reinforced_helmet],
				[3, ::Legends.Helmet.Southern.southern_helmet_with_coif],
				[3, ::Legends.Helmet.Southern.turban_helmet],
				[1, ::Legends.Helmet.Southern.janissary_helmet]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helm));
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
			"weapons/named/named_two_handed_hammer",
			"weapons/named/named_two_handed_scimitar",
			"weapons/named/named_two_handed_scimitar",
			"weapons/named/named_two_handed_mace",
			"weapons/named/named_two_handed_flail",
			"weapons/named/named_bardiche"
		];

		local armor = clone this.Const.Items.NamedSouthernArmors;
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor(
				this.Const.World.Common.convNameToList(armor)
			));
		}

		::Legends.Perks.grant(this, ::Legends.Perk.ReachAdvantage);
		return true;
	}
});
