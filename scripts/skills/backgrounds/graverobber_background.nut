this.graverobber_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.graverobber";
		this.m.Name = "Graverobber";
		this.m.Icon = "ui/backgrounds/background_25.png";
		this.m.BackgroundDescription = "Graverobbers are not faint of heart.";
		this.m.GoodEnding = "Graverobbers like %name% aren\'t exactly the most well liked men in this world, but all you needed from him was to be a great mercenary and he came through in spades. After you left the business, you learned that the graverobber stayed for the long haul. From what you know, he\'s now the company\'s trainer, helping green recruits get up to speed.";
		this.m.BadEnding = "A man like %name% the graverobber came to the company to help escape from his most unlawful and immoral errors, and what better way to do that than killing people for money? Unfortunately, the %companyname% slowly began to fall apart. You learned that %name% eventually left the company and joined with a similar, competing outfit. You\'re not sure where he is now, and you\'re not sure whether to be insulted by his betrayal or understand the reasoning behind it. Business is only business, after all.";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMin;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Outlaw;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.MaceTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [
				this.Const.Perks.GhoulTree,
				this.Const.Perks.SkeletonTree
			],
			Class = [
				this.Const.Perks.ShovelClassTree
			],
			Magic = []
		}
	}



	function onBuildDescription()
	{
		return "{What compels a man to disturb those who have passed away? | With rumors of the dead rising again, perhaps it is but forward thinking to go around digging up graves. | An enemy to moral standards and sensibilities, men who take spades to fresh graves find few allies. | A coward attacks a man when he\'s down, a graverobber attacks a man when he\'s really down. | It is trivial how easily a man abrogated by death can be acquired by mere graverobbing. | When it comes to death, worms take the flesh, and time the bones, but graverobbers get the jewels.} {Raised by an abusive mother, %name% found happier coordinance with the dead than the living. | After many lonely nights in hermitry, %name% is said to have taken up dancing with the dead. | %name% romanced beneath the stars, but pale and cold describes more than just the night sky. | For entertainment in a boring life, %name% is known to visit the murky gastines of graveyards. | Swindled by a salesman, %name% found himself digging up graves for loot. So the story goes, anyway. | Once a fine jeweler, dementia drove %name% into crafting a very different style of attire. A toothy necklace chatters at you as he explains.} {The deviancies of such a man may know no bounds, but his for-now warm body could be of use. | He\'s not right in the head, but maybe he\'s right with a sword in hand. Maybe. | Disturbing as he might be, desperate times call for desperate recruits. | He wears a plain necklace with a subtle offwhite color best described as \'bone\'. | Driven away by an especially mad mob, %name% is one of many outcasts to venture into the world of mercenaries. | The man is quiet, but you can\'t shut him up around a graveyard. | Hopefully he likes putting cold bodies into graves as much as he likes digging them up.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				5,
				8
			],
			Stamina = [
				10,
				15
			],
			MeleeSkill = [
				4,
				7
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				1
			],
			RangedDefense = [
				0,
				1
			],
			Initiative = [
				5,
				10
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
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "ragged_surcoat"],
			[1, "leather_wraps"],
			[1, "leather_tunic"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"],
			[1, "open_leather_cap"],
			[1, "headscarf"],
			[1, "ancient/ancient_household_helmet"]
		]));
	}

});

