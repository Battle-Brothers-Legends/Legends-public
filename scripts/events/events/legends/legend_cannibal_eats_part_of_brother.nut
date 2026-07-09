this.legend_cannibal_eats_part_of_brother <- this.inherit("scripts/events/event", {
	m = {
		Cannibal = null,
		Dinner = null
	},
	function create()
	{
		this.m.ID = "event.legend_cannibal_eats_part_of_brother";
		this.m.Title = "At night...";
		this.m.Cooldown = 55 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]A scream pierces the still night. %randombro% hurtles into your tent with news of an attack. By the time you find the problem, you see you are not under attack at all, but instead %cannibal% has helped themselves to a bit of %dinner% for dinner. The happy cannibal gently cooks their haul in a pan over the campfire as their cattle screams in pain. \n\nThey do not move an inch.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Vile.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local potential = [];
				local injuries = this.Const.Injury.Cannibal;

				foreach( inj in injuries )
				{
					else if (inj.ID == "injury.maimed_foot" && !_event.m.Dinner.getSkills().hasSkill("injury.maimed_foot") && !_event.m.Dinner.getSkills().hasTrait(::Legends.Trait.LegendProstheticFoot))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.missing_ear" && !_event.m.Dinner.getSkills().hasSkill("injury.missing_ear") && !_event.m.Dinner.getSkills().hasTrait(::Legends.Trait.LegendProstheticEar))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.missing_eye" && !_event.m.Dinner.getSkills().hasSkill("injury.missing_eye") && !_event.m.Dinner.getSkills().hasTrait(::Legends.Trait.LegendProstheticEye))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.missing_finger" && !_event.m.Dinner.getSkills().hasSkill("injury.missing_finger") && !_event.m.Dinner.getSkills().hasTrait(::Legends.Trait.LegendProstheticFinger))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.missing_nose" && !_event.m.Dinner.getSkills().hasSkill("injury.missing_nose") && !_event.m.Dinner.getSkills().hasTrait(::Legends.Trait.LegendProstheticNose))
					{
						potential.push(inj);
					}
					else if (inj.ID != "injury.maimed_foot" && inj.ID != "injury.missing_ear" && inj.ID != "injury.missing_eye" && inj.ID != "injury.missing_finger" && inj.ID != "injury.missing_nose" && !_event.m.Dinner.getSkills().hasSkill(inj.ID))
					{
						potential.push(inj);
					}
				}

				if (potential.len() > 0)
				{
					local cannibal_injury = this.new("scripts/skills/" + potential[this.Math.rand(0, potential.len() - 1)].Script);
					_event.m.Dinner.getSkills().add(cannibal_injury);
					this.List.push({
						id = 10,
						icon = cannibal_injury.getIcon(),
						text = _event.m.Dinner.m.Name + " suffers " + cannibal_injury.m.Name
					});
					this.List.push(::Legends.EventList.changeMood(_event.m.Cannibal, 2.0, "Enjoyed a good meal"));
					this.List.push(::Legends.EventList.changeMood(_event.m.Dinner, -4.0, "Got partially eaten by " + _event.m.Cannibal.m.Name));
				}
				else
				{
					this.List.push(::Legends.EventList.changeMood(_event.m.Cannibal, 1.0, "Enjoyed a good meal"));
					this.List.push(::Legends.EventList.changeMood(_event.m.Dinner, -3.0, "Got partially eaten by " + _event.m.Cannibal.m.Name));
				}
				this.Characters.push(_event.m.Dinner.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;
		local brothers = this.World.getPlayerRoster().getAll();
		local cannibal_candidates = [];
		local dinner_candidates = [];

		if (this.World.Assets.getFood() > 0 || this.World.getTime().IsDaytime)
		{
			return;
		}

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasTrait(::Legends.Trait.LegendCannibalistic))
			{
				cannibal_candidates.push(bro);
			}
		}

		if (cannibal_candidates.len() < 1)
		{
			return;
		}

		this.m.Cannibal = cannibal_candidates[this.Math.rand(0, cannibal_candidates.len() - 1)];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.legend_donkey")
				continue;

			if (bro.getID() != this.m.Cannibal.getID())
			{
				local potential = [];
				local injuries = this.Const.Injury.Cannibal;

				foreach( inj in injuries )
				{
					if (inj.ID == "injury.broken_elbow_joint" && !bro.getSkills().hasSkill("injury.broken_elbow_joint") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticForearm))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.broken_knee" && !bro.getSkills().hasSkill("injury.broken_knee") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticLeg))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.maimed_foot" && !bro.getSkills().hasSkill("injury.maimed_foot") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticFoot))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.missing_ear" && !bro.getSkills().hasSkill("injury.missing_ear") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticEar))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.missing_eye" && !bro.getSkills().hasSkill("injury.missing_eye") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticEye))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.missing_finger" && !bro.getSkills().hasSkill("injury.missing_finger") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticFinger))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.missing_hand" && !bro.getSkills().hasSkill("injury.missing_hand") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticHand))
					{
						potential.push(inj);
					}
					else if (inj.ID == "injury.missing_nose" && !bro.getSkills().hasSkill("injury.missing_nose") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticNose))
					{
						potential.push(inj);
					}
					else if (inj.ID != "injury.broken_elbow_joint" && inj.ID != "injury.broken_knee" && inj.ID != "injury.maimed_foot" && inj.ID != "injury.missing_ear" && inj.ID != "injury.missing_eye" && inj.ID != "injury.missing_finger" && inj.ID != "injury.missing_hand" && inj.ID != "injury.missing_nose" && !bro.getSkills().hasSkill(inj.ID))
					{
						potential.push(inj);
					}
				}

				if (potential.len() > 0)
				{
					dinner_candidates.push(bro);
				}
			}
		}

		if (dinner_candidates.len() < 1)
		{
			return;
		}

		this.m.Dinner = dinner_candidates[this.Math.rand(0, dinner_candidates.len() - 1)];
		this.m.Score = 5.5 + dinner_candidates.len() / 2.0;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cannibal",
			this.m.Cannibal.m.Name
		]);
		_vars.push([
			"dinner",
			this.m.Dinner.m.Name
		]);
	}

	function onClear()
	{
		this.m.Cannibal = null;
		this.m.Dinner = null;
	}

});

