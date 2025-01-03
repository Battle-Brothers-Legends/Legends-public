this.legend_dervish_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_dervish";
		this.m.Name = "Dervish";
		this.m.Icon = "ui/backgrounds/background_dervish.png";
		this.m.BackgroundDescription = "The dervish is a religious background that enters an almost trance-like state in combat.";
		this.m.GoodEnding = "Although the life of excess was not the way of the dervish, %name% took the money given to them and set it aside, accumulating a Vizier\'s fortune of crowns. %name% donated this money to local widows and shelters for the poor before selling what they were wearing and wandering back into the streets, just as they were found.";
		this.m.BadEnding = "The life of a mercenary sated the brutal needs of %name%, but allowed their spiritual nature to become corrupt and twisted. %name% turned to a life of mercenary work fully, becoming greedy and dining on the pleasures of excess. In turn they made many enemies and disgusted their former peers. Through unknown methods %name% was found poisoned a few seasons later.";
		this.m.HiringCost = 140;
		this.m.DailyCost = 14;
		this.m.Excluded = [
			"trait.bleeder",
			"trait.ailing",
			"trait.fragile",
			"trait.gluttonous",
			"trait.legend_frail",
			"trait.legend_light",
			"trait.dumb",
			"trait.legend_seductive"
		];
		this.m.ExcludedTalents = [];
		// this.m.IsGuaranteed = ["tough_trait"]
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.BeardChance = 50;
		this.m.Ethnicity = 1;
		this.m.BackgroundType = this.Const.BackgroundType.Combat;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[3];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.CleaverTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.ClothArmorTree
			],
			Traits = [ //lf 5
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.IntelligentTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.HealerClassTree,
				this.Const.Perks.FaithClassTree
			],
			Magic = []
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				15,
				25
			],
			Bravery = [
				15,
				20
			],
			Stamina = [
				10,
				14
			],
			MeleeSkill = [
				6,
				10
			],
			RangedSkill = [
				0,
				3
			],
			MeleeDefense = [
				-3,
				2
			],
			RangedDefense = [
				-2,
				-2
			],
			Initiative = [
				10,
				16
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Dervish");
	}

	function onBuildDescription()
	{
		return "{%name% is a mixed character - you have never seen someone so violent yet so calm at the same time. | %name% says it is down to years of training and prayer that steadies the commitment of a person - however you suspect that the reason is more animalistic and simple than they let on.}{The dedication and aggression from %name% dwarfs that of the monks in the north. | %name% sleeps under the overhang of a market stall and walks the city during the daytime, often in bare feet and dressed in little more than rags. | This spartan martial lifestyle has left %name% with a strong body and a stronger mind. | Their sanity is still up for debate however. }{When you first heard of %name% they sounded like your typical mercenary - loud, strong and an unhealthy interest in all things that could kill a man. | Upon closer inspection they seem more alike a zealous beggar than anything else - dressed in shabby clothing and preaching wherever they go. }{%name% speaks, acts, eats, sleeps and a manner of other things as any religious southerner would do. | However their demeanour changes significantly whenever you put a weapon in their hand, showing a combination of ornate flourishes that seem more like a dance than a practical combat style. | While it would take the eye out of any man or creature close enough, their resolve is above and beyond their peers.}";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local armor = this.Const.World.Common.pickArmor([
			[1, "oriental/cloth_sash"]
		]);
		items.equip(armor);
		local helm = this.Const.World.Common.pickHelmet([
			[2, "oriental/southern_head_wrap"],
			[1, "legend_noble_southern_hat"],
			[3, ""]
		]);
		items.equip(helm)
	}
});

