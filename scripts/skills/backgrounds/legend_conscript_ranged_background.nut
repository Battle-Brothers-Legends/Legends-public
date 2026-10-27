this.legend_conscript_ranged_background <- this.inherit("scripts/skills/backgrounds/legend_conscript_background", {
	m = {},

	function create() {
		this.legend_conscript_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendConscriptRanged);
		this.m.DailyCostMult = 1.0;
	}

	function onChangeAttributes() {
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendConscriptRanged);
	}

	function onAdded() {
		this.character_background.onAdded();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendThrowSand);
	}

	function onAddEquipment() {
		local items = this.getContainer().getActor().getItems();

		items.addToBag(::Legends.Items.pickItem([
			[1, "weapons/oriental/light_southern_mace"],
			[1, "weapons/oriental/saif"]
		], "scripts/items/"));

		items.equip(::Legends.Items.pickItem([
			[1, "weapons/oriental/handgonne"]
		], "scripts/items/"));

		items.equip(::Legends.Items.pickBasicAmmo(items.getItemAtSlot(::Const.ItemSlot.Mainhand)));

		items.equip(::Legends.Items.pickArmor([
			[1, ::Legends.Armor.Southern.padded_vest]
		]));

		items.equip(::Legends.Items.pickHelmet([
			[1, ::Legends.Helmet.Southern.nomad_head_wrap],
			[1, ::Legends.Helmet.Southern.gunner_hat],
			[1, ::Legends.Helmet.None]
		]));
	}
});
