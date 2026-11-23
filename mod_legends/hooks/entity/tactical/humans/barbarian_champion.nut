::mods_hookExactClass("entity/tactical/humans/barbarian_champion", function(o)
{
	local create = o.create;
	o.create = function () {
		create();
		this.m.OnDeathLootTable.extend([
			[2.5, "scripts/items/misc/legend_masterwork_fabric"],
			[1.5, "scripts/items/misc/legend_masterwork_metal"],
			[1.0, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}

	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
		local b = this.m.BaseProperties;
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBalance);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecUnarmed);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
		this.m.Hitpoints = b.Hitpoints * 1.25;
		::Legends.S.scaleBaseProperties(b);
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand)) {
			local weapons = [
				"weapons/barbarians/skull_hammer",
				"weapons/barbarians/two_handed_spiked_mace",
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50) {
			local items = [
				"scripts/items/weapons/barbarians/heavy_javelin",
				"scripts/items/weapons/barbarians/heavy_throwing_axe"
			];

			this.m.Items.addToBag(this.new(items[this.Math.rand(0, items.len() - 1)]));
		}

		local armor = [
			[33, ::Legends.Armor.Barbarian.rugged_scale_armor],
			[34, ::Legends.Armor.Barbarian.heavy_iron_armor],
			[33, ::Legends.Armor.Barbarian.thick_plated_barbarian_armor],
			[5, ::Legends.Armor.Barbarian.reinforced_heavy_iron_armor]
		];

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head)) {
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Barbarian.crude_faceguard_helmet],
				[1, ::Legends.Helmet.Barbarian.closed_scrap_metal_helmet],
				[1, ::Legends.Helmet.Barbarian.crude_metal_helmet]
			]));
		}
	}

	o.makeMiniboss = function () {
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = this.Const.Items.NamedBarbarianWeapons;
		local armor = this.Const.Items.NamedBarbarianArmors;
		local helmets = this.Const.Items.NamedBarbarianHelmets;
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		local r = this.Math.rand(1, 4);
		if (this.Math.rand(1, 100) <= 5) {
			weapons = this.Const.Items.NamedBarbarianWeaponsHigh;
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			return true;
		}
		if (r == 1) {
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else if (r == 2) {
			local weightName = this.Const.World.Common.convNameToList(armor);
			this.m.Items.equip(this.Const.World.Common.pickArmor(weightName));
		}
		else if (r == 3) {
			local weapons = [
				"weapons/named/legend_named_heavy_throwing_axe",
				"weapons/named/legend_named_heavy_javelin"
			];
			this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else {
			local weightName = this.Const.World.Common.convNameToList(helmets);
			this.m.Items.equip(this.Const.World.Common.pickHelmet(weightName));
		}

		return true;
	}
});
