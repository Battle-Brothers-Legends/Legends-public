::mods_hookExactClass("skills/backgrounds/nomad_ranged_background", function(o)
{
	o.create = function ()
	{
		this.nomad_background.create();
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.MaceTree,
				::Const.Perks.SpearTree,
				::Const.Perks.BowTree,
				::Const.Perks.SlingTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.ViciousTree,
				::Const.Perks.FastTree,
				::Const.Perks.AgileTree,
				::Const.Perks.DeviousTree
			],
			Enemy = [
				::Const.Perks.CivilizationTree,
				::Const.Perks.BeastTree,
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.NomadRanged);
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
			[1, ::Legends.Armor.Southern.nomad_robe],
			[1, ::Legends.Armor.Southern.thick_nomad_robe],
			[1, ::Legends.Armor.Southern.stitched_nomad_armor],
			[1, ::Legends.Armor.Southern.leather_nomad_robe]
		]));

		local helm = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.nomad_head_wrap],
			[1, ::Legends.Helmet.Southern.nomad_leather_cap],
			[1, ::Legends.Helmet.Southern.nomad_light_helmet]
		]);
		items.equip(helm);
	}
});
