this.brawler_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.brawler";
		this.m.Name = "Brawler";
		this.m.Icon = "ui/backgrounds/background_27.png";
		this.m.BackgroundDescription = "Brawlers are unmatched in unarmed combat, and physical exercise tends to leave them in good shape.";
		this.m.GoodEnding = "A brawler like %name% is dangerous with just his fists, and proved himself similarly savage with weapons. Before you left the %companyname%, you talked to the fighter about whether or not he\'d stay in the band. He said he had no desire to return to prizefighting, shook your hand, and thanked you for giving him the opportunity. Last you heard, the company chose him for a one-on-one, winner take all fight to settle compensation differences with a competing mercenary band. He won in the first round.";
		this.m.BadEnding = "%name% the brawler left the company when it became clear it would soon dissolve and probably end up killing everyone who stayed onboard. He returned to prizefighting, grinding out the following years in brutal, weekly bouts. As he got older, his chin disappeared, as did his speed and power. He was left jobbing, intentionally taking falls and losing badly when he didn\'t. Eventually, no one would give him a fight. A nobleman offered him a large sum to wrestle a bear and the desperate %name% took him up on it. When the \'fight\' was over, the brawler lay dead, mangled beyond recognition, being dragged around the mud by a ferocious beast as drunken highborn cheered and clapped.";
		this.m.HiringCost = 84;
		this.m.DailyCost = 13;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.ailing",
			"trait.clubfooted",
			"trait.irrational",
			"trait.asthmatic",
			"trait.clumsy",
			"trait.fat",
			"trait.craven",
			"trait.insecure",
			"trait.dastard",
			"trait.fainthearted",
			"trait.bright",
			"trait.bleeder",
			"trait.fragile",
			"trait.tiny"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Level = this.Math.rand(1, 2);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Kind;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Lowborn;
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.LargeTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.FistsClassTree
			],
			Magic = []
		}
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip()
		ret.push(
			{
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] Damage when unarmed"
			}
		)
		return ret
	}

	function onBuildDescription()
	{
		return "{Burly and with churchbells for fists, %name% has spent much of the past year sharpening his boxing skills on the grindstone that is his fellow man. | With a face contorted to the shapes of others\' knuckles, it\'s not hard to realize that %name% is a career fighter. | %name% loves the drink as much as he does a good fight, a potent combination. | A hard upbringing by his father and brothers honed %name% into being a temperamental fighter. | Bullies in %name%\'s spriteful youth forged him into a man that prefers to seek out a fight rather than wait for it to come to him.  | %name% only ever had one real talent: using his fists to bloody the noses of other men and not going down no matter what. | Growing up, %name% wrestled bulls on the family farm. Unfortunately for men, he found time to venture into the cities.} {For the past year he has been employed by a local lord, paraded around to fistfight the champions of royalty. | A lover of the bar brawl, the man has apparently been banned from too many taverns to count. | Gaining notoriety as a fighter in %randomtown% meant he had to fight every single proud, boasting, and drunk man who came his way. | Although he became an undefeated prizefighter, he was hardly earning enough to get by. | Fiery in spirit, he\'s always willing to take up fisticuffs. Local fighting rings say he\'s got a mean left hook.} {Hearing of greater fights to be had, %name% has put down his mitts to take up the more lucrative vocation of being a sellsword. | Only one person has bested %name%: his wife. After she chided him for being an embarrassment with no ambition, he decided to take up the more \'prestigious\' field of mercenary work. | Years of martial combat practically destroyed his memory. Some think he mistook a mercenary camp as an item on his shopping list. | Very low on crowns and barely able to open his broken hands to hug his own son much less throw a punch, %name% seeks a new career. | After years of hardship, the promise of regular pay for mercenary work is a tempting offer for him, even though he has little idea of actual warfare. | This man could murder a rock and injure a stone - a good addition to any outfit.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				6,
				10
			],
			Bravery = [
				2,
				5
			],
			Stamina = [
				7,
				10
			],
			MeleeSkill = [
				3,
				5
			],
			RangedSkill = [
				-6,
				-6
			],
			MeleeDefense = [
				1,
				2
			],
			RangedDefense = [
				-3,
				0
			],
			Initiative = [
				5,
				15
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.BrawlerTitles[this.Math.rand(0, this.Const.Strings.BrawlerTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[1, "tattered_sackcloth"],
			[1, "leather_wraps"]
		]));
		items.equip(this.new("scripts/items/accessory/legend_hand_wraps_item"))
	}

});

