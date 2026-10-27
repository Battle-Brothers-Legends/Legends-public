::mods_hookExactClass("skills/backgrounds/regent_in_absentia_background", function(o) {
	o.create = function() {
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.RegentInAbsentia);
		this.m.BackgroundDescription = "%name% is a Regent in Absentia, choosing to spend their time with a mercenary company as opposed to in court.";
		this.m.GoodEnding = "A noble at heart, the disowned noble%person% %name% returned to %them% family. Word has it %they% kicked in the doors and demanded a royal seat. An usurper challenged %them% in combat and, well, %name% learned a lot in %them% days with the %companyname% and %they% now sits on a very, very comfortable throne.";
		this.m.BadEnding = "A %person% of nobility at heart, %name% the disowned noble%person% returned to %them% family home. Word has it an usurper arrested %them% at the gates. %Them% head currently rests on a pike with crows for a crown.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Weasel)
		];
		this.m.IsCombatBackground = true;
		this.m.IsNoble = true;
		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = ::Const.BackgroundType.Combat | ::Const.BackgroundType.Noble | ::Const.BackgroundType.Crusader;
	}

	o.getTooltip = function() {
		return this.character_background.getTooltip();
	}

	o.setGender <- function(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		this.setBodyCharacteristics(_gender, _gender ? {
			Bodies = ::Const.Bodies.FemaleMuscular
		} : {
			Bodies = ::Const.Bodies.Thick
		});

		if (_gender) {
			this.m.Icon = "ui/backgrounds/background_06.png";
		}
	}

	o.onBuildDescription <- function() {
		return "{%name% is no longer disowned by %their% royal family, yet %their% allegiance is now with the %companyname%. Despite not returning home to %their% lineage, you know that deep down %they% is emboldened by the fact that %they% is back in %their% natural bloodline.}";
	}

	o.onChangeAttributes <- function() {
		return ::Legends.Backgrounds.getStats(::Legends.Background.RegentInAbsentia);
	}

	o.onAddEquipment = function() {
		local items = this.getContainer().getActor().getItems();

		items.equip(::Legends.Items.pickItem([
			[1, "weapons/arming_sword"],
			[1, "weapons/hand_axe"],
			[1, "weapons/boar_spear"],
			[1, "weapons/morning_star"],
		], "scripts/items/"));

		items.equip(::Legends.Items.pickItem([
			[1, "shields/wooden_shield"]
		], "scripts/items/"));

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
