this.legend_shieldmaiden_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_shieldmaiden";
		this.m.Name = "Shieldmaiden";
		this.m.Icon = "ui/backgrounds/legend_shieldmaiden.png";
		this.m.BackgroundDescription = "Shieldmaidens are fierce female warriors from the northern settlements.";
		this.m.GoodEnding = "The shieldmaiden, %name% stayed with %companyname% a little longer after your departure, netting herself a small horde of crowns. Nobody truly knew what happened to her next, but she was last seen hiring other women as fighters not far from where you picked her up so long ago.";
		this.m.BadEnding = "As %companyname% declined in strength, %name% was one of the first to take charge. Her defensive nature led to inaction and ended up with most of the company being whittled down by goblin arrows in a swamp, many with their shields still clutched in their hands under the never-ending rain of projectiles.";
		this.m.HiringCost = 450;
		this.m.DailyCost = 30;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Tiny)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Initiative
		];
		this.m.Titles = [
			"the Shieldmaiden",
			"the White Death",
			"the Wall",
			"the Ironside"
		];
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.Ethnicity = 0;
		this.m.Level = this.Math.rand(1, 2);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Female | this.Const.BackgroundType.Crusader;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		// this.m.PerkTreeDynamicMins.Defense = 3;
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SpearTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [	
				this.Const.Perks.HeavyArmorTree,
			],
			Traits = [
				this.Const.Perks.SturdyTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.FastTree
			],
			Enemy = [
				this.Const.Perks.BarbarianTree
			],
			Class = [],
			Magic = []
		}
	}

	function onBuildDescription()
	{
		return "{%name% was born to a family with a long history of female warriors. | %name% hails from the distant north, where ideas about the fairer sex tend to be far rougher. | %name% claims to have once been the personal protector of a great jarl, but was exiled from her home for reasons that she seems hesitant to speak of. | %name% caught your eye by flexing her scarred bicep, and she claims that every cut is another man killed. | %name% talks of distant climes and frozen lands that, from her description, you can hardly imagine man could be cursed to walk. | You met %name% in a local tavern, drinking enough to kill most men and challenging anyone who passed to a fight. | %name% has the farthest thing you can imagine from a pretty face, but she makes up for that with a spear and shield that have both clearly seen their share of war.} {Despite whatever hangups many have about women warriors, %name% speaks of a thousand battles you\'ve never heard of yet sound plenty dangerous to you, and she bears enough scars to confirm their veracity. | She proudly displays an old shield that seems more crack than wood, and claims that it was gifted to her from a great warrior that she had killed herself. | When a local bruiser challenged her he decided to spend the first moments of the fight gloating to his friends, only to receive a swift punch leading to a broken jaw. | She doesn\'t say much, but those few words she does say speak thousands about the strange places she\'s seen and the stranger things she\'s killed there.} {%name% spits on the ground as she sees a merchant claiming to be selling the hides of Unhold, and says she\'s killed baby ones at twice the size. | You have no idea how many of her stories are fabricated, but %name% seems to know how to swing a sword well enough. | When one of your men made a pass on her it took two others to drag her off of the nearly unconscious mercenary. | When you ask her to demonstrate her skill, she grabs one of your men and pulls him to the ground in a headlock before you can stop her. She\'s brave, at least. | You\'re not sure if the woman\'s entirely all there, but she seems like she knows a shieldwall well enough. | You met her in the tavern after a brawl. It was a bad one, but %name% was the only one—besides you—left standing. | You can tell by the look in her eyes that this woman has seen her fair share of war.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				7,
				10
			],
			Bravery = [
				6,
				8
			],
			Stamina = [
				8,
				12
			],
			MeleeSkill = [
				4,
				6
			],
			RangedSkill = [
				6,
				10
			],
			MeleeDefense = [
				8,
				12
			],
			RangedDefense = [
				4,
				7
			],
			Initiative = [
				-15,
				-7
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[1, "padded_surcoat"],
			[1, "ragged_surcoat"],
			[1, "gambeson"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "open_leather_cap"],
			[1, "aketon_cap"],
			[1, "full_leather_cap"],
			[1, "full_aketon_cap"]
		]));

		r = this.Math.rand(0, 3);
		if (r <= 2)
		{
			items.equip(this.new("scripts/items/shields/heater_shield"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/shields/legend_tower_shield"));
		}

		r = this.Math.rand(0, 4);
		if (r <= 2)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		}
	}
});
