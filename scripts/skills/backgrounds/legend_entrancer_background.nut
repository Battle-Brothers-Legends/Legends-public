this.legend_entrancer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_entrancer";
		this.m.Icon = "ui/backgrounds/background_wizard_2.png";
		local r = this.Math.rand(0, 3);
		this.m.Name = "Entrancer";
		this.m.HiringCost = 1000;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty)
		];
		this.m.Titles = [
			"Glass Eyed",
			"the Distant",
			"Dream Walker",
			"the Possessed",
			"the Dreamer",
			"the Haunted"
		];
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.BackgroundType = this.Const.BackgroundType.Female | this.Const.BackgroundType.Performing | this.Const.BackgroundType.Druid;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[0];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[0];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[0];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[0];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[0];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[0];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[0];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[0];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[0];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[0];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[0];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[0];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[0];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.HammerTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.FlailTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.CalmTree
			],
			Enemy = [],
			Class = [],
			Magic = [this.Const.Perks.ValaTranceMagicTree]
		}
	}



	function onBuildDescription()
	{
		return "{%name% appears distant, barely concious of the outside world. There is a whole universe unfolding behind those eyes, and at times the trance drives limbs to move and utterances to spill forth.  It can be unerving, but at times the serenity of it all soothes you and draws you into the trance state. }";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "legend_herbalist_robe"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"]
		]));

	}
});

