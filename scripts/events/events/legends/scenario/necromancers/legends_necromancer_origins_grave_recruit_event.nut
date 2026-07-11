this.legends_necromancer_origins_grave_recruit_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legends_necromancer_origins_grave_recruit";
		this.m.Title = "Near the mass grave...";
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({ //— \n |
			ID = "A",
			Text = "[img]gfx/ui/events/event_132.png[/img]{While on the road, you notice a corpse face first in the dirt. After some time another appears. Then another — and another. The decaying human breadcrumbs culminate into a large battlefield boasting a hasily dug pit filled with corpses, presumably not the victor\'s... \n\n...if indeed there was one. \n\nCircling the site the battle appeared to be recent, some corpses are remarkably fresh in what appears to be a mix between an ambush, a counter ambush and a third party that was in the wrong place at the wrong time.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Try to raise something.",
					function getResult( _event )
					{
						return "B";
					}
				},
				{
					Text = "Loot the battlefield.",
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
			ID = "B",
			Text = "[img]gfx/ui/events/event_29.png[/img]{Seeing oppertunity, a ritual is performed — and you manage to pull a new recruit from the grip of death before they became a mindless thrall to another. You looked deep into them, and name them %joiner%.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Time to dress you up nicely!",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}
				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
 				_event.m.Dude.getFlags().add("PlayerZombie");
				_event.m.Dude.getFlags().add("undead");
				_event.m.Dude.getFlags().add("zombie_minion");
				_event.m.RawDescription = "You pulled this minion from a mass grave. You know little about who they once were — nor do you care.";
				_event.m.Dude.setStartValuesEx(this.Const.CharacterBackgroundsRandomForUndead); //see character_backgrounds file
				::Legends.Traits.grant(this, ::Legends.Trait.LegendRottenFlesh);
				::Legends.Perks.grant(this, ::Legends.Perk.LegendZombieBite);
				this.Characters.push(_event.m.Dude.getImagePath());
				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.NegativeEventValue + "]Your reputation with everyone has decreased slightly[/color]"
				});

				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveEventValue + "]Your reputation with the undead has increased slightly[/color]"
				});

				local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
				local settlement = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Settlement);
				local oriental = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);
				local undead = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Undead);

				foreach( n in nobles )
				{
					n.addPlayerRelation(-5.0, "Became a greater threat");
				}
				foreach( n in settlement )
				{
					n.addPlayerRelation(-10.0, "Became a greater threat");
				}
				foreach( n in oriental )
				{
					n.addPlayerRelation(-5.0, "Became a greater threat");
				}
				foreach( n in undead )
				{
					n.addPlayerRelation(20.0, "You should not see this");
				}
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_22.png[/img]{You move on, but not without alleviating the dead of their worldly possessions...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We shouldn\'t draw attention to ourselves.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(18, 628);
				this.World.Assets.addMoney(money);
			}

		});
	}

	function onUpdateScore()
	{
		//see 'static_functions' ::Legends.S.humansOnly for more details.
		if (this.World.Assets.getOrigin().getID() != "scenario.legends_solo_necro" && this.World.Assets.getOrigin().getID() != "scenario.legends_necro" && bro.getFlags().has("PlayerZombie")) //if not either of these origin, skip event
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local locations = this.World.EntityManager.getLocations();
		local nearSite = false;
		local currentTile = this.World.State.getPlayer().getTile();

		foreach( v in locations )
		{
			if (v.getTypeID() == "location.undead_mass_grave" && v.getTile().getDistanceTo(currentTile) < 5)
			{
				nearSite = true;
				break;
			}
		}

		if (!nearSite)
		{
			return;
		}

		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"joiner",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

