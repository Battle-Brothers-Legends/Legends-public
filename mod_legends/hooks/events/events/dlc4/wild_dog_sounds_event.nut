::mods_hookExactClass("events/events/dlc4/wild_dog_sounds_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function( _event ) {
					if (_event.m.Hunter != null) {
						this.Options.push({
							Text = "You\'re a hunter, %hunter%, go take a look.",
							function getResult( _event ) {
								return "D";
							}
						});
					}

					if (_event.m.Wildman != null) {
						this.Options.push({
							Text = "You came from the wilds, %wildman%, go take a look.",
							function getResult( _event ) {
								return "E";
							}
						});
					}

					if (_event.m.Expendable != null) {
						this.Options.push({
							Text = "Looks like a job for the new guy. Go take a look, %recruit%!",
							function getResult( _event ) {
								return this.Math.rand(1, 100) <= 40 ? "F" : "G";
							}
						});
					}
				}
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]{You tell the company to ignore the sounds. That\'s a hard task to oblige as the cries of the wild dogs only grow louder and louder until, just like that, they stop. Your mercenaries stand still as though making any noise could bring the hell of whatever horror it is that\'s out there. Nothing comes to pass, but a number of the company have a hard time sleeping through the night.}";
				s.start <- function ( _event ){
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.beast_slayer" || bro.getBackground().getID() == "background.legend_commander_ranger")
							continue;

						if (bro.getBackground().getID() == "background.wildman" || bro.getBackground().getID() == "background.barbarian" || bro.getBackground().getID() == "background.legend_berserker" || bro.getBackground().getID() == "background.legend_commander_berserker")
							continue;

						if (this.Math.rand(1, 100) <= 25) {
							bro.worsenMood(0.5, "Didn\'t get a good night\'s sleep");
							::Legends.Effects.grant(bro, ::Legends.Effect.Exhausted, function(_effect) {
								this.List.push({
									id = 10,
									icon = _effect.getIcon(),
									text = bro.getName() + " is exhausted"
								});
							}.bindenv(this));
						}
					}
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]{You tell the company to plug their ears if it bothers them so much. As the cries of the wild dogs grow louder the company turn to impromptu ear candling to keep the sounds at bay. Eventually, the sense deprived sellswords are awkwardly walking around like animatronics. You look to join the muted, plugging a waxball into your ear, but before you can get the second ear a loud crash sends inventory flowing and a tent billows as it collapses. You drain your ear and bark orders to the mercenaries who are scattered all over the camp.}";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_14.png[/img]{It does appear the mercenaries will not be assuaged by telling them to grow a pair. %hunter% elects to go seek out the noise, sure it\'s nothing more than the wild dogs squabbling over primacy over the pack. You agree, the archer venturing into the dark all alone. Just as soon as the outline is gone the canines cease their crying and you hear a growl that seems as though it came from a much higher ground. The whole camp is dead silent, daring not to even move.\n\n An hour later and the hunter walks into camp, nobody having heard the archer come in. The hunter is camouflaged in mud slaked with twigs and leaves. %hunter%\'s grafted stems into a hood, worn like some arboreal abbess. With hushed tones, the sellswords ask what it was. With a shrug the reply comes.%SPEECH_ON%Well. I seen about a dozen dead dogs. Some ripped apart. Found a few in the pit of very large footprints and they\'d not found the print but had been stomped there, you know. And I saw something move along in the shadows between the tree tops and it went the other way and I did not follow. I found a deer dead on its feet leaning against a tree. Heart faltered by whatever it saw, I suppose. I harvested everything I could.%SPEECH_OFF%The hunter turns and slings forward a rack of meat strung to a paneling of wood and leaves.%SPEECH_ON%Anyone hungry?%SPEECH_OFF%} ";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Hunter.getImagePath());
					local item = this.new("scripts/items/supplies/cured_venison_item");
					local item = this.new("scripts/items/supplies/cured_venison_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					_event.m.Hunter.getBaseProperties().Bravery += 1;
					_event.m.Hunter.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Hunter.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Resolve"
					});
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers ) {
						if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.beast_slayer")
							continue;

						if (bro.getBackground().getID() == "background.wildman" || bro.getBackground().getID() == "background.barbarian")
							continue;

						if (this.Math.rand(1, 100) <= 15)
							bro.worsenMood(0.5, "Concerned that there\'s something big out there");
					}
				}
			}
			if (s.ID == "F") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]{You look about the company. A young %recruit% looks back. Looking down, as though to look within themself, and then hurriedly gets to their feet.%SPEECH_ON%Say no more, captain. I will find out what this disturbance is.%SPEECH_OFF%The fresh recruit gathers their things and then stands at the edge of the camp\'s light, a very dark forest looking back at them. The mercenary stares down again and clenches and unclenches their hands.%SPEECH_ON%Alright. Alright.%SPEECH_OFF%He looks up.%SPEECH_ON%Let\'s do this.%SPEECH_OFF%The recruit is never seen again.}";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Expendable.getImagePath());
					local dead = _event.m.Expendable;
					::Legends.addFallen(dead, "Went missing");
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.Expendable.getName() + " went missing"
					});
					_event.m.Expendable.getItems().transferToStash(this.World.Assets.getStash());
					_event.m.Expendable.getSkills().onDeath(this.Const.FatalityType.None);
					this.World.getPlayerRoster().remove(_event.m.Expendable);
				}
			}
			if (s.ID == "G") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]{You look about the company. A young %recruit% looks back. They look down, as though to look within themself, and then hurriedly gets to their feet.%SPEECH_ON%Say no more, captain. I will find out what this disturbance is.%SPEECH_OFF%The fresh recruit gathers their things and then stands at the edge of the camp\'s light, a very dark forest looking back at them. The mercenary stares down again and clenches and unclenches their hands. %recruit% huffs and then steps forth, immediately slipping into the shadows. Hours pass. Finally, %recruit% returns. Their clothes are in tatters. Weapons are gone.  Spitting forth story after story. Magic rings, volcanoes, giant eagles, absolute nonsense. Whatever %recruit% saw, it\'s clear the blubbering sellsword needs to clear their head with some well earned beauty sleep. Which the\'ll get since all that awful noise has ceased.}";
				s.start <- function( _event ) {
					this.Characters.push(_event.m.Expendable.getImagePath());
					_event.m.Expendable.addXP(200, false);
					_event.m.Expendable.updateLevel();
					this.List.push({
						id = 16,
						icon = "ui/icons/xp_received.png",
						text = _event.m.Expendable.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] Experience"
					});
					_event.m.Expendable.improveMood(3.0, "Had an excellent adventure");

					if (_event.m.Expendable.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Expendable.getMoodState()],
							text = _event.m.Expendable.getName() + this.Const.MoodStateEvent[_event.m.Expendable.getMoodState()]
						});
					}

					local items = _event.m.Expendable.getItems();

					if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && items.getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Weapon) && !items.getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Legendary) && !items.getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Named)) {
						this.List.push({
							id = 10,
							icon = "ui/items/" + items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getIcon(),
							text = "You lose " + this.Const.Strings.getArticle(items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getName()) + items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getName()
						});
						items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					}

					if (items.getItemAtSlot(this.Const.ItemSlot.Head) != null)
						items.getItemAtSlot(this.Const.ItemSlot.Head).setCondition(this.Math.max(1, items.getItemAtSlot(this.Const.ItemSlot.Head).getConditionMax() * this.Math.rand(10, 40) * 0.01));

					if (items.getItemAtSlot(this.Const.ItemSlot.Body) != null)
						items.getItemAtSlot(this.Const.ItemSlot.Body).setArmor(this.Math.max(1, items.getItemAtSlot(this.Const.ItemSlot.Body).getRepairMax() * this.Math.rand(10, 40) * 0.01));
				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.Const.DLC.Wildmen || !this.Const.DLC.Unhold)
			return;

		if (this.World.getTime().IsDaytime)
			return;

		if (this.World.getTime().Days < 20)
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.SnowyForest)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_hunter = [];
		local candidates_wildman = [];
		local candidates_recruit = [];
		local others = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.beast_slayer"  || bro.getBackground().getID() == "background.legend_ranger"  || bro.getBackground().getID() == "background.legend_commander_ranger")
				candidates_hunter.push(bro);
			else if (bro.getBackground().getID() == "background.wildman")
				candidates_wildman.push(bro);
			else if (bro.getXP() == 0)
				candidates_recruit.push(bro);
			else
				others.push(bro);
		}

		if (candidates_hunter.len() == 0 && candidates_wildman.len() == 0 && candidates_recruit.len() == 0 || others.len() == 0)
			return;

		if (candidates_hunter.len() != 0)
			this.m.Hunter = candidates_hunter[this.Math.rand(0, candidates_hunter.len() - 1)];

		if (candidates_wildman.len() != 0)
			this.m.Wildman = candidates_wildman[this.Math.rand(0, candidates_wildman.len() - 1)];

		if (candidates_recruit.len() != 0)
			this.m.Expendable = candidates_recruit[this.Math.rand(0, candidates_recruit.len() - 1)];

		this.m.Score = 10;
	}

	o.onPrepareVariables = function ( _vars ) {
		_vars.push([
			"hunter",
			this.m.Hunter ? this.m.Hunter.getName() : ""
		]);
		_vars.push([
			"wildman",
			this.m.Wildman ? this.m.Wildman.getName() : ""
		]);
		_vars.push([
			"recruit",
			this.m.Expendable ? this.m.Expendable.getName() : ""
		]);
	}
})
