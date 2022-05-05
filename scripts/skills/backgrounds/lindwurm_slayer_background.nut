this.lindwurm_slayer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.lindwurm_slayer";
		this.m.Name = "Lindwurm Slayer";
		this.m.Icon = "ui/backgrounds/background_71.png";
		this.m.DailyCost = 28;
		this.m.Excluded = [
			"trait.ailing",
			"trait.asthmatic",
			"trait.bleeder",
			"trait.bright",
			"trait.clubfooted",
			"trait.clumsy",
			"trait.craven",
			"trait.dastard",
			"trait.disloyal",
			"trait.double_tongued",
			"trait.fainthearted",
			"trait.fragile",
			"trait.frail",
			"trait.fear_beasts",
			"trait.greedy",
			"trait.hate_greenskins",
			"trait.hate_undead",
			"trait.hesitant",
			"trait.impatient",
			"trait.insecure",
			"trait.irrational",
			"trait.night_blind",
			"trait.pessimist",
			"trait.slack",
			"trait.team_player",
			"trait.weasel"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[3];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
	}

	//Default Male
	function setGender(_gender = -1)
	{
		local r = _gender;
		if (_gender == -1)
		{
			r = 0;
			if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled")
			{
				r = this.Math.rand(0, 1);
			}
		}

		if (r == 0)
		{
			return;
		}
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 1;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
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
		return "";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				6,
				3
			],
			Bravery = [
				12,
				10
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				8,
				8
			],
			RangedSkill = [
				10,
				8
			],
			MeleeDefense = [
				5,
				4
			],
			RangedDefense = [
				-3,
				-3
			],
			Initiative = [
				8,
				12
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/fighting_spear"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/noble_sword"));
		}
		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			items.equip(this.new("scripts/items/shields/buckler_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "mail_hauberk"],
			[1, "leather_scale_armor"],
			[1, "noble_mail_armor"],
			[1, "light_scale_armor"],
			[1, "footman_armor"],
			[1, "reinforced_mail_hauberk"]
		]));

		local helm = [
			[1, "feathered_hat"],
			[1, "headscarf"],
			[1, "mail_coif"],
			[1, "greatsword_hat"]
		];

		items.equip(this.Const.World.Common.pickHelmet(helm));
	}

});

