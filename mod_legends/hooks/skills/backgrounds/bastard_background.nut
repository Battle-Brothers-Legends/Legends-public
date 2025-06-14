::mods_hookExactClass("skills/backgrounds/bastard_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.bastard";
		this.m.Name = "Bastard";
		this.m.Icon = "ui/backgrounds/background_37.png";
		this.m.BackgroundDescription = "Bastards often have profited from some training in melee fighting.";
		this.m.GoodEnding = "{%name%, the bastard son of a familially inconsiderate nobleman, departed the %companyname% to try to carve out his own family lineage. The last you heard, he\'d managed to acquire himself a good plot of land and a modest stone castle rests on it. While successful, he still harbors resentment for his family. | A bastard son of a nobleman, %name% couldn\'t help but always have that lingering feeling he just didn\'t belong in this world. But the %companyname% gave him a brotherhood to call family. As far as you know, he still fights with the company to this day.}";
		this.m.BadEnding = "Bastards like %name% usually don\'t get far in this world. They\'re too hated in the highborn world in which they live, and hated by the lowborn because they don\'t understand the politics that would make a bastard more common to them than any nobleman. Not long after you left the company, you got wind of %name%\'s passing. Apparently, a young and cruel lord took over his noble house and saw the bastard as a threat to his throne. Despite the bastard wanting nothing to do with that life anymore, it managed to catch up with him anyway. He was assassinated in a tavern bed, his throat cut as he slept.";
		this.m.HiringCost = 170;
		this.m.DailyCost = 21;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(1, 3);
		this.m.BackgroundType = this.Const.BackgroundType.Combat;
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.PerkTreeDynamicMins.Defense = 3;
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.LargeTree
			],
			Enemy = [
				this.Const.Perks.NoblesTree
			],
			Class = [],
			Profession = [], 
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.onBuildDescription <- function ()
	{
		return "{%name% was born during a fiery military campaign far away from his father\'s home. | %name%\'s mother hailed from a pub in %randomtown%. Which is strange, because his father is a married royal in %townname%. | With a wife cursed by a witch, %name%\'s father gave himself to another woman to \'continue\' the bloodline. | With the king away so long, %name%\'s queen of a mother could hardly resist the temptations of a local servant. | %name% was born nine months after raiders pillaged his parents\' castle.} {The life of a bastard was not an easy one: the man was constantly hounded by jealous half-brothers. | Like some kind of royal leper, the bastard was kept far away from the public eye. | Thankfully, for much of his life %name% knew not that he was a bastard child. | A controversy at birth, %name% was only spared abandonment by the omens of a local oracle. | Being a royal bastard gave the man a good life, so long as he kept his head low, and his unwanted status even lower. | Hatred by both strangers and family steeled the bastard for the eventual difficulties outside his royal upbringing.} {Angered by his role in life, %name% did attempt a coup to take the throne. It did not go far. He is now banished from every court in the land. | When a half-brother pelted him with stones, %name% felt little remorse running the sibling through with a sword. He blamed it on a servant, but quickly left his royal housing thereafter. | %name%\'s father tried to pass him off as legitimate, but when a royal marriage fell through the ensuing scandal of impropriety proved too much. The bastard now roams the land, free of the shackles of controversy. | Being the oldest son in line made %name% a target for his younger, legitimate brothers. It was an easy choice to leave that life of politics and backstabbing. | Found in bed with a half-sister, the scandals in %name%\'s life grew far too heavy to stay in the royal courts. | Tired of the trivialities of royal processions, %name% only wishes to join a group of men that care not for bloodlines and legitimacy. | When an assassin poisoned his father\'s wine, %name% was quickly blamed for the murder. Escaping an angry mob was only the beginning of an exciting, new life. | While he came to love him dearly, %name%\'s father knew the royal court was not safe. He sent the man away to forge a life on his own terms.}";
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
				5,
				10
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				-5,
				5
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	o.onAdded <- function ()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 4) == 4)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.BastardTitles[this.Math.rand(0, this.Const.Strings.BastardTitles.len() - 1)]);
		}
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/heater_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.ragged_surcoat],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.padded_surcoat]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.nasal_helmet],
			[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
			[1, ::Legends.Helmet.Standard.hood]
		]));
	}
});
