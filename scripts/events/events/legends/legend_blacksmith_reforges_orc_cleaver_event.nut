this.legend_blacksmith_reforges_orc_cleaver_event <- this.inherit("scripts/events/event", {
	m = {
		Blacksmith = null
	},
	function create()
	{
		this.m.ID = "event.legend_blacksmith_reforges_orc_cleaver"; //—
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]While at a short rest, %blacksmith% is ideally amusing themselves by digging through the company stash — reorganising various items to be in better order. Eventually they come across a worn orc cleaver that has seen better days. %blacksmith% notices you and brings the weapon to your attention. %SPEECH_ON%If I were two foot taller and about half as smart I\'d say this is almost a decent weapon.%SPEECH_OFF% The blacksmith carefully turns the blade in their hands, inspecting every angle as an artist would a painting. %SPEECH_ON%There\'s a warp running along the blade and the spine \'as a crack in it, you\'ve got a really bad amount of edge damage around the tip here as well. On top of that — it is far too heavy to swing and I can barely hold it in one hand. If I swung this thing too hard I\'d likely go with it...%SPEECH_OFF% %blacksmith% scratches their chin and gently puts the blade back in the cart. %SPEECH_ON%I don\'t know what its made of, but I can have a try at just reforging the whole thing if you give me a thousand crowns to cover my materials and I can start right now — but the blade may already be too far gone...%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It is worth the risk.",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 60 ? "B" : "C"; //B = succeed || C = fail
					}

				},
				{
					Text = "We don\'t have time for this.", //skip
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Blacksmith.getImagePath());
			}

		});
		this.m.Screens.push({ //succeed
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]%blacksmith% warms up the blade and hammers on it for some time — quickly twisting it this way and that as the blade cycles between hot and cold. They fight with the crude weapon until it begins to take a more sleek and finer form, losing some of the bloated mass of metal from both sides.\n They take it to the grindstone and slowly resharpen all the edges from haft to tip, lastly dressing the handle in something more comfortable for human hands.\n\n While not an artistic masterpiece, you can\'t deny that improvements have been made to the performance of the weapon overall.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Much better!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-1000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]1000[/color] Crowns"
				});
				local item;
				local itemnamed;

				item = this.new("scripts/items/weapons/greenskins/orc_cleaver");
				this.World.Assets.getStash().remove(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You lose " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});


				itemnamed = this.new("scripts/items/weapons/named/named_orc_cleaver");
				this.World.Assets.getStash().add(itemnamed);
				this.List.push({
					id = 10,
					icon = "ui/items/" + itemnamed.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(itemnamed.getName()) + itemnamed.getName()
				});

				_event.m.Blacksmith.improveMood(1.5, "Reforged a primitive weapon");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Blacksmith.getMoodState()],
					text = _event.m.Blacksmith.getName() + this.Const.MoodStateEvent[_event.m.Blacksmith.getMoodState()]
				});

			}

		});
		this.m.Screens.push({ //Fail
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]%blacksmith% warms up the blade and hammers on it for some time — quickly twisting it this way and that as the blade cycles between hot and cold. They fight with the crude weapon until it begins to take a more sleek and finer form, %blacksmith% begins to curse under their breath as they put the weapon back into their forge to reheat it. This happens again several times more as they fight with the metal more and more.\n\n After the fourth attempt, the blade eventually cracks and snaps in two under the weight of their hammer. %blacksmith% gracefully accepts this by whispering insults at the blade before tossing it into the undergrowth with an almighty force.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Shame.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-1000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]1000[/color] Crowns"
				});
				local item;

				item = this.new("scripts/items/weapons/greenskins/orc_cleaver");
				this.World.Assets.getStash().remove(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You lose " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				_event.m.Blacksmith.worsenMood(1.0, "Failed to reforge a weapon");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Blacksmith.getMoodState()],
					text = _event.m.Blacksmith.getName() + this.Const.MoodStateEvent[_event.m.Blacksmith.getMoodState()]
				});
			}
		});
	}

	function onUpdateScore()
	{

		// if (!this.World.getTime().IsDaytime)
		// {
		// 	return;
		// }

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 7 && bro.getBackground().getID() == "background.legend_blacksmith") //if this bro level is equal to or greater than the number stated, this event can happen.
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local numitem = 0;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "weapon.orc_cleaver") //check item is in stash before triggering!
			{
				numitem = ++numitem;
				break;
			}
		}

		if (numitem == 0)
		{
			return;
		}

		this.m.Blacksmith = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 4;
	}

	function onPrepare()
	{
		// local items = this.World.Assets.getStash().getItems();
		// local candidates = [];

		// foreach( item in items )
		// {
		// 	if (item == null)
		// 	{
		// 		continue;
		// 	}

		// 	if (item.isItemType("scripts/items/weapons/greenskins/orc_cleaver"))
		// 	{
		// 		candidates.push(item);
		// 	}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"blacksmith",
			this.m.Blacksmith.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Blacksmith = null;
	}

});

