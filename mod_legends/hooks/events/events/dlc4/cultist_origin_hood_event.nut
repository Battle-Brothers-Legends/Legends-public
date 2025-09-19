::mods_hookExactClass("events/events/dlc4/cultist_origin_hood_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_03.png[/img]{%randomcultist%, one your followers, enters your tent and then just as soon leaves. You stand to see where the\'ve gone, but come to find a leather half-helm sitting atop your table. The leather is stitched with hairs of unknown origin and pinched together by what look like hooks and fingernails. The holes of the helm are a pitch black, and you get the sense that even if you filled them the darkness would never depart. It is then, staring into those emptied sockets, that you know something is staring back. You nod approvingly.}";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Tailor.getImagePath());
					local stash = this.World.Assets.getStash().getItems();

					foreach( i, item in stash ) {
						if (item != null && (item.getID() == "armor.head.hood" || item.getID() == "armor.head.aketon_cap" || item.getID() == "armor.head.open_leather_cap" || item.getID() == "armor.head.full_aketon_cap" || item.getID() == "armor.head.full_leather_cap")) {
							stash[i] = null;
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "You lose " + item.getName()
							});
							break;
						}
					}

					local item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.cultist_leather_hood]]);
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

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist))
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		local stash = this.World.Assets.getStash().getItems();
		local numItems = 0;

		foreach( item in stash ) {
			if (item != null && (item.getID() == "armor.head.hood" || item.getID() == "armor.head.aketon_cap" || item.getID() == "armor.head.open_leather_cap" || item.getID() == "armor.head.full_aketon_cap" || item.getID() == "armor.head.full_leather_cap"))
				numItems = ++numItems;
		}

		if (numItems == 0)
			return;

		this.m.Tailor = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = numItems * 5;
	}
})
