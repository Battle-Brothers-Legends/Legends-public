this.belly_dancer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.belly_dancer";
		this.m.Name = "Belly Dancer";
		this.m.Icon = "ui/backgrounds/background_64.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "%name% the southern belly dancer left the company in good time. While their... particularities made them an excellent soldier, it was not their life\'s passion. To entertain, through rhythmic, confusingly erotic motions, that is what they wanted. The last you heard, they were in the court of a Vizier serving not only as an entertainer, but, thanks to time with the %companyname%, also as an adviser on marital matters.";
		this.m.BadEnding = "As the company failed to achieve the success you had hoped for, many departed its ranks. The southern belly dancer joined them. Unfortunately, %name% sought to ply their trade in the north, thinking they may be able to spread culture there. The indigenous population was quick to accuse them of \'unregulated body sorcery\' and burn %name% at the stake.";
		this.m.HiringCost = 500;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Deathwish)
		];
		// this.m.ExcludedTalents = [
		// 	this.Const.Attributes.Hitpoints,
		// 	this.Const.Attributes.Fatigue,
		// 	this.Const.Attributes.Bravery
		// ];
		this.m.Bodies = this.Const.Bodies.SouthernFemale;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.SouthernYoung;
		this.m.BeardChance = 1;
		this.m.Ethnicity = 1;
		this.m.BackgroundType = this.Const.BackgroundType.Female | this.Const.BackgroundType.Performing;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [
				this.Const.Perks.SwordmastersTree
			],
			Class = [],
			Magic = []
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				7,
				14
			],
			RangedSkill = [
				5,
				10
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
				20
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Belly Dancer");
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[3, "oriental/cloth_sash"],
			[1, ""]
		]))

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[4, "legend_jewelry"]
		]));
	}
});

