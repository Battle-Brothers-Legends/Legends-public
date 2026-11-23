::mods_hookExactClass("events/events/adopt_wardog_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "E", function (_screen) {
			_screen.start <- function (_event) {
				local item = this.new("scripts/items/accessory/legend_wardog_item");
				item.m.Name = "Battle Brother";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}
		});
		::Legends.Screens.hook(this, "F", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_37.png[/img]A rugged dog such as he would make for a great mascot. The little mutt could definitely boost morale. You order %bro% to feed it some food in the hopes that it\'ll tag along. %They_bro% goes out with a scrap of leftovers and crouches down.%SPEECH_ON%Good dog.%SPEECH_OFF%The mongrel sniffs the food, then chomps down on it - and the mercenary\'s hand along with it. The brother jumps back, nestling %their_bro% arm into %their_bro% chest as though %they_bro% might lose it otherwise. The dog, on the other hand, swallows the scrap and then runs off.";
		});
		::Legends.Screens.hook(this, "G", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_27.png[/img]You ask %houndmaster% the houndmaster if %they_houndmaster% can try and \'woo\' this dog. %They_houndmaster% nods and steps toward it. The wild mongrel\'s ears go from pinned to pointed. Crouched, the houndmaster slowly edges %their_houndmaster% way toward the beast. %They_houndmaster% keeps %their_houndmaster% hand out with a piece of meat in the palm. Hunger overcomes heedfulness and the dog sniffs its way ever closer to the houndmaster\'s hand. The dog tongues it out of %their_houndmaster% palm and chows down. The dog trainer feeds him another bite. %They_houndmaster% scruffs him up and finds the sweet spot behind his ears. Looking back, %houndmaster% nods.%SPEECH_ON%Aye, it\'s an agreeable beast and will be easily trained.%SPEECH_OFF%That\'s great. You ask if it can fight. The houndmaster purses %their_houndmaster% lips.%SPEECH_ON%A dog is akin to a man. If it can breathe, it can fight.%SPEECH_OFF%";
			_screen.start <- function (_event) {
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				local item = this.new("scripts/items/accessory/legend_wardog_item");
				item.m.Name = "Battle Brother";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}
		});
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		onUpdateScore();
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		foreach (bro in brothers) if (bro.getBackground().getID() == "background.houndmaster" || bro.getBackground().getID() == "background.legend_muladi")	{
			candidates.push(bro);
		}

		if (candidates.len() != 0) {
			this.m.Houndmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
		}
	}
})
