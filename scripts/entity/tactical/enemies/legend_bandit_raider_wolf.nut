this.legend_bandit_raider_wolf <- this.inherit("scripts/entity/tactical/enemies/legend_bandit_raider", {
	m = {},
	function create()
	{
		this.legend_bandit_raider.create();
		this.m.Name = "Disguised Bandit";
	}

	function onInit()
	{
		this.legend_bandit_raider.onInit();
	}

	function assignRandomEquipment()
	{
		if (::Math.rand(0, 8) <= 1) {
			this.getItems().equip(::Const.World.Common.pickItem([
				[1, "weapons/woodcutters_axe"],
				[1, "weapons/billhook"],
				[1, "weapons/pike"],
				[1, "weapons/warbrand"],
				[1, "weapons/legend_militia_glaive"],
			], "scripts/items/"));
		} else {
			this.getItems().equip(::Const.World.Common.pickItem([
				[1, "weapons/shortsword"],
				[1, "weapons/hand_axe"],
				[1, "weapons/boar_spear"],
				[1, "weapons/morning_star"],
				[1, "weapons/falchion"],
				[1, "weapons/arming_sword"],
				[1, "weapons/flail"],
			], "scripts/items/"));

			if (::Math.rand(1, 100) <= 75) {
				this.getItems().equip(::Const.World.Common.pickItem([
					[3, "shields/wooden_shield"],
					[1, "shields/kite_shield"],
				], "scripts/items/"));
			}
		}

		if (::Math.rand(1, 100) <= 33) {
			this.getItems().addToBag(::Const.World.Common.pickItem([
				[1, "weapons/throwing_axe"],
				[1, "weapons/javelin"],
			], "scripts/items/"));
		}

		local item = ::Const.World.Common.pickArmor([
			[20, ::Legends.Armor.Standard.ragged_surcoat],
			[20, ::Legends.Armor.Standard.padded_leather],
			[20, ::Legends.Armor.Standard.worn_mail_shirt],
			[20, ::Legends.Armor.Standard.patched_mail_shirt],
			[20, ::Legends.Armor.Standard.leather_lamellar],
			[20, ::Legends.Armor.Standard.basic_mail_shirt]
		]);
		item.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade"));
		this.getItems().equip(item);

		if (this.Math.rand(1, 100) <= 75) {
			this.getItems().equip(::Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.nasal_helmet],
				[1, ::Legends.Helmet.Standard.dented_nasal_helmet],
				[1, ::Legends.Helmet.Standard.rusty_mail_coif],
				[1, ::Legends.Helmet.Standard.headscarf],
				[1, ::Legends.Helmet.Standard.nasal_helmet_with_rusty_mail]
			]));
		}

		this.assignPerks();

	}

});

