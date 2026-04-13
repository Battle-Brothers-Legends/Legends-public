this.legends_minstrel_and_troubador_event <- this.inherit("scripts/events/event", {
	m = {
		Minstrel = null,
		Troubador = null
	},
	function create()
	{
		this.m.ID = "event.legends.minstrel_and_troubador";
		this.m.Title = "During camp...";
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%minstrel% is singing a quiet song alone when %troubador% pipes up. %SPEECH_ON% Our bard sits in thought and hums a song of nought. He must be unimpressed by the battles we have fought, unswayed by the treasure we sought, uninspired by the beasts we caught. Is this tiny song all the praise our efforts have brought?%SPEECH_OFF%\n\n %minstrel% answers %SPEECH_ON% Our actor has quite a way with words, where my memory is blurred. If these deeds such emotion hath stirred, perhaps the troubadour could remind those who have not heard? %SPEECH_OFF%\n\n The two began a duet, going back and forth on ever greater deeds the company had achieved. A very entertaining song, even if it were not all entirely true. | As %minstrel% sings by the fire, the %troubador% begins to dance. As the song rises and falls, so does the body of the troubadour. Each scene is portrayed through movement, the thrust of a sword, the swoon of a lover, chained together into a rythmic show. It is an entrancing performance. | %troubador% is telling a story as the fire crackles. %minstrel% begins to add soft melodies behind the words, rising and falling along with the tale. The combination adds an air of mystery and grandiosity to the story, elevating it into a thrilling adventure, heartwarming romance and uplifting success. | %minstrel% has been playing a series of folk song, when %troubador% asks to sing the one about the {dragon | princess | king | flower | sword | tavern | mercenaries}. The bard obliges, and the two of them sing a rousing rendition of the old song.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Bravo!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Minstrel.getImagePath());
				this.Characters.push(_event.m.Troubador.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Minstrel.getID())
					{
						continue;
					}

					if (bro.getID() == _event.m.Troubador.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 33)
					{
						this.List.push(::Legends.EventList.changeMood(bro, 1.0, "Felt entertained"));
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_minstrel = [];
		local candidates_troubador = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasTrait(::Legends.Trait.Player))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.minstrel" && bro.getGender() != 1)
			{
				candidates_minstrel.push(bro);
			}

			if (bro.getBackground().getID() == "background.minstrel" && bro.getGender() == 1)
			{
				candidates_troubador.push(bro);
			}

		}

		if (candidates_minstrel.len() == 0)
		{
			return;
		}

		if (candidates_troubador.len() == 0)
		{
			return;
		}

		this.m.Minstrel = candidates_minstrel[this.Math.rand(0, candidates_minstrel.len() - 1)];
		this.m.Troubador = candidates_troubador[this.Math.rand(0, candidates_troubador.len() - 1)];
		this.m.Score = (candidates_minstrel.len() + candidates_troubador.len())  * 10 ;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"minstrel",
			this.m.Minstrel.getNameOnly()
		]);
		_vars.push([
			"troubador",
			this.m.Troubador.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Minstrel = null;
		this.m.Troubador = null;
	}

});

