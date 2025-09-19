::mods_hookExactClass("events/events/dlc4/cultist_origin_finale_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]%cultist% enters your tent and a strong, brisk wind chases in after, rearing up your scrolls and other notes. %cultist% walks forward, hands crossed infront, a rather priestly look to the approach.%SPEECH_ON%Sir, I\'ve been spoken to and it is a grave matter which I\'ve been given responsibility for.%SPEECH_OFF%You put your hand up and call for silence. Carefully, you reach out to each candle in the tent and snuff them out until one remains. You bring it to your face...";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]Kneeling before the candle, you hold your hand over the flame and the fire comes to a standstill, pointing upright and unmoving. You\'ve seen icicles more animated than it. You stare into the glow and the tent melts away, slipping into the folds of an immense and immutable darkness. The cultist is gone. In place is a black cloak, its arms to your shoulders, a slate of granite for a head, its edges chipped and cracking. It appears there is something behind this mask, behind this futile effort to keep your mind safe from its true visage. You reach out to the mask, but some invisible force stops you.%SPEECH_ON%In good time you shall see all that I am.%SPEECH_OFF%The voice is booming yet narrowed into a brutish whisper only for you to hear.%SPEECH_ON%I\'ll give you Death, mortal, and warmed in its comforts, Death shall be visited upon your enemies. %sacrifice% will not be lost, they will be with you always, this I promise you.%SPEECH_OFF%A whiteness snaps back over you, a rush of wind, tent flaps curling outward, the candle\'s flame tilting impossibly without going out, and a frigid coolness that has your first breath seen floating across the air. %cultist% is nowhere to be seen. You quickly get up and touch your face and skin, making sure that you are all that you\'re supposed to be. To your great disappointment, Davkul is gone and you are still you.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]Davkul would be most unhappy with your failure to obey, not that you feel any urge other than to do what is asked. You and the %cultist% go to %sacrifice%\'s tent. Leaning up as though already expecting you, %sacrifice% sees the knife in the carriage of your party and nods at the simple sight of it. %cultist% kneels beside and you realize they\'ve already talked before this, that the question to you very well may have been a test of your devotion to Davkul. You are happy to have passed.\n\n%sacrifice% unbuttons their shirt and %cultist% pierces the chest as though he were putting a key into a lock, and twists it all the same. The sacrifice gasps and tenses, for no devotion to Davkul can put aside the manner in which death may be permitted, which is in pain and suffering. But %sacrifice% smiles, and the light doesn\'t so much go out of the eyes as the darkness, a sort you haven\'t seen before, replaces it. And like that, %sacrifice% is gone.\n\n %cultist% gets to work on the still warm corpse, carving the flesh with rapid slices across the skin and hard cuts into the tendons. Pulling the chest apart, a black fog lingers with the blade\'s every move, and it seems to sway cheerily after its every move. When %cultist% is done, %sacrfice% has been turned into a slab of armor, flesh torn asunder and stretched, teeth for rivets, tendons for strappings, bones for pauldrons, a cuirass of absolute carnage. And it pulses and moves as though that manifested it still lived. %cultist% turns to you, hands slopped red.%SPEECH_ON%Davkul awaits us all.%SPEECH_OFF%You nod and embrace your fellow comrade.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Sacrifice.getImagePath());
					local dead = _event.m.Sacrifice;
					::Legends.addFallen(dead, "Sacrificed to Davkul");
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.Sacrifice.getName() + " has died"
					});
					_event.m.Sacrifice.getItems().transferToStash(this.World.Assets.getStash());
					this.World.getPlayerRoster().remove(_event.m.Sacrifice);
					this.World.Assets.getStash().makeEmptySlots(1);

					local item = this.new("scripts/items/legend_armor/legendary/legend_davkul_armor");

					item.m.Description = "A grisly aspect of Davkul, an ancient power not from this world, and the last remnants of " + _event.m.Sacrifice.getName() + " from whose body it has been fashioned. It shall never break, but instead keep regrowing its scarred skin on the spot.";
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain the " + item.getName()
					});
					local brothers = this.World.getPlayerRoster().getAll();

					foreach (bro in brothers) {
						if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist)) {
							bro.improveMood(2.0, "Appeased Davkul");

							if (bro.getMoodState() >= this.Const.MoodState.Neutral) {
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						} else {
							bro.worsenMood(3.0, "Horrified by the death of " + _event.m.Sacrifice.getName());

							if (bro.getMoodState() < this.Const.MoodState.Neutral) {
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
					}
				}
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]You feel this is a test. Not one to pass by sacrificing one of your men, but quite the opposite. Davkul may have sent false believers to see if you would do all that they say, simply because they say it. You do not know how you know this, you just know, which is the very sort of certainty one should follow most. Just as you stand to go tell %cultist% of your decision, half the candles in the room suddenly blow out. Tendrils of smoke waft in the remaining gloom, a twisting haze through which, for but a moment, you swear you see a blackened visage fade out the tent\'s opening. You get the feeling that %cultist% already knows what choice you\'ve made. You stay in the tent and await Davkul\'s presence. When it is not felt, you simply light the candles again and speak to the emptied room.%SPEECH_ON%Davkul awaits us all.%SPEECH_OFF%";
				s.start <- function (_event)
				{
					this.Characters.push(_event.m.Cultist.getImagePath());
					local brothers = this.World.getPlayerRoster().getAll();

					foreach (bro in brothers) {
						if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist)) {
							bro.worsenMood(2.0, "Was denied the chance to appease Davkul");

							if (bro.getMoodState() < this.Const.MoodState.Neutral) {
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
					}
				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.Const.DLC.Wildmen)
			return;

		if (this.World.getTime().IsDaytime)
			return;

		if (this.World.getTime().Days <= 150)
			return;

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 12)
			return;

		if (!this.World.Assets.getStash().hasEmptySlot())
			return;

		local sacrifice_candidates = [];
		local cultist_candidates = [];
		local bestCultist;

		foreach( bro in brothers ) {
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist)) {
				cultist_candidates.push(bro);
				// This requires a Cultist, that isn't a convert.
				if ((bestCultist == null || bro.getLevel() > bestCultist.getLevel()) && bro.getBackground().getID() == "background.cultist")
					bestCultist = bro;

				if (bro.getLevel() >= 11)
					sacrifice_candidates.push(bro);
			}
		}

		if (cultist_candidates.len() <= 5 || bestCultist == null || bestCultist.getLevel() < 11 || sacrifice_candidates.len() < 2)
			return;

		for( local i = 0; i < sacrifice_candidates.len(); i = ++i ) {
			if (bestCultist.getID() == sacrifice_candidates[i].getID()) {
				sacrifice_candidates.remove(i);
				break;
			}
		}

		this.m.Cultist = bestCultist;
		this.m.Sacrifice = sacrifice_candidates[this.Math.rand(0, sacrifice_candidates.len() - 1)];
		this.m.Score = cultist_candidates.len();
	}

})
