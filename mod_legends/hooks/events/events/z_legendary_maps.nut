foreach(entry in [
	["events/events/location/abandoned_village_enter_event", "Victory", ::Legends.Map.AbandonedVillage],
	["events/events/dlc2/location/ancient_statue_event", "A", ::Legends.Map.AncientStatue],
	["events/events/dlc2/location/ancient_watchtower_event", "A", ::Legends.Map.AncientSpire],
	["events/events/dlc2/location/fountain_of_youth_event", "C", ::Legends.Map.GrotequeTree],
	["events/events/dlc2/location/golden_goose_event", "D", ::Legends.Map.CuriousShipWreck],
	["events/events/dlc2/location/unhold_graveyard_event", "A", ::Legends.Map.CuriousShipWreck],
	["events/events/dlc4/location/icy_cave_enter_event", "Victory", ::Legends.Map.IcyCave],
	["events/events/dlc6/location/meteorite_enter_event", "A", ::Legends.Map.FallenStar],
	["events/events/dlc6/location/oracle_enter_event", "A", ::Legends.Map.Oracle],
	["events/events/dlc6/location/sunken_library_enter_event", "Victory", ::Legends.Map.SunkenLibrary],
	["events/events/dlc6/location/vulcano_enter_event", "A", ::Legends.Map.AncientCity]
]) {
	::mods_hookExactClass(entry[0], function (o) {
		local create = o.create;
		o.create = function () {
			create();
			foreach(screen in this.m.Screens) {
				if(screen.ID == entry[1]) {
					local original = screen.start;
					screen.start = function (_event) {
						original(_event);
						::Legends.Maps.markVisited(entry[2]);
						::Legends.Maps.cleanUp();
					}
					break;
				}
			}
		}
	})
}

foreach (location in [
	"entity/world/locations/undead_vampire_coven_location",
]) {
	::mods_hookExactClass(location, function(o) {
		local onDropLootForPlayer = o.onDropLootForPlayer;
		o.onDropLootForPlayer = function (_lootTable) {
			_lootTable.push(this.new("scripts/items/misc/legend_map_legendary_item"));
			onDropLootForPlayer(_lootTable);
		}
	});
}

foreach (location in [
	"entity/world/locations/bandit_camp_location",
	"entity/world/locations/bandit_hideout_location",
	"entity/world/locations/bandit_ruins_location",
	"entity/world/locations/nomad_hidden_camp_location",
	"entity/world/locations/nomad_ruins_location",
	"entity/world/locations/nomad_tent_city_location",
	"entity/world/locations/nomad_tents_location"
]) {
	::mods_hookExactClass(location, function(o) {
		local onDropLootForPlayer = o.onDropLootForPlayer;
		o.onDropLootForPlayer = function (_lootTable) {
			if (this.Math.rand(1, 4) == 1)
				_lootTable.push(this.new("scripts/items/misc/legend_map_named_item"));
			onDropLootForPlayer(_lootTable);
		}
	});
}
