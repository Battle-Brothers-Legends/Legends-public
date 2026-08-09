
this.legend_ironmonger_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendIronmonger);
		this.m.Name = "Ironmonger";
		this.m.Icon = "ui/backgrounds/background_ironmonger.png";
		this.m.BackgroundDescription = "Ironmongers are stronger than average and good at maintaining equipment.";
		this.m.GoodEnding = "A more reliable sellsword than most, %name%\'s background as an ironmonger helped %them% to keep the %companyname%\'s equipment functioning. Having saved more than enough crowns, %name% retired and returned to blacksmithing, learning from a true master and becoming a paragon of the craft. Last you heard of %them% %they% was living in luxury, making custom weapons and armor for nobles.";
		this.m.BadEnding = "%name% the ironmonger stayed with the %companyname% for some time after your departure, but after a particularly nasty stretch of bad luck %they% saw the rot for what it was and jumped ship. Bad luck seemed to follow %them%, however, and %they% never managed to settle down. He burned through his leftover crowns in a few years. He died in poverty one winter, freezing overnight.";
		this.m.HiringCost = 100;
		this.m.DailyCost = 11;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Fragile)

		];
		this.m.Titles = [
			"the Ironmonger",
			"the Metalsmith",
			"the Farrier",
			"the Scavenger",
			"the Iron-shaper",
			"the Scrounger"
		];
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Crusader;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree,
				::Const.Perks.SwordTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.AxeTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.IndestructibleTree,
				::Const.Perks.FastTree,
				::Const.Perks.LargeTree,
				::Const.Perks.FitTree
			],
			Enemy = [],
			Class = [],
			Profession = [
				::Const.Perks.RepairProfessionTree
			],
			Magic = []
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender) : this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.YoungMale, HairColors = ::Const.HairColors.Young});
	}

	function onBuildDescription() {
		return "{When one needs tools repaired but cannot afford a blacksmith, they seek out their local ironmonger. | A self taught smith working from scrap metal, the ironmonger works mostly with farm tools and horseshoes.} {No ironmonger can compare to the skills of a full fledged blacksmith, but it can be a lucrative profession in smaller villages. | Though lacking the skills of a fully trained blacksmith, ironmongers are vital for some settlements, too small or remote to merit a resident blacksmith.} {%name% was an ironmonger in %townname%. | %name% served for many years as an ironmonger in %townname%. | %name% was an ironmonger, like %their% father. | Urged by %their% parents to join the craft, %name% was an ironmonger for many years. | Not to be outdone by %their% overachieving militia sister, %name% learned to smith and served as the local ironmonger.} {Unfortunately, a trained blacksmith arrived in town, and %name%\'s skills were quickly rendered obsolete. Facing poverty, %they% left home to join a company of sellswords. | %name%\'s clients eventually dried up, and %they% was forced to leave home and seek new work. | %name% eventually left home due to a tragedy that %they% refused to speak of. Face grim, %they% seeks new employment.}";
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendIronmonger);
	}


	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.apron],
			[1, ::Legends.Armor.Standard.linen_tunic],
			[1, ::Legends.Armor.Standard.leather_tunic]
			//, [1, ::Legends.Armor.Standard.legend_blacksmith_apron]
		]));
	}

});
