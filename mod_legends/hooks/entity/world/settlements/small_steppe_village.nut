::mods_hookExactClass("entity/world/settlements/small_steppe_village", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		if (this.World.Assets.getOrigin().getID() == "scenario.legends_nomad") {
			this.m.DraftList.push(::Legends.Background.Nomad);
			this.m.DraftList.push(::Legends.Background.NomadRanged);
		}
	}
});
