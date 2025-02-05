this.peddler_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.peddler";
		this.m.Name = "Peddler";
		this.m.Icon = "ui/backgrounds/background_19.png";
		//gender neutral description
		this.m.BackgroundDescription = "Peddlers are not used to hard physical labor or warfare, but they do excel at haggling for good prices.";
		this.m.GoodEnding = "A lover of the sale, %name% the peddler couldn\'t stay fighting for long. He eventually left the %companyname% to go out and start his own business. Recently,you got word that he was selling trinkets with the company\'s sigil on them. You specifically told him to do whatever they wanted except just this one thing, but apparently your warning merely fostered the idea. When you went to tell him to stop, he slammed a crown-bulging satchel on a rather ornate table, saying it was your \'cut.\' He sells those trinkets to this day.";
		this.m.BadEnding = "With hard times hitting the %companyname%, many brothers saw fit to return to their old lives. %name% the peddler was no different. Last you heard he got the tar beaten out of him trying to sell stolen wares that \'fell off the wagon\' to the very merchant which they originally belonged.";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.huge",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.iron_jaw",
			"trait.clubfooted",
			"trait.brute",
			"trait.athletic",
			"trait.iron_lungs",
			"trait.strong",
			"trait.tough",
			"trait.cocky",
			"trait.dexterous",
			"trait.dumb",
			"trait.deathwish",
			"trait.bloodthirsty",
			"trait.legend_aggressive",
			"trait.legend_ambitious",
			"trait.legend_firm"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.Bodies = this.Const.Bodies.Thick;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Kind;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[3];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.StaffTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.MaceTree

			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [this.Const.Perks.BanditTree],
			Class = [this.Const.Perks.BarterClassTree],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.GoodEnding = "A lover of the sale, %name% the peddler couldn\'t stay fighting for long. She eventually left the %companyname% to go out and start her own business. Recently, you got word that she was selling trinkets with the company\'s sigil on them. You specifically told her to do whatever they wanted except just this one thing, but apparently your warning merely fostered the idea. When you went to tell her to stop, she slammed a crown-bulging satchel on a rather ornate table, saying it was your \'cut.\' She sells those trinkets to this day.";
		this.m.BadEnding = "With hard times hitting the %companyname%, many brothers saw fit to return to their old lives. %name% the peddler was no different. Last you heard she got the tar beaten out of her trying to sell stolen wares that \'fell off the wagon\' to the very merchant which they originally belonged.";

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleThick;
		this.addBackgroundType(this.Const.BackgroundType.Female);

	}



	function onBuildDescription()
	{
		//gender neutral
		return "{House to house, | Once a proud merchant, now | An annoyance to most, | In tough times, everyone has to scrape by somehow, hence why | Not of the trades, but instead of trade itself,} %name% is a mere peddler. {Dancing, singing, boasting or acting a king, anything to make that sale. | Pushy and unrelenting, their tenacity is admirable. | %name% will try to sell off a rusty bucket for a helm once worn by kings. This trader will sell anything. | %name% will make you crave things you never knew you wanted. No refunds, though. | %name% used to make a decent living selling {used carts | pots, pans and jars }, until fierce competition ended the business - with a broken arm.} {Self marketing is what this frail merchant does best, though few believe the pitch about having \'Great swordsmanship and resolute bravery\'. | Supposedly handed out \'coupons\' for \'services\', whatever those are. %name% is chippy, though, and any outfit these days could use a warm body no matter its real value. | If hired, %name% promises, you\'ll get a special discount on a virility enhancing potion. | %name% lowers their voice and tells you they\'ve got a great deal on rusted arrow tips, just for you. The merchant looks disappointed at your lack of interest. | This merchant knows a man who knows a man who knows a man. All three strangers potentially better at fighting than %name%. | A shame a war can\'t be fought with words these days. %name% would be unstoppable.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				-10,
				-9
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				2,
				7
			],
			RangedDefense = [
				2,
				7
			],
			Initiative = [
				0,
				7
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		local actor = this.getContainer().getActor();

		if (this.Math.rand(0, 3) == 3)
		{
			actor.setTitle(this.Const.Strings.PeddlerTitles[this.Math.rand(0, this.Const.Strings.PeddlerTitles.len() - 1)]);
		}

	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "linen_tunic"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ""],
			[1, "feathered_hat"]
		]));

	}
});

