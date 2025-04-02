::mods_hookExactClass("skills/backgrounds/killer_on_the_run_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.killer_on_the_run";
		this.m.Name = "Killer on the Run";
		this.m.Icon = "ui/backgrounds/background_02.png";
		this.m.BackgroundDescription = "A killer on the run may kill again, and he knows where to aim.";
		this.m.GoodEnding = "Always a risk taker, you accepted %name% into the %companyname%\'s ranks despite him being a killer on the run. It worked in your favor as he proved himself an able and brave sellsword. As far as you know, he is still with the company, thoroughly enjoying every \'business\' opportunity it affords him.";
		this.m.BadEnding = "While many doubted the risk of hiring a killer on the run such as %name%, the man did prove himself a very capable sellsword. Unfortunately, an old life never trails far behind and bounty hunters kidnapped him in the night. You can find his skeleton squatting in a gibbet fifty feet in the air.";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic)
		];
		this.m.Titles = [
			"Darkhearted",
			"Backblade",
			"Throatslash",
			"on the Run",
			"the Wanted",
			"the Murderer"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.FastTree
			],
			Enemy = [
				this.Const.Perks.NoblesTree,
				this.Const.Perks.MercenaryTree
			],
			Class = [],
			Magic = [
				this.Const.Perks.AssassinMagicTree
			]
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "Always a risk taker, you accepted %name% into the %companyname%\'s ranks despite her being a killer on the run. It worked in your favor as she proved herself an able and brave sellsword. As far as you know, she is still with the company, thoroughly enjoying every \'business\' opportunity it affords her.";
		this.m.BadEnding = "While many doubted the risk of hiring a killer on the run such as %name%, the woman did prove herself a very capable sellsword. Unfortunately, an old life never trails far behind and bounty hunters kidnapped her in the night. You can find her skeleton squatting in a gibbet fifty feet in the air.";

	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Chance To Hit Head"
			}
		);
		return ret;
	}

	o.onBuildDescription <- function ()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{%fullname% has a face that no one desires - one fit for a wanted poster. | With blood on her hands, %name% resembles a woman recently described to you by bounty hunters. | %name% looks about ready to join any outfit - or disappear into its ranks. | Upon meeting people, %name% stammers out her name as if reluctant to part with it.} {Recognizing %name% is no hard feat: this woman is a known-murderer, the blood of both her cuckolding husband and his lover on her hands. | Her eyes are dark and shifting. There is a crime behind them, but also a sense of humanity, as if she knows she has done wrong and is looking to make amends. | Mud stands up to her legs. She\'s been running for a long time. Her hands tremble, too, for her legs run from what her hands have done. | They say she killed her newborn daughter, having always wanted a son instead. | Some believe she struck down a man in self-defense. | Being blackmailed with scandalous information, it\'s hard to blame the woman for what she has done.} {Even if she has done wrong, a party of killers could use a woman such as she. But can the woman be trusted? | %name%\'s eyes skirt from yours. When you ask how she is with a weapon, she mumbles about only having to hit \'the man\' once. | A woman of %name%\'s physique could be useful, but how much can you depend upon a woman whose former life was one of being on the run? | The woman chamfers on her fingernails like a beaver would a tree. She\'s jumpy, but maybe that\'s a good thing in this world. | Mercenary bands are just the thing for a woman like her.}";
		}
		else
		{
			return "{%fullname% has a face that no one desires - one fit for a wanted poster. | With blood on his hands, %name% resembles a man recently described to you by bounty hunters. | %name% looks about ready to join any outfit - or disappear into its ranks. | Upon meeting people, %name% stammers out his name as if reluctant to part with it.} {Recognizing %name% is no hard feat: this man is a known-murderer, the blood of both his cuckolding wife and her lover on his hands. | His eyes are dark and shifting. There is a crime behind them, but also a sense of humanity, as if he knows he has done wrong and is looking to make amends. | Mud stands up to his legs. He\'s been running for a long time. His hands tremble, too, for his legs run from what his hands have done. | They say he killed his newborn daughter, having always wanted a son instead. | Some believe he struck down a man in self-defense. | Being blackmailed with scandalous information, it\'s hard to blame the man for what he has done.} {Even if he has done wrong, a party of killers could use a man such as he. But can the man be trusted? | %name%\'s eyes skirt from yours. When you ask how he is with a weapon, he mumbles about only having to hit \'the man\' once. | A man of %name%\'s physique could be useful, but how much can you depend upon a man whose former life was one of being on the run? | The man chamfers on his fingernails like a beaver would a tree. He\'s jumpy, but maybe that\'s a good thing in this world. | Mercenary bands are just the thing for a man like him.}";
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				3,
				6
			],
			RangedSkill = [
				3,
				5
			],
			MeleeDefense = [
				1,
				3
			],
			RangedDefense = [
				-3,
				0
			],
			Initiative = [
				0,
				5
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[1, "linen_tunic"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"]
		]));
	}

	o.onUpdate = function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}
});
