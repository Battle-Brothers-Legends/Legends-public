::mods_hookExactClass("events/events/dlc2/location/witchhut_enter_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				s.start <- function (_event) {
					//may replace this with a flag on the old man sells event later
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) //replicated in oracle_event.nut
					{
						local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

						if (item != null && (item.getID() == "accessory.legend_oms_amphora" || item.getID() == "accessory.legend_oms_fate" || item.getID() == "accessory.legend_oms_tome" || item.getID() == "accessory.legend_oms_paw" || item.getID() == "accessory.legend_oms_rib"))
						{
							this.Options.push({
								Text = "Can tell me what this relic does?",
								function getResult( _event )
								{
									this.World.Flags.set("Item Identified", true); //Used to change the description of the identified item to explain it's effect(s)
									return "Relic_identify";
								}
							});
						}
					}

					local stash = this.World.Assets.getStash().getItems();
					foreach( item in stash )
					{
						if (item != null && (item.getID() == "accessory.legend_oms_amphora" || item.getID() == "accessory.legend_oms_fate" || item.getID() == "accessory.legend_oms_tome" || item.getID() == "accessory.legend_oms_paw" || item.getID() == "accessory.legend_oms_rib"))
						{
							this.Options.push({
								Text = "Can tell me what this relic does?",
								function getResult( _event )
								{
									this.World.Flags.set("Item Identified", true); //Used to change the description of the identified item to explain it's effect(s)
									return "Relic_identify";
								}
							});
						}
					}
				}
			}
		}

		this.m.Screens.push({
			ID = "Relic_identify",
			Text = "", //text based on given item, not input here.
			Image = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "Back to the knife...",
				function getResult( _event ) {
					return "D";
				}
			}
			],
			function start( _event )
			{
				local stash = clone this.World.Assets.getStash().getItems(); //we need to check both stash...
				foreach (bro in this.World.getPlayerRoster().getAll()) {
					local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory); //...and the equipped slots of all bros otherwise this event will break.
					if (item != null) {
						stash.push(item);
					}
				}

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "accessory.legend_oms_amphora")
						this.Text = "[img]gfx/ui/events/event_52.png[/img]{A hint of weariness enters the woman\'s voice as you ask your question. She offers her hand. %SPEECH_ON%Show me.%SPEECH_OFF% You hand the heavy jug to her, the contents of which slosh this way and that inside the vessel. Her eyes gleam and study the art covering the amphora. She whispers to herself a few things, but you only make out %SPEECH_ON%I thought I had lost you...%SPEECH_OFF% Without warning, she drips her finger into the mulch and sucks on it. You wait for a reaction but none comes, she either has tasted worse or hides her pain very well. She places the jug down and locks eyes with you. %SPEECH_ON%You have a problem, I know of this item and have come across it before - but it is not how I remember it. The mixture inside has spoiled, which I did not think was possible until now. It has long passed it\'s orginal purpose and I cannot guarantee what you will be drinking each time this refills.%SPEECH_OFF% She takes a sip from the vessel, and instantly pales and spits it out with a force that could blind a man.}";
					else if (item != null && item.getID() == "accessory.legend_oms_fate")
						this.Text = "[img]gfx/ui/events/event_52.png[/img]{The woman takes the tome and flicks through it\'s pages. At first the speed of which is rapid, but after a time she freezes and starts from the beginning again, reading very carefully and methodically between what appears to be blank pages. Minutes pass as she digests the information on each page before moving on. After a dozen pages, the reading becomes faster and she finally flicks through the last pages all the way to end end. %SPEECH_ON%Interesting, but not finished. I liked the part about the mackrel and the bucket.%SPEECH_OFF% Your mind begins to wander, is this another trick? She smiles at you wryly and folds her arms. %SPEECH_ON%It\'s blank for you, isn\'t it? I have read about this book before. It often trades hands because the owner doesn\'t like to be reminded of how uncontrollable their life is each time they pass their bookshelf. They think that passing on Van Hoorst\'s \'hronolosko ludilo\' will bring them back control. This is only one of five volumes, this is volume four, I believe.%SPEECH_OFF% The woman flicks through a few more of the pages again, possibly trying to discern if this conversation has had any impact on her end. She closes the book carefully and slides it across the table to you. %SPEECH_ON%Regardless, you should know that anyone who holds this is playing a risky game. Many think that the books alter fate themselves, not just reveal it. Those who die with these books in hand often do so with no chance at recovery. Some have said that they have seen men bleed to death from a pinprick because the book willed it so.%SPEECH_OFF%}";
					else if (item != null && item.getID() == "accessory.legend_oms_tome") //ledger
						this.Text = "[img]gfx/ui/events/event_52.png[/img]{The woman rolls her eyes and offers her hand. You produce the bound ledger and in almost the same motion, she flicks it open at a random page. Her eyes dart horizontially more than vertically across the page. She closes the ledger, and then opens it again and her curiosity deepens. With that, she closes the ledger a final time and throws it back at you, which you only just manage to catch. %SPEECH_ON%Boring!%SPEECH_OFF% She attends to a cooking pot starting to boil. %SPEECH_ON%I have seen these before, they\'re ledgers to track debtors and indebted alike. I know none of these names or what they mean but I do know the symbols in the margins.%SPEECH_OFF% She sips the soup from a spoon, and throws the spoon back into the pot the way a squirrel would discard a spent acorn. %SPEECH_ON%Symbols like \'Dead\' or \'Missing\', but there is one in there which is more broad - \'Taken\'. Be whom or what I am unsure, but based on the age of that skin and the names I think you found a relic of the Fallen Empire. Have you seen those packs of bones out there? Pretending like nothing is wrong despite being a magnet for wild and hungry dogs who don\'t know any better? They were a superstitious lot and even in death, they still are. If I were you I\'d tie that around my neck and you\'ll have them running back to that black pit of theirs in no time.%SPEECH_OFF%}";
					else if (item != null && item.getID() == "accessory.legend_oms_paw")
						this.Text = "[img]gfx/ui/events/event_52.png[/img]{You take the hairy paw from your bag and lay it on the table. The woman barely looks at it. %SPEECH_ON%Manwolf paw. Seen a dozen of them. We like to collect them for sport.%SPEECH_OFF% She flashes another paw of a larger size than yours attached to a belt on her dress. You think you catch the paw twitching, but it could just be her movement making it sway. %SPEECH_ON%Good for vigor, gives you that energy you need to run through the woods...or more.%SPEECH_OFF% She flashes you a wry smile and looks you up and down. A veil of discomfort decends down on you. %SPEECH_ON%be aware that those who pretend to be a beast also think like a beast. They may be big, hairy and strong but they have the bravery of a dog all the same when real danger comes.%SPEECH_OFF%}";
					else if (item != null && item.getID() == "accessory.legend_oms_rib")
						this.Text = "[img]gfx/ui/events/event_52.png[/img]{You produce the rib from your pack, the woman studies it as it comes out and fixes her gaze at it touches the table. No sooner as your hand is clear does she take it and hold it at either end. She softly bites one end and taps it on the edge of her cooking pot. A jolt of energy runs up your legs as you wnat to move in to stop her mishandling the relic you paid so much for. %SPEECH_ON%It\'s the real thing. I am quite impressed. No sheep bones or plaster as usual, this is the bone of a woman who i feel a burning hatred for. I know a godwhore when I see one, or in this case, part of one.%SPEECH_OFF% She notices how jittery you have become, and places the bone neatly back into your hands. %SPEECH_ON%These fools die for many reasons. Mostly killed by their own kind. This one has a painful energy about it - a mixture of pain and fear. I feel sharpness and hear the whistling of arrows when I hold it.%SPEECH_OFF% She exhales as if to purge the memory from her mind. %SPEECH_ON%Her loss will be your gain, however. These martyrs often protect against what killed them in the first place. But often at a cost of what didn\'t kill them.%SPEECH_OFF% She purses her lips. %SPEECH_ON%Stay away from axes, spears and the like, stranger.%SPEECH_OFF%}";

					if (item != null && (item.getID() == "accessory.legend_oms_amphora" || item.getID() == "accessory.legend_oms_fate" || item.getID() == "accessory.legend_oms_tome" || item.getID() == "accessory.legend_oms_paw" || item.getID() == "accessory.legend_oms_rib"))
						this.List = [{
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = item.getName() + " is now identified and its tooltip has now been updated"
						}];
				}
			}
		});
	}
});
