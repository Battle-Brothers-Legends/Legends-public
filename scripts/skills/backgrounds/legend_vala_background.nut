this.legend_vala_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_vala";
		this.m.Name = "Vala";
		this.m.Icon = "ui/backgrounds/legend_vala.png";
		this.m.BackgroundDescription = "A Vala is a travelling seer, shaman and sorceress.";
		this.m.GoodEnding = null;
		this.m.BadEnding = null;
		this.m.HiringCost = 20000;
		this.m.DailyCost = 24;
		this.m.Ethnicity = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.EagleEyes),
			::Legends.Traits.getID(::Legends.Trait.LegendSureshot),
			::Legends.Traits.getID(::Legends.Trait.LegendSteadyHands)
		];
		this.m.Titles = [
			"the Vala"
		];
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.BackgroundType = this.Const.BackgroundType.Female | this.Const.BackgroundType.Performing | this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Druid;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[3];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[3];
		this.m.Modifiers.Enchanting = 1.0;
		this.m.Level = 2;
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.StaffTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.SturdyTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.HealerClassTree,
				this.Const.Perks.ChefClassTree
			],
			Magic = [
				this.Const.Perks.ValaChantMagicTree,
				this.Const.Perks.ValaTranceMagicTree,
				this.Const.Perks.ValaSpiritMagicTree
			]
		};
		this.m.CustomPerkTree = [
			[],
			[],
			[],
			[],
			[],
			[],
			[],
			[],
			[],
			[],
			[]
		];
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.extend([
		{
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Most of the Vala\'s skills require her staff and scale in one way or another with the strength of her Resolve. Chants are sorcerous incantations delivered by song. These affect an area around the Vala and last until the start of her next turn. Trances are altered states entered into by the Vala. She will remain in these until her task is either completed or interrupted. Receiving damage of any kind, or becoming too fatigued to continue, will drop the Vala out of an active trance."
		},
		{
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can inscribe weapons, shields, helmets and armor provided the company has Uncut Gems."
		},
		{
			id = 14,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Experience Gain"
		}]);
		if (this.getContainer().getActor().getLevel() >= 12)
		{
			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The Vala has become a master of the intricate and lost art of inscribing signs and sigils. Increases the speed at which she can craft runes by [color=" + this.Const.UI.Color.PositiveValue + "]30%[/color]"
			});
		}

		return ret
	}

	function onBuildDescription()
	{
		return "{%name% is a travelling seer, shaman and sorceress. Besides the ability to inscribe objects with magical rune sigils she also knows sorcerous incantations in the form of chants, and can induce trance states through which she may perceive and interact with the spirit world and the spirits therein.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-1,
				2
			],
			Bravery = [
				10,
				15
			],
			Stamina = [
				8,
				12
			],
			MeleeSkill = [
				0,
				3
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				-1,
				3
			],
			RangedDefense = [
				-2,
				-4
			],
			Initiative = [
				10,
				15
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = this.Math.rand(2, 3);
		this.getContainer().getActor().fillTalentValues(2, true);

		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_staff_vala"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, "legend_vala_cloak"],
			[1, "legend_vala_dress"]
		]));
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.15;
	}
});
