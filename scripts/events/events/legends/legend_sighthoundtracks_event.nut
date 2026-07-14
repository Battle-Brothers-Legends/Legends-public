this.legend_sighthoundtracks_event <- this.inherit("scripts/events/event", {
	m = {
		Houndhandler = null,
		Hound = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.legend_sighthoundtracks"; //— \'
		this.m.Title = "Near %townname%";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay; //hound picks up a scent and leads to something, maybe.
		this.m.Screens.push({
			ID = "A",
			Text = "%townImage%Near %townname%, you sit in your tent and begin planning tomorrow\'s march. A commotion comes from outside, which given the company you keep is not unusual. As you refocus, the interruption comes again at a greater amplification. You move to investigate. \n\nOutside, %houndhandler% yanks the chain on the company sighthound, who is eagerly wrenching the chain this way and that.%SPEECH_ON%Sorry capt\'n I haven\'t a clue wha\' got into \'im%SPEECH_OFF% The mercenary forces the hound to sit, and it seems to get the message this time, although the hound\'s eyes are fixated on something else in the distance. \nYou consider letting it off the chain for a bit, even just to sate your curiosity.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let it loose.",
					function getResult( _event )
					{
						return "B"; //pt.2
					}

				},
				{
					Text = "Leave them to it.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndhandler.getImagePath());
			}

		});
		this.m.Screens.push({ //\n\n
			ID = "B",
			Text = "%townImage%%houndhandler% takes their weight off the creature, which immediately resumes trying to get away. The mercenary shoots you a look as if they mistook you, before unshackling the collar with reservation. Almost without pause, the hound calms, and begins prowling away from camp...",
			Image = "",
			List = [],
			Characters = [], //catch rabbit, catch thief, run away, find an item
			Options = [
				{
					Text = "The hunt begins.",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);
						if (r <= 25)
						{
							return "C"; //runs away
						}
						else if (r <= 40)
						{
							return "D"; //catch rabbit (weaker reward)
						}
						else if (r <= 20)
						{
							return "E"; //catch thief (moderate reward)
						}
						else if (r <= 15)
						{
							return "F"; //find item (best reward)
						}
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndhandler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C", //runs away
			Text = "[img]gfx/ui/events/event_64.png[/img]After a short trek into a clearing, the hound senses you are far behind and chooses this as its moment — rapidly clearing distance between you and %houndhandler%, shortly disappearing over the horizon...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fark it.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndhandler.getImagePath());
				_event.m.Hound.getContainer().unequip(_event.m.Hound);
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Hound.getIcon(),
					text = _event.m.Hound.getName() + " bounds away."
				});
			}

		});
		this.m.Screens.push({
			ID = "D", //catch rabbit (weaker reward) //\n\n
			Text = "[img]gfx/ui/events/event_20.png[/img]After the best part of an hour, the sighthound has led you further away from camp. It regularly turns to check you and %houndhandler% are still following, and at times seems quite frustrated with your lack of enthusiasm for the hunt. \nAn hour turns into two, then into two-and-a-half. Finally, the hound picks up something in a mottle of trees. With sudden brutality, it launches into a bush and drags out a sizable rabbit. %houndhandler% is not best pleased you rambled for this long for a single rabbit, but the hound remains overjoyed. ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "At least that's lunch sorted...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndhandler.getImagePath());
				this.World.Assets.getStash().add(this.new("scripts/items/supplies/legend_rabbit_meat_item"));
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_food.png",
					text = "[color=" + this.Const.UI.Color.PositiveEventValue + "]" You gained some meat "[/color]"
				});
			}
		});
		this.m.Screens.push({
			ID = "E", //catch thief (moderate reward) //\n\n
			Text = "[img]gfx/ui/events/event_20.png[/img]Your hound darts this way and that through the coarse underbrush, only stopping for a moment to reacquire its target. You only catch glimpses as you chase, but after a while you realise what you are chasing. The thief hurtles over a rock and the sighthound pins him down. In the melee coins flow from the thief like blood to the point where you question if they are human at all. The man screams out for mercy and tosses what remains of their coin bag to the ground as if that would help at all. \n\n%houndhandler% heels the hound, which obeys begrudgingly. The thief quickly scrambles and escapes, leaving a trail of crowns in their wake. The hound samples one of the coins in curiosity. %SPEECH_ON%Aye there it is, I bet once we get back we\'d find a fair chunk of our crowns missin\'%SPEECH_OFF% With that, all three of you head back to camp. The hound still gnawing on a crown. Taking a count of the lost spoils, there is more here than what is missing. You don\'t seem to be the first to be robbed — nor likely the last...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "At least someone is earning their keep.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndhandler.getImagePath());
				local money = this.Math.rand(144, 571);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gained [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
				});
			}
		});
		this.m.Screens.push({
			ID = "F", //find item (best reward) //\n\n —
			Text = "[img]gfx/ui/events/event_20.png[/img]The hound does not journey far from camp. At times you think the whole task fruitless — the hound seems to constantly second guess itself, doubling back, stalling and going in circles. \n\nAs you consider chaining the beast again, it, without much hesitation, climbs down into a cut in the earth you must have missed several times now. As you descend you feel smooth stone under your boots. The hound pushes a door open and descends into the darkness. You exchange a look with %houndhandler%, causing you both to draw your weapons as you quickly light a torch. \n\nHeld aloft, the flame caresses the squat, flat stone roof of the hovel, ages abandoned and in disarray. Dried blood and makeshift bandages cover the floor, you see two beady glowing eyes sat in a corner, where the sighthound has found the lap of a skeleton to sit in. \n\nAges old, it still grips a eloquently made long spear in a defensive posture. The story here is unknown, but it looks like help never came.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We'll put it to good use.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndhandler.getImagePath());
				local item = this.new("scripts/items/weapons/named/named_spetum");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}
		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && (item.getID() == "accessory.legend_sighthound"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Houndhandler = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Hound = this.m.Houndhandler.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);
		this.m.Town = town;
		this.m.Score = candidates.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"houndhandler",
			this.m.Houndhandler.getNameOnly()
		]);
		_vars.push([
			"hound",
			this.m.Hound.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Houndhandler = null;
		this.m.Hound = null;
		this.m.Town = null;
	}

});
