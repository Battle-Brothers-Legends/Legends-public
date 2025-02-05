this.slave_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.slave";
		this.m.Name = "Indebted";
		this.m.Icon = "ui/backgrounds/background_60.png";
		this.m.BackgroundDescription = "The indebted are a caste of de-facto slaves in the city states, and as such are not hired, but bought, and receive no daily wage.";
		this.m.GoodEnding = "%name% the indebted has had a rough life and you\'ve both contributed to that and helped alleviate it in some way. Found as a slave in the south, far from family and home. \'Hired\' essentially for free and worked as an enslaved sellsword. After you left the %companyname%, %name% was removed from the ledger of indebted and was for all intents and purposes free. %name% stayed with the company and has been rising through its ranks ever since. You stand at an odd relation, %name% never thanked you, nor expressed ill will.";
		this.m.BadEnding = "With your retiring from the unsuccessful %companyname%, %name% the indebted from the north carried on with the company for a time. You got wind that the mercenary band ran into financial troubles and was selling off \'flesh and material\' to make ends meet. It seems %name%\'s time with the company presumably ended sometime there, and %name%\'s time as a slave started again.";
		this.m.HiringCost = this.Math.rand(19, 22) * 10;
		this.m.DailyCost = 0;
		this.m.Titles = [
			"the Enslaved",
			"the Northerner",
			"the Captive",
			"the Pale",
			"the Prisoner",
			"the Kidnapped",
			"the Unlucky",
			"the Indebted",
			"the Indebted",
			"the Unfree",
			"the Restrained",
			"the Shackled",
			"the Bound"
		];
		this.m.Excluded = [
			"trait.survivor",
			"trait.iron_jaw",
			"trait.gluttonous",
			"trait.lucky",
			"trait.loyal",
			"trait.cocky",
			"trait.fat",
			"trait.fearless",
			"trait.brave",
			"trait.drunkard",
			"trait.determined",
			"trait.greedy",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.hate_greenskins",
			"trait.legend_aggressive",
			"trait.legend_ambitious",
			"trait.legend_slack"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Bravery
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[3];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Terrain =  [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.0, //swamp
				0.01, //hills
				0.01, //forest
				0.01, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.01, //mountains
				0.0, // ?
				0.01, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //stepps
				0.0, //ocean
				0.01, //desert
				0.01 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CleaverTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.SlingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [this.Const.Perks.SouthernersTree],
			Class = [this.Const.Perks.FistsClassTree], //this.Const.Perks.FistsClassTree
			Magic = []
		}
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 19,
			type = "text",
			icon = "ui/icons/special.png",
			text = "No morale check triggered for non-indebted allies upon dying"
		});
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Is always content with being in reserve"
		});
		return ret;
	}

	function onBuildDescription()
	{
		if(this.isBackgroundType(this.Const.BackgroundType.Female))
		{

		return "{You can tell %name% is a northerner simply by appearance. Servitude in the south has come by way of being indebted to the Gilder transgressed against through faith in the heretical old gods. | %name% bears the features of a northerner, easily capturing the eye of passing men or women. It also happened to catch the attention of a priest who claimed the northerner was indebted to the Gilder and promptly sold the interloper into servitude. | A northerner, %name% was once a soldier sent south on patrol. Lost in the desert, troop slowly dwindling until %name% was the last survivor. Caught by slavers and brought back from the brink, and of course sold into servitude once %name%\'s healed body was worth something. | Despite being a northerner and thus easily spotted, %name% unwisely sought the criminal life and was caught thieving pomegranates from a Vizier\'s garden. %name%\'s lucky to have a head, but now serves as a commodity of labor on the slave markets.}";
		}
		else
		{

		return "{You can tell %name% is a northerner simply by appearance. And his servitude in the south has come by way of being indebted to the Gilder whom he has transgressed with his faith in the heretical old gods. | %name% bears the features of a northerner, easily capturing the eye of passing men or women. It also happened to catch the attention of a priest who claimed the northerner was indebted to the Gilder and promptly sold the interloper into servitude. | A northerner, %name% was once a soldier sent south on patrol. Lost in the desert, his troop slowly dwindled until he was the last survivor. Manhunters caught him and brought him back from the brink, and of course sold him into servitude once his healed body was worth something. | Despite being a northerner and thus easily spotted, %name% unwisely sought the criminal life and was caught thieving pomegranates from a Vizier\'s garden. He\'s lucky to have his head, but now serves as a commodity of labor on the slave markets.}";
		}

	}

	function setGender(_gender = -1)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 19);

		if (_gender != 1) return;

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "%name% the indebted has had a rough life and you\'ve both contributed to that and helped alleviate it in some way. You found her as a slave in the south, far from family and home. You \'hired\' her essentially for free and worked her as an enslaved sellsword. After you left the %companyname%, her name was removed from the ledger of indebted and she was for all intents and purposes a free woman. She stayed with the company and has been rising through its ranks ever since. You stand at an odd relation to the woman. She\'s never thanked you, nor has she expressed ill.";
		this.m.BadEnding = "With your retiring from the unsuccessful %companyname%, %name% the indebted from the north carried on with the company for a time. You got wind that the mercenary band ran into financial troubles and was selling off \'man and material\' to make ends meet. It seems %name%\'s time with the company presumably ended sometime there, and her time as a slave started again.";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				10
			],
			Bravery = [
				-5,
				0
			],
			Stamina = [
				6,
				12
			],
			MeleeSkill = [
				0,
				2
			],
			RangedSkill = [
				0,
				3
			],
			MeleeDefense = [
				0,
				2
			],
			RangedDefense = [
				0,
				2
			],
			Initiative = [
				-5,
				-5
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;

		if (this.Math.rand(1, 100) <= 66)
		{
			local body = actor.getSprite("body");
			local tattoo_body = actor.getSprite("tattoo_body");
			tattoo_body.setBrush("scar_01_" + body.getBrush().Name);
			tattoo_body.Color = body.Color;
			tattoo_body.Saturation = body.Saturation;
			tattoo_body.Visible = true;
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[3, "tattered_sackcloth"],
			[2, "leather_wraps"],
			[1, "indebted_armor_rags"],
			[2, ""]
		]));
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.IsContentWithBeingInReserve = true;

		if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin() != null && this.World.Assets.getOrigin().getID() == "scenario.manhunters")
		{
			_properties.XPGainMult *= 1.1;
			_properties.SurviveWithInjuryChanceMult = 0.0;
		}
	}

});

