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

	function setGender(_gender = -1) {
		this.adventurous_noble_background.setGender(_gender);
	}

	function onAddEquipment() {
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);
		if (r == 0) {
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 1) {
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else if (r == 2) {
			items.equip(this.new("scripts/items/weapons/arming_sword"));
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.gambeson],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.mail_shirt],
			[1, ::Legends.Armor.Standard.mail_hauberk]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
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