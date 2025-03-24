::mods_hookExactClass("skills/backgrounds/lindwurm_slayer_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.lindwurm_slayer";
		this.m.Name = "Lindwurm Slayer";
		this.m.Icon = "ui/backgrounds/background_71.png";
		this.m.BackgroundDescription = "This mercenary is a one of a kind Lindwurm hunter, descendant of Dirk the Dragonslayer.";
		this.m.GoodEnding = "%name% left the %companyname% and started a lucrative career as a \'dragon specialist\' advisor to the nobility. As far as you can tell %they% does very little actual work, instead spending %their% days attending lavish banquets, entertaining hosts and their guests with war-stories whilst quaffing their wine.";
		this.m.BadEnding = "Disillusioned with the %companyname%, %name% left to pursue a solo dragon hunting career in order to finally live-up to the legacy of %their% famous father. %They% was last seen taking odd beast hunting contracts, but news of his exploits has no spread far and you fear the worst.";
		this.m.DailyCost = 31;
		this.m.HiringCost = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.LegendFrail),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.Weasel)
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 4);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[3];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];

		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.00,//plains
				0.025, //swamp
				0.0, //hills
				0.025, //forest
				0.025, //forest
				0.025, //forest_leaves
				0.025, //autumn_forest
				0.01, //mountains
				0.0, // ?
				0.00, //farmland
				0.015, // snow
				0.015, // badlands
				0.015, //highlands
				0.0, //stepps
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.BowTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.DeviousTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				this.Const.Perks.LindwurmTree
			],
			Class = [
				this.Const.Perks.BeastClassTree
			],
			Magic = []
		}
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 1;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.onBuildDescription <- function ()
	{
		return "{%name% is a supposedly famous monster hunter with a particular talent for slaying lindwurms. They says he is the son of Dirk the Dragonslayer, the monster hunter who ostensibly slew the last living dragon.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				14,
				18
			],
			Bravery = [
				10,
				12
			],
			Stamina = [
				6,
				12
			],
			MeleeSkill = [
				11,
				11
			],
			RangedSkill = [
				8,
				10
			],
			MeleeDefense = [
				5,
				7
			],
			RangedDefense = [
				-3,
				-3
			],
			Initiative = [
				8,
				14
			]
		};
		return c;
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/fighting_spear"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/noble_sword"));
		}
		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			items.equip(this.new("scripts/items/shields/buckler_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "mail_hauberk"],
			[1, "leather_scale_armor"],
			[1, "noble_mail_armor"],
			[1, "light_scale_armor"],
			[1, "footman_armor"],
			[1, "reinforced_mail_hauberk"]
		]));

		local helm = [
			[1, "feathered_hat"],
			[1, "headscarf"],
			[1, "mail_coif"],
			[1, "greatsword_hat"]
		];

		items.equip(this.Const.World.Common.pickHelmet(helm));
	}

});
