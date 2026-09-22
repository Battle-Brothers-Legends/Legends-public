this.legion_origin_generic_trenches_event <- this.inherit("scripts/events/events/legends/scenario/legion/legion_event", {
	m = {},

	function create() {
		this.m.ID = "event.legion_origin_generic_trenches";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 80.0 * ::World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_128.png[/img]As you cross the border of an ancient farmstead, you nearly fall into a trench. A labourer rises her head from the trench, peeking over the meridian, before returning to work silently save for the scratching of her hands against the soil.\n Further along shows a similar story — another labourer fruitlessly digging into a boulder with a shovel that has been blistered down to the shaft. From a better vantage the situation is clear, if not puzzling. A maze of trenches, palisades and bridges scour the landscape, each with labourers digging in separate, uncoordinated directions. A lashlord holds a frayed whip high, bringing it down on a labourer who has long since fallen into a pile of bones face-first in a collapsed trench.\n Further into the labyrinth the fortifications have more structure. The palisades are better maintained, the pits defensible. At the epicenter sits a collapsed tent with barely any fabric remaining, attendants stand ready with poised filthy quills at a table with a commander who is more lifeless than is to be ideal, slumped in a beaten dark oak chair over documents long since faded and ruined.\n\n The pensman turn to you in unison, then uncaringly back to their commander. Waiting for orders that will never come.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Watch your step.",
					getResult = @(_event)0
				}
			],

			function start(_event) {}
		});
	}

	function onUpdateScore() {
		if (!this.validateLegionEvent()) {
			return;
		}

		local currentTile = ::World.State.getPlayer().getTile();
		local locations = ::World.EntityManager.getLocations();
		local nearSite = false;
		foreach (v in locations) {
			if (v.getTile().getDistanceTo(currentTile) < 10) {
				nearSite = true;
				break;
			}
		}

		if (!nearSite) {
			return;
		}

		this.m.Score = 3;
	}
});
