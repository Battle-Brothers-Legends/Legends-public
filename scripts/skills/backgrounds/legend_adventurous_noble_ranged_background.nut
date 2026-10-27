this.legend_adventurous_noble_ranged_background <- this.inherit("scripts/skills/backgrounds/adventurous_noble_background", {
	function create () {
		this.adventurous_noble_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendAdventurousNobleRanged);
		this.m.Names = ::Const.Strings.LadyNames;
	}

	function onChangeAttributes () {
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendAdventurousNobleRanged);
	}

	function onAddEquipment() {
		local items = this.getContainer().getActor().getItems();

		items.equip(::Legends.Items.pickItem([
			[1, "weapons/hunting_bow"],
			[1, "weapons/crossbow"],
			[1, "weapons/pike"]
		], "scripts/items/"));

		items.equip(::Legends.Items.pickBasicAmmo(items.getItemAtSlot(::Const.ItemSlot.Mainhand)));

		items.equip(::Legends.Items.pickArmor([
			[1, ::Legends.Armor.Standard.mail_shirt],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.mail_hauberk]
		]));

		items.equip(::Legends.Items.pickHelmet([
			[2, ::Legends.Helmet.Standard.nasal_helmet],
			[2, ::Legends.Helmet.Standard.padded_nasal_helmet],
			[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
			[1, ::Legends.Helmet.Standard.legend_noble_floppy_hat],
			[1, ::Legends.Helmet.Standard.legend_noble_hat],
			[1, ::Legends.Helmet.Standard.legend_noble_hood],
			[1, ::Legends.Helmet.Standard.legend_noble_crown],
			[1, ::Legends.Helmet.Standard.mail_coif],
			[2, ::Legends.Helmet.None]
		]));
	}
});
