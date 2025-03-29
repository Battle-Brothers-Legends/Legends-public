::mods_hookExactClass("entity/world/locations/undead_vampire_coven_location", function(o) 
{
	o.create = function ()
	{
		this.location.create();
		this.m.TypeID = "location.undead_vampire_coven";
		this.m.LocationType = this.Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.ruins";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.CombatLocation.AdditionalRadius = 5;
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.Vampires);
		}
		else if (r == 2)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.VampiresAndSkeletons);
		}
		else if (r == 3)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.Mummies);
		}

		this.m.Resources = 250;
		this.m.RoamerSpawnList = this.Const.World.Spawn.Vampires;
		this.m.NamedWeaponsList = this.Const.Items.NamedUndeadWeapons;
		this.m.NamedShieldsList = this.Const.Items.NamedUndeadShields;
	}
});