this.legend_druid_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Tattoo = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_druid";
		this.m.Name = "Druid Commander";
		this.m.Icon = "ui/backgrounds/druid_background.png";
		this.m.BackgroundDescription = "Druids are from the wild lands and are ardent defenders of nature.";
		this.m.GoodEnding = "While the %companyname% visited a settlement in the far north %name% bit off more than they could chew with an Unhold contract. Dazed and injured they were taken by a particularly large Unhold for unknown purposes. Months later %name% was found eating, sleeping and even fighting with the giants to defend their home. Sellswords today still joke about the 'giant farker' in the woods, but who is the pet and who is the master is quite the mystery to this day.";
		this.m.BadEnding = "%name% stayed for a little while longer with the company after your departure, then without notice they simply vanished from the company records entirely. Some say they were tired of what the company had become - obsessed with gold and trinkets and straying too far from what it was founded on.";
		this.m.HiringCost = 10000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal)
		];
		this.m.Titles = [
			"the Savage",
			"the Outcast",
			"the Wildman",
			"the Feral",
			"the Wild",
			"the Barbarian",
			"the Green thumb",
			"Oakheart",
			"Treebeard",
			"the flower",
			"the Pollenator",
			"Nature's Wrath",
			"the Bear",
			"the Wolf",
			"the Sapling"
		];
		this.m.Faces = this.Const.Faces.AfricanMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.African;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.BeardChance = 100;
		this.m.Bodies = this.Const.Bodies.AfricanMale;
		this.m.Ethnicity = 2;
		this.m.Level = 3;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Untalented;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[3];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0,//plains
			0.05, //swamp
			0.05, //hills
			0.1, //forest
			0.1, //forest
			0.1, //forest_leaves
			0.0, //autumn_forest
			0.05, //mountains
			0.0, // ?
			0.0, //farmland
			0.05, // snow
			0.05, // badlands
			0.05, //highlands
			0.05, //stepps
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
			this.m.CustomPerkTree = [
			[
				::Legends.Perk.LegendMedIngredients,
				::Legends.Perk.LegendWither,
				::Legends.Perk.LegendSpecialistSelfdefense,
				::Legends.Perk.LegendSpecialistHerbalist,
				::Legends.Perk.LegendAmbidextrous,
				::Legends.Perk.Student,
				::Legends.Perk.Colossus,
				::Legends.Perk.NineLives,
				::Legends.Perk.Pathfinder,
				::Legends.Perk.Recover,
				::Legends.Perk.LegendAlert
			],
			[
				::Legends.Perk.LegendScryTrance,
				::Legends.Perk.LegendGatherer,
				::Legends.Perk.FortifiedMind,
				::Legends.Perk.CoupDeGrace,
				::Legends.Perk.Dodge,
				::Legends.Perk.HoldOut,
				// ::Legends.Perk.LegendComposure,
				::Legends.Perk.QuickHands,
				::Legends.Perk.LegendSmackdown,
			],
			[
				::Legends.Perk.LegendRoots,
				::Legends.Perk.LegendHerbcraft,
				::Legends.Perk.LegendPrayerOfLife,
				::Legends.Perk.LegendGrappler,
				::Legends.Perk.LegendSpecStaffStun,
				::Legends.Perk.LegendTacticalManeuvers,
				::Legends.Perk.Taunt,
				::Legends.Perk.LegendFeint,
				::Legends.Perk.LegendOnslaught,
				::Legends.Perk.LegendSecondWind
			],
			[
				::Legends.Perk.LegendSpecBandage,
				::Legends.Perk.LegendSpecPoison,
				::Legends.Perk.LegendSummonWolf,
				::Legends.Perk.LegendSpecUnarmed,
				::Legends.Perk.SpecSword,
				::Legends.Perk.SpecThrowing,
				::Legends.Perk.LegendMasteryStaves,
				::Legends.Perk.LegendFavouredEnemyGoblin,
				::Legends.Perk.LegendFavouredEnemyBandit
			],
			[
				::Legends.Perk.LegendPotionBrewer,
				::Legends.Perk.LegendReadOmensTrance,
				::Legends.Perk.LegendInsects,
				::Legends.Perk.LoneWolf,
				::Legends.Perk.LegendVengeance,
				::Legends.Perk.LegendBattleheart,
				::Legends.Perk.LegendFavouredEnemyOrk,
				::Legends.Perk.LegendFavouredEnemyNoble
			],
			[
				::Legends.Perk.LegendMinnesanger,
				::Legends.Perk.LegendDistantVisions,
				::Legends.Perk.LegendMuscularity,
				::Legends.Perk.LegendSummonStorm,
				::Legends.Perk.LegendClarity,
				::Legends.Perk.Berserk,
				::Legends.Perk.Nimble,
				::Legends.Perk.LegendMindOverBody,
				::Legends.Perk.LegendLastStand,
				::Legends.Perk.LegendRebound
			],
			[
				::Legends.Perk.LegendPummelIntoSubmission,
				::Legends.Perk.LegendMiasma,
				::Legends.Perk.LegendFieldTriage,
				::Legends.Perk.LegendTumble,
				::Legends.Perk.LegendSummonBear,
				::Legends.Perk.Fearsome,
				::Legends.Perk.Duelist,
				::Legends.Perk.KillingFrenzy,
				::Legends.Perk.BattleFlow,
				// ::Legends.Perk.Stalwart,
				::Legends.Perk.LegendFreedomOfMovement

			]
		];


	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AfricanFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.African;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AfricanFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		if(this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{For some, the wild is a refuge. | It is said that woman is born with the wilderness in her, and that she does wrong by turning her back on it. | Civilization is a stain, one prolonged arming of every next-generation to better battle the ultimate enemy: Mother Nature herself. | In a time of war, it\'s not surprising that many once again seek refuge in the wild. | Some people flee from town to town. Others stop in between, disappearing into the tranquil forests.} {%name% once found a safe register amongst the trees, but that time is over. | Once a mysterious figure to hunters - the famed masskewatsthat - %name% now returns to civilization for reasons unknown. | %name%\'s got the hands of a blacksmith, but the hygiene of a pigsty. | Maybe it was spurned love, or maybe just war, but %name% has spent the last decade far from the rest of mankind. | Possibly a poacher who settled where she hunted, %name%\'s lived amongst the trees for untold years. | With cleverly stitched garb, %name%\'s atavistic appearance perhaps belies a past as a tailor or tanner.} {There is an obvious language barrier with the druid, but for some reason she seems very willing to fight. Let\'s hope his newfound \'calling\' doesn\'t have a darker purpose behind it. | Colorful and permanent ritual rites circle about her body. When asked why she wishes to join a band of mercenaries, she hoots and, with a crooked finger, replicates one of her fleshen arts across the sky. | Wounds, old and fresh, dot her already mottled body. And they are not superficial - this woman had been fighting something fierce in the wild. | One has to wonder if the calamities which chased her into the forests have come to chase her back out. | Judging by her wild grunting, it\'s doubtful she\'s here to rejoin civilization. | Years as a recluse haven\'t made the woman forget what a few crowns can get you. The question is, why did she come back? | She has the strength to wrestle a boar - and her many scars makes you wonder if perhaps she did.}";
		}
		else
		{
			return "{For some, the wild is a refuge. | It is said that man is born with the wilderness in him, and that he does wrong by turning his back on it. | Civilization is a stain, one prolonged arming of every next-generation to better battle the ultimate enemy: Mother Nature herself. | In a time of war, it\'s not surprising that many once again seek refuge in the wild. | Some people flee from town to town. Others stop in between, disappearing into the tranquil forests.} {%name% once found a safe register amongst the trees, but that time is over. | Once a mysterious figure to hunters - the famed masskewatsthat - %name% now returns to civilization for reasons unknown. | %name%\'s got the hands of a blacksmith, but the hygiene of a pigsty. | Maybe it was spurned love, or maybe just war, but %name% has spent the last decade far from the rest of mankind. | Possibly a poacher who settled where he hunted, %name%\'s lived amongst the trees for untold years. | With cleverly stitched garb, %name%\'s atavistic appearance perhaps belies a past as a tailor or tanner.} {There is an obvious language barrier with the druid, but for some reason he seems very willing to fight. Let\'s hope his newfound \'calling\' doesn\'t have a darker purpose behind it. | Colorful and permanent ritual rites circle about his body. When asked why he wishes to join a band of mercenaries, he hoots and, with a crooked finger, replicates one of his fleshen arts across the sky. | Wounds, old and fresh, dot his already mottled body. And they are not superficial - this man had been fighting something fierce in the wild. | One has to wonder if the calamities which chased him into the forests have come to chase him back out. | Judging by his wild grunting, it\'s doubtful he\'s here to rejoin civilization. | Years as a recluse haven\'t made the man forget what a few crowns can get you. The question is, why did he come back? | He has the strength to wrestle a boar - and his many scars makes you wonder if perhaps he did.}";
		}


	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				-10,
				0
			],
			RangedSkill = [
				-10,
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

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
		this.m.Tattoo = this.Math.rand(0, 1);
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("body");
		tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		tattoo_body.Visible = true;
		tattoo_head.setBrush(this.m.Tattoo == 0 ? "warpaint_01_head" : "scar_02_head");
		tattoo_head.Visible = true;
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		}
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("The Druid");
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 2;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		local stash = this.World.Assets.getStash();
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		items.equip(this.new("scripts/items/weapons/legend_staff"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Barbarian.hide_and_bone_armor]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.bear_headpiece]
		]));

	}

	function onSerialize( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Tattoo);
	}

	function onDeserialize( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Tattoo = _in.readU8();
	}

});
