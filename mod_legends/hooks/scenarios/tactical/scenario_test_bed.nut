::mods_hookExactClass("scenarios/tactical/scenario_test_bed", function(o)
{
	o.initEntities = function ()
	{
		for( local i = 0; i < _numPlayer; i = ++i )
		{
			local x = 0;
			local y = 0;

			while (1)
			{
				x = this.Math.rand(2, 6);
				y = this.Math.rand(2, 6) - x / 2;

				if (this.Tactical.getTile(x, y).Level == 3)
				{
					continue;
				}

				if (this.Tactical.getTile(x, y).IsEmpty)
				{
					break;
				}
			}

			local entity = this.spawnEntity("scripts/entity/tactical/player", x, y);
			entity.setName(this.getRandomPlayerName());
			entity.setScenarioValues();
			local items = entity.getItems();
			local helmet = [
				[1, ::Legends.Helmet.Southern.southern_head_wrap]
			];
			items.equip(this.Const.World.Common.pickHelmet(helmet));


			local r = this.Math.rand(1, 3);
			local a = this.new("scripts/items/armor/oriental/gladiator_harness");
			local u;
			r = this.Math.rand(1, 2);

			if (r == 1)
			{
				u = this.new("scripts/items/armor_upgrades/light_gladiator_upgrade");
			}
			else if (r == 2)
			{
				u = this.new("scripts/items/armor_upgrades/heavy_gladiator_upgrade");
			}

			a.setUpgrade(u);
			items.equip(a);
			items.equip(this.new("scripts/items/weapons/oriental/firelance"));
		}

		local entity = this.spawnEntity("scripts/entity/tactical/enemies/orc_berserker");
		entity.setFaction(this.Const.Faction.Orcs);
		entity.assignRandomEquipment();
	}
});
