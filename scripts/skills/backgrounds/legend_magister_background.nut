this.legend_magister_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_magister";
		this.m.Name = "Magister";
		this.m.Icon = "ui/backgrounds/background_magister.png";
		this.m.BackgroundDescription = "Magisters are a unique breed of insane. While among the ranks of the insane preside over, their quiet madness eclipses all and causes the rest to fall in line.";
		this.m.GoodEnding = "The cultist, %name%, left the company with a band of cloaked converts. You know not what became of the fanatic, but every so often they appear in your dreams. Often standing alone in a great void and there is always someone, or something, lingering in the black beyond. Every night, this image gets a little more clear, and each night you find yourself staying up later and later just to avoid dreaming at all.";
		this.m.BadEnding = "You heard that %name%, the cultist, left the company at some juncture and went out to spread the faith. There\'s no telling what became of the fanatic, but there was a recent inquisition against unholy faiths and hundreds of \'folk in dark cloaks with even darker intentions\' were burned at the stake across the realm.";
		this.m.HiringCost = 250;
		this.m.DailyCost = 27;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
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
		this.m.Level = this.Math.rand(2, 3);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.BackgroundType = this.Const.BackgroundType.Cultist | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[3];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CleaverTree,
				this.Const.Perks.FlailTree,	
				this.Const.Perks.SlingTree,	
				this.Const.Perks.SwordTree,						
				this.Const.Perks.StaffTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.CalmTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.InspirationalTree
			],
			Enemy = [
				this.Const.Perks.CaravanTree,
				this.Const.Perks.NoblesTree
			],
			Class = [
				this.Const.Perks.NinetailsClassTree,
				this.Const.Perks.SickleClassTree,
				this.Const.Perks.HealerClassTree
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

	function getTooltip()
	{
		local ret = this.character_background.getTooltip()
		ret.push(
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will never be sacrificed to Davkul"
			}
		)
		return ret
	}

	function onBuildDescription()
	{
		return "{Magisters are a conduit of evil in the world, seemingly sucking up all the suffering around them and directing it upon whoever they please.} {%name% is wreathed in fabrics that seem to obey a differant set of rules to the rest of the world. | %name% occasionally turns their head as if an unseen force was whispering to them, nodding and whispering back to the unseen force in kind, almost as if affirming their own madness. | %name% whispers into their weapon and nods in agreement with it, almost as if conversing with a long lost friend. | The stranger tracks and nods towards unseen figures like a ringmaster for a ghostly parade. | The look in the eyes of %name% reveals little, aside from the fact that the more you look at them the more you notice the irregularaties, having a smaller, second pupil for instance. | They stand with a a crooked posture, as if holding up a heavy and unseen burden.} \"Davkul awaits us all\" %name% parrots. You are not certain, but you feel a second voice repeat those words in unison from deep inside your mind.";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				5
			],
			Bravery = [
				15,
				25
			],
			Stamina = [
				-4,
				6
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				5,
				8
			],
			MeleeDefense = [
				-2,
				5
			],
			RangedDefense = [
				2,
				5
			],
			Initiative = [
				-5,
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
			items.equip(this.new("scripts/items/weapons/legend_tipstaff"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_reinforced_flail"));
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

