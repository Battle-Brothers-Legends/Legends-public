this.cultist_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.cultist";
		this.m.Name = "Cultist";
		this.m.Icon = "ui/backgrounds/background_34.png";
		this.m.BackgroundDescription = "Cultists have a resolve to spread further their cult that is second to few.";
		this.m.GoodEnding = "The cultist, %name%, left the company with a band of cloaked converts. You know not what became of the fanatic, but every so often they appear in your dreams. Often standing alone in a great void and there is always someone, or something, lingering in the black beyond. Every night, this image gets a little more clear, and each night you find yourself staying up later and later just to avoid dreaming at all.";
		this.m.BadEnding = "You heard that %name%, the cultist, left the company at some juncture and went out to spread the faith. There\'s no telling what became of the fanatic, but there was a recent inquisition against unholy faiths and hundreds of \'folk in dark cloaks with even darker intentions\' were burned at the stake across the realm.";
		this.m.HiringCost = 50;
		this.m.DailyCost = 7;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
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
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed)
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
		this.m.BackgroundType = this.Const.BackgroundType.Cultist | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CleaverTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.SlingTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [
				this.Const.Perks.CaravanTree,
				this.Const.Perks.NoblesTree
			],
			Class = [
				this.Const.Perks.NinetailsClassTree,
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
		return "{The cultist stands with a placard hanging from their neck. | Their face is wreathed in garish tattoos. They carry a note. | The face is hidden inside a deep cowl, an islanded tip of a nose all that you see in the darkness. They carry a placard around their neck. | Clothed in rags, it is strange they neither sweat nor shake in heat or cold. Clutching a scroll as if it protects from the very elements. | Scripture is written across their arm in scars, the coda of madness. | The stranger writes in the dirt as quick as someone who has done it a thousand times. The message is clear to see. | They stand with a tome nestled behind a crooked arm. They hand it to you. Opening it, the leather feels like none you\'ve ever touched before. There is only one passage inside, written over and over.} It reads: \"Ph\'nglui mglw\'nafh Davkul R\'lyeh wgah\'nagl fhtagn. Nn\'nilgh\'ri, nn\'nglui. Sgn\'wahl sll\'ha ep\'shogg.\" Hmm... quaint.";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-3,
				5
			],
			Bravery = [
				15,
				20
			],
			Stamina = [
				-2,
				8
			],
			MeleeSkill = [
				-5,
				5
			],
			RangedSkill = [
				-5,
				5
			],
			MeleeDefense = [
				-5,
				5
			],
			RangedDefense = [
				-5,
				5
			],
			Initiative = [
				0,
				5
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
		r = this.Math.rand(0, 8);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_scythe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 4)
		{
			if (this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/battle_whip"));
			}
			else if (!this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
			}
		}
		else if (r >= 5)
		{
		 items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "tattered_sackcloth"],
			[1, "leather_wraps"],
			[1, "monk_robe"],
			[1, "cultist_leather_robe"]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "cultist_hood"],
			[1, "hood"],
			[1, "cultist_leather_hood"]
		]));
	}

	function onAdded()
	{
		this.character_background.onAdded();
		this.getContainer().getActor().getFlags().add("cultist");
	}
});

