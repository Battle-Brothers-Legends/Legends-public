this.legend_gladiator_prizefighter_background <- this.inherit("scripts/skills/backgrounds/gladiator_background", {
	m = {},
	function create()
	{
		this.gladiator_background.create();
		this.m.Name = "Gladiator Prizefighter";
		this.m.BackgroundDescription = "Gladiator Prizefighters cost a lot of coin, but their time exchanging punches in the arena has made them tough as nails and fit as a butcher\'s dog.";
		this.m.HiringCost = 550; // higher to offset the cheaper gear

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.FistsTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.SturdyTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.BeastClassTree
			],
			Magic = []
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				14,
				15
			],
			Bravery = [
				5,
				5
			],
			Stamina = [
				10,
				15
			],
			MeleeSkill = [
				9,
				11
			],
			RangedSkill = [
				3,
				6
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				0,
				3
			],
			Initiative = [
				5,
				8
			]
		};
		return c;
	}

	function getTooltip ()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]5%[/color] bonus damage to [color=#400080]Hand to Hand[/color] and [color=#400080]Choke[/color]"
		})
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendChoke) || _skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand))
		{
			_properties.DamageTotalMult *= 1.05;
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		local a = this.Const.World.Common.pickArmor([
			[1, "oriental/gladiator_harness"]
		]);

		r = this.Math.rand(1, 5);
		if (r <= 1)
			items.equip(this.new("scripts/items/weapons/oriental/qatal_dagger"));
		r = this.Math.rand(1, 5);
		if (r <= 1)
			items.equip(this.new("scripts/items/tools/throwing_net"));

		a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));
		items.equip(a);

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "oriental/gladiator_helmet", this.Math.rand(13, 15)],
			[1, ""]
		]));

		this.getContainer().getActor().getItems().equip(this.new("scripts/items/accessory/legend_cestus_item"));

	}
});
