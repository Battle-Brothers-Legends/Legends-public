::mods_hookExactClass("entity/world/locations/legendary/stronghold_waterskin_location", function (o) {

	o.replaceTroops <- function (_from, _to, _num) {
		for (local i = this.m.Troops.len() - 1; i >= 0 && _num > 0; i--) {
			if (this.m.Troops[i].Script == _from.Script) {
				this.m.Troops.remove(i);
				::Const.World.Common.addTroop(this, { Type = _to }, false);
				_num--;
			}
		}
	}

	local onSpawned = o.onSpawned;
	o.onSpawned = function () {
		onSpawned();
		this.replaceTroops(::Const.World.Spawn.Troops.SkeletonPriest, ::Const.World.Spawn.Troops.LegendMummyPriest, 1);
		this.replaceTroops(::Const.World.Spawn.Troops.SkeletonHeavyPolearm, ::Const.World.Spawn.Troops.LegendMummyMedium, 3);
		this.updateStrength();
	}
});
