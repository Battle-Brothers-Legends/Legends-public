this.legend_trader_recruitment <- this.inherit("scripts/events/event", {
	m = {
		Trader = null
	},
	function create()
	{
		this.m.ID = "event.legend_trader_recruitment";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 120 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_41.png[/img]{Travelling along the road %companyname% passes by various ordinary people. Usually they step aside as soon as they spot a company of grim looking mercenaries armed to the teeth, but a bold few will occasionally risk direct interaction. It seems you\'ve encountered one of these bold ones - a wayfarer approaches you, perhaps a little too readily.%SPEECH_ON%Oh, hello there! If it isn\'t the famous %companyname%!\n\nI have heard many stories of your famed deeds! So many glorious battles! So many enemies defeated! And so many spoils collected!%SPEECH_OFF%The traveler coughs, taking stock of your reaction before continuing.%SPEECH_ON%I can only imagine that such a party of strong warriors, so necessarily preoccupied with the battlefield, needs help outside of the fight! Getting supplies at the best possible price! Selling excess equipment! Well, I can make it happen! I\'m not much of a warrior, it is true, but you certainly don\'t need more of fighters! What you need is...someone like me.%SPEECH_OFF%The trader is smiles cheerfully and bows, but you notice the quick darting glances towards your supplies and best equipment. You\'ve no doubt the total value of the company\'s possessions has already been calculated in the trader\'s mind.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to the %companyname%.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Trader);
						this.World.getTemporaryRoster().clear();
						_event.m.Trader.onHired();
						return 0;
					}

				},
				{
					Text = "We\'d rather not take you in.",
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
				_event.m.Trader = roster.create("scripts/entity/tactical/player");
				_event.m.Trader.setStartValuesEx([
					"legend_trader_background"
				]);
				::Legends.Traits.grant(_event.m.Trader, ::Legends.Trait.Greedy);
				this.Characters.push(_event.m.Trader.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.have_z_crowns").isDone())
		{
			return;
		}

		if (this.World.Assets.getMoney() <= 30000)
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();

		if (!playerTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local totalbrothers = 0;
		local brotherlevels = 0;

		foreach( bro in brothers )
		{
			switch(bro.getBackground().getID())
			{
			case "background.legend_trader":
			case "background.legend_commander_trader":
				return;
			}

			totalbrothers = totalbrothers + 1;
			brotherlevels = brotherlevels + bro.getLevel();
		}

		if (totalbrothers < 1 || brotherlevels < 30)
		{
			return;
		}

		this.m.Score = 20.0 + brotherlevels / totalbrothers * 10.0 / this.Const.LevelXP.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Trader = null;
	}

});

