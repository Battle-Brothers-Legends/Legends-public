this.legend_legendary_locations_check_event <- this.inherit("scripts/events/event", {
    m = {},
    function create() {
        this.m.ID = "event.legend_legendary_locations_check";
        this.m.Title = "Your friendly legendary location check";
        this.m.Cooldown = 600000 * this.World.getTime().SecondsPerDay;
        this.m.Score = 0;
        this.m.Screens.push({
            ID = "A",
            Text = "[img]gfx/ui/events/event_16.png[/img]",
            Image = "",
            List = [],
            Options = [
            {
                Text = "Understood!",
                function getResult( _event ) {
	                ::World.Flags.add("LegendsLegendaryLocationCheck");
                    return 0;
                }
            }
            ],
            function start( _event ) {
                local spawnedLocations = ::Legends.Maps.getSpawnedLegendaryLocations();
                local missingLocations = [];
                foreach(location in ::Legends.Maps.Locations) {
                    local isSpawned = false;
                    foreach(spawned in spawnedLocations) {
                        if (location.Target == spawned.m.TypeID) {
                            isSpawned = true;
                            break;
                        }
                    }
                    if(!isSpawned) {
                        missingLocations.push(location);
                    }
                }

                if(missingLocations.len() == 0) {
                    this.Text = "[img]gfx/ui/events/event_16.png[/img] All good. All locations spawned properly.";
                } else {
                    local txt = "[img]gfx/ui/events/event_16.png[/img] These locations are missing:";
                    foreach (location in missingLocations) {
                        txt = txt + "\n" + location.Name;
                    }
                    txt = txt + "\n\nIf you're not concerned about them, you can continue playing.";
                    this.Text = txt
                }

	            this.List.push({
		            id = 10,
		            icon = "ui/icons/xp_received.png",
		            text = " gains [color=%positiveEvent%]" + _value + "[/color] Experience"
	            })
            }
        });
    }

	function isValid() {
		return !::World.Flags.has("LegendsLegendaryLocationCheck");
	}

	function canFire() {
		return this.isValid();
	}
});

