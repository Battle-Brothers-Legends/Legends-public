::mods_hookExactClass("entity/world/settlements/buildings/fletcher_building", function(o)
{
	o.onUpdateShopList = function ()
	{
		local list = [
			{
				R = 10,
				P = 1.0,
				S = "weapons/legend_slingshot"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/short_bow"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/legend_dilapitated_sling"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/legend_sturdy_sling"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/short_bow"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/hunting_bow"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/hunting_bow"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/war_bow"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/war_bow"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/legend_northern_sling"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/light_crossbow"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/light_crossbow"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/crossbow"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/crossbow"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/heavy_crossbow"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/heavy_crossbow"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/throwing_axe"
			},
			{
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_fletcher"
			},
			{
				R = 0,
				P = 1.0,
				S = "ammo/quiver_of_arrows"
			},
			{
				R = 0,
				P = 1.0,
				S = "ammo/quiver_of_bolts"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 40,
				P = 1.0,
				S = "ammo/legend_armor_piercing_arrows"
			},
			{
				R = 40,
				P = 1.0,
				S = "ammo/legend_broad_head_arrows"
			},
			{
				R = 40,
				P = 1.0,
				S = "ammo/legend_armor_piercing_bolts"
			},
			{
				R = 40,
				P = 1.0,
				S = "ammo/legend_broad_head_bolts"
			},
			{
				R = 70,
				P = 1.0,
				S = "ammo/large_quiver_of_bolts"
			},
			{
				R = 70,
				P = 1.0,
				S = "ammo/large_quiver_of_arrows"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/throwing_spear"
			}
		];

		foreach( i in this.Const.Items.NamedRangedWeapons )
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.25, false);
	}
});
