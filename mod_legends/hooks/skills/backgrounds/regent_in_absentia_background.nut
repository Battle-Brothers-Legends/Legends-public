::mods_hookExactClass("skills/backgrounds/regent_in_absentia_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.RegentInAbsentia);
		this.m.Name = "Regent in Absentia";
		this.m.Icon = "ui/backgrounds/background_06.png";
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
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Noble | this.Const.BackgroundType.Crusader;
		this.m.PerkTreeDynamic = {
			Weapon = [],
			Defense = [],
			Traits = [],
			Enemy = [],
			Class = [],
			Magic = [
				::Const.Perks.CaptainMagicTree
			],
			Profession = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleMuscular}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Thick});

		if (_gender) {
			this.m.Icon = "ui/backgrounds/background_06.png";
		}
	}

	o.onBuildDescription <- function ()
	{
		return "{%name% is no longer disowned by %their% royal family, yet %their% allegiance is now with the %companyname%. Despite not returning home to %their% lineage, you know that deep down %they% is emboldened by the fact that %they% is back in %their% natural bloodline.}";
	}

	o.onChangeAttributes <- function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.RegentInAbsentia);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/arming_sword"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/morning_star"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
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
		]))
	}
});
