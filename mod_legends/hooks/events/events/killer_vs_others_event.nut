::mods_hookExactClass("events/events/killer_vs_others_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]While you attempt to study some poorly drawn maps, the sound of blades being drawn pierces your ears. You roll up your work and put it into a scroll\'s sleeve before making way to the disturbance.\n\n%killerontherun% is being held down by one mercenary\'s knee, while %otherguy1% and %otherguy2% look about ready to chop a head off. Seeing your arrival, the mercenaries calm down for a moment. They explain that the killer tried to slay one of them. Indeed, the speaker has a nick on the neck. A little bit deeper and something other than words would be coming out right about now. The company demand %killerontherun% be hanged for this attempted murder.";
				s.Options[0].Text = "Have the knave flogged for this.";
				s.Options[1].Text = "Have the villain hanged for this.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_38.png[/img]You order the %person_killer% flogged. %killer% spits on your name as the brothers tie %them_killer% up to a tree. You say do that again and you\'ll add more lashings. They rip %their_killer% shirt off and take turns with the whip as you stand by the side, counting. On the first lash a straight line of skin is stripped from %their_killer% back. The man flinches and you hear the ropes that bind %them_killer% draw taut as %their_killer% hands clench into fists. By the fifth lashing %they_killer% is no longer standing. By the tenth %they_killer% is no longer awake. After five more you call it and order the men to take %them_killer% down and tend %their_killer% wounds.";
				local start = s.start;
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
					start(_event);
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_02.png[/img]You order the %person_killer% hanged. Half the company cheers and %killerontherun% screams a shriek rather suitable for seeing death ordered to %their_killer% side. They drag the killer beneath a tree. Ropes are thrown up over the branches, again and again, looping and drawing taut. One sellsword ties a noose while the others cheer and clap and drink beer. A stool is placed and the condemned is forced to stand on it. As %killerontherun%\'s head is put into the noose, %they_killer% says %they_killer% has a word for all of you, but whatever %they_killer% has to say is cut off when %otherguy1% kicks the stool out from beneath %them_killer%.\n\nThis is not a good way to die. It is by an executioner\'s hand or means. Ordinarily being dropped from a platform breaks the neck, or is even decapitated. This one hangs choking and kicking. You hear some screams in %their_killer% lungs, but they struggle to get past %their_killer% throat. A few minutes pass and %they_killer% is still fighting. %otherguy2% steps over to the dying person, grabbing one of %their_killer% jerking feet to keep %them_killer% still, and with %their_otherguy2% free hand %they_otherguy2% stabs %killerontherun% in the heart. And that was that.\n\n{Surprisingly, the mercenaries agree to cut the %them_killer% down and bury %them_killer%. | %They_killer% is left hanging there when the company\'s march begins anew.}";
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					this.Characters.push(_event.m.OtherGuy1.getImagePath());
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.Killer.getName() + " has died"
					});
					_event.m.Killer.getItems().transferToStash(this.World.Assets.getStash());
					_event.m.Killer.getSkills().onDeath(this.Const.FatalityType.None);
					::Legends.addFallen(_event.m.Killer, "Hanged for attempted murder");
					this.World.getPlayerRoster().remove(_event.m.Killer);
					_event.m.OtherGuy1.improveMood(2.0, "Got satisfaction with " + _event.m.Killer.getNameOnly() + "\'s hanging");

					if (_event.m.OtherGuy1.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.OtherGuy1.getMoodState()],
							text = _event.m.OtherGuy1.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy1.getMoodState()]
						});
					}
				}
			}

			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]While you try to bring peace between a party of misfits, your attempts for neutrality only seem to anger a few of them. In particular, the one with the nicked neck is seething, swearing and kicking things over. A few of the others worry aloud about a lack of discipline.";
				local start = s.start;
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					start(_event);
				}
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_64.png[/img]The call for cooler heads to prevail seems to have failed as %killerontherun%\'s body is found dead anyway. {It appears someone stabbed the killer in the back. | Someone garroted the killer with a line of strong linen. | %killerontherun% was nearly chopped in half, the work of a truly angry person. | %killerontherun%\'s head was found resting next to %their_killer% chest, hands placed in such a manner as to be holding it. | Emphasis on the word \'body\', as the head was nowhere to be found. | Someone had slit %killerontherun% \'s throat in the night. | Bruises on the body and cuts on the hands suggests a fight, but whoever it was managed to gut the killer anyway.} You have a good guess as to who did it, but none of the mercenaries seem all that upset about the killer\'s death and certain proof would elude any kind of investigation. While all of that may be true, you still order the suspected mercenary to help bury the dead.";
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-2);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases"
					});
					this.Characters.push(_event.m.OtherGuy1.getImagePath());
					this.List.push({
						id = 13,
						icon = "ui/icons/kills.png",
						text = _event.m.Killer.getName() + " has died"
					});
					_event.m.Killer.getItems().transferToStash(this.World.Assets.getStash());
					_event.m.Killer.getSkills().onDeath(this.Const.FatalityType.None);
					::Legends.addFallen(_event.m.Killer, "Murdered by his fellow comrades");
					this.World.getPlayerRoster().remove(_event.m.Killer);
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers )
					{
						if (bro.getID() == _event.m.OtherGuy1.getID())
						{
							continue;
						}

						if (this.Math.rand(1, 100) <= 33)
						{
							continue;
						}

						bro.worsenMood(1.0, "Concerned about lack of discipline");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}
			if (s.ID == "F") {
				s.Text = "Well, %killerontherun% isn\'t dead, but %they_killer% stands before you broken and beaten. It looks like vengeful justice found %them_killer% out anyway. %They_killer% demands that some suspected brothers be punished for going around your orders. You consider this, but then ask the %person_killer% what will happen if you continue this cycle of violence. It\'s hard to see the %person_killer%\'s face as it is puffed up in blacks and purples, and %their_killer% eyes are lost behind puckered lids, but %they_killer% nods gingerly. You are right, %they_killer% says. It is best to let this whole thing die down lest it get out of control.";
				local start = s.start;
				s.start <- function ( _event ) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					start(_event);
				}
			}
		}
	}
})
