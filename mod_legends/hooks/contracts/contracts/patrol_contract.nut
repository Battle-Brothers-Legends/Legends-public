::mods_hookExactClass("contracts/contracts/patrol_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Patrol Duty";
		this.m.DescriptionTemplates = [
			"Hiring mercenaries to protect the roads is a costly business, but it appears %s has been left with little choice.",
			"While the presence of sellswords may deter banditry and ensure safe passage along the roads, such services come at a premium.",
			"Banditry and highway robbery in their lands makes the nobility look weak, thus making fighting patrols a reliable repeat contract.",
			"As rumors of bandit gangs plundering the trade routes to %s spread, the need for vigilant patrols becomes paramount.",
			"With merchants hesitant to travel to %s due to the growing threat of banditry, the nobility needs to be seen doing something to restore confidence.",
			"Amidst escalating reports of bandit attacks and caravan ambushes, the imperative to patrol the roads becomes undeniable.",
			"Whilst neither glamorous or especially exciting work, it feels undeniably good to be paid for just plodding about.",
			"Getting paid to walk the lads about for a few days might just be the best deal of the year.",
		];
	}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null) {
			if (this.getFaction() != null)
				r = this.format(r, ::Const.UI.getColorized(::World.FactionManager.getFaction(this.getFaction()).getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
		}

		this.m.Description = r;
	}

	o.addKillCount = function ( _actor, _killer )
	{
		if (_killer != null && _killer.getFaction() != this.Const.Faction.Player && _killer.getFaction() != this.Const.Faction.PlayerAnimals)
		{
			return;
		}

		if (this.m.Flags.get("HeadsCollected") >= this.m.Payment.MaxCount)
		{
			return;
		}

		if (_actor.getXPValue() == 0)
		{
			return;
		}

		if (_actor.getType() == this.Const.EntityType.GoblinWolfrider || _actor.getType() == this.Const.EntityType.Wardog || _actor.getType() == this.Const.EntityType.Warhound || _actor.getType() == this.Const.EntityType.SpiderEggs || _actor.getFlags().has("tail"))
		{
			return;
		}

		if (!_actor.isAlliedWithPlayer() && !_actor.isAlliedWith(this.m.Faction) && !_actor.isResurrected())
		{
			this.m.Flags.set("HeadsCollected", this.m.Flags.get("HeadsCollected") + 1);
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
			if (s.ID == "CrucifiedF")
			{
				foreach (option in s.Options)
				{
					option.Text = "Rest in peace. (Increase Moral Reputation)";
				}
				s.start <- function ()
				{
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers )
					{
						if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.OffendedByViolence) && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
						{
							bro.worsenMood(0.5, "You let a crucified man die a slow death");

							if (bro.getMoodState() < this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
					}
				}

			}
			if (s.ID == "Success3")
			{
				s.Text = "[img]gfx/ui/events/event_45.png[/img]{Your return to %employer% is met with curiosity. He\'s counting crowns but, before giving you any, asks you how many \'heads\' you collected in your journey. After reporting %killcount% kills, he purses his lips and nods.%SPEECH_ON%Good enough.%SPEECH_OFF%The man spills some crowns into a satchel and hands it over. | Returning to %employer%, you find the man sitting deeply into an enormous chair, as if he needed all that space to support his nobility, opulence, and pride.\n\nYou talk about the patrol, how you killed %killcount% while on the road. Your emphasis is on the kills, as that is what you\'re being paid for. %employer% nods and has one of his men throw crowns into a satchel and hand it over. | %employer% stands by a window, drinking wine and seeming to ogle a few women gardening below. Without turning to face you, he asks how many you killed on your journey.%SPEECH_ON%%killcount%.%SPEECH_OFF%The nobleman chuckles.%SPEECH_ON%You make it seem so easy.%SPEECH_OFF%Again without looking, he snaps his fingers. A man appears from the side with a satchel in hand. You take it, then take your leave. | %employer% is reading scrolls of papers as he welcomes you in. He\'s curious as to how many kills you racked up on patrol. You report %killcount%, to which he hums and makes a small note on one of the papers. Nodding his head, he kicks open a chest next to him and starts scooping crowns into a satchel. He hands it over and then, without even looking up, tells you to get out. | There\'s a party going on at %employer%\'s abode. You weave through the crowd and drunken opulence to get to the man. He shouts over the music and noise, asking how many you cut down on your patrol. It\'s odd, but shouting that you killed %killcount% seems to have no effect on the partygoers. Shrugging, %employer% turns and leaves, slipping into the crowd of attendees. You try to chase, but a man cuts you off, slamming a satchel into your chest.%SPEECH_ON%Your payment, mercenary. Now, please, see to the door. People are beginning to notice you and they did not come here to feel uncomfortable.%SPEECH_OFF%}";
			}
		}
	}
});
