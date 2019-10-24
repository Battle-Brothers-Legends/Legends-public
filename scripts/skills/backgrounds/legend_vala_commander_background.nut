this.legend_vala_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_vala";
		this.m.Name = "Vala";
		this.m.Icon = "ui/backgrounds/legend_vala.png";
		this.m.BackgroundDescription = "A Vala is a travelling seer, shaman and sorceress.";
		this.m.GoodEnding = null;
		this.m.BadEnding = null;
		this.m.HiringCost = 240;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.clumsy",
			"trait.cocky",
			"trait.craven",
			"trait.dastard",
			"trait.fainthearted",
			"trait.insecure",
			"trait.disloyal",
			"trait.loyal"
		];
		this.m.Titles = [
			"the Vala"
		];
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Body = this.Const.Bodies.AllFemale[this.Math.rand(0, this.Const.Bodies.AllFemale.len() - 1)];
		this.m.IsFemaleBackground = true;
		this.m.IsUntalented = true;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[3];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[3];
		this.m.Modifiers.Enchanting = 1.0;
		this.m.Level = 2;

		if (!this.Const.LegendMod.Configs.LegendMagicEnabled())
		{
			this.m.CustomPerkTree = [
			[
				this.Const.Perks.PerkDefs.NineLives,
				this.Const.Perks.PerkDefs.Pathfinder,
				this.Const.Perks.PerkDefs.Recover,
				this.Const.Perks.PerkDefs.Student,
				this.Const.Perks.PerkDefs.LegendValaInscribeShield,
				this.Const.Perks.PerkDefs.LegendRoster1
			],
			[
				this.Const.Perks.PerkDefs.LegendValaTranceMalevolent,
				this.Const.Perks.PerkDefs.FastAdaption,
				this.Const.Perks.PerkDefs.Colossus,
				this.Const.Perks.PerkDefs.FortifiedMind,
				this.Const.Perks.PerkDefs.Backstabber,
				this.Const.Perks.PerkDefs.LegendRoster2
			],
			[
				this.Const.Perks.PerkDefs.LegendValaChantSenses,
				this.Const.Perks.PerkDefs.LegendValaPremonition,
				this.Const.Perks.PerkDefs.RallyTheTroops,
				this.Const.Perks.PerkDefs.HoldOut,
				this.Const.Perks.PerkDefs.LegendValaInscribeHelmet,
				this.Const.Perks.PerkDefs.LegendRoster3
			],
			[
				this.Const.Perks.PerkDefs.LegendValaChantMastery,
				this.Const.Perks.PerkDefs.LegendValaTranceMastery,
				this.Const.Perks.PerkDefs.LegendAlert,
				this.Const.Perks.PerkDefs.LegendValaInscriptionMastery
			],
			[
				this.Const.Perks.PerkDefs.LegendValaChantDisharmony,
				this.Const.Perks.PerkDefs.LegendValaInscribeArmor,
				this.Const.Perks.PerkDefs.LegendRoster4
			],
			[
				this.Const.Perks.PerkDefs.LegendValaThreads,
				this.Const.Perks.PerkDefs.LegendMindOverBody,
				this.Const.Perks.PerkDefs.LegendRoster5
			],
			[
				this.Const.Perks.PerkDefs.LegendValaChantFury,
				this.Const.Perks.PerkDefs.LegendValaInscribeWeapon,
				this.Const.Perks.PerkDefs.LegendFieldTriage,
				this.Const.Perks.PerkDefs.PerfectFocus,
				this.Const.Perks.PerkDefs.LegendRoster6
			],
			[],
			[],
			[],
			[]
		];
		}
		else
		{
			this.m.CustomPerkTree = [
			[
				this.Const.Perks.PerkDefs.LegendValaWarden,
				this.Const.Perks.PerkDefs.NineLives,
				this.Const.Perks.PerkDefs.Pathfinder,
				this.Const.Perks.PerkDefs.Recover,
				this.Const.Perks.PerkDefs.Student,
				this.Const.Perks.PerkDefs.LegendValaInscribeShield,
				this.Const.Perks.PerkDefs.LegendRoster1
			],
			[
				this.Const.Perks.PerkDefs.LegendValaTranceMalevolent,
				this.Const.Perks.PerkDefs.FastAdaption,
				this.Const.Perks.PerkDefs.Colossus,
				this.Const.Perks.PerkDefs.FortifiedMind,
				this.Const.Perks.PerkDefs.Backstabber,
				this.Const.Perks.PerkDefs.LegendRoster2
			],
			[
				this.Const.Perks.PerkDefs.LegendValaChantSenses,
				this.Const.Perks.PerkDefs.LegendValaPremonition,
				this.Const.Perks.PerkDefs.RallyTheTroops,
				this.Const.Perks.PerkDefs.HoldOut,
				this.Const.Perks.PerkDefs.LegendValaInscribeHelmet,
				this.Const.Perks.PerkDefs.LegendRoster3
			],
			[
				this.Const.Perks.PerkDefs.LegendValaChantMastery,
				this.Const.Perks.PerkDefs.LegendValaTranceMastery,
				this.Const.Perks.PerkDefs.LegendAlert,
				this.Const.Perks.PerkDefs.LegendValaInscriptionMastery
			],
			[
				this.Const.Perks.PerkDefs.LegendValaChantDisharmony,
				this.Const.Perks.PerkDefs.LegendValaInscribeArmor,
				this.Const.Perks.PerkDefs.LegendRoster4
			],
			[
				this.Const.Perks.PerkDefs.LegendValaThreads,
				this.Const.Perks.PerkDefs.LegendValaSpiritualBond,
				this.Const.Perks.PerkDefs.LegendMindOverBody,
				this.Const.Perks.PerkDefs.LegendRoster5
			],
			[
				this.Const.Perks.PerkDefs.LegendValaChantFury,
				this.Const.Perks.PerkDefs.LegendValaInscribeWeapon,
				this.Const.Perks.PerkDefs.LegendFieldTriage,
				this.Const.Perks.PerkDefs.PerfectFocus,
				this.Const.Perks.PerkDefs.LegendRoster6
			],
			[],
			[],
			[],
			[]
		];
		}

	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onBuildDescription()
	{
		return "{%name% is a travelling seer, shaman and sorceress. Besides the ability to inscribe objects with magical rune sigils she also knows sorcerous incantations in the form of chants, and can induce trance states through which she may perceive and interact with the spirit world and the spirits therein.}";
	}


	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [-4, -6],
			Bravery = [10, 15],
			Stamina = [8, 12],
			MeleeSkill = [-2, -3],
			RangedSkill = [0, 0],
			MeleeDefense = [0, 0],
			RangedDefense = [0, 0],
			Initiative = [6, 9]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setName(this.Const.Strings.CharacterNamesFemaleNorse[this.Math.rand(0, this.Const.Strings.CharacterNamesFemaleNorse.len() - 1)]);
		actor.setTitle("the Vala");
		this.m.Container.add(this.new("scripts/skills/traits/loyal_trait"));
		this.m.Container.add(this.new("scripts/skills/perks/legend_vala_information"));
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_roster_1"));
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = this.Math.rand(2, 3);
		this.getContainer().getActor().fillTalentValues(2, true);

		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_staff_vala"));
		local r = this.Math.rand(0, 1);
		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/legend_vala_cloak"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/legend_vala_dress"));
		}
	}

	function onAddLegendEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = this.Math.rand(2, 3);
		this.getContainer().getActor().fillTalentValues(2, true);

		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_staff_vala"));

		local r = this.Math.rand(0, 1);
		if (r == 0)
		{
			items.equip(this.new("scripts/items/legend_armor/armor/legend_armor_vala_cloak"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/legend_armor/armor/legend_armor_vala_dress"));
		}
	}
});
