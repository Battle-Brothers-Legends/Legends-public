this.legend_crusader_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_crusader";
		this.m.Name = "Holy Crusader";
		this.m.Icon = "ui/backgrounds/background_60.png";
		this.m.HiringCost = 20000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.hate_greenskins",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.paranoid",
			"trait.night_blind",
			"trait.swift",
			"trait.ailing",
			"trait.brute",
			"trait.bloodthirsty",
			"trait.greedy",
			"trait.gluttonous",
			"trait.dumb",
			"trait.clubfooted",
			"trait.irrational",
			"trait.hesitant",
			"trait.disloyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure",
			"trait.asthmatic"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.All;
		this.m.Body = "bust_naked_body_01";
		this.m.Level = 2;
		this.m.IsCombatBackground = true;
		this.m.IsOffendedByViolence = true;
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
		return "%name% lives to fight the undead scourge. Little is known about him and he almost never talks save for the occasional grunt while swinging his sword. His language seems to be codified into one simple structure: killing creatures of evil.";
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

		if (this.Math.rand(1, 100) <= 25)
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
				5,
				5
			],
			Bravery = [
				10,
				10
			],
			Stamina = [
				15,
				15
			],
			MeleeSkill = [
				15,
				15
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				20,
				20
			],
			RangedDefense = [
				-5,
				-5
			],
			Initiative = [
				-5,
				-5
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Crusader");
		this.m.Container.add(this.new("scripts/skills/perks/perk_rebound"));
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_roster_1"));
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeDefense] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 2;
		local items = this.getContainer().getActor().getItems();
		local stash =this.World.Assets.getStash()
		local r;
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		stash.add(this.new("scripts/items/supplies/armor_parts_item"));
		stash.add(this.new("scripts/items/supplies/medicine_item"));
		stash.add(this.new("scripts/items/supplies/cured_venison_item"));
		items.equip(this.new("scripts/items/weapons/legend_crusader_sword"));;
		items.equip(this.new("scripts/items/armor/legend_crusader_armor"));
		items.equip(this.new("scripts/items/helmets/closed_flat_top_helmet"));
	
	}

});
