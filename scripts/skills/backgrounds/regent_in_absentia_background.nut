this.regent_in_absentia_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.regent_in_absentia";
		this.m.Name = "Regent in Absentia";
		this.m.Icon = "ui/backgrounds/background_06.png";
		this.m.BackgroundDescription = "%name% is a Regent in Absentia, choosing to spend their time with a mercenary company as opposed to in court.";
		this.m.GoodEnding = "A noble at heart, the disowned noble%person% %name% returned to %them% family. Word has it %they% kicked in the doors and demanded a royal seat. An usurper challenged %them% in combat and, well, %name% learned a lot in %them% days with the %companyname% and %they% now sits on a very, very comfortable throne.";
		this.m.BadEnding = "A %person% of nobility at heart, %name% the disowned noble%person% returned to %them% family home. Word has it an usurper arrested %them% at the gates. %Them% head currently rests on a pike with crows for a crown.";
		this.m.HiringCost = 135;
		this.m.DailyCost = 30;
		this.m.Excluded = [
			"trait.ailing",
			"trait.clubfooted",
			"trait.clumsy",
			"trait.craven",
			"trait.dastard",
			"trait.legend_double_tongued",
			"trait.fainthearted",
			"trait.legend_fear_nobles",
			"trait.fragile",
			"trait.legend_frail",
			"trait.hesitant",
			"trait.insecure",
			"trait.legend_slack",
			"trait.spartan",
			"trait.clubfooted",
			"trait.weasel"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Thick;
		this.m.IsCombatBackground = true;
		this.m.IsNoble = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Noble | this.Const.BackgroundType.Crusader;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.PerkTreeDynamic = {
			Weapon = [],
			Defense = [],
			Traits = [],
			Enemy = [],
			Class = [],
			Magic = [
				this.Const.Perks.CaptainMagicTree
			]
		}
	}

	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
 			//Female
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleMuscular;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.Icon = "ui/backgrounds/background_06.png";
	}

	function onBuildDescription()
	{
		return "{%name% is no longer disowned by %their% royal family, yet %their% allegiance is now with the %companyname%. Despite not returning home to %their% lineage, you know that deep down %they% is emboldened by the fact that %they% is back in %their% natural bloodline.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				3,
				-2
			],
			Bravery = [
				4,
				14
			],
			Stamina = [
				-10,
				-5
			],
			MeleeSkill = [
				5,
				15
			],
			RangedSkill = [
				0,
				10
			],
			MeleeDefense = [
				1,
				8
			],
			RangedDefense = [
				1,
				8
			],
			Initiative = [
				1,
				15
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/arming_sword"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/morning_star"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}


		items.equip(this.Const.World.Common.pickArmor([
			[1, "mail_shirt"],
			[1, "basic_mail_shirt"],
			[1, "mail_hauberk"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, "nasal_helmet"],
			[2, "padded_nasal_helmet"],
			[1, "nasal_helmet_with_mail"],
			[1, "legend_noble_floppy_hat"],
			[1, "legend_noble_hat"],
			[1, "legend_noble_hood"],
			[1, "legend_noble_crown"],
			[1, "mail_coif"],
			[2, ""]
		]))
	}
});
