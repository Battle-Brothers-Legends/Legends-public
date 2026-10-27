this.legend_disowned_noble_ranged_background <- this.inherit("scripts/skills/backgrounds/disowned_noble_background", {
	function create () {
		this.disowned_noble_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendDisownedNobleRanged);
		this.setBodyCharacteristics(1);
		this.m.BackgroundDescription = "Disowned Ladies often have profited from some training in ranged warfare at court and know the weaknesses of noble armies.";
	}

	function onChangeAttributes () {
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendDisownedNobleRanged);
	}

	function onAddEquipment() {
		local items = this.getContainer().getActor().getItems();

		items.equip(::Legends.Items.pickItem([
			[1, "weapons/hunting_bow"],
			[1, "weapons/light_crossbow"],
			[1, "weapons/arming_sword"]
		], "scripts/items/"));

		items.equip(::Legends.Items.pickBasicAmmo(items.getItemAtSlot(::Const.ItemSlot.Mainhand)));

		if (items.getItemAtSlot(::Const.ItemSlot.Offhand) == null) {
			items.equip(::Legends.Items.pickItem([
				[1, "shields/wooden_shield"]
			], "scripts/items/"));
		}

		items.equip(::Legends.Items.pickArmor([
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.gambeson],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.mail_shirt],
			[1, ::Legends.Armor.Standard.mail_hauberk]
		]));

		items.equip(::Legends.Items.pickHelmet([
			[1, ::Legends.Helmet.Standard.nasal_helmet],
			[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
			[1, ::Legends.Helmet.Standard.aketon_cap],
			[1, ::Legends.Helmet.Standard.full_aketon_cap],
			[1, ::Legends.Helmet.Standard.mail_coif],
			[1, ::Legends.Helmet.Standard.feathered_hat],
			[3, ::Legends.Helmet.None]
		]));
	}
});
