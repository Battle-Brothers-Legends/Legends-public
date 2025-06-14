::mods_hookExactClass("skills/backgrounds/miner_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.miner";
		this.m.Name = "Miner";
		this.m.Icon = "ui/backgrounds/background_45.png";
		this.m.BackgroundDescription = "A miner will be used to physical labor, but breathing in the dusty air of the mines may have taken a toll on his health over the years.";
		this.m.GoodEnding = "%name% the miner never did return to the mines, thankfully. If there\'s one life that could be worse than that of fighting for a living, it very well may be digging into mountains for a living! Apparently, the miner built a home by the sea, spending the rest of his days peacefully fishing for dinner and enjoying sunrises or some such sappy shite.";
		this.m.BadEnding = "If there\'s one life that\'s more rough than that of being a sellsword, it is that of being a miner. Sadly, %name% returned to that life, going back into the mines to dig out metals and ores to fill some rich man\'s pockets. A recent earthquake collapsed many such mines. You\'re not sure if the ol\' brother survived, but it\'s looking pretty grim.";
		this.m.HiringCost = 75;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard)
		];
		this.m.Titles = [
			"the Miner",
			"the Crawler",
			"Earthside"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.Modifiers.Terrain =  [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.0, //swamp
				0.1, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.075, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //stepps
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.HammerTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.SturdyTree
			],
			Enemy = [
				this.Const.Perks.OrcTree,
				this.Const.Perks.UnholdTree
			],
			Class = [
				this.Const.Perks.PickaxeClassTree
			],
			Profession = [
				this.Const.Perks.MinerProfessionTree
			], 
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.onBuildDescription <- function ()
	{
		return "{To support a fatherless family, %name% went into the mines at a very young age. | An orphan, the only work %name% could find was working the mines of the earth. | Mining is tough work, the sort of job men like %name% flock to. | Even though his father died in the mines, %name% felt compelled to work in them himself, like most men do where he grew up. | %name% worked in the mines as a family tradition spanning many generations. | Whenever wars start up, miners like %name% are more needed than ever, lest an army wishes to go without steel to wield. | A hardhelm and a pickaxe, the tools %name% has been taking deep into the earth for years.} {But, as always, a mine doesn\'t last forever, and the miner barely escaped the last collapse. | Sadly, he proved to be the only survivor of a shaft collapse, and there\'s no way he\'s digging back in there by himself. | After a tragic mine collapse, the sight of dozens of widows moved the man to think of a different field of work. | Surviving yet another collapse, the man\'s wife demanded he seek a new line of work no matter what it was. | Bending over and scuttling about in the dark gets old, though, and so the man sought a different vocation. | Working in environments far too dark, the man accidentally killed a coworker. The tragedy pushed him from the field. | After his own son lost his life in the mines, the man left the job forever. | But suffering from relentless coughs, the man felt maybe a career in fresh air would better serve him.} {%name% has the stocky frame of a miner. Unfortunately, he has the lungs of one, too. | He\'s tough alright, but %name%\'s wheezing sounds like rusted blades grinding together.  | You have to wonder if %name%\'s lungs have enough metal dust in them to fashion a blade or two. | %name%\'s breath could probably ink a chunk of coal. | %name% spent years earning keep for a company store. Now he wants to earn some real coin. | %name% looks forward to pocketing some of that gold he spent years plucking out of the earth. | Annoyingly, %name% points at half your gear - the metal stuff, mostly - and reminds everyone who\'s responsible for it being there. | %name% has almost catlike vision in the dark. He would have made for a good assassin if it weren\'t for his damned wheezing. | %name% has cheated death a few times, so why not try it a few times more as mercenary? | %name%\'s already had the earth itself out for his head so a few things above the soil don\'t scare him much. | If darkness truly is death\'s ambassador, %name%\'s already been talking to it for years. | Stupidly brave souls like %name% can definitely find a good register in an outfit such as this. | %name% proudly boasts that, once upon a time, he could play cards in the dark. You don\'t doubt it. | If %name% can swing a sword as well as a pickaxe, then all is well.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				10,
				10
			],
			Bravery = [
				2,
				5
			],
			Stamina = [
				-14,
				-8
			],
			MeleeSkill = [
				3,
				7
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
				0,
				0
			]
		};
		return c;
	}

	o.onSetAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/pickaxe"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Standard.mouth_piece]
		]));
	}

});
