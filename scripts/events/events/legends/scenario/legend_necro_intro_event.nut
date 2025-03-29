this.legend_necro_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_necro_intro_event";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_132.png[/img]{The necromancer felt their heart claw and writhe inside their chest. The struggle continued but after a moment longer the master necromancer left this earth. A death such as this was very rare, especially considering the age of the once proud figure now lain before their students.\n\n The trio saw an opportunity. An agreement was formed and preperations were made. The old master drunkenly fell from the table, animating as if a madman had tangled the strings of their puppet. Their flesh almost immediately went into decay — great chunks began to peel a slough off their face.\n\n Ironic... despite all their knowledge they could not even save themselves from a fate they once imposed upon countless others.\n\n With a new pet the situation was still dire — three students of the dark arts were now free from their master\'s trappings and could finally venture into the world. Their studies were incomplete, but each of them managed to master a cornerstone of necromancy, however their practical experience thus far had been limited to dead rats and the occasional vagrant.\n\n Every budding necromancer knows that many hands make light work — living or dead. So why be one frail old man when you can be three ambitious and young prodigies? The world belongs to the young and the bold!\n\n With their tutorship incomplete the trio take their new plaything and seek their own potential, but what they find in the real world will greatly differ to what they have read in their books...}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A new pet, with many more on the way...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			//	this.logInfo("Making zombies like you");
			//	this.World.FactionManager.makeZombiesFriendlyToPlayer(); //DOES THIS WORK? - (it does, but removed due to locking player into some contracts they can't complete!)
				this.logInfo("Unlocking gathering");
				this.World.Flags.set("HasLegendCampGathering", true);
			}
		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "Strangers In A Strange Land";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});