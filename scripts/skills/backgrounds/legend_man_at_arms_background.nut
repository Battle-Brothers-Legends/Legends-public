this.legend_man_at_arms_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_man_at_arms";
		this.m.Name = "Man-At-Arms";
		this.m.Icon = "ui/backgrounds/background_man_at_arms.png";
		this.m.BackgroundDescription = "An old soldier, maimed by some forgettable past conflict, waits for another war that may never come.";
		this.m.GoodEnding = "A former militia recruit such as %name% eventually left the %companyname%. Traveling the lands, visiting villages and helping them establish credible militias with which to defend themselves. Finding success in an increasingly dangerous world, %name% eventually came to be a known name, called upon as a sort of \'fixer\' to come and ensure these villages would remain safe. Last you heard, %name% had purchased a plot of land and was raising a family far from the strife of the world.";
		this.m.BadEnding = "%name% left the collapsing company and returned to the village. Back in the militia, it wasn\'t long until {greenskins | raiders} attacked and the militia was called to action. It\'s said that %name% stood tall, rallying the defense while slaying through countless enemies before succumbing to mortal wounds. When you visited the village, you found children playfighting beneath a statue made in the %name%\'s image.";
		this.m.HiringCost = 130;
		this.m.DailyCost = 15;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Fat)

		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.PolearmTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				this.Const.Perks.BanditTree,
				this.Const.Perks.DirewolfTree
			],
			Class = [
				this.Const.Perks.MilitiaClassTree
			],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.OldFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleSkinny;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.Name = "Woman-At-Arms";

	}

	function onBuildDescription()
	{
		//gender neutral
		return "{Years ago, %name% decided to join the local militia. The pay was good and the job was easy. At first. | %name% had no talents in their youth, but quickly found their calling when defending their home from bandits. | When the living dead swarmed into town one cold night years ago, %name% was one of the few who took up arms to protect their home - which bought precious time for others to flee. | %name% was never destined for greatness - they quickly found themselves content in protecting an otherwise sleepy village outside of %randomtown% with a handful of others. | Bored of farming, %name% used their talents of stabbing and hammering to protect the village they grew up in.} {%name% is largely self taught, practising their combat skills on the occasional lost undead or meek bandit raid. Although their current injuries suggest that at one time they still had a lot to learn. | %name% has fought alongside farmers, mercenaries and even nobles. However their inability to gain fame led them to age past their prime - and pick up an injury along the way. | The injury %name% carries is quite evident, however they assure you that they can fight just as well as any mercenary could. Only time will tell how much of a lie this might be. | %name%\'s injury was unrelated to their duties protecting their home. Instead they recite the tale of 'The cat, the witchling and the cupboard'. Which you find works well as a way to fall asleep on your feet.} {With the writing on the wall that %name% may have a long and painful death ahead of them, they decided to do what they always dreamed of - fighting in a real battle. | Years have not been kind to %name%, however their longer than usual time spent training has gifted them with a much broader skillset than your average militia. | %name% has outlived enemies and allies alike, and now finds themselves completely alone in a world full of strangers. | %name%\'s experience and determination in the face of danger is a skill that is rare, even among more hardened professions.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				8,
				15
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				7,
				11
			],
			RangedSkill = [
				7,
				7
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				2,
				4
			],
			Initiative = [
				-10,
				-5
			]
		};
		return c;
	}

	function onAddEquipment() // NO TWO HANDED WEAPONS OR OFFHANDS HERE - 'missing hand' will unequip the item and cause errors if you add them.
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		local weapons = [
			"weapons/arming_sword",
			"weapons/bludgeon",
			"weapons/boar_spear",
			"weapons/hand_axe",
			"weapons/military_pick",
			"weapons/hand_axe",
			"weapons/legend_glaive",
			"weapons/javelin",
			"weapons/scramasax"
		];

		items.equip(this.Const.World.Common.pickArmor([ //1 = least likely
			[1, "worn_mail_shirt"],
			[2, "patched_mail_shirt"],
			[3, "leather_lamellar"],
			[3, "basic_mail_shirt"],
			[4, "gambeson"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[4, ""],
			[3, "aketon_cap"],
			[1, "deep_sallet"],
			[2, "full_aketon_cap"],
			[2, "open_leather_cap"],
			[3, "full_leather_cap"]
		]));
		local rng = this.Math.rand(0, this.Const.Injury.Permanent.len()-1);
		this.m.Container.add(this.new("scripts/skills/" + this.Const.Injury.Permanent[rng].Script)) //adds random injury
	}
});

