::mods_hookExactClass("skills/backgrounds/minstrel_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.minstrel";
		this.m.Name = "Minstrel";
		this.m.Icon = "ui/backgrounds/troubadour.png";
		this.m.BackgroundDescription = "A good minstrel will sing a saga to inspire the men, play the flute to calm them, or entertain them with poetry around the camp fire. A lute is not a weapon, however, and minstrels are often not used to physical labor or bloodshed.";
		this.m.GoodEnding = "Ah, %name%. What an addition to the %companyname%! The minstrel not only became an excellent fighter, but was crucial in keeping the men\'s spirits high in the toughest of times. A poet and actor at heart, he eventually retired from the company and started up a theater company. He current performs plays for both the nobility and laymen. The minstrel does not yet realize it, but his playful wit and sharp commentary are slowly bringing the classes together.";
		this.m.BadEnding = "Never a fighter at heart, %name% the minstrel quickly left the declining %companyname%. He and a group of musicians and jesters spend their evenings performing for drunken noblemen. You managed to see one of these performances for yourself. %name% spent much of the time being berated by the inebriated and having half-eaten chicken bones thrown at him. One of the nobles even thought it\'d be funny to set a dog loose on one of the jesters. You could see the minstrel\'s dreams dying in his eyes, but the show went on.";
		this.m.HiringCost = 665;
		this.m.DailyCost = 19;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted)
		];
		this.m.Titles = [
			"the Minstrel",
			"the Skjald",
			"the Poet",
			"Songbird",
			"the Troubadour",
			"the Chorine",
			"the Lover",
			"the Bard"
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Performing;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.MaceTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.DaggerTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.InspirationalTree
			],
			Enemy = [
				this.Const.Perks.NoblesTree
			],
			Class = [
				this.Const.Perks.BardClassTree,
				this.Const.Perks.JugglerClassTree
			],
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Name = "Troubadour";
		this.m.Icon = "ui/backgrounds/background_42.png";
		this.m.BackgroundDescription = "A good troubadour will give a speech to inspire the company, act out a scene to calm them, or entertain them with dancing around the camp fire. The actors tumbles and moves may be repurposed for the real battle, if their nerve holds steady";
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "Ah, %name%. What an addition to the %companyname%! The minstrel not only became an excellent fighter, but was crucial in keeping the men\'s spirits high in the toughest of times. A poet and actor at heart, she eventually retired from the company and started up a theater company. She currently performs plays for both the nobility and laymen. The minstrel does not yet realize it, but her playful wit and sharp commentary are slowly bringing the classes together.";
		this.m.BadEnding = "Never a fighter at heart, %name% the minstrel quickly left the declining %companyname%. She and a group of musicians and jesters spend their evenings performing for drunken noblemen. You managed to see one of these performances for yourself. %name% spent much of the time being berated by the inebriated and having half-eaten chicken bones thrown at her. One of the nobles even thought it\'d be funny to set a dog loose on one of the jesters. You could see the minstrel\'s dreams dying in her eyes, but the show went on.";
	}

	o.onBuildDescription <- function ()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "\'{I can swing a sword and cleave an axe, | One might ask of me a task, | Right with god, but in the left a flask,} {and I say, \'You question a woman who wears no mask?\'. | and so I have to move quick, but not quite fast.} {Stare down the stuffed bears I did, | Into my frayed pantaloons I bid, | Along the muddy roads my boots skid,} {and so of many things I am rid. | truth! My shameful talent is to - ferociously! - knit.} {So take me along your adventure, | Bring me with your men who clatter and clamber, | Hand me your shield and that thing shaped like a member,} {and let us go and bid fear a farewell to remember! | and let\'s - oh, ow! I have a splinter! | and may we come, one and all, to a healthy next-winter!}\'. {The woman speaks gibberish. | It rhymes!}";
		}
		else
		{
			return "{I can swing a sword and cleave an axe, | One might ask of me a task, | Right with god, but in the left a flask,} {and I say, \'You question a man who wears no mask?\'. | and so I have to move quick, but not quite fast.} {Stare down the stuffed bears I did, | Into my frayed pantaloons I bid, | Along the muddy roads my boots skid,} {and so of many things I am rid. | truth! My shameful talent is to - ferociously! - knit.} {So take me along your adventure, | Bring me with your men who clatter and clamber, | Hand me your shield and that thing shaped like my member,} {and let us go and bid fear a farewell to remember! | and let\'s - oh, ow! I have a splinter! | and may we come, one and all, to a healthy next-winter!}. {The man speaks gibberish. | It rhymes!}";
		}

	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				10,
				15
			],
			Stamina = [
				0,
				6
			],
			MeleeSkill = [
				5,
				5
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				3,
				6
			],
			RangedDefense = [
				0,
				3
			],
			Initiative = [
				5,
				5
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "linen_tunic", this.Math.rand(3,4)]
		]));
		local r;

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "feathered_hat"]
		]));

		local r = this.Math.rand(0, 1);
		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/lute"));
		}
		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_drum"));
		}
	}

});
