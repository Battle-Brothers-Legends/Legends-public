this.legend_lurker_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_lurker";
		this.m.Name = "Lurker";
		this.m.Icon = "ui/backgrounds/background_lurker.png";
		this.m.BackgroundDescription = "This one is unsettling, even for a cultist. Ever quiet and brooding, but with eyes as keen as that of a vengeful god.";
		this.m.GoodEnding = "The cultist, %name%, left the company with a band of cloaked converts. You know not what became of the fanatic, but every so often they appear in your dreams. Often standing alone in a great void and there is always someone, or something, lingering in the black beyond. Every night, this image gets a little more clear, and each night you find yourself staying up later and later just to avoid dreaming at all.";
		this.m.BadEnding = "You heard that %name%, the cultist, left the company at some juncture and went out to spread the faith. There\'s no telling what became of the fanatic, but there was a recent inquisition against unholy faiths and hundreds of \'folk in dark cloaks with even darker intentions\' were burned at the stake across the realm.";
		this.m.HiringCost = 120;
		this.m.DailyCost = 11;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.MeleeSkill
		];
		this.m.Titles = [
			"the Cultist",
			"the Mad",
			"the Believer",
			"the Occultist",
			"the Insane",
			"the Follower",
			"the Lost",
			"the Odd",
			"the Misguided",
			"the Fanatic",
			"the Zealot"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.Level = this.Math.rand(1, 2);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.BackgroundType = this.Const.BackgroundType.Cultist | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.00,//plains
				0.10, //swamp
				0.0, //hills
				0.05, //forest
				0.05, //forest
				0.05, //forest_leaves
				0.05, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.05, //farmland
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
				this.Const.Perks.CleaverTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.BowTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SlingTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree,
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.MartyrTree
			],
			Enemy = [
				this.Const.Perks.CaravanTree,
				this.Const.Perks.NoblesTree,
				this.Const.Perks.ArcherTree
			],
			Class = [
				this.Const.Perks.BeastClassTree,
				this.Const.Perks.NinetailsClassTree,
				this.Const.Perks.ShortbowClassTree
			],
			Profession = [],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Faces = this.Const.Faces.OldFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	// Should overwrite the "character_backgrounds" isCultist() check
	function isCultist()
	{
		return true;
	}

	function onBuildDescription()
	{
		return "{%name% has always been a quiet sort, preferring to observe rather than act impulsively. | They gravitate to the darkest places possible and have no problem marching through difficult terrain. | Shot in the head by a bolt at close range, %name% was pulled from a shallow grave far in the southern sands by a healer, now they seek reprisal. | Clothed in rags, %name% is suprisingly at ease with their surroundings, ever watchful of potential predators...or prey. | %name% carries a myriad of makeshift arrows, some bone and others metal. However a few shafts and arrowheads seem more otherworldly than the others... | Looking at %name% you can\'t help but feel that you have met one another before. A familial bond links the two of you together as if you have known each other a lifetime before.} They place a finger on their lips and your thoughts evaporate. \"Davkul awaits us all, chosen one\".";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-3
			],
			Bravery = [
				5,
				10
			],
			Stamina = [
				0,
				10
			],
			MeleeSkill = [
				2,
				5
			],
			RangedSkill = [
				7,
				12
			],
			MeleeDefense = [
				-5,
				2
			],
			RangedDefense = [
				1,
				3
			],
			Initiative = [
				8,
				16
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		if (!this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			local actor = this.getContainer().getActor();
			local tattoo_body = actor.getSprite("tattoo_body");
			local tattoo_head = actor.getSprite("tattoo_head");

			if (this.Math.rand(1, 100) <= 50)
			{
				local body = actor.getSprite("body");
				tattoo_body.setBrush("tattoo_01_" + body.getBrush().Name);
				tattoo_body.Visible = true;
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				tattoo_head.setBrush("tattoo_01_head");
				tattoo_head.Visible = true;
			}
		}
	}

	function updateAppearance()
	{
		if (!this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			local actor = this.getContainer().getActor();
			local tattoo_body = actor.getSprite("tattoo_body");

			if (tattoo_body.HasBrush)
			{
				local body = actor.getSprite("body");
				tattoo_body.setBrush("tattoo_01_" + body.getBrush().Name);
			}
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Const.DLC.Wildmen)
		{
			r = this.Math.rand(1, 100);

			if (r <= 50)
			{
				items.equip(this.new("scripts/items/weapons/short_bow"));
				items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
			else if (r <= 80)
			{
				items.equip(this.new("scripts/items/weapons/legend_dilapitated_sling"));
			}
			else
			{
				items.equip(this.new("scripts/items/weapons/wonky_bow"));
				items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
		}
		else
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				items.equip(this.new("scripts/items/weapons/short_bow"));
			}
			else
			{
				items.equip(this.new("scripts/items/weapons/wonky_bow"));
			}

			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.leather_wraps],
			[1, ::Legends.Armor.Standard.monk_robe],
			[1, ::Legends.Armor.Standard.cultist_leather_robe]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.cultist_hood],
			[1, ::Legends.Helmet.Standard.hood],
			[1, ::Legends.Helmet.Standard.cultist_leather_hood]
		]));
	}

	function onAdded()
	{
		this.character_background.onAdded();
		this.getContainer().getActor().getFlags().add("cultist");
	}
});
