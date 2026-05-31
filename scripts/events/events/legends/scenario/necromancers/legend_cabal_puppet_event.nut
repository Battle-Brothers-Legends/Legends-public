this.legend_cabal_puppet_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legend_cabal_puppet";
		this.m.Title = "Jumping the fence";
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_29.png[/img]As you walk along the road, {you can\'t help but notice a shifting figure moving out of the corner of your eye. | a small shape darting in and out of your vision. | a lumbering mass traipsing through the field.} On closer inspection it seems a member of the undead has lost their way - just as a sheep jumps the paddock and wanderers aimlessly before being stolen or killed.\n\n It is hard to say where this one came from, perhaps a {nearby battlefield | mass grave | far off place | raided farmstead | shallow ditch | shallow grave}. Either way, they would make a good addition to %companyname% to bolster your horde.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I shall call you... %joiner%!",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "Leave it to wander.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"legend_puppet_background"
				]);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.legends_necro")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		if (!this.World.State.getPlayer().getTile().HasRoad)
		{
			return;
		}

		this.m.Score = 7;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"joiner",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

