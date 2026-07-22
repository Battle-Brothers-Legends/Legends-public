::mods_hookExactClass("skills/backgrounds/refugee_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.Refugee);
		this.m.Name = "Refugee";
		this.m.Icon = "ui/backgrounds/background_38.png";
		this.m.BackgroundDescription = "Refugees lack the conviction to fight for their homes, but they are used to long and exhausting travel by now.";
		this.m.GoodEnding = "%name% the refugee showed %themselves% to be a natural fighter, but %they% eventually retired from the %companyname%. Word has it %they% returned to %their% home and is currently using all %their% crowns to help rebuild it.";
		this.m.BadEnding = "With the downfall of the %companyname% written plainly on the wall, %name% the refugee split with the company. %They% used what scant crowns %they% had left to purchase a set of shoes and returned to %their% destroyed home to try and rebuild it. While walking home, an illiterate wildman murdered %them% and ate the shoes.";
		this.m.HiringCost = 40;
		this.m.DailyCost = 4;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented)
		];
		this.m.Titles = [
			"the Refugee",
			"the Survivor",
			"Runsfar",
			"the Derelict",
			"the Surbated"
		];
		this.m.Ethnicity = ::Math.rand(0, 2);
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.PerkTreeDynamicMins.ClassChance += 0.20;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.PolearmTree,
				::Const.Perks.SlingTree,
				::Const.Perks.ThrowingTree
			],
			Defense = [
				::Const.Perks.ClothArmorTree
			],
			Traits = [
				::Const.Perks.MartyrTree,
				::Const.Perks.SturdyTree,
				::Const.Perks.FastTree,
				::Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
			
		if (this.m.Ethnicity == 0) {
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
		}
		else if (this.m.Ethnicity == 1) {
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemaleSkinny, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.Southern}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernMale, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.Southern, Beards = ::Const.Beards.Untidy});
			this.m.Names = ::Const.Strings.SouthernNames;
			this.m.LastNames = ::Const.Strings.SouthernNamesLast;
		}
		else if (this.m.Ethnicity == 2) {	
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanFemaleSkinny, Faces = ::Const.Faces.AfricanFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.African}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanMale, Faces = ::Const.Faces.AfricanMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.African, Beards = ::Const.Beards.Untidy});
			this.m.Names = ::Const.Strings.SouthernNames;
			this.m.LastNames = ::Const.Strings.SouthernNamesLast;
		}
	}

	o.onBuildDescription <- function ()	{
		return "{Catastrophes are cheap. | Disease, the ultimate invisible hand. | Win or lose a war, everything is as it has been.} %name% hails from a tiny village that {is now only remembered by spoken word, a generation away from being forgotten. | was destroyed, to put it succinctly. | now stands as a mere footnote, wasting little of the historian\'s ink. | suffered the world\'s wrath.} But %name% is a survivor. {%They% fled the disaster with just the clothes on %their% back. | %Their% home ablaze, %they% saved what %they% could and fled. | After stumbling upon %their% dead family, %they% gathered what %they% could and ran. | War, famine, disease. It\'s all a blur to %them% now.} {%name% is merely a %person% anxious to look ahead rather than behind. | %name% carries little more than a sense of steeled determination, but that is something worth having. | A horrific history scars %their% body and glazes %their% eyes, but the %person% is easily motivated to never experience that past again. | Whatever befell the %person%\'s town didn\'t get %them% and, judging by the rumors you hear, that\'s saying something. | The %person% isn\'t skilled in martial arts, but %they% is for damn sure determined to survive. | Whatever vocation %they% had in the past is now lost. Like many others, %they% seeks mercenary work to get by in this increasingly bloody world. | One of many refugees you\'ve seen, this %person% has decided to stop running and start fighting.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				0,
				5
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				10,
				10
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				2
			],
			RangedDefense = [
				0,
				1
			],
			Initiative = [
				10,
				18
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.legend_rabble_tunic]
		]))
	}
});

