this.legend_nomad_gladiator <- this.inherit("scripts/entity/tactical/human/gladiator", {
	function create() {
		this.gladiator.create();
		this.m.Type = this.Const.EntityType.LegendNomadGladiator;
		this.actor.create();
	}

	function onInit() {
		this.gladiator.onInit();
		::Legends.Perks.remove(this, ::Legends.Active.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendLithe);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldSkill);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
		}
	}

	function assignRandomEquipment ()
	{
		local r;

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace",
				"weapons/oriental/heavy_southern_mace",
				"weapons/fighting_axe",
				"weapons/fighting_axe",
				"weapons/fighting_spear"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar",
					"weapons/oriental/swordlance",
					"weapons/oriental/polemace",
					"weapons/two_handed_hammer",
					"weapons/greataxe",
					"weapons/legend_ranged_flail"
				]);
			}

			if (this.Const.DLC.Wildmen && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace",
					"weapons/bardiche"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin",
				"weapons/throwing_spear"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			local offhand = [
				"tools/throwing_net",
				"shields/oriental/metal_round_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + offhand[this.Math.rand(0, offhand.len() - 1)]));
		}


		this.m.Items.equip(this.Const.World.Southern.pickArmor([
			[1, ::Legends.Armor.Barbarian.nomad_gladiator_armor_00],
			[1, ::Legends.Armor.Barbarian.nomad_gladiator_armor_01],
			[1, ::Legends.Armor.Barbarian.nomad_gladiator_armor_02]
		]));

		this.m.Items.equip(this.Const.World.Southern.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.nomad_gladiator_helmet_00]
		]));
	}
});