::mods_hookExactClass("events/events/dlc2/alp_captured_in_hole_event", function(o) {
	o.m.Guildmaster <- null;

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				local start = s.start;
				s.start <- function (_event) {
					start(_event);
					if (_event.m.Guildmaster != null) {
						this.Options.push({
							Text = "Let the Guildmaster speak.",
							function getResult( _event ) {
								return "guildmaster";
							}
						});
					}
				}
			}
			if (s.ID == "F") {
				s.Text = "[img]gfx/ui/events/event_122.png[/img]{%beastslayer% the beast slayer walks up to the hole and stares in, nodding.%SPEECH_ON%You don\'t have it captured. Alps cannot be captured.%SPEECH_OFF%The monster enslaver looks over and asks how so. The slayer laughs.%SPEECH_ON%Because that is no ordinary creature. This alp is biding its time. You said it sends nightmares to people looking in, yeah? Yeah, that\'s right. Fear is its blade and it is sharpening it right and steady. It is practicing its craft the best it can. Alps use environments to put their victims in and currently it\'s making do with the dirt. But eventually you\'ll look in and it\'ll be looking up, ready for the very moment, and you\'ll find yourself in the hole with it. Not you, yourself. No, the body would be spared. It will take your mind into that hole. And it will be there. You and that monstrosity alone in all the dark this world has to spare. For how long? Days, weeks. A very dangerous alp can cage your mind for what seems like years. You\'ll come out of it a fool, broken and slobbering and begging for death, that is if you still have the capacity to speak by then.%SPEECH_OFF%The slayer takes a bow from one of the enslaver\'s guards and nocks an arrow. The alp looks up and its mouth blossoms open to rows of razor sharp teeth. The slayer shoots it right in the maw killing it instantly, before handing the bow back and unfurling a journeyman sheet.%SPEECH_ON%This is the pay I am owed. Extra for saving your soul and mind from an alp\'s forever harvest. I\'ll also be taking the alp\'s skin. Agreed?%SPEECH_OFF%The enslaver hurriedly nods.%SPEECH_ON%Yes, yes of course!%SPEECH_OFF%}";
			}
		}

		this.m.Screens.push({ //—
			ID = "guildmaster",
			Text = "[img]gfx/ui/events/event_122.png[/img]{%guildmaster% gently approaches the man and his bodyguards like a stranger would approach a feral dog. %guildmaster% puts their arm around the peddler and leads him out of earshot of their hired help. The guards barely blink at this as their employer is led away under the wing of the old master.\n\n Several minutes pass as the master and peddler calmly talk back and forth. Occasionally the peddler rubs their forehead as if being told he\'d go backrupt. %guildmaster% produces a book from a small pack and finds a page — almost as if by magic, and begins pointing to the illustrations within.\n The peddler begins to steadily turn a pale shade of white as their eyes move quickly across the page. Now even the hired help are interested as to what is going on but before they can react, %guildmaster% takes a pike out of the closest guard\'s hands and thrusts it into the pit — followed by an agonising wail.\n\n The peddler quickly gets between the master and the guards and whispers in hushed tones. No doubt with some embellishment. The guards look from you, to him — then back to you and finally at the guild master. The merchant nods in your direction with a concerned smile as the group depart.\n %guildmaster% returns with a trophy and smiles in your direction. %SPEECH_ON%What did you tell them?%SPEECH_OFF% %guildmaster% shrugs and keeps you in the corner of their gaze as they watch the peddler and their thugs leave. %SPEECH_ON%I told \'im that the young alp would steal his genitals.%SPEECH_OFF% You feel something tingle in your body. %SPEECH_ON%No — only witchlings do that. Best be going before they figure it out, he even paid me to kill it. The daft man.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
			{
				Text = "Best all of you check yourselves before we get going...",
				function getResult( _event ) {
					return 0;
				}
			}
			],

			function start( _event ) {
				this.Characters.push(_event.m.Guildmaster.getImagePath());
				this.World.Assets.addMoney(350);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]350[/color] Crowns"
				});
				local item = this.new("scripts/items/misc/parched_skin_item");
				local item = this.new("scripts/items/weapons/pike");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				_event.m.Guildmaster.improveMood(1.0, "Dealt with an Alp");
				_event.m.Guildmaster.getBaseProperties().Bravery += 5;
				_event.m.Guildmaster.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Guildmaster.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+3[/color] Resolve"
				});
			}
		});
	}

	o.onUpdateScore = function () {
		if (!this.Const.DLC.Unhold)
			return;

		if (this.World.getTime().Days < 30)
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad || currentTile.Type == this.Const.World.TerrainType.Snow)
			return;

		if (!this.World.Assets.getStash().hasEmptySlot())
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_guildmaster = [];
		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.legend_guildmaster")
				candidates_guildmaster.push(bro);
		}
		if (candidates_guildmaster.len() != 0) {
			this.m.Guildmaster = candidates_guildmaster[this.Math.rand(0, candidates_guildmaster.len() - 1)];
		}
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function (_vars) {
		onPrepareVariables(_vars);
		_vars.push([
			"guildmaster",
			this.m.Guildmaster ? this.m.Guildmaster.getNameOnly() : ""
		]);
	}

	local onClear = o.onClear;
	o.onClear = function () {
		onClear();
		this.m.Guildmaster = null;
	}

});
