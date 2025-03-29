this.legend_beggar_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_beggar_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text =  "[img]gfx/ui/events/event_51.png[/img]Two crowns. A whole week and all you have for it is two crowns.\n\nYou sigh as you amble through the narrow streets, heading toward your alley for the night. You've seen a lot in the square. There, your hand is on the pulse of the town. You can tell when things aren't right, you see it in the way they walk. Have they been walking differently?\n\nYour thoughts are cut short by a sudden commotion.\n\nTwo men are standing right where you usually sleep. One of them is short, youthful, and clothed in red fabric. A noble\'s son. A cloaked man has him cornered against the stone wall. The brat speaks, his voice a panicked quiver all but lost in the gloom. %SPEECH_ON%Wait \'till father hears what you\'ve done!%SPEECH_OFF% The second man responds with a swift motion. The young man cries out, but the scream is cut short by a hand over his mouth. He slumps down to the ground, leaving a crimson stain on the wall.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A gruesome sight",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_50.png[/img]You must\'ve cried out in turn, as the man\'s head snaps around. Your eyes meet. In an instant, he clambers up a wall and vanishes among the rooftops. You step towards the body. His face is familiar. His indifference towards your plight all too normal for a highborn.\n\nDead men make poor companions, and a noble\'s corpse brings danger. As you make to leave, it catches your eye. A golden glimmer. A sack practically bursting with crowns, screaming its value to your shrewd gaze.\n\nYou shouldn\'t. You do.\n\nIt's heavy. Hundreds of crowns heavy, far too large to conceal under hood or rag. As you search for a temporary hiding spot, a faint flickering seeps into the alley. Soldiers. A voice calls out, terse and convinced of trouble. %SPEECH_ON%What\'s going on here? What have you...%SPEECH_OFF%The footman\'s gaze falls upon the dead noble. %SPEECH_ON%You murdering swine!%SPEECH_OFF%",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Time to run!",
					function getResult( _event )
					{
						return "C";
					}
				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({
			ID = "C",
			Title = "Beggar",
			Text = "[img]gfx/ui/events/event_04.png[/img]Shock does little to lend a man speed, and the soldier\'s outrage slows the drawing of his sword. Retreading the cloaked man\'s steps, you vault onto and over a decaying roof, landing amidst another street. A horn bellows nearby.\n\nYour safety is brief, snuffed out of your mind by the growing swell of clattering armor. The only way out is to skip town entirely.\n\nAs the adrenaline wears off, you begin to realize the true impact of this ordeal. Wholly convinced of your guilt, the vengeful weight of %enemynoble% will crash down upon you in time. Your gold may buy you weapons and those to wield them, but for how long? \n\nYou stare at the shimmering fortune in your hands. Was it worth it? A heave of your plunder convinces you. With dreams of a fresh start, you continue on.",
			Image = "",
			Banner = "",
			List = [],
			Options = [
				{
					Text = "No going back now",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
				//this.World.FactionManager.makeNoblesUnfriendlyToPlayer();
			}
		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "Legend Beggar";
	}

	function onPrepareVariables( _vars )
	{
		local homevillage = this.World.Flags.get("HomeVillage");
		_vars.push([
			"home",
			homevillage
		]);
		foreach (s in this.World.EntityManager.getSettlements())
		{
			if (s.getName() == homevillage)
			{
				homevillage = s;
				break;
			}
		}
		local noblehouse = homevillage.getFactionOfType(this.Const.FactionType.NobleHouse);
		_vars.push([
			"enemynoble",
			noblehouse.getName()
		]);
	}

	function onClear()
	{
	}

});


