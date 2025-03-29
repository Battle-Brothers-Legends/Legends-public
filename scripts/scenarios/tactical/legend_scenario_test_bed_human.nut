this.legend_scenario_test_bed_human <- this.inherit("scripts/scenarios/tactical/scenario_template", {
	m = {},
	function generate()
	{
		this.logDebug("ScenarioTestBed::generate()");
		this.createStash();
		this.initMap();
		this.initEntities(6, 1);
		this.initStash();
		local weather = this.Tactical.getWeather();
		this.Tactical.getCamera().Level = 0;
	}

	function initMap()
	{
		local testMap = this.MapGen.get("tactical.tundra");
		local minX = testMap.getMinX();
		local minY = testMap.getMinY();
		this.Tactical.resizeScene(minX, minY);
		testMap.fill({
			X = 0,
			Y = 0,
			W = minX,
			H = minY
		}, null);
		this.MapGen.get("tactical.human_camp").fill({
			X = 0,
			Y = 0,
			W = minX,
			H = minY
		}, null);
	}

	function initEntities( _numPlayer, _numEnemy )
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
			items.equip(this.new("scripts/items/armor/werewolf_hide_armor"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			items.equip(this.new("scripts/items/weapons/greataxe"));
			items.equip(this.new("scripts/items/accessory/legend_wardog_item"));
			items.equip(this.new("scripts/items/shields/wooden_shield"));
			local r = this.Math.rand(0, 2);
			local items = entity.getItems();
		}

		local entity = this.spawnEntity("scripts/entity/tactical/enemies/orc_berserker");
		entity.setFaction(this.Const.Faction.Orcs);
		entity.assignRandomEquipment();
	}

	function spawnEntity( _script, _minX = 10, _maxX = 28, _minY = 3, _maxY = 28 )
	{
		local x = 0;
		local y = 0;

		while (1)
		{
			x = this.Math.rand(_minX, _maxX);
			y = this.Math.rand(_minY, _maxY) - x / 2;

			if (this.Tactical.getTile(x, y).Level == 3)
			{
				continue;
			}

			if (this.Tactical.getTile(x, y).IsEmpty)
			{
				break;
			}
		}

		return this.Tactical.spawnEntity(_script, x, y);
	}

	function initStash()
	{
		this.Stash.clear();
		this.Stash.resize(63);
		this.Stash.setLocked(true);
	}

});

