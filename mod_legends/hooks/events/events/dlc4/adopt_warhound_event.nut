::mods_hookExactClass("events/events/dlc4/adopt_warhound_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "%terrainImage%{You reach out to the hound and it lifts its head to you as though you were another threat. Its eyes peer blackly from a long-matted mane that still drips with blood. The sheep, having seen what carnage this beast has already wrought, bay nervously as they watch you. But you won\'t be deterred. You put your hand forth, palm supinated, and the weary dog slowly lowers into it. You nod.%SPEECH_ON%There\'s more fight in you yet, friend.%SPEECH_OFF%}";
			_screen.start <- function (_event) {
				local item = this.new("scripts/items/accessory/legend_warhound_item");
				item.m.Name = "Warrior the Warhound";
				this.List.extend(::Legends.EventList.addItems([item], ::World.Assets.getStash()));
			}
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "%terrainImage%{You move to take the hound, but as you crouch down one of the sheep bays and charges, knocking you over. The company laughs and by the time you get to your knees another sheep crushes you from behind to many cheers. Drawing out your sword emits a sharp twang that sends the sheep scurrying. When you look back at the hound its nose is to the dirt and its eyes peerless. It has died and the sheep slowly collect around it bleating and crying out. You sheathe your sword and tell the company to move on.}";
		});
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "%terrainImage%{%houndman% steps forward.%SPEECH_ON%I know this breed. It is of northern stock, a sturdy creature. There is one thing it shall respect in a pack leader and it is strength.%SPEECH_OFF%The sellsword crouches before the dog and without pause puts its hands around the scuff of its neck and starts to scratch. Despite the sudden movements, the dog responds positively and when the mercenary stops scratching the dog lifts up off the ground and lopes forward and follows the dog whisperer. %houndman% stares back at you and roughs the dog up with some heavy petting.%SPEECH_ON%Yeah he\'ll fight for us. Fightin\' is what he\'s made for. He just needed someone to watch him rip and tear.%SPEECH_OFF%What a lovely creature this is. And the dog is fine, too.}";
			_screen.start <- function (_event) {
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				local item = this.new("scripts/items/accessory/legend_warhound_item");
				item.m.Name = "Warrior the Warhound";
				this.List.extend(::Legends.EventList.addItems([item], ::World.Assets.getStash()));
			}
		});
	}

	o.onUpdateScore = function () {
		if (!::World.Assets.getStash().hasEmptySlot() || ::World.State.getPlayer().getTile().SquareCoords.Y < ::World.getMapSize().Y * 0.7) {
			return;
		}

		local candidates = ::World.getPlayerRoster().getAll().filter(@(_, _bro)(::Legends.Backgrounds.hasAny(_bro, ::Legends.Background.Houndmaster, ::Legends.Background.Barbarian, ::Legends.Background.LegendMuladi)));
		if (candidates.len() != 0) {
			this.m.Houndmaster = candidates[::Math.rand(0, candidates.len() - 1)];
		}

		this.m.Score = 5;
	}
})
