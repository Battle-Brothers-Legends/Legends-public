::mods_hookExactClass("entity/world/settlements/buildings/kennel_building", function(o)
{
	o.onUpdateShopList = function ()
	{
		local list = [
			{
				R = 0,
				P = 1.0,
				S = "accessory/legend_wardog_item"
			},
			{
				R = 15,
				P = 1.0,
				S = "accessory/legend_wolf_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "accessory/legend_armored_wardog_item"
			},
			{
				R = 40,
				P = 1.0,
				S = "misc/wardog_armor_upgrade_item"
			}
		];

		if (this.m.Settlement.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.7)
		{
			list.push({
				R = 0,
				P = 1.0,
				S = "accessory/legend_warhound_item"
			});
			list.push({
				R = 0,
				P = 1.0,
				S = "accessory/legend_wolf_item"
			});
			list.push({
				R = 0,
				P = 1.0,
				S = "accessory/legend_armored_warhound_item"
			});
		}
		else
		{
			list.push({
				R = 0,
				P = 1.0,
				S = "accessory/legend_wardog_item"
			});
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 0.75, false);
	}
});
