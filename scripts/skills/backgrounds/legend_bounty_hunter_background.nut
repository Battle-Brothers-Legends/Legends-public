this.legend_bounty_hunter_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},

	function create() {
		this.character_background.create(); //—
		this.m.ID = "background.legend_bounty_hunter"; //only for solo assassin origin
		this.m.Name = "Bounty Hunter";
		this.m.Icon = "ui/backgrounds/background_bountyhunter.png";
		this.m.BackgroundDescription = "Bounty Hunters are solitary in nature who prefer more direct means to that of assassins. Anyone who is brave enough to walk the roads and take coin alone is either a fool or has more than meets the eye to them";
		this.m.GoodEnding = "%name% stayed with the company a while longer after you left, eventually retiring to a quieter life. %They% settled in the mountains and discovered a hidden talent for raising wolves. %They% lived a long life separated from those %they% once hunted, surrounded by a new family of %their% own.";
		this.m.BadEnding = "Like the shifting sands, %name% quickly moved elsewhere after the company collapsed. %They% found it difficult to return to %their% craft after making so many enemies in both the north and the south. Standing alone once again, one too many killers sent in the night eventually wore %them% down. Like %their% past, %they% simply vanished into the background.";
		this.m.HiringCost = 500; //Equipment will factor into cost and these guys can be quite well equipped
		this.m.DailyCost = 55;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.LegendFearDark),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople),
		];
		this.m.Titles = [
			"the Mancatcher",
			"the Hunter",
			"the Ruthless",
			"the Bounty Hunter",
			"the Brutal",
			"the Cruel",
			"the Unforgiving",
			"the Merciless",
			"the Tracker",
			"the Catcher",
			"the Heartless",
			"the Swine"
		];
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Bodies = this.Const.Bodies.SouthernThick;

		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.BackgroundType = this.Const.BackgroundType.Outlaw;

		this.m.Level = this.Math.rand(3, 6);
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.01, //plains
			0.02, //swamp
			0.01, //hills
			0.02, //forest
			0.02, //forest
			0.02, //forest_leaves
			0.02, //autumn_forest
			0.0, //mountains
			0.0, // ?
			0.0, //farmland
			0.0, // snow
			0.02, // badlands
			0.02, //highlands
			0.05, //stepps
			0.0, //ocean
			0.05, //desert
			0.05 //oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.MaceTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.SwordTree,
				::Const.Perks.AxeTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.ThrowingTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.MediumArmorTree
			],
			Traits = [
				::Const.Perks.ViciousTree,
				::Const.Perks.DeviousTree,
				::Const.Perks.CalmTree,
				::Const.Perks.AgileTree
			],
			Enemy = [
				::Const.Perks.CivilizationTree,
				::Const.Perks.SwordmastersTree,
				::Const.Perks.OutlawTree
			],
			Class = [],
			Profession = [],
			Magic = [
				::Const.Perks.AssassinMagicTree
			]
		}
	}

	//Default Male
	function setGender(_gender = -1) {
		if (_gender == -1) {
			_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled"
				? 0
				: ::Math.rand(0, 1);
		}

		if (_gender != 1) {
			return;
		}
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.SouthernFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function getTooltip() {
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "[color=%positive%]+10%[/color] Chance To Hit Head"
		});
		return ret;
	}

	function onBuildDescription() //—
	{
		return "{The growing number of thieves, outlaws and miscreants creates steady work for those who wish to put their lives on the line. | From the noble houses to the gilded southern states, everyone wants someone else dead or missing at the end of the day. | A profession attempted by many but mastered by few — bounty hunters have made a living on catching dangerous people. | The steady growth of cities always makes way for new work, and the work involved in catching those who do not wish to be found has been perfected into an art form by %name%.} {Their profession transcends that of the manhunters, who have become weak catching those who cannot fight back. | Ever curious, %name% is more of a walking toolkit than a person — %their% knives, vials, ropes and other assorted implements mark that of a character who veers between paranoid and well prepared. | %They% bears scars of past contracts but assures you that nobody has escaped %them% yet. | Surprisingly educated, %name% is adept at identifying what direction the wind is blowing, when the next rain will fall and how many steps it would take before an average man collapses from exhaustion.} {Mercenary work for %them% is what %they% do normally, but perhaps with more distractions and shorter marches. | While tough, %name% is calm and reserved enough to make anyone feel uneasy. | While %their% past is a mystery, %their% skill set is impossible to ignore. Having %them% on the payroll is a small price to pay to avoid meeting %them% as an adversary down the line. | %name% treads a fine line between upholding a contract at all costs and hunting down even the lowliest nomad or beggar for coin. | Many see bounty hunters as no better than manhunters. The difference being that nobody would admit it openly to a bounty hunter.}";
	}

	function updateAppearance() {
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush) {
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes() {
		local c = {
			Hitpoints = [
				5,
				7
			],
			Bravery = [
				8,
				10
			],
			Stamina = [
				10,
				14
			],
			MeleeSkill = [
				5,
				8
			],
			RangedSkill = [
				10,
				14
			],
			MeleeDefense = [
				5,
				9
			],
			RangedDefense = [
				5,
				5
			],
			Initiative = [
				20,
				20
			]
		};
		return c;
	}

	function onAddEquipment() {
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0) {
			items.equip(this.new("scripts/items/weapons/battle_whip"));
			items.equip(this.new("scripts/items/shields/buckler_shield"));
		} else if (r == 1) {
			items.equip(this.new("scripts/items/weapons/oriental/heavy_southern_mace"));
			items.equip(this.new("scripts/items/tools/throwing_net"));
		} else if (r == 2) {
			items.equip(this.new("scripts/items/weapons/oriental/saif"));
			items.equip(this.new("scripts/items/tools/daze_bomb_item"));
		} else if (r == 3) {
			items.equip(this.new("scripts/items/weapons/oriental/swordlance"));
		} else if (r == 4) {
			items.equip(this.new("scripts/items/weapons/oriental/two_handed_saif"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.assassin_robe],
			[1, ::Legends.Armor.Southern.cloth_sash],
			[1, ::Legends.Armor.Southern.blade_dancer_armor_00]
		]));

		local helm = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.assassin_face_mask],
			[1, ::Legends.Helmet.Standard.theamson_barbute_helmet],
			[1, ::Legends.Helmet.Southern.blade_dancer_helmet_00]
		]);
		items.equip(helm);
	}

	function onUpdate(_properties) {
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}
});
