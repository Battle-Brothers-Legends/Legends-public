this.legend_conscript_ranged_background <- this.inherit("scripts/skills/backgrounds/legend_conscript_background", {
	m = {},
	function create()
	{
		this.legend_conscript_background.create();
		this.m.Name = "Conscript Gunner";
		this.m.Icon = "ui/backgrounds/background_ranged_conscript.png";
		this.m.HiringCost = 100; //this is less than normal (300) because the handgonne is 3k value and that is being added to the recruit cost along with other equipment. Combined with extra levels and other recruiting rules they are being generated with a ~20k hire cost.
		this.m.DailyCost = 35;
		this.m.DailyCostMult = 1.0;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.SlingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.TrainedTree
			],
			Enemy = [
				this.Const.Perks.ArcherTree
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				8,
				8
			],
			Bravery = [
				6,
				2
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				5,
				3
			],
			RangedSkill = [
				15,
				12
			],
			MeleeDefense = [
				2,
				0
			],
			RangedDefense = [
				6,
				8
			],
			Initiative = [
				10,
				10
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendThrowSand);
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/oriental/saif"));
		}

		items.equip(this.new("scripts/items/weapons/oriental/handgonne"));
		items.equip(this.new("scripts/items/ammo/powder_bag"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.padded_vest]
		]));
		local helm = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.nomad_head_wrap],
			[1, ::Legends.Helmet.Southern.gunner_hat],
			[1, ::Legends.Helmet.None]
		]);
		items.equip(helm);
	}
});

