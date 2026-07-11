this.legion_origin_generic_deathspiral_event <- this.inherit("scripts/events/event", {
	m = {},

	function create()
	{
		this.m.ID = "event.legion_origin_generic_deathspiral";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 80.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({ //—
			ID = "A",
			Text = "[img]gfx/ui/events/event_101.png[/img]As you approach a slope, a strange sight unfolds — hundreds of muddle around a black monolith much smaller than the one you are already familiar with. Crowds of auxiliaries, labourers and unidentifiable legionaries circle the monument like ants in a deathspiral.\n Many are physically broken, hobbling along after what must be years of walking in circles. The less fortunate are crushed underfoot, still attempting to crawl in the hypnotic pattern. Given time, the rest of the structure may be uncovered purely by the unknowning toil of those it has drawn in.\n\n For the briefest of moments, you are drawn to it — even at this distance. The hum is quiet, yet soothing.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Maybe this will be us one day...",
					function getResult( _event )
					{
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		//see 'static_fucntions' ::Legends.S.humansOnly for more details.
		if (::World.Assets.getOrigin().getID() != "scenario.legend_risen_legion") {
			return;
		}

		local hasSkeleton = false;
		foreach (bro in ::World.getPlayerRoster().getAll()) {
    		if (bro.getFlags().has("PlayerSkeleton")) {
				hasSkeleton = true;
				break;
			}
		}

		if (!hasSkeleton) {
    		return; 
		}

		local locations = this.World.EntityManager.getLocations();
		local nearSite = false;
		foreach( v in locations )
		{
			if (v.getTile().getDistanceTo(currentTile) < 14)
			{
				nearSite = true;
				break;
			}
		}

		if (!nearSite)
		{
		 return;
		}

		this.m.Score = 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

