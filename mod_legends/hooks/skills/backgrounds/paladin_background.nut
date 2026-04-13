::mods_hookExactClass("skills/backgrounds/paladin_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.paladin";
		this.m.Name = "Oathtaker";
		this.m.Icon = "ui/backgrounds/background_69.png";
		this.m.BackgroundDescription = "Oathtakers are brave warriors sworn to uphold a strict code, and are no strangers to combat. The faith in their cause might seem foolhardy for the nonbeliever, but for them it\'s a driving force which increases their health and initiative.";
		this.m.GoodEnding = "%name% the Oathtaker stayed with the %companyname%, wielding Young Anselm\'s skull to proselytize knightly virtues unto the world. Most see %them% as something of an annoyance, but there is also some charm in a %person% who believes fully in matters of honor and pride and doing good. Last you heard, %they% singlehandedly saved a lord\'s princess from a gang of alley thieves. In celebration, he was wed to the damsel, though rumors abound that she is unhappy in bed, proclaiming that the Oathtaker insists on Young Anselm\'s skull watching from the corner. Whatever\'s going on, you\'re happy that the %person% is still doing %their% thing to the fullest.";
		this.m.BadEnding = "Once an Oathtaker to the bone, %name% grew disenchanted with %their% fellow believers and one night had a dream that they were, in fact, the true heretics. %They% slew every Oathtaker in reach and then fled out, eventually joining the Oathbringers of all people. Last that was heard of %them%, %they% reclaimed Young Anselm\'s skull and smashed it with a hammer. Enraged, %their% new Oathbringer brethren promptly slew %them% down. %name%\'s corpse was found stabbed over a hundred times, ashy skull fragments powdering a bloodied, madly grinning face.";
		this.m.HiringCost = 350;
		this.m.DailyCost = 34;
		this.m.Titles = [
			"the Crusader",
			"the Zealot",
			"the Pious",
			"the Devoted",
			"the Paladin",
			"the Righteous",
			"the Oathbound",
			"the Oathsworn",
			"the Virtuous"
		];
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
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.LegendSureshot),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Weasel)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Initiative
		];
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.BeardChance = 60;
		this.m.Level = this.Math.rand(1, 3);
		this.m.IsCombatBackground = true;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Crusader;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMin;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];

		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.05, //plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.03, //farmland
				0.0, // snow
				0.01, // badlands
				0.01, //highlands
				0.0, //steppes
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.PolearmTree,
				::Const.Perks.ShieldTree,
				::Const.Perks.MaceTree,
				::Const.Perks.HammerTree,
				::Const.Perks.SwordTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.LargeTree,
				::Const.Perks.MartyrTree,
				::Const.Perks.FitTree
			],
			Enemy = [
				::Const.Perks.UndeadTree
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		local bonus = this.Math.round(this.getContainer().getActor().getBaseProperties().Bravery * 0.10);
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=%positive%]%_bonus%[/color] bonus to Hitpoints, Fatigue and Initiative from your base Resolve",
			param = [["_bonus", bonus]]
		});
		return ret;
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleMuscular;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	o.onBuildDescription <- function ()
	{
		return "{Oathbringers. Oathbringers. Oathbringers. Oathbringers. Oathbringers. Oathbringers. Oathbringers. Oathbringers. Oathbringers. Oathbringers. Oathbringers. Oathbringers!\n\nOathbringers Oathbringers Oathbringers Oathbringers Oathbringers Oathbringers!!!\n\nOATHBRINGERS OATHBRINGERS OATHBRINGERS!!! | %name% is a diligent follower of the famed founder of the Oathtakers, Young Anselm. %They% believes %themselves% blessed to be in the company of likeminded warriors who, though not without fault, will try and do right in the world. | Some say %name% was an Oathtaker the moment %they% was born. It is the %person% %themselves% who says this most often, though, which leads to some speculation that %they% was almost assuredly a terrible degenerate and %they%\'s just now making up for a horrific past. | When you think of an Oathtaker, %name% is about as clean as they come. Keeps %their% uniform and armor nice and tidy. Respects %their% superiors but is never mawkish. And %they%\'s absolutely excellent at directing steel through an Oathbringer\'s face. An outstanding Oathtaker if there ever was one. | Living in a faraway land, chasing honor and bringing death to Oathbringers, %name% heard of the %companyname%\'s prestigious past and just had to find it and join up. %They% is a %person% of incredible resolve and most importantly %they% does not truck with Oathbringers. | Young Anselm\'s spirit has brought %name% to the %companyname%. Or so %they% says. Whatever brought %them% into the company, %they% is no doubt a talented fighter and will serve the outfit well. | The majesty of Young Anselm\'s spirit cannot be taken for granted. At least that is what %name% believes. %they% states that %they% fights on behalf of the dead Oathtaker. Young Anselm must have been a spirited fellow indeed for this %person% is a wicked talent with any steel.  | Like many Oathtakers, %name% knows three divine elements: Young Anselm\'s spirit is to be cherished, Oaths are to be taken seriously, and all Oathbringers must die. Earning some coin on the side is also nice, which is why %they% has made %their% \'fourth\' element fighting for outfits like the %companyname%. | It is a little peculiar for an Oathtaker to earn a sellsword\'s coin fighting, but %name% states that it was never forbidden by Young Anselm\'s teachings. Instead, it is the personal responsibility of the individual Oathtakers to maintain their oaths, which %they% can readily do cleaving enemies for the %companyname%. | %name% carries a ledger dedicated to only one kind of inventory: how many Oathbringers %they%\'s killed. %They% even has a list of when and where %they% did the deed, and of course how. The \"how\" entries even get a little extra dedication, with lines and lines meticulously describing how %they% dispatched %their% hated foes. Frankly, you like the %person%\'s enthusiasm. | %name%, a Oathtaker, is of such a singular mind it has you almost worried what %they%\'d do without Young Anselm\'s directives. Now, that said, a part of you is curious how %they%\'d fare dedicating %themselves% to another craft. With %their% resolve and drive, %they% could probably weave an unbelievable basket, possibly even do it underwater like those learned experts. | %name% is everything one would want in an honorable %person%: smart, fit, and quite good swinging some steel. %Their% dedication to the Oaths is only matched by %their% ability to absolutely demolish those who stand in %their% way. A perfect fit for the %companyname%, truly. | With the %companyname% gaining renown, it is becoming one of the more notable outfits in the land. Naturally, a talented and honorable %person% like %name% would seek to join up, albeit at a cost. %Their% services to Young Anselm\'s cause mean %their% attention is no doubt split, but even being consumed by righteousness %they% is still an indefatigable fighter worth having in the %companyname%.}";
	}

	o.onUpdate <- function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		local bonus = this.Math.round(this.getContainer().getActor().getBaseProperties().Bravery * 0.10);
		_properties.Initiative += bonus;
		_properties.Hitpoints += bonus;
		_properties.Stamina += bonus;
	}

	o.onSetAppearance = function ()
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

	o.updateAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				10,
				6
			],
			Bravery = [
				13,
				16
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				5,
				9
			],
			RangedSkill = [
				3,
				6
			],
			MeleeDefense = [
				5,
				7
			],
			RangedDefense = [
				-10,
				-5
			],
			Initiative = [
				13,
				12
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local actor = this.getContainer().getActor();
		actor.setVeteranPerks(3);
		local items = actor.getItems();
		local r;

		if (items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/arming_sword",
				"weapons/fighting_axe",
				"weapons/winged_mace",
				"weapons/military_pick",
				"weapons/warhammer",
				"weapons/longaxe",
				"weapons/billhook",
				"weapons/greataxe",
				"weapons/greatsword",
				"weapons/legend_zweihander",
				"weapons/longsword",
				"weapons/polehammer",
				"weapons/two_handed_flail",
				"weapons/two_handed_flanged_mace",
				"weapons/bardiche"
			];

			items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (items.hasEmptySlot(this.Const.ItemSlot.Offhand) && this.Math.rand(1, 100) <= 75)
		{
			local shields = [
				"shields/wooden_shield",
				"shields/wooden_shield",
				"shields/heater_shield",
				"shields/kite_shield"
			];
			items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		r = this.Math.rand(0, 5);

		items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Standard.adorned_mail_shirt],
			[2, ::Legends.Armor.Standard.adorned_warriors_armor],
			[1, ::Legends.Armor.Standard.adorned_heavy_mail_hauberk]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Standard.heavy_mail_coif],
			[2, ::Legends.Helmet.Standard.adorned_closed_flat_top_with_mail],
			[1, ::Legends.Helmet.Standard.adorned_full_helm]
		]));
	}

});
