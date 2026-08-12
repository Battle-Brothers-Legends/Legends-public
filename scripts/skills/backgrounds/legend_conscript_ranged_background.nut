this.legend_conscript_ranged_background <- this.inherit("scripts/skills/backgrounds/legend_conscript_background", {
	m = {},
	function create()
	{
		this.legend_conscript_background.create();
		this.m.Name = "Conscript Gunner";
		this.m.Icon = "ui/backgrounds/background_ranged_conscript.png";
		this.m.DailyCostMult = 1.0;
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendConscriptRanged);
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

