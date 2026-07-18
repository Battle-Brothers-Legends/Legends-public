this.legend_warhoundowner_event <- this.inherit("scripts/events/event", {
	m = {
		Houndhandler = null,
		Merchant = null,
		Hound = null
	},
	function create()
	{
		this.m.ID = "event.legend_warhoundowner"; //— \'
		this.m.Title = "At a Creek";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay; //warhound finds owner, decisions happen
		this.m.Screens.push({
			ID = "A", //find man fishing, offering to buy hound
			Text = "[img]gfx/ui/events/event_08.png[/img]As you trudge through the cold, the snow capitulates beneath the slow progress of %companyname%. The conditions out here are more brutal than you expected — and makes you wonder how anyone survives up here for so long. The wildmen whisper that this is the last foothold of the old gods, a refrain of their power here in the north. \n\nWith that thought, a figure comes into view by a creek daubed in furs and tattoos in equal measure, he skilfully skewers another fish from the water. He initially ignores you, only to peer at you from the corner of his vision, assess you, and return to his hunt.\n\n Meanwhile, %houndhandler% is struggling to keep the company warhound under control. The dog thrashes this way and that against their chain, almost pulling their handler into the stream.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "See what it wants.",
				getResult = @(_event) "B" //pt.2
			}, {
				Text = "We move on.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Houndhandler.getImagePath());
			}
		});
		this.m.Screens.push({ //\n\n //— \'
			ID = "B",
			Text = "[img]gfx/ui/events/event_143.png[/img]%houndhandler% snatches the chain off the warhound, who immediately bolts for the man. Fearing an escalation, the company readies their weapons. The hound bounds into the man, who finally pays notice. \nAfter a few moments, what would be a savaging mauling, instead turns into play. The wrinkled man now beaming a smale at the hound as it desperately tries to climb into his shoulders. The fisherman checks the front paw of the hound, and his face churns into a more serious complexion, barking a question to you over the stream. %SPEECH_ON%%Where did you find this hound mercenary?%SPEECH_OFF% %houndhandler% makes the distance between you two, and enters a lengthy discussion as the dog bounds between them in excitement. After some time your mercenary returns, with the hound in tow. %SPEECH_ON%Turns out this man raised this dog as a puppy, which was taken from him a few seasons back by a thief. I asked for proof and he told us to check the front paw.%SPEECH_OFF% You lean down and check the front paw of the dog, who gives it willingly. Before releasing the man was referring to the other paw. %SPEECH_ON%Right there capt\'n. A scar on the bottom of the paw. Just as the man said.%SPEECH_OFF%You consider your options — the man is either an exceptional liar, or is indeed the owner of this hound, which you must admit, you acquired under dubious circumstances.%SPEECH_ON%The wildling isn\'t twisting our arms neither, he wants to make a trade.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [], //
			Options = [{
				Text = "What has he got to trade?",
				getResult = @(_event) "C" //trade - multiple
			}, {
				Text = "Just give him the hound.", //moral rep
				getResult = @(_event) "D"
			}, {
				Text = "How many crowns will he pay?",
				getResult = @(_event) "E" //just money
			}, {
				Text = "The hound is ours. We move on.",
				getResult = @(_event) 0 //end
			}],
			function start(_event) {
				this.Characters.push(_event.m.Houndhandler.getImagePath());
			}
		});
		this.m.Screens.push({ //— \'
			ID = "C", //trade options
			Text = "[img]gfx/ui/events/event_136.png[/img]The wildman unpacks his sack, producing a few items of note. %hound% paces eagerly between you all.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "What has he got to trade?",
				getResult = @(_event) "D" //trade - multiple
			}, {
				Text = "Just give him the hound.", //moral rep
				getResult = @(_event) "E"
			}, {
				Text = "How many crowns will he pay?",
				getResult = @(_event) "F" //just money
			}, {
				Text = "The hound is ours. We move on.",
				getResult = @(_event) 0 //end
			}],
			function start(_event) {
			}
		});
		this.m.Screens.push({
			ID = "D", //trade options //\n\n —
			Text = "[img]gfx/ui/events/event_136.png[/img]The man in fur dumps his sack of belongings and fishes out a few choice items — namely a signet ring, some crushed valubles from an Unhold and some high quality fox fur. He presents them to you each in turn.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Deal. Give him the hound.",
				getResult = @(_event) "G"
			}, {
				Text = "I've changed my mind, how many crowns is he willing to pay?",
				getResult = @(_event) "F" //just money
			}],
			function start(_event)
			{
				this.Options.push({
					Text = "%merchant% has something to add...",
					getResult = @(_event)"MerchantNamed"
				});
			}
		});
		this.m.Screens.push({ //— \'
			ID = "E", //give hound for moral points //\n\n
			Text = "[img]gfx/ui/events/event_143.png[/img]The spearfisher is surprised, but makes the trade without hesitation. He unleashes the hound, which faithfully leans against his leg, playfully running his large fingers through its fur. As he packs up his camp, he swings a bundle of fish over his shoulder and smiles to you. %SPEECH_ON%You have made me a very happy man today sellsword.%SPEECH_OFF%You performs a gesture you do not recognise, you hesitate to mimic it back.%SPEECH_ON%May the old golds smile upon you, and may we meet again.%SPEECH_OFF% With that, the man and his canine companion vanish into the trees with catch in tow. You think to what you could have got in return, but that bitterness is washed over by a feeling that something is, indeed, smiling upon you. \n\nYou hope, at the very least, that dog will die of old age rather than the tip of a spear.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "May we meet again.",
				function getResult(_event){
				this.World.Assets.addMoralReputation(4);
					return 0}
			}],
			function start(_event) {
				this.Characters.push(_event.m.Houndhandler.getImagePath());
				this.List.push(::Legends.EventList.changeMood(_event.m.Houndhandler, 2.0, "Gave a warhound a chance at a new life."));
				_event.m.Hound.getContainer().unequip(_event.m.Hound);
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Hound.getIcon(),
					text = _event.m.Hound.getName() + " leaves for a better life."
				});
				 this.List.push({
				 	id = 11,
				 	icon = "ui/icons/asset_moral_reputation.png",
				 	text = "Gained morality for doing a noble deed."
				 });
			}
		});
		this.m.Screens.push({
			ID = "F", //just crowns //\n\n —
			Text = "[img]gfx/ui/events/event_04.png[/img]The stranger produces a large pouch of coins and counts out roughly half the bag — surmounting to 400 crowns total. It is offered to you with a neutral expression.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Deal.",
				getResult = @(_event) "H"
			}, {
				Text = "This isn't enough, what is he willing to trade?",
				getResult = @(_event) "D" //to item trade
			}],
			function start( _event )
			{
				this.Options.push({
					Text = "%merchant% has some input...",
					getResult = @(_event)"MerchantCoins"
				});
			}
		});
		this.m.Screens.push({
			ID = "G", //wrap up after trade items //\n\n —
			Text = "[img]gfx/ui/events/event_143.png[/img]The spearfisher is satisfied with the trade, and hands over the valubles to you in the way a victim hands over their possessions to a brigand. Still, the man smiles at the hound as %houndhandler% gives him the chain, wordlessly departing both further down the creek without any trouble.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "A good trade.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				local item = this.new("scripts/items/loot/deformed_valuables_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				local item = this.new("scripts/items/loot/valuable_furs_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				_event.m.Hound.getContainer().unequip(_event.m.Hound);
				this.List.push({
					id = 11,
					icon = "ui/items/" + _event.m.Hound.getIcon(),
					text = _event.m.Hound.getName() + " has been sold."
				});
			}
		});
		this.m.Screens.push({
			ID = "H", //wrap up after trade for crowns //\n\n —
			Text = "[img]gfx/ui/events/event_143.png[/img]The spearfisher is satisfied with the trade, and hands over the crowns. His smile is gone, but returns when he looks at the hound once more. %houndhandler% hands over the chain and the man unshackles it without hesitation. The hound runs free around his legs and both depart further down the streams into the wilderness.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "A good trade.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.World.Assets.addMoney(400);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]400[/color] Crowns"
				});
				_event.m.Hound.getContainer().unequip(_event.m.Hound);
				this.List.push({
					id = 11,
					icon = "ui/items/" + _event.m.Hound.getIcon(),
					text = _event.m.Hound.getName() + " has been sold."
				});
			}
		});

		this.m.Screens.push({
			ID = "MerchantCoins", //peddler increases price //\n\n —
			Text = "[img]gfx/ui/events/event_04.png[/img]%merchant% takes both you and %houndhandler% off to one side and explains the economics of the situation — you have something the man clearly and desperately wants, %companyname% also has to cover the cost of a new hound, the inconveniences of losing said hound, and the fact that the hound he knew is now better trained and battle-tested more than any kennel or village trainer could do. The peddler also pyramids their fingers. %SPEECH_ON%We also all saw there was at least half that amount of gold in that pouch, right?%SPEECH_OFF% Before you or your hound handler can discuss, the merchant paces confidently over to the towering man and reiterates the situation. Their face sours, but relaxes upon seeing the hound, which %merchant% has wryly brought with them without either of you noticing. \n\nThe fisherman relents, and hands over the whole bag to the peddler. You quickly take the bag before they can take their \'fee\' from it.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "A good trade.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.List.push(::Legends.EventList.changeMood(_event.m.Merchant, 1.5, "Traded a dog for a lot of crowns."));
				local money = this.Math.rand(581, 782);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
					}
				];
				_event.m.Hound.getContainer().unequip(_event.m.Hound);
				this.List.push({
					id = 11,
					icon = "ui/items/" + _event.m.Hound.getIcon(),
					text = _event.m.Hound.getName() + " has been sold."
				});
			}
		});
		this.m.Screens.push({
			ID = "MerchantNamed", //peddler ups item reward //\n\n —
			Text = "[img]gfx/ui/events/event_143.png[/img]%merchant% intercedes after looking at the items on display. They turn back to the hound and showcase it as someone would a selection of pots and pans. The wildman is unamused, but still listens. After what feels like an eternity of this, the peddler comes to an agreement. The wildman departs with the hound in tow, handing something to the merchant begrudgingly. %merchant% comes back to you and %houndhandler% with a skilfully made set of throwing axes as payment. ",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "An exceptional item!",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.List.push(::Legends.EventList.changeMood(_event.m.Merchant, 2.0, "Traded a dog for an exceptional set of axes."));
				local item = this.new("scripts/items/weapons/named/named_weapon/legend_named_heavy_throwing_axe");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				_event.m.Hound.getContainer().unequip(_event.m.Hound);
				this.List.push({
					id = 11,
					icon = "ui/items/" + _event.m.Hound.getIcon(),
					text = _event.m.Hound.getName() + " has been sold."
				});
			}
		});
	}

	function onUpdateScore() {
		if (!::World.getTime().IsDaytime)
			return;

//		local playerTile = ::World.State.getPlayer().getTile();
		local currentTile = this.World.State.getPlayer().getTile();
		if (currentTile.Type != this.Const.World.TerrainType.Snow && currentTile.Type != this.Const.World.TerrainType.SnowyForest) //only happens in snow areas
		{
			return;
		}

		if (currentTile.HasRoad) //cannot appear on a road
		{
			return;
		}

		if (this.Stash.getNumberOfEmptySlots() < 3) //must have 3 stash spaces free or more
		{
			return;
		}

		local brothers = ::World.getPlayerRoster().getAll();
		local candidates = [];
		local candidate_merchant = [];

		if (candidate_merchant.len() != 0)
		{
			this.m.Merchant = candidate_Merchant[this.Math.rand(0, candidate_Merchant.len() - 1)];
		}

		foreach (bro in brothers) {
			local item = bro.getItems().getItemAtSlot(::Const.ItemSlot.Accessory);
			if (item != null && (item.getID() == "accessory.legend_warhound"))
			{
				candidates.push(bro);
			}

			if (bro.getBackground().getID() == "background.peddler")
			{
				candidate_merchant.push(bro);
			}
		}

		if (candidates.len() == 0)
			return;

		this.m.Houndhandler = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Hound = this.m.Houndhandler.getItems().getItemAtSlot(::Const.ItemSlot.Accessory);
		this.m.Score = candidates.len() * 10;
	}

	function onPrepareVariables(_vars) {
		_vars.push([
			"houndhandler",
			this.m.Houndhandler.getNameOnly()
		]);
		_vars.push([
			"hound",
			this.m.Hound.getName()
		]);
		_vars.push([
			"merchant",
			this.m.Merchant != null ? this.m.Merchant.getNameOnly() : ""
		]);
	}

	function onClear() {
		this.m.Houndhandler = null;
		this.m.Hound = null;
		this.m.Merchant = null;
	}
});
