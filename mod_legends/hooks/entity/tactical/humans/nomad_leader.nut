::mods_hookExactClass("entity/tactical/humans/nomad_leader", function(o)
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
		::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace",
				"weapons/fighting_spear"
			];

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 66)
		{
			local shields = [
				"shields/oriental/metal_round_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 35)
		{
			local weapons = [
				"weapons/javelin",
				"weapons/throwing_spear"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}


		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local armor = [
				[1, ::Legends.Armor.Southern.plated_nomad_mail],
				[1, ::Legends.Armor.Southern.southern_long_mail_with_padding],
			];

			local helmet = [
				[4, ::Legends.Helmet.Southern.southern_helmet_with_coif],
				[8, ::Legends.Helmet.Southern.nomad_reinforced_helmet]
			];

			local outfits = [
				[1, ::Legends.Outfit.southern_knight_outfit_00],
				[1, ::Legends.Outfit.white_nomad_leader_outfit_00]
			];

			foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item)
			}
			return;
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, ::Legends.Armor.Southern.plated_nomad_mail],
				[2, ::Legends.Armor.Southern.southern_long_mail_with_padding],
				[1, ::Legends.Armor.Standard.theamson_nomad_leader_armor_heavy],
				[2, ::Legends.Armor.Standard.citrene_nomad_leader_armor_00],
				[1, ::Legends.Armor.Standard.southern_knight_armor]
			]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local helmet = [
				[4, ::Legends.Helmet.Southern.southern_helmet_with_coif],
				[1, ::Legends.Helmet.Standard.theamson_nomad_leader_helmet_facemask],
				[1, ::Legends.Helmet.Standard.theamson_nomad_leader_helmet_heavy],
				[8, ::Legends.Helmet.Southern.nomad_reinforced_helmet]
			];

			helmet.push([4, ::Legends.Helmet.Southern.kamy_southern_helmet]);
			helmet.push([4, ::Legends.Helmet.Standard.southern_knight_helmet]);

			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		}
	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local r = this.Math.rand(1, 4);

		local armor = clone this.Const.Items.NamedSouthernArmors;
		local helmets = clone this.Const.Items.NamedSouthernHelmets;

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernMeleeWeapons[this.Math.rand(0, this.Const.Items.NamedSouthernMeleeWeapons.len() - 1)]));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernShields[this.Math.rand(0, this.Const.Items.NamedSouthernShields.len() - 1)]));
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
			this.m.Items.equip(this.Const.World.Common.pickHelmet(
				this.Const.World.Common.convNameToList(
					helmets
				)
			));
		}

		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		return true;
	}
});
