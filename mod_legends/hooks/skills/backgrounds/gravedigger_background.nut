::mods_hookExactClass("skills/backgrounds/gravedigger_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.gravedigger";
		this.m.Name = "Gravedigger";
		this.m.Icon = "ui/backgrounds/background_28.png";
		this.m.BackgroundDescription = "Gravediggers are used to physical labor and handling the dead.";
		this.m.GoodEnding = "With the great successes of the %companyname%, %name% the gravedigger got continued practice in his trade. As the crowns began to stack, he eventually left the company and returned to the graveyards. Last you heard, he had retired to digging holes again and was happily raising a family of sextons.";
		this.m.BadEnding = "The way you heard things, %name% the gravedigger was one of the last men to leave the %companyname%. With hardly a crown to his name, he slipped hard into drinking and last you heard his body was found in a muddied gully.";
		this.m.HiringCost = 50;
		this.m.DailyCost = 5;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Quick),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Optimist)
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.MaceTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.SturdyTree
			],
			Enemy = [
				this.Const.Perks.GhoulTree,
				this.Const.Perks.ZombieTree
			],
			Class = [
				this.Const.Perks.ShovelClassTree
			],
			Magic = []
		}
	}



	o.onBuildDescription <- function ()
	{
		return "{%name% got his start as a gravedigger by burying his baby brother. | Putting a sword to his drunken father\'s neck, %name%\'s start in gravedigging was a nasty one. First he buried the crime, and then he buried the lawmen who came around asking questions. | After disease swept through %townname%, %name% was the last man standing. He had to abandon his trade to take up the only thing left: gravedigging.} There\'s a look in the dead, they say. But there\'s also a look in those who have seen the dead. %name% has now spent a life and a half {staring at corpses | putting bodies in the ground | digging graves, big ones and small}. To the gravedigger, {death is now but a science | the dead have been better company than the living | earning gold for burying the dead is no new task}. {Employed by a wagon-train, %name% traveled the land and dug it up, too. But one day his burial was suddenly undone. Not by the buzzards or rats, but by the dead itself. Seeing such a sight, and having to bury the same man twice, no doubt compels a swift career change. | Every gravedigger is eyed with suspicion. It wasn\'t long until his patrons became accusers and the notion of a horrific crime of undead passion drove him from his work. The claims are absurd, but you can\'t get a read on his pale face. It\'s like playing cards with the moon. | By now, the man looks as if he could use a change of scenery. Just don\'t ask him to bury the casualties.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				0,
				4
			],
			Bravery = [
				7,
				5
			],
			Stamina = [
				5,
				7
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
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-5,
				0
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_hoe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[1, "tattered_sackcloth"],
			[1, "leather_tunic"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"],
			[1, ""]
		]));
	}


});
