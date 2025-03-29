::mods_hookExactClass("events/events/dlc4/adopt_warhound_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.start <- function ( _event ) {
					local item = this.new("scripts/items/accessory/legend_warhound_item");
					item.m.Name = "Warrior the Warhound";
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
			}
			if (s.ID == "C") {
				s.Text = "%terrainImage%{You move to take the hound, but as you crouch down one of the sheep bays and charges, knocking you over. The company laughs and by the time you get to your knees another sheep crushes you from behind to many cheers. Drawing out your sword emits a sharp twang that sends the sheep scurrying. When you look back at the hound its nose is to the dirt and its eyes peerless. It has died and the sheep slowly collect around it bleating and crying out. You sheathe your sword and tell the company to move on.}";
			}
			if (s.ID == "D") {
				s.Text = "%terrainImage%{%houndman% steps forward.%SPEECH_ON%I know this breed. It is of northern stock, a sturdy creature. There is one thing it shall respect in a pack leader and it is strength.%SPEECH_OFF%The sellsword crouches before the dog and without pause puts its hands around the scuff of its neck and starts to scratch. Despite the sudden movements, the dog responds positively and when the mercenary stops scratching the dog lifts up off the ground and lopes forward and follows the dog whisperer. %houndman% stares back at you and roughs the dog up with some heavy petting.%SPEECH_ON%Yeah he\'ll fight for us. Fightin\' is what he\'s made for. He just needed someone to watch him rip and tear.%SPEECH_OFF%What a lovely creature this is. And the dog is fine, too.}";
				s.start <- function (_event) {
					this.Characters.push(_event.m.Houndmaster.getImagePath());
					local item = this.new("scripts/items/accessory/legend_warhound_item");
					item.m.Name = "Warrior the Warhound";
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
			}
		}
	}


	o.onUpdateScore = function () {
		if (!this.Const.DLC.Wildmen)
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.7)
			return;

		if (!this.World.Assets.getStash().hasEmptySlot())
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
			if (bro.getBackground().getID() == "background.houndmaster" || bro.getBackground().getID() == "background.barbarian" || bro.getBackground().getID() == "background.legend_muladi" )
				candidates.push(bro);

		if (candidates.len() != 0)
			this.m.Houndmaster = candidates[this.Math.rand(0, candidates.len() - 1)];

		this.m.Score = 5;
	}
})
