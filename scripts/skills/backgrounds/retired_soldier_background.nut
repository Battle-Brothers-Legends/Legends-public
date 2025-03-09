this.retired_soldier_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.retired_soldier";
		this.m.Name = "Retired Soldier";
		this.m.Icon = "ui/backgrounds/background_24.png";
		this.m.BackgroundDescription = "Retired soldiers tend to have decent experience in warfare, and their resolve is not easily broken. However, their age may have taken a toll on their physical attributes.";
		this.m.GoodEnding = "%name% retired again, this time from sellswording instead of soldiering. Leaving the %companyname% behind, he built a cabin out in the woods and enjoys the peace and quiet, staying as far away from all the fighting as he can get.";
		this.m.BadEnding = "Tired of all the fighting, %name% left the quickly declining %companyname% and went out and built himself a cabin in the woods. Unfortunately, vagabonds attacked. Word has it he was found bleeding out on the floor, surrounded by six dead men and the last man standing, a nervous, broken boy shakily waving a sword at the dying old man.";
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
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
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
				this.Const.Perks.SwordTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				this.Const.Perks.BanditTree,
				this.Const.Perks.BarbarianTree
			],
			Class = [
				this.Const.Perks.LongswordClassTree
			],
			Magic = [
				// this.Const.Perks.CaptainMagicTree
			]
		}
	}



	function onBuildDescription()
	{
		return "Once {a sergeant | a royal guardsman | a dedicated soldier | a respected armsman | a frontliner | a soldier | a footman} in the army of a local lord, %fullname% {retired from service after taking an arrow to the knee | was replaced by an aspiring youngster | was expelled after falling asleep on guard duty | retired after a long and exemplary service | was wounded in combat and forced to retire | grew weary of the battles and bloodbaths, formally ending his service before it ruined his mind | battled the ferocious orc hordes, the campaigns eventually forcing him into retirement}. {He locked his equipment in a chest along with the memories of his duty, intending to never pick up either one again | He shelved both sword and shield in his study as merely relics of a military past | He hung his weapons above the chimney as a silent reminder of the man he used to be | But a new chapter in his life was awaiting him, one where he would not need a sword to get on with his day | With many years of service behind him, he could finally get some peace and quiet | Absent of a military drill\'s barking, his life never felt so quiet}. {For many years he lived a happy life with his beloved wife, until she died of old age. With nothing else to turn to | Only when finding out that his former comrades were brutally slain in an ambush | Only when hearing rumors of a large invasion about to destroy his homeland, | He tried to live as a farmer for a while, but every day he missed having a good sword in hand and standing in the shieldwall. Finally, | But life outside the army, as it turned out, was not for him, for he felt idle and useless. Finally, | For a time, he felt at ease. But as the land was consumed by warfare, | Time spent away from war was short-lived, as the war soon came to him. It wasn\'t long until | Living out on a farm, boredom crept at %name%\'s wits until, finally,} he picked up arms once more. Although {his best days are long over | not as physically fit as he once was | his constitution is not that of a young man anymore | he is not the brash young fighter he once was | time away from the service has dampened his abilities}, {his swordfighting skills are still enough to beat any young braggart | he still knows how fighting is done on the battlefield | his experience is second to few | he can rely on the combat experience of a lifetime | he is eager to stand amongst brothers | he is eager to find battle again | his itch to find battle is mirrored by his capabilities to actually fight | he still knows a thing or two about holding a shieldwall}.";
	}

	function onChangeAttributes()
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

	function onAddEquipment()
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
			[1, "patched_mail_shirt"],
			[1, "padded_leather"],
			[1, "basic_mail_shirt"],
			[1, "worn_mail_shirt"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ""],
			[1, "nasal_helmet"],
			[1, "padded_nasal_helmet"],
			[1, "mail_coif"],
			[1, "rusty_mail_coif"],
			[1, "aketon_cap"],
			[1, "full_aketon_cap"]
		]));

	}

});

