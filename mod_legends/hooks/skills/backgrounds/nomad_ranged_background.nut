::mods_hookExactClass("skills/backgrounds/nomad_ranged_background", function(o)
{
	o.create = function ()
	{
		this.nomad_background.create();
		this.m.HiringCost = 300;
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				-3
			],
			Stamina = [
				2,
				0
			],
			MeleeSkill = [
				5,
				3
			],
			RangedSkill = [
				15,
				14
			],
			MeleeDefense = [
				5,
				3
			],
			RangedDefense = [
				6,
				5
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	o.onAdded <- function ()
	{
		this.character_background.onAdded();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendThrowSand);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/oriental/nomad_sling"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/oriental/composite_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "oriental/nomad_robe"],
			[1, "oriental/thick_nomad_robe"],
			[1, "oriental/stitched_nomad_armor"],
			[1, "oriental/leather_nomad_robe"]
		]));

		local helm = this.Const.World.Common.pickHelmet([
			[1, "oriental/nomad_head_wrap"],
			[1, "oriental/nomad_leather_cap"],
			[1, "oriental/nomad_light_helmet"]
		]);
		items.equip(helm);
	}
});