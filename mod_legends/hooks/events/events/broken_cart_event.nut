::mods_hookExactClass("events/events/broken_cart_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "B", function (_screen) {
			local start = _screen.start;
			_screen.start <- function (_event) {
				start(_event);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases"
				});
			}
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			local start = _screen.start;
			_screen.start <- function (_event) {
				start(_event);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases"
				});
			}
		});

		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_55.png[/img]You order the men to search the cart and take what they can. %randombrother% draws %their_randombrother% sword and looks ready to slay the donkey, the animal looking stupidly at its own mortality in the reflection of the blade. The merchant cries out and you hold your hand out, staying the execution.%SPEECH_ON%Leave the draught animal where it stands.%SPEECH_OFF%The trader offers meager thanks as a line of your men walk behind him, his very goods in their hands.";

			local start = _screen.start;
			_screen.start <- function (_event) {
				start(_event);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases"
				});
			}
		});
	}
})
