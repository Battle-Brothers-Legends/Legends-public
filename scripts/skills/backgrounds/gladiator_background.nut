this.gladiator_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.gladiator";
		this.m.Name = "Gladiator";
		this.m.Icon = "ui/backgrounds/background_61.png";
		this.m.BackgroundDescription = "Gladiators are expensive, but a life in the arena has forged them into skilled fighters.";
		this.m.GoodEnding = "You thought that %name% the gladiator would return to the arenas as you thought he might. However, news from the south speaks of an uprising of indebted and gladiators alike. Unlike previous revolts, this one has viziers swinging from rooftops and slavers being lynched in the streets. The general upheaval is apparently about to sit the once-ringfighter as a legitimate powerbroker in the region.";
		this.m.BadEnding = "The call of the crowd was too loud for the gladiator %name%. After your quick retirement from the unsuccessful %companyname%, the fighter returned to the southern kingdoms\' fighting arenas. Unfortunately, the wear and tear of his time with mercenaries slowed him a step and he was mortally slain by a half-starved slave wielding a pitchfork and a net.";
		this.m.HiringCost = 200;
		this.m.DailyCost = 38;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.fear_undead",
			"trait.legend_fear_nobles",
			"trait.weasel",
			"trait.night_blind",
			"trait.legend_fear_dark",
			"trait.legend_sureshot",
			"trait.ailing",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];
		this.m.Ethnicity = this.Math.rand(1, 2);
		if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.Gladiator;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
			this.m.Beards = this.Const.Beards.Southern;
			this.m.BeardChance = 60;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanGladiator;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Beards = this.Const.Beards.Southern;
			this.m.BeardChance = 60;
		}

		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Level = this.Math.rand(2, 5);
		this.m.BackgroundType = this.Const.BackgroundType.Combat;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[0];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[0];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[0];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0, //plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.05, //stepps
				0.0, //ocean
				0.1, //desert
				0.1 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.PolearmTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree,
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.FitTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.BeastClassTree
			],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		if (this.m.Ethnicity == 1)
		{
			this.m.Faces = this.Const.Faces.SouthernFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.Young;
			this.m.Bodies = this.Const.Bodies.SouthernFemaleMuscular;
		}
		else
		{
			this.m.Faces = this.Const.Faces.AfricanFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Bodies = this.Const.Bodies.AfricanFemaleMuscular;
		}

		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}


	function onBuildDescription()
	{
		return "{The South is littered with slaves of all sorts, called the indebted for their debt to the Gilder. While most find themselves in the fields, a select few are taken to the fighting pits to battle it out. | While northerners do partake in combat tournaments, nothing gets close to the violence and gore of a southern gladiatorial pit. | In the South, rich and poor alike enjoy cheering on the gladiators of the fighting pits. | Southern gladiatorial pits are filled with indebted and voluntary killers alike. | A bloody house of combat and betting, a gladiatorial pit is the one place in the South one may find rich and poor crowded together.} {It was from these ranks %name% came. %they% rapidly grew through the ranks and managed to buy %their% way out of the pits and into whatever \'freedom\' one could find after such a life. | A crowd-favorite, %name%\'s time as a gladiator ended after a \'pardon\' by %their% wealthy sponsors. But in early retirement %they% found %their% life unfulfilled. | Successful killers such as %name% can buy their way to freedom, though the bloodlust has yet to leave the woman. | %name% was involved in a \'diving\' incident and received a year long ban from the pits. | But gladiators like %name% are not just popular with the public, but particularly with lusty folk . A raunchy tryst with a noble led to the fighter being spirited away under the cover of night lest %they% be mutilated. | A pit\'s most popular fighter is usually a blend of murderous handsomeness, and a woman such as %name% was only the former. Dispirited by the lack of fame %they% thought %they% had earned, %they% purchased %their% freedom and departed the blood sport.} {Gladiators usually cross from fighting pit to fighting pit, so a sturdy, well skilled fighter such as %name% is rare to find in the wild. Yet here %they% stands, albeit with enough scars to make a flagellant blush. | You\'ve met many a warrior, but rarely one with the particular skillsets of a pit fighter such as %name%. All the clashing in the arenas has made %their% a clever warrior indeed, and also one with many a scar and injury to match %their% time there. | There\'s many pairings in this world, and a gladiator with an untouched body is not one of them. %name% is a skilled fighter, but %they% earned those experiences with %their% own blood and body. | An impressive gladiatorial resume such as the one %name% brings hints at a woman well versed in killing. The many scars, however, flatly state that %their% time in the pits came with an irreversible price of their own. | Gladiators such as %name% could be the most skilled fighters in all the land, but the fighting pits are full of games and are designed to bring harm to all who partake. The woman is a talented warrior, but %they% wears the scars and wounds of a career in the arena.}";
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 30)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				3,
				6
			],
			Bravery = [
				5,
				5
			],
			Stamina = [
				5,
				8
			],
			MeleeSkill = [
				10,
				13
			],
			RangedSkill = [
				6,
				8
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				5,
				8
			],
			Initiative = [
				3,
				8
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(1, 2) == 2)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.GladiatorTitles[this.Math.rand(0, this.Const.Strings.GladiatorTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/shamshir",
				"weapons/oriental/two_handed_scimitar",
				"weapons/oriental/heavy_southern_mace",
				"weapons/oriental/heavy_southern_mace",
				"weapons/oriental/swordlance",
				"weapons/oriental/polemace",
				"weapons/fighting_axe",
				"weapons/fighting_spear"
			];

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace",
					"weapons/bardiche"
				]);
			}

			items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			local offhand = [
				"tools/throwing_net",
				"shields/oriental/metal_round_shield"
			];
			items.equip(this.new("scripts/items/" + offhand[this.Math.rand(0, offhand.len() - 1)]));
		}


		local a = this.Const.World.Common.pickArmor([
			[1, "oriental/gladiator_harness"]
		]);

		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));
		}
		else if (r == 2)
		{
			a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));
		}
		items.equip(a);

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "oriental/gladiator_helmet", this.Math.rand(13, 15)],
			[1, ""]
		]));

	}

});

