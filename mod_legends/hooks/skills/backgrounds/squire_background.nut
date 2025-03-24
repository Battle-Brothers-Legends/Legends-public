::mods_hookExactClass("skills/backgrounds/squire_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.squire";
		this.m.Name = "Squire";
		this.m.Icon = "ui/backgrounds/background_03.png";
		this.m.BackgroundDescription = "Squires usually have received some training in warfare, and often have a high resolve to excel in what they do.";
		this.m.GoodEnding = "%name% the squire eventually left the %companyname%. You\'ve heard that he\'s since been knighted. No doubt he is sitting happy as a plum wherever he is.";
		this.m.BadEnding = "The squire, %name%, eventually departed the %companyname%. He intended to return home and become knighted, fulfilling his lifelong dream. Cruel politics got in the way and not only was he not knighted, he was stripped of his squire duties. Word has it he hanged himself from a barn\'s rafters.";
		this.m.HiringCost = 320;
		this.m.DailyCost = 26;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack)
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.YoungMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Tidy;


		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Educated;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMax; //Neutral-good essentially
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree,
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.FastTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		}
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.PrettyFemale;
		this.m.Beards = null;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleMuscular;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "%name% the squire eventually left the %companyname%. You\'ve heard that she\'s since been knighted. No doubt she is sitting happy as a plum wherever she is.";
		this.m.BadEnding = "The squire, %name%, eventually departed the %companyname%. She intended to return home and become knighted, fulfilling her lifelong dream. Cruel politics got in the way and not only was she not knighted, she was stripped of her squire duties. Word has it she hanged herself from a barn\'s rafters.";

	}

	o.onBuildDescription <- function ()
	{
		if(this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{A young squire, %name% dutifully accompanied her knight to many battles. | Squire to a harsh knight, %name% spent her days running errands for her lordship. | Although a squire, %name%\'s life largely meant guarding prisoners of war, much to her chagrin. | Squire to a knight, sure, but %name% mostly cleaned latrines, fed dogs, and got far too much use out of a shinebox.} {One night, strange, shuffling men silhouetted the moonlit horizon. Alarm bells met their moans and an hour later half of %townname% lay in ruin. | While traveling, brigands attacked her lordship\'s wagon-train. Swords were drawn, heads were halved, and when it was all said and done the squire had failed: everyone she was supposed to protect lay dead. | But one evening a horde of ferocious, furred creatures came down upon her lord\'s keep. In desperation, %name% let a group of prisoners free, hoping they would aid her in combat. Instead, they slew her lordship and ran off into the night. The squire, bravely, managed to survive, a dozen husky corpses at her feet, but the battle left her alone and without purpose. | Angered by a horrible crime in %townname%, she took matters into her own hands, personally slaying the criminal. A just act, but also an improper one. The young squire was banished for her insubordination. | When a devilish red knight came to %townname% for a duel, %name%\'s knight proved far too sick to fight. After downing a mug of liquid confidence, %name% donned her lordship\'s armor and faced the red knight herself. With a sword slash so fast it rang the very air, %name% slew her opponent down.} {Now there was only one task left for her - to attain knighthood. | Now the squire seeks the company of good folk with which to again prove herself worthy of being a knight. | As war ravages the land, there is now plenty of opportunity to put her skills to use. | Though a bit too earnest, there is no doubt the world needs women like %name%.}";
		}
		else
		{
			return "{A young squire, %name% dutifully accompanied his knight to many battles. | Squire to a harsh knight, %name% spent his days running errands for his lordship. | Although a squire, %name%\'s life largely meant guarding prisoners of war, much to his chagrin. | Squire to a knight, sure, but %name% mostly cleaned latrines, fed dogs, and got far too much use out of a shinebox.} {One night, strange, shuffling men silhouetted the moonlit horizon. Alarm bells met their moans and an hour later half of %townname% lay in ruin. | While traveling, brigands attacked his lordship\'s wagon-train. Swords were drawn, heads were halved, and when it was all said and done the squire had failed: everyone he was supposed to protect lay dead. | But one evening a horde of ferocious, furred creatures came down upon his lord\'s keep. In desperation, %name% let a group of prisoners free, hoping they would aid him in combat. Instead, they slew his lordship and ran off into the night. The squire, bravely, managed to survive, a dozen husky corpses at his feet, but the battle left him alone and without purpose. | Angered by a horrible crime in %townname%, he took matters into his own hands, personally slaying the criminal. A just act, but also an improper one. The young squire was banished for his insubordination. | When a devilish red knight came to %townname% for a duel, %name%\'s knight proved far too sick to fight. After downing a mug of liquid confidence, %name% donned his lordship\'s armor and faced the red knight himself. With a sword slash so fast it rang the very air, %name% slew his opponent down.} {Now there was only one task left for him - to attain knighthood. | Now the squire seeks the company of good folk with which to again prove himself worthy of being a knight. | As war ravages the land, there is now plenty of opportunity to put his skills to use. | Though a bit too earnest, there is no doubt the world needs men like %name%.}";
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				2,
				5
			],
			Bravery = [
				3,
				7
			],
			Stamina = [
				5,
				7
			],
			MeleeSkill = [
				5,
				7
			],
			RangedSkill = [
				0,
				3
			],
			MeleeDefense = [
				2,
				4
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				1,
				4
			]
		};
		return c;
	}

	o.onUpdate <- function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.10;
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
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_leather"],
			[1, "leather_tunic"],
			[1, "padded_surcoat"],
			[1, "gambeson"]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "nasal_helmet"],
			[1, "full_aketon_cap"],
			[1, "aketon_cap"],
			[1, "open_leather_cap"]
		]))
	}

});

