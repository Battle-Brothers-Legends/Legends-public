this.legend_cultist_converts_to_puppet_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null
	},
	function create() {
		this.m.ID = "event.legend_cultist_converts_to_puppet";
		this.m.Title = "A Higher Purpose";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({ //— \n |
			ID = "A", //cultist begs to be converted to a puppet
			Text = "[img]gfx/ui/events/event_03.png[/img]The day is, by sellsword standards, quiet. However, the entrance of %cultist% seeks to jeopardise that calm with new ramblings and portents of doom.%SPEECH_ON%I have been in your service for days! WHY WILL YOU NOT LET ME ASCEND!?%SPEECH_OFF% The words roll around in your head for a moment — but you still don\'t quite get the meaning. You get the impression if you keep nodding along something will come of it. %SPEECH_ON%There MUST be a sacrifice. There is ALWAYS a sacrifice. There HASN\'T been a sacrifice! I ask you take me, make me you you raise so I cna serve both you and him...%SPEECH_OFF%There it is. There is always a request. There is always questions around saving a loved one from death or curing ailments using dark magic. This, however, is a very unusual request. But not one that couldn\'t be granted...",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Grant the wish.",
				getResult = @(_event) "B"
			}, {
				Text = "Decline the wish.",
				getResult = @(_event) "C"
			}],
			function start(_event)
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
			}

		});
		this.m.Screens.push({ //— \n |
			ID = "B", //become puppet
			Text = "[img]gfx/ui/events/event_140.png[/img]%cultist% is overjoyed — So overjoyed in fact that they take a knife from a table and cut their own throat open. \n\nAs they lay there. Bleeding. Dead. A thought crosses your mind. You have usually settled for scraps and corpses in much worse states than this. If you acted now and raised %cultist%, there is a strong potential that they would become thing much stronger than what you normally find. You have sold yourself on the idea. Even if it was after the fact that the affected party made the final commitment to do so. \nA ritual is prepared, and a new puppet is remade. The blood still seeping from the wound. The newly raised looks at you with lifeless eyes, you gaze into them and see something remains of %puppet% in this new vessel.\n Are they happy? Do they have the answers they dedicated their life to? It is hard to judge these things beyond the veil. \n\nYou think you hear them murmer something, but brush it aside as nothing more than the wind.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "This has to be a first...",
				function getResult(_event)
				{
					return 0;
				}
			}],
			function start(_event)
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Cultist = roster.create("scripts/entity/tactical/player");
				_event.m.Cultist.getFlags().add("PlayerZombie");
				_event.m.Cultist.getFlags().add("undead");
				_event.m.Cultist.getFlags().add("zombie_minion");

				_event.m.Cultist.addLightInjury();
				_event.m.Cultist.resetPerks();
				_event.m.Cultist.getBaseProperties().Initiative -= 35;
				_event.m.Cultist.getBaseProperties().Hitpoints += 25;
				_event.m.Cultist.getBaseProperties().Stamina += 15;
				_event.m.Cultist.getBaseProperties().MeleeSkill += 25;
				_event.m.Cultist.getBaseProperties().RangedDefense += 1;
				_event.m.Cultist.getBaseProperties().MeleeDefense += 2;
				_event.m.RawDescription = "%name% was, or perhaps still somewhat is, a cultist of Davkul — but now serves a different master. You wonder if they have any regrets behind those lifeless, pallid eyes...";
				::Legends.Traits.grant(this, ::Legends.Trait.LegendRottenFlesh);
				::Legends.Perks.grant(this, ::Legends.Perk.LegendZombieBite);
				this.Characters.push(_event.m.Cultist.getImagePath());

				foreach( bro in brothers )
				{
					this.List.push({
					id = 16,
					icon = "ui/icons/kills.png",
					text = _event.m.Cultist.getName() + " [color=" + this.Const.UI.Color.NegativeEventValue + "]has been reborn.[/color]"
					});

					this.List.push({
						id = 16,
						icon = "ui/icons/regular_damage.png",
						text = "[color=" + this.Const.UI.Color.PositiveEventValue + "]Your sacrifice has some supernatural strength![/color]"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B", //reject cultist gets sad
			Text = "[img]gfx/ui/events/event_39.png[/img]The proposal is too strange for you to consdier, plus %cultist% does good work for %companyname% and the ritual would be dangerous. They remain disgruntled, but this will pass.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Let\'s go.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				local brothers = ::World.getPlayerRoster().getAll();
				foreach (bro in brothers) {
					this.List.push({
						id = 16,
						icon = "ui/icons/mood_02.png",
						text = Cultist.getName() + " [color=" + this.Const.UI.Color.NegativeEventValue + "] becomes upset [/color]"
					});
				}

				local entry = ::Legends.EventList.changeMood(_event.m.Cultist, 1.5, "Was rejected from ascending");
				this.Characters.push(_event.m.Cultist.getImagePath());
			}
		});
	}

	function onUpdateScore()
	{
		//see 'static_functions' ::Legends.S.humansOnly for more details.
		local originID = ::World.Assets.getOrigin().getID();
		if (originID != "scenario.legends_solo_necro" && originID != "scenario.legends_necro")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_Cultist = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}
			//cultist must be lvl 9 or higher to justify the cost of the sacrifice
			if (bro.getLevel() < 9 && ::Legends.Backgrounds.has(bro, ::Legends.Background.Cultist))
			{
				candidates_cultist.push(bro);
			}
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		this.m.Score = 3;
	}

	function onPrepare() {}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cultist",
			this.m.Puppet.getName()
		]);
	}

	function onClear()
	{
		this.m.Cultist = null;
	}
});

