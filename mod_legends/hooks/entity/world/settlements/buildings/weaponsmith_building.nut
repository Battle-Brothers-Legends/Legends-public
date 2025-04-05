::mods_hookExactClass("entity/world/settlements/buildings/weaponsmith_building", function(o)
{
	o.onUpdateShopList = function ()
	{
		local list = [
			{
				R = 20,
				P = 1.0,
				S = "weapons/dagger"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/dagger"
			},
			{
				R = 55,
				P = 1.0,
				S = "weapons/rondel_dagger"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/boar_spear"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/fighting_spear"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/hand_axe"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/shortsword"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/shortsword"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_repair"
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
				R = 10,
				P = 1.0,
				S = "weapons/throwing_axe"
			},
			{
				R = 45,
				P = 1.0,
				S = "weapons/pike"
			},
			{
				R = 45,
				P = 1.0,
				S = "weapons/pike"
			},
			{
				R = 45,
				P = 1.0,
				S = "weapons/billhook"
			},
			{
				R = 45,
				P = 1.0,
				S = "weapons/longaxe"
			},
			{
				R = 35,
				P = 1.0,
				S = "weapons/falchion"
			},
			{
				R = 35,
				P = 1.0,
				S = "weapons/falchion"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/morning_star"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/morning_star"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/arming_sword"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/legend_parrying_dagger"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/arming_sword"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/military_cleaver"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/winged_mace"
			},
			{
				R = 55,
				P = 1.0,
				S = "weapons/fighting_axe"
			},
			{
				R = 65,
				P = 1.0,
				S = "weapons/noble_sword"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/military_pick"
			},
			{
				R = 65,
				P = 1.0,
				S = "weapons/warhammer"
			},
			{
				R = 55,
				P = 1.0,
				S = "weapons/flail"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/greatsword"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/warbrand"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/greataxe"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/two_handed_hammer"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/legend_battle_glaive"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/legend_swordstaff"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/legend_halberd"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/legend_ranged_flail"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/legend_ranged_wooden_flail"
			}
		];

		if (this.Const.DLC.Unhold)
		{
			list.extend([
				{
					R = 50,
					P = 1.0,
					S = "weapons/two_handed_wooden_hammer"
				},
				{
					R = 50,
					P = 1.0,
					S = "weapons/longsword"
				},
				{
					R = 50,
					P = 1.0,
					S = "weapons/legend_longsword"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/three_headed_flail"
				},
				{
					R = 70,
					P = 1.0,
					S = "weapons/two_handed_flail"
				},
				{
					R = 65,
					P = 1.0,
					S = "weapons/legend_reinforced_flail"
				},
				{
					R = 60,
					P = 1.0,
					S = "weapons/two_handed_wooden_flail"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/spetum"
				},
				{
					R = 60,
					P = 1.0,
					S = "weapons/polehammer"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/goedendag"
				},
				{
					R = 90,
					P = 1.0,
					S = "weapons/legend_military_goedendag"
				},
				{
					R = 90,
					P = 1.0,
					S = "weapons/legend_military_warscythe"
				},
				{
					R = 55,
					P = 1.0,
					S = "weapons/two_handed_mace"
				},
				{
					R = 40,
					P = 1.0,
					S = "weapons/legend_two_handed_club"
				},
				{
					R = 65,
					P = 1.0,
					S = "weapons/two_handed_flanged_mace"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/fencing_sword"
				},
				{
					R = 90,
					P = 1.0,
					S = "weapons/legend_estoc"
				},
				{
					R = 10,
					P = 1.0,
					S = "weapons/throwing_spear"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/battle_whip"
				},
				{
					R = 70,
					P = 1.0,
					S = "weapons/legend_cat_o_nine_tails"
				}
			]);
		}

		if (this.m.Settlement.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.7)
		{
			list.push({
				R = 70,
				P = 1.0,
				S = "weapons/bardiche"
			});
		}
		else if (this.m.Settlement.getTile().SquareCoords.Y < this.World.getMapSize().Y * 0.4)
		{
			list.push({
				R = 75,
				P = 1.0,
				S = "weapons/scimitar"
			});
			list.push({
				R = 85,
				P = 1.0,
				S = "weapons/shamshir"
			});
		}

		foreach( i in this.Const.Items.NamedMeleeWeapons )
		{
			if (this.Math.rand(1, 100) <= 30)
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
