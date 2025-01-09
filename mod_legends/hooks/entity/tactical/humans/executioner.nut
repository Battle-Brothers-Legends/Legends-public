::mods_hookExactClass("entity/tactical/humans/executioner", function(o)
{
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
				"weapons/two_handed_hammer"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_flail"
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/bardiche"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}


		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "lamellar_harness"],
				[1, "heavy_lamellar_armor"]
			]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helm = [
				[3, "oriental/nomad_reinforced_helmet"],
				[3, "oriental/southern_helmet_with_coif"],
				[3, "oriental/turban_helmet"]
			];
			helm.push(
				[1, "oriental/janissary_helmet"]
			);

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
			"weapons/named/named_two_handed_scimitar"
		];

		if (this.Const.DLC.Unhold)
		{
			weapons.extend([
				"weapons/named/named_two_handed_mace",
				"weapons/named/named_two_handed_flail"
			]);
		}

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/named/named_bardiche"
			]);
		}

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
