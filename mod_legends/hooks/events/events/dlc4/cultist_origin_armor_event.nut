::mods_hookExactClass("events/events/dlc4/cultist_origin_armor_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_03.png[/img]{An urgency takes %randomcultist%,  who stands, leaves the party\'s campfire, strides across the campground and retires to a tent. It is there that you see %randomcultist% at work, a silhouette and shadows moving frenetically. And there\'s more than just %randomcultist% in there: curves of unknown come and go beside, reaching up in poles of black, tendrils of darkness, whipping and flailing to match the energy of the faithful\'s own procession. And then it is done, a silhouette falling forward before yanking something to the light.\n\n %randomcultist% leaves the tent with the sort of hurry with which it was entered, but this time with a piece of leather chest armor in hand. %randomcultist% drops it to the ground.%SPEECH_ON%He awaits us all, brethren.%SPEECH_OFF%The chest armor is patterned with unique cuts which are arranged in strips that, to the unbelieving eye, would be meaningless. To you, it is but a language of Davkul.}";
				s.start <- function (_event)
				{
					this.Characters.push(_event.m.Tailor.getImagePath());
					local stash = this.World.Assets.getStash().getItems();

					foreach( i, item in stash ) {
						if (item != null && (item.getID() == "armor.body.padded_leather" || item.getID() == "armor.body.padded_surcoat" || item.getID() == "armor.body.rugged_surcoat" || item.getID() == "armor.body.thick_tunic" || item.getID() == "armor.body.blotched_gambeson")) {
							stash[i] = null;
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "You lose " + item.getName()
							});
							break;
						}
					}
					local item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.cultist_leather_robe],
					]);
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

		foreach( bro in brothers )
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist))
				candidates.push(bro);

		if (candidates.len() == 0)
			return;

		local stash = this.World.Assets.getStash().getItems();
		local numItems = 0;

		foreach( item in stash )
			if (item != null && (item.getID() == "armor.body.padded_leather" || item.getID() == "armor.body.padded_surcoat" || item.getID() == "armor.body.rugged_surcoat" || item.getID() == "armor.body.thick_tunic" || item.getID() == "armor.body.blotched_gambeson"))
				numItems++;

		if (numItems == 0)
			return;

		this.m.Tailor = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = numItems * 5;
	}

})
