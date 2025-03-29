this.legend_barbarian_vs_shieldmaiden <- this.inherit("scripts/events/event", {
	m = {
		Barbarian = null,
		Shieldmaiden = null
	},
	function create()
	{
		this.m.ID = "event.legend_barbarian_vs_shieldmaiden";
		this.m.Title = "During camp...";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]You find %barbarian% and %shieldmaiden% arguing with one another. The Barbarian\'s voice is raised.%SPEECH_ON%The best defence is the good offence! That\'s why I rush to a battle first!%SPEECH_OFF%Also raising her voice, and clenching a shield at her side, the Shieldmaiden shakes her head.%SPEECH_ON%Why are you even talking to me? I have no desire to get to know someone who is only going to get killed by rushing into battle before thinking!%SPEECH_OFF%The fighting words kick off a scuffle.\n\n",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Are you both done?",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local victorious = false;

				if (this.Math.rand(1, 100) <= 50)
				{
					this.Text = this.Text + " %barbarian% rushes at %shieldmaiden% with a full swing of a weapon, as if trying to cut her in half, but she raises her shield to deftly deflect the blow and immedietly counters with a quick jab of her shield that stuns and knocks %barbarian% back.%SPEECH_ON%See I told you! you rush without thinking and now you are laying on the ground...%SPEECH_OFF%";
					local MeleeDefense = this.Math.rand(2, 4);
					_event.m.Shieldmaiden.getBaseProperties().MeleeDefense += MeleeDefense;
					_event.m.Shieldmaiden.getSkills().update();
					_event.markAsLearnedS();
					_event.m.Shieldmaiden.improveMood(1.0, "victorious in a brawl");
					_event.m.Shieldmaiden.addLightInjury();
					local injury1 = _event.m.Barbarian.addInjury(this.Const.Injury.Brawl);
					_event.m.Barbarian.worsenMood(0.5, "Overpowered by " + _event.m.Shieldmaiden.getName());
					this.List = [
						{
							id = 16,
							icon = "ui/icons/melee_defense.png",
							text = _event.m.Shieldmaiden.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + MeleeDefense + "[/color] Melee Defense"
						},
						{
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = _event.m.Shieldmaiden.getName() + " suffers light wounds"
						},
						{
							id = 10,
							icon = injury1.getIcon(),
							text = _event.m.Barbarian.getName() + " suffers " + injury1.getNameOnly()
						},
						{
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Barbarian.getMoodState()],
							text = _event.m.Barbarian.getName() + this.Const.MoodStateEvent[_event.m.Barbarian.getMoodState()]
						}
					];
				}
				else
				{
					this.Text = this.Text + " %barbarian% rushes at %shieldmaiden% who tries to react by blocking the blow with her shield but the Barbarian easily circumvents her defence and knocks her to the ground, before stopping a strike an inch from her head.%SPEECH_ON%See I told you! Best defence is a good offence%SPEECH_OFF%";
					local meleeSkill = this.Math.rand(2, 4);
					_event.m.Barbarian.getBaseProperties().MeleeSkill += meleeSkill;
					_event.m.Barbarian.getSkills().update();
					_event.markAsLearnedB();
					_event.m.Barbarian.improveMood(1.0, "victorious in a brawl");
					local injury2 = _event.m.Shieldmaiden.addInjury(this.Const.Injury.Brawl);
					_event.m.Shieldmaiden.worsenMood(0.5, "Overpowered by " + _event.m.Barbarian.getName());
					_event.m.Barbarian.addLightInjury();
					this.List = [
						{
							id = 16,
							icon = "ui/icons/melee_skill.png",
							text = _event.m.Barbarian.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeSkill + "[/color] Melee Skill"
						},
						{
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = _event.m.Barbarian.getName() + " suffers light wounds"
						},
						{
							id = 10,
							icon = injury2.getIcon(),
							text = _event.m.Shieldmaiden.getName() + " suffers " + injury2.getNameOnly()
						},
						{
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Shieldmaiden.getMoodState()],
							text = _event.m.Shieldmaiden.getName() + this.Const.MoodStateEvent[_event.m.Shieldmaiden.getMoodState()]
						}
					];
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

		local Barbarian_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 3)
			{
				continue;
			}

			if ((bro.getBackground().getID() == "background.barbarian" && !bro.getFlags().has("learned")) || (bro.getBackground().getID() == "background.raider" && !bro.getFlags().has("learned")))
			{
				Barbarian_candidates.push(bro);
				break;
			}
		}

		if (Barbarian_candidates.len() == 0)
		{
			return;
		}

		local Shieldmaiden_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() > 3 && bro.getBackground().getID() == "background.legend_shieldmaiden" && !bro.getFlags().has("learned"))
			{
				Shieldmaiden_candidates.push(bro);
			}
		}

		if (Shieldmaiden_candidates.len() == 0)
		{
			return;
		}

		this.m.Barbarian = Barbarian_candidates[this.Math.rand(0, Barbarian_candidates.len() - 1)];
		this.m.Shieldmaiden = Shieldmaiden_candidates[this.Math.rand(0, Shieldmaiden_candidates.len() - 1)];
		this.m.Score = (Barbarian_candidates.len() + Shieldmaiden_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function markAsLearnedB()
	{
		this.m.Barbarian.getFlags().add("learned");
	}

	function markAsLearnedS()
	{
		this.m.Shieldmaiden.getFlags().add("learned");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"shieldmaiden",
			this.m.Shieldmaiden.getNameOnly()
		]);
		_vars.push([
			"barbarian",
			this.m.Barbarian.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Shieldmaiden = null;
		this.m.Barbarian = null;
	}

});

