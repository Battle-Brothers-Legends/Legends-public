this.legend_horse_courser <- this.inherit("scripts/skills/backgrounds/legend_horse", {
	m = {},
	function create()
	{
		this.legend_horse.create();
		this.m.ID = "background.legend_horse_courser";
		this.m.Name = "Courser";
		this.m.Icon = "ui/backgrounds/donkey.png";
		this.m.BackgroundDescription = "Coursers are swift and strong horses well-suited for war, hunting and transportation.";
		this.m.GoodEnding = "%name% the Courser was sold to a Lady of a Noble House as her coming-of-age present. Though its fighting skill dulled with age, it was well-loved and enjoyed the luxurious life of a Noble's steed.";
		this.m.BadEnding = "%name% the Courser didn't wear its warwounds with as much pride and dignity one could have hoped, and one time when the horse encountered a knight in the city, it went wild and started bucking. When the knight himself was unhorsed in the commotion, there was no mercy. %name% was put down.";
		this.m.HiringCost = 20000;
		this.m.DailyCost = 1;
		this.m.Excluded = [
			"trait.tiny",
			"trait.clubfooted",
			"trait.bright",
			"trait.weasel",
			"trait.craven",
			"trait.ailing",
			"trait.clumsy",
			"trait.asthmatic"
		];
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[2];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[3];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[2];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[3];
	}

	function onBuildDescription()
	{
		return "{%name% was raised as a fine riding horse.|%name% was reared by a Burgher.|Though the work is dangerous, being the steed of a Squire allowed %name% to see the world. | Fast as the lightning and sturdy as an oak, %name% was the pick of the bunch.|%name% has carried their owner to more important meetings than battles|%name% has an illustrious history of serving as the steed of notable Burghers, though none know why it has so often been sold on. | %name%'s swift speed has their owner's life numerous times. | More than once, %name% has stood steady as even men ran in fear, saving both the life and reputation of its owner. | When the former owner fell on hard times, %name% was put up for sale. | When its owner fell in battle, their comrades put %name% up for sale to help his widow | Though a fine a Courser as most others, the former owner still put %name% up for sale when he acquired an even finer steed. | Lost in a bet, %name% was put up for sale as the new owner was more interested in money than a steed.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				100,
				120
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				40,
				50
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				-20,
				-20
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				10,
				15
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Initiative] = 3;
		talents[this.Const.Attributes.Fatigue] = 3;
		this.getContainer().getActor().fillTalentValues(1, true);

	}

});
