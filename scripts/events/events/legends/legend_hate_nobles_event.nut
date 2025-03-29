this.legend_hate_nobles_event <- this.inherit("scripts/events/event", {
	m = {
		Image = "",
		Casualty = null,
		excludedTraits = [
			"fear_nobles",
			"hate_nobles",
			"legend_hate_nobles",
			"dastard",
			"craven",
			"fainthearted",
			"weasel"
		]
	},
	function create()
	{
		this.m.ID = "event.legend_hate_nobles";
		this.m.Title = "After the battle...";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{Gods, that was a hard fought battle. Bodies lay all around you, some not fully dead yet groaning in agony. Those in the company still standing get to the  grim task of sending those souls on their way and looting the fallen. As your vision returns to normal and the thundering in your ears recede, you clap eyes on %brother%, who is screaming into the pale face of what was a particularly fair young nobleman, whose blonde locks are now matted with blood.%SPEECH_ON%YOU THINK YOU ARE BETTER THEN ME YOU NOBLE FARK?!%SPEECH_OFF%They shake the shoulders of the nobleman, the golden head lolling about. The lad is quite clearly dead.%SPEECH_ON%I \'AINT NOTHIN! I \'AINT TRASH! I FARKIN SHOWED YOU DIDN'\'T I?!%SPEECH_OFF%They punch the corpse in the face, dropping it to the ground, then howling more expletives, pick it up and punch it again. And again. The obscene racket is starting to give you a headache. Sighing, you stride over and lay %brother% out with the flat of your sword. They curl up whimpering, their energy finally spent. You sheathe your sword and idly wonder what vicious barb the noble lad could have spoken to goad such a reaction.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "At least they are motivated.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Casualty.getImagePath());
				::Legends.Traits.grant(_event.m.Casualty, ::Legends.Trait.LegendHateNobles, function(_trait) {
					this.List.push({
						id = 10,
						icon = _trait.getIcon(),
						text = _event.m.Casualty.getName() + " now hates the nobility."
					});
				}.bindenv(this));
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 30.0) //from 5
		{
			return;
		}

		local fallen = [];
		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 2)
		{
			return;
		}

		if (fallen[0].Time < this.World.getTime().Days || fallen[1].Time < this.World.getTime().Days)
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.NobleHouse).getID())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() < 3)
				return;
			foreach (trait in this.m.excludedTraits)
			{
				if (bro.getSkills().hasSkill("trait." + trait))
					continue;
			}
			candidates.push(bro);
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Casualty = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 500;
	}

	function onPrepare()
	{
		this.m.Image = "[img]gfx/ui/events/event_46.png[/img]";
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"brother",
			this.m.Casualty.getName()
		]);
		_vars.push([
			"image",
			this.m.Image
		]);
	}

	function onClear()
	{
		this.m.Casualty = null;
		this.m.Image = "";
	}

});

