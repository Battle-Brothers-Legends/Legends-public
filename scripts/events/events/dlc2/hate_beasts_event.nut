this.hate_beasts_event <- this.inherit("scripts/events/event", {
	m = {
		Image = "",
		Casualty = null,
		excludedTraits = [
			"fear_beasts",
			"hate_beasts",
			"dastard",
			"craven",
			"fainthearted",
			"weasel"
		]
	},
	function create()
	{
		this.m.ID = "event.hate_beasts";
		this.m.Title = "After the battle...";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[img]Beast corpses litter the ground everywhere, their sticky ichor tainting the soil black. With a scowl you realise that your clothes and sword are also covered in the stuff, that will be murder to wash out. Around you the company survivors are busy making certain the things are truly dead, that is except for %brother%, who is still frantically swinging their weapon about in lethal arcs.%SPEECH_ON%YOU \'AINT EATING ME YOU FARKS!%SPEECH_OFF%You call out to them, try to tell them the battle is over, but that wild look in their eyes tells you they did not hear.%SPEECH_ON%YOU DISGUSTING! FILTHY! ABNORMAL! FARKIN! FREAKS!%SPEECH_OFF%Brothers scramble out of the way of the whirlwind that is %brother%, lest they lose limbs. You gamely follow behind them and were just considering a tackle, when they abruptly turn and start hacking up a particularly monstrous sized beast corpse. Gobbets of flesh rain everywhere, including over you and your up-until-now unsoiled hat. Just farkin great. Swearing viciously, you take your leave, telling your grinning sergeant to let %brother% work it out their system. You go to find a stream to bathe, relax and mull over a fitting punishment detail.}", 
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A little hatred can be a powerful thing.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Casualty.getImagePath());
				local trait = this.new("scripts/skills/traits/hate_beasts_trait");
				_event.m.Casualty.getSkills().add(trait);
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Casualty.getName() + " now hates beasts"
				});
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

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID())
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
		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") == this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID())
		{
			this.m.Image = "[img]gfx/ui/events/event_81.png[/img]";
		}
		else
		{
			this.m.Image = "[img]gfx/ui/events/event_83.png[/img]";
		}
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

