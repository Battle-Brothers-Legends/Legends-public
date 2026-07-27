this.legend_lonewolf_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendLonewolf);
		this.m.Name = "Lone Wolf";
		this.m.Icon = "ui/backgrounds/background_lone_wolf.png";
		this.m.BackgroundDescription = "You\'ve come this far. Is it worth it? What are a few more heads on the pile in the pursuit of satisfaction?";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0; //Avatar
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendLight)
		];
		this.m.Titles = [ //More
			"the Lone Wolf",
			"the Wolf",
			"the Hyena",
			"the Hound",
			"Steelwielder",
			"the Slayer",
			"the Jouster",
			"the Giant",
			"the Mountain",
			"Butcher of %townname%",
			"the Defiler",
			"the Knightslayer",
			"the Hedge Knight"
		];

		this.m.Ethnicity = this.Math.rand(0, 2);
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.MaceTree,
				::Const.Perks.FlailTree,
				::Const.Perks.HammerTree,
				::Const.Perks.AxeTree,
				::Const.Perks.HammerTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.FistsTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.LargeTree,
				::Const.Perks.IndestructibleTree,
				::Const.Perks.MartyrTree,
				::Const.Perks.FitTree
			],
			Enemy = [
				::Const.Perks.SwordmastersTree
			],
			Class = [],
			Profession = [],
			Magic = [
				::Const.Perks.ImmortalMagicTree
			]
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.setCommanderGender();
		if (this.m.Ethnicity == 0) {
			_gender ? this.setBodyCharacteristics(_gender) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.CommonMale}, 60);
			if(_gender) {
				this.m.Names = ::Const.Strings.CharacterNamesFemale;
			}
		}
		else if (this.m.Ethnicity == 1) {
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemaleMuscular, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Gladiator, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.Southern, Beards = ::Const.Beards.Southern}, 60);
			this.m.Names = ::Const.Strings.SouthernNames;
			this.m.LastNames = ::Const.Strings.SouthernNamesLast;
		}
		else if (this.m.Ethnicity == 2) {	
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanFemaleMuscular, Faces = ::Const.Faces.AfricanFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.African}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanGladiator, Faces = ::Const.Faces.AfricanMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.African, Beards = ::Const.Beards.Southern}, 60);
			this.m.Names = ::Const.Strings.SouthernNames;
			this.m.LastNames = ::Const.Strings.SouthernNamesLast;
		}
	}

	function onBuildDescription()
	{
		return "{You\'ve come so far that you forgot where you came from and how it all started. Distant memories of gold grew into fame. But what point is fame and gold to those who are mortal? If you want to create a legacy you\'ll need to prove yourself first - but years spent alone training for battles that never came will make it hard for anyone to notice you outside of a tournament.}";
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendLonewolf);
	}


	function onAddEquipment() //chooses a weapon through starting event
	{
		// local items = this.getContainer().getActor().getItems();
		// local helm = this.getContainer().getActor().getItems();
		// // local r;

		// // r = this.Math.rand(0, 5);

		// // if (r == 0)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/legend_zweihander"));
		// // }
		// // else if (r == 1)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/longsword"));
		// // }
		// // else if (r == 2)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
		// // }
		// // else if (r == 3)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/pike"));
		// // }
		// // else if (r == 4)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/warbrand"));
		// // }
		// // else if (r == 5)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/goedendag"));
		// // }

		// items.equip(this.Const.World.Common.pickArmor([
		// 	// [1, ::Legends.Armor.Standard.mail_hauberk],
		// 	// [1, ::Legends.Armor.Standard.basic_mail_shirt],
		// 	// [1, ::Legends.Armor.Standard.scale_armor],
		// 	// [1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
		// 	[1, ""]
		// ]));

		// local helm = [
		// 	// [1, ::Legends.Helmet.Standard.nasal_helmet],
		// 	// [1, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
		// 	// [1, ::Legends.Helmet.Standard.mail_coif],
		// 	// [1, ::Legends.Helmet.Standard.bascinet_with_mail],
		// 	[1, ""]
		// ];

		// // if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
		// // {
		// // 	helm.push([1, ::Legends.Helmet.Standard.theamson_barbute_helmet])
		// // }

		// // items.equip(this.Const.World.Common.pickHelmet(helm));
	}
});
