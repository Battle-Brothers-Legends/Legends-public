::Legends.Map <- {};
::Legends.Maps <- {
	Type = {
		Legendary = "misc.legend_map_legendary",
		Named = "misc.legend_map_named"
	}
	Locations = []
	add = function(_id, _name) {
		this.Locations.push({
			Target = _id,
			Name = _name
		});
		return this.Locations.top();
	}
}

// vanilla locations
::Legends.Map.AncientStatue <- ::Legends.Maps.add("location.ancient_statue", "Ancient Statue");
::Legends.Map.AncientTemple <- ::Legends.Maps.add("location.ancient_temple", "Ancient Temple");
::Legends.Map.AncientSpire <- ::Legends.Maps.add("location.ancient_watchtower", "Ancient Spire");
::Legends.Map.BlackMonolith <- ::Legends.Maps.add("location.black_monolith", "Black Monolith");
::Legends.Map.GrotequeTree <- ::Legends.Maps.add("location.fountain_of_youth", "Grotesque Tree");
::Legends.Map.IcyCave <- ::Legends.Maps.add("location.icy_cave_location", "Icy Cave");
::Legends.Map.StonePillars <- ::Legends.Maps.add("location.kraken_cult", "Stone Pillars");
::Legends.Map.CuriousShipWreck <- ::Legends.Maps.add("location.land_ship", "Curious Ship Wreck");
::Legends.Map.SunkenLibrary <- ::Legends.Maps.add("location.sunken_library", "Sunken Library");
::Legends.Map.HuntingGround <- ::Legends.Maps.add("location.tundra_elk_location", "Hunting Ground");
::Legends.Map.UnholdGraveyard <- ::Legends.Maps.add("location.unhold_graveyard", "Unhold Graveyard");
::Legends.Map.GoblinCity <- ::Legends.Maps.add("location.goblin_city", "Rul\'gazhix");
::Legends.Map.WaterMill <- ::Legends.Maps.add("location.waterwheel", "Watermill");
::Legends.Map.WitchHut <- ::Legends.Maps.add("location.witch_hut", "Witch Hut");
::Legends.Map.FallenStar <- ::Legends.Maps.add("location.holy_site.meteorite", "The Fallen Star");
::Legends.Map.Oracle <- ::Legends.Maps.add("location.holy_site.oracle", "The Oracle");
::Legends.Map.AncientCity <- ::Legends.Maps.add("location.holy_site.vulcano", "The Ancient City");
::Legends.Map.AbandonedVillage <- ::Legends.Maps.add("location.abandoned_village", "Abandoned Village");

// legends locations
::Legends.Map.AncientMastaba <- ::Legends.Maps.add("location.legend_mummy", "Ancient Mastaba");
// ::Legends.Map.Tournament <- ::Legends.Maps.add("location.legend_tournament", "Tournament");
//::Legends.Map.TeeteringTower <- ::Legends.Maps.add("location.legend_wizard_tower","Teetering Tower");
