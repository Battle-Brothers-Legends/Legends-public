::Const.World.Settlements.Legends_villages_coast <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/legends_fishing_village",
		function isSuitable( _terrain)
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
];
::Const.World.Settlements.Legends_villages <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/legends_fishing_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_snow_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Snow && _terrain.Adjacent[this.Const.World.TerrainType.Snow] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}

		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_tundra_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Tundra && _terrain.Adjacent[this.Const.World.TerrainType.Tundra] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_steppe_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Steppe && _terrain.Adjacent[this.Const.World.TerrainType.Steppe] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_mining_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Hills || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Snow || _terrain.Local == this.Const.World.TerrainType.Steppe) && _terrain.Adjacent[this.Const.World.TerrainType.Hills] >= 2 && _terrain.Region[this.Const.World.TerrainType.Mountains] >= 1 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_swamp_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Swamp || _terrain.Local == this.Const.World.TerrainType.Tundra) && _terrain.Adjacent[this.Const.World.TerrainType.Swamp] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_lumber_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Forest || _terrain.Local == this.Const.World.TerrainType.AutumnForest || _terrain.Local == this.Const.World.TerrainType.LeaveForest) && (_terrain.Adjacent[this.Const.World.TerrainType.Forest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.LeaveForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.SnowyForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.AutumnForest] >= 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_farming_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Plains && _terrain.Adjacent[this.Const.World.TerrainType.Plains] >= 4 && _terrain.Region[this.Const.World.TerrainType.Mountains] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
::Const.World.Settlements.Legends_fortifications <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/legends_coast_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_snow_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Snow && _terrain.Adjacent[this.Const.World.TerrainType.Snow] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_tundra_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Tundra && _terrain.Adjacent[this.Const.World.TerrainType.Tundra] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_steppe_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Steppe && _terrain.Adjacent[this.Const.World.TerrainType.Steppe] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_forest_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra) && (_terrain.Adjacent[this.Const.World.TerrainType.Forest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.LeaveForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.SnowyForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.AutumnForest] >= 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_mountains_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe || _terrain.Local == this.Const.World.TerrainType.Hills) && _terrain.Adjacent[this.Const.World.TerrainType.Hills] >= 2 && _terrain.Region[this.Const.World.TerrainType.Mountains] >= 1 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_swamp_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe || _terrain.Local == this.Const.World.TerrainType.Swamp) && _terrain.Adjacent[this.Const.World.TerrainType.Swamp] > 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_farm_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Plains && _terrain.Adjacent[this.Const.World.TerrainType.Plains] >= 4 && _terrain.Region[this.Const.World.TerrainType.Mountains] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0 && _terrain.Region[this.Const.World.TerrainType.Forest] == 0 && _terrain.Region[this.Const.World.TerrainType.AutumnForest] == 0 && _terrain.Region[this.Const.World.TerrainType.LeaveForest] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];

::Const.World.Settlements.Legends_citystates <- [
	{
		IsFlexible = true,
		Script = "scripts/entity/world/settlements/city_state",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Oasis || _terrain.Local == this.Const.World.TerrainType.Desert) && _terrain.Adjacent[this.Const.World.TerrainType.Steppe] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Plains] == 0 && _terrain.Region[this.Const.World.TerrainType.Steppe] == 0 && _terrain.Region[this.Const.World.TerrainType.Plains] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];