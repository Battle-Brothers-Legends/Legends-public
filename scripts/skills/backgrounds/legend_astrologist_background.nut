this.legend_astrologist_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_astrologist";
		this.m.Icon = "ui/backgrounds/background_astrologist.png";
		this.m.Name = "Astrologist";
		this.m.HiringCost = 150;
		this.m.DailyCost = 10;
		this.m.Excluded = [];
		this.m.Titles = [
			"the Surveyer",
			"the Science Guy"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Body = "bust_naked_body_01";
		this.m.Level = 1;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMin;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.StavesTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree
			],
			Enemy = [],
			Class = [],
			Magic = [this.Const.Perks.PremonitionMagicTree]
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
		return "{There is no description Mwah doesn\'t have any real thoughts in his head unlike this super cool Astrologist. Please understand! He\'s checking out Uranus haha}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
                0
			],
			Bravery = [
				0,
				10
			],
			Stamina = [
				-5,
				0
			],
			MeleeSkill = [
				-10,
				5
			],
			RangedSkill = [
				-10,
				10
			],
			MeleeDefense = [
				-5,
				-5
			],
			RangedDefense = [
				5,
				5
			],
			Initiative = [
				-5,
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		// local talents = this.getContainer().getActor().getTalents();
		// talents.resize(this.Const.Attributes.COUNT, 0);
		// talents[this.Const.Attributes.Bravery] = 3;
		// this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "legend_seer_hat"],
			[1, "magician_hat"]
		]));
		items.equip(this.new("scripts/items/armor/thick_dark_tunic"));
		items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
		local stash = this.World.Assets.getStash()
	}

	function onAddLegendEquipment()
	{
		// local talents = this.getContainer().getActor().getTalents();
		// talents.resize(this.Const.Attributes.COUNT, 0);
		// talents[this.Const.Attributes.Bravery] = 3;
		// this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "legend_seer_hat"],
			[1, "magician_hat"]
		]));
		items.equip(this.new("scripts/items/legend_armor/cloth/legend_dark_tunic"));
		items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
		local stash = this.World.Assets.getStash()
	}

});
