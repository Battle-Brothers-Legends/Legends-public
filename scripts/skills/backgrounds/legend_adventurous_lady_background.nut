this.legend_adventurous_lady_background <- this.inherit("scripts/skills/backgrounds/adventurous_noble_background", {
	function create () {
		this.adventurous_noble_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendAdventurousLady);
		this.m.BackgroundType = this.m.BackgroundType | this.Const.BackgroundType.Female;
		this.m.Icon = "ui/backgrounds/background_adventurous_noble_woman.png";
		this.m.BackgroundDescription = "Adventurous Ladies tend to have high resolve and ranged skills, but often neglect melee defense.";
		this.m.Names = this.Const.Strings.LadyNames;
		this.setBodyCharacteristics(1, {Bodies = ::Const.Bodies.FemaleMuscular, Faces = ::Const.Faces.PrettyFemale, HairColors = ::Const.HairColors.Young})
	}

	function onChangeAttributes () {
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendAdventurousLady);
	}

	function onAddEquipment() {
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);
		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/pike"));
		}


		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.mail_shirt],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.mail_hauberk]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
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