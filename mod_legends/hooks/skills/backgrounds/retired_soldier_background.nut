::mods_hookExactClass("skills/backgrounds/retired_soldier_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.retired_soldier";
		this.m.Name = "Retired Soldier";
		this.m.Icon = "ui/backgrounds/background_24.png";
		this.m.BackgroundDescription = "Retired soldiers tend to have decent experience in warfare, and their resolve is not easily broken. However, their age may have taken a toll on their physical attributes.";
		this.m.GoodEnding = "%name% retired again, this time from sellswording instead of soldiering. Leaving the %companyname% behind, %they% built a cabin out in the woods and enjoys the peace and quiet, staying as far away from all the fighting as %they% can get.";
		this.m.BadEnding = "Tired of all the fighting, %name% left the quickly declining %companyname% and went out and built %themselves% a cabin in the woods. Unfortunately, vagabonds attacked. Word has it %they% was found bleeding out on the floor, surrounded by six dead men and the last man standing, a nervous, broken boy shakily waving a sword at the dying old %person%.";
		this.m.HiringCost = 140;
		this.m.DailyCost = 15;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack)
		];
		this.m.Titles = [
			"the Oldguard",
			"the Old",
			"the Sergeant",
			"the Veteran",
			"the Soldier"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 3);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Crusader;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];
		this.m.PerkTreeDynamicMins.Defense = 3;
		this.m.PerkTreeDynamicMins.Enemy = 2;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.AxeTree,
				::Const.Perks.ShieldTree,
				::Const.Perks.ThrowingTree,
			],
			Defense = [
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.OrganisedTree,
				::Const.Perks.InspirationalTree,
				::Const.Perks.FitTree
			],
			Enemy = [
				::Const.Perks.OutlawTree
			],
			Class = [],
			Profession = [
				::Const.Perks.FencingTeacherProfessionTree
			],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Faces = this.Const.Faces.OldFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleMuscular;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.onBuildDescription <- function ()
	{
		return "Once {a sergeant | a royal guards%person% | a dedicated soldier | a respected arms%person% | a frontliner | a soldier | a foot%person%} in the army of a local lord, %fullname% {retired from service after taking an arrow to the knee | was replaced by an aspiring youngster | was expelled after falling asleep on guard duty | retired after a long and exemplary service | was wounded in combat and forced to retire | grew weary of the battles and bloodbaths, formally ending %their% service before it ruined %their% mind | battled the ferocious orc hordes, the campaigns eventually forcing %them% into retirement}. {He locked %their% equipment in a chest along with the memories of %their% duty, intending to never pick up either one again | %They% shelved both sword and shield in %their% study as merely relics of a military past | %They% hung %their% weapons above the chimney as a silent reminder of the %person% %they% used to be | But a new chapter in %their% life was awaiting %them%, one where %they% would not need a sword to get on with %their% day | With many years of service behind %them%, %they% could finally get some peace and quiet | Absent of a military drill\'s barking, %their% life never felt so quiet}. {For many years %they% lived a happy life with %their% beloved wife, until she died of old age. With nothing else to turn to | Only when finding out that %their% former comrades were brutally slain in an ambush | Only when hearing rumors of a large invasion about to destroy %their% homeland, | %They% tried to live as a farmer for a while, but every day %they% missed having a good sword in hand and standing in the shieldwall. Finally, | But life outside the army, as it turned out, was not for %them%, for %they% felt idle and useless. Finally, | For a time, %they% felt at ease. But as the land was consumed by warfare, | Time spent away from war was short-lived, as the war soon came to %them%. It wasn\'t long until | Living out on a farm, boredom crept at %name%\'s wits until, finally,} %they% picked up arms once more. Although {%their% best days are long over | not as physically fit as %they% once was | %their% constitution is not that of a young %person% anymore | %they% is not the brash young fighter %they% once was | time away from the service has dampened %their% abilities}, {%their% swordfighting skills are still enough to beat any young braggart | %they% still knows how fighting is done on the battlefield | %their% experience is second to few | %they% can rely on the combat experience of a lifetime | %they% is eager to stand amongst brothers | %they% is eager to find battle again | %their% itch to find battle is mirrored by %their% capabilities to actually fight | %they% still knows a thing or two about holding a shieldwall}.";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-15,
				-10
			],
			Bravery = [
				13,
				10
			],
			Stamina = [
				-10,
				-10
			],
			MeleeSkill = [
				13,
				10
			],
			RangedSkill = [
				5,
				0
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				5,
				8
			],
			Initiative = [
				-5,
				-10
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
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
			items.equip(this.new("scripts/items/weapons/falchion"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.patched_mail_shirt],
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.worn_mail_shirt]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Standard.nasal_helmet],
			[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
			[1, ::Legends.Helmet.Standard.mail_coif],
			[1, ::Legends.Helmet.Standard.rusty_mail_coif],
			[1, ::Legends.Helmet.Standard.aketon_cap],
			[1, ::Legends.Helmet.Standard.full_aketon_cap]
		]));
	}

});
