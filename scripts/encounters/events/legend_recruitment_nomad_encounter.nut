this.legend_recruitment_nomad_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
		Nomad = null
    },
    function create()
    {
	    this.encounter.create();
        this.m.Type = "encounter.legend_recruitment_nomad_encounter";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Cooldown = 31 * ::World.getTime().SecondsPerDay;
	}

    function createScreens()
    {
        this.m.Screens.extend([{ // \' —
            ID = "Start",
            Title = "On the outskirts...",
			Text = "[img]gfx/ui/events/event_161.png[/img]The sun blisters and cracks what little is not covered by the sand. The tribe is doing well despite the heat, but all are silent, fearing to lose the remaining moisture in the mouths. \n\nDistantly, a figure crests dune — daubed in ragged silks and trailing themselves desperately. \nEventually you meet, they are the sole survivor of their nomad tribe, cut down to the last.",
            Image = "",
            List = [],
			Characters = [],
			Options = [
			{
				Text = "We always need more like us.",
				function getResult( _event )
				{
					this.World.getPlayerRoster().add(_event.m.Nomad);
					this.World.getTemporaryRoster().clear();
					_event.m.Nomad.onHired();
					return 0;
				}
			},
			{
					Text = "Keep walking stranger.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}
			}
			]

            function start(_event)
			{
				local backgrounds = [
					[1,	"nomad_background"],
					[2, "nomad_ranged_background"],
					[3, "legend_muladi_background"]
				];
				local totalWeight = 0;
				local result = [];
				foreach (background in backgrounds)
				{
				    totalWeight += background[0];
				}
				local r = this.Math.rand(0, totalWeight);
				foreach (background in backgrounds)
				{
				    r = r - background[0];
				    if (r <= 0)
				    {
				       result.push(background[1]);
				      break;
				    }
				}
				local roster = this.World.getTemporaryRoster();
				_event.m.Nomad = roster.create("scripts/entity/tactical/player");
				_event.m.Nomad.setStartValuesEx(result);
				this.Characters.push(_event.m.Nomad.getImagePath());
			}
        }]);
    }

    function isValid(_settlement)
    {
	    if (!this.World.getTime().IsDaytime) //must be daytime
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();
		if (currentTile.Type != this.Const.World.TerrainType.Desert) //must be desert
		{
			return;
		}

	    if (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
		    return false;

		if (this.World.Assets.getOrigin().getID() != "scenario.legends_nomads")
			return;

		if (_settlement.isIsolatedFromRoads())
			return false;

		if (::World.getPlayerRoster().getSize() >= ::World.Assets.getBrothersMax())
			return false;

		if (playerTile.SquareCoords.Y < ::World.getMapSize().Y * 0.7)
			return false;
    }

	function onClear()
	{
		this.m.Nomad = null;
	}
});
